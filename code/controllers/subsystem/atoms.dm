#define BAD_INIT_QDEL_BEFORE 1
#define BAD_INIT_DIDNT_INIT 2
#define BAD_INIT_SLEPT 4
#define BAD_INIT_NO_HINT 8

SUBSYSTEM_DEF(atoms)
	name = "Atoms"
	init_order = INIT_ORDER_ATOMS
	flags = SS_NO_FIRE

	/// A stack of list(source, desired initialized state)
	/// We read the source of init changes from the last entry, and assert that all changes will come with a reset
	var/list/initialized_state = list()
	var/base_initialized

	var/list/late_loaders = list()

	var/list/BadInitializeCalls = list()

	///initAtom() adds the atom its creating to this list iff InitializeAtoms() has been given a list to populate as an argument
	var/list/created_atoms

	/// Atoms that will be deleted once the subsystem is initialized
	var/list/queued_deletions = list()

	#ifdef PROFILE_MAPLOAD_INIT_ATOM
	var/list/mapload_init_times = list()
	#endif

	initialized = INITIALIZATION_INSSATOMS

/datum/controller/subsystem/atoms/Initialize()
	initialized = INITIALIZATION_INNEW_MAPLOAD
	InitializeAtoms()
	initialized = INITIALIZATION_INNEW_REGULAR

	return SS_INIT_SUCCESS

#ifdef PROFILE_MAPLOAD_INIT_ATOM
#define PROFILE_INIT_ATOM_BEGIN(...) var/__profile_stat_time = TICK_USAGE
#define PROFILE_INIT_ATOM_END(atom) mapload_init_times[##atom.type] += TICK_USAGE_TO_MS(__profile_stat_time)
#else
#define PROFILE_INIT_ATOM_BEGIN(...)
#define PROFILE_INIT_ATOM_END(...)
#endif

/datum/controller/subsystem/atoms/proc/InitializeAtoms(list/atoms, list/atoms_to_return)
	if(initialized == INITIALIZATION_INSSATOMS)
		return

	// Generate a unique mapload source for this run of InitializeAtoms
	var/static/uid = 0
	uid = (uid + 1) % (SHORT_REAL_LIMIT - 1)
	var/source = "subsystem init [uid]"
	set_tracked_initalized(INITIALIZATION_INNEW_MAPLOAD, source)

	// This may look a bit odd, but if the actual atom creation runtimes for some reason, we absolutely need to set initialized BACK
	CreateAtoms(atoms, atoms_to_return, source)
	clear_tracked_initalize(source)
	SSicon_smooth.free_deferred(source)

	if(length(late_loaders))
		for(var/I in 1 to length(late_loaders))
			var/atom/A = late_loaders[I]
			//I hate that we need this
			if(QDELETED(A))
				continue
			A.LateInitialize()
		testing("Late initialized [length(late_loaders)] atoms")
		late_loaders.Cut()

	if(created_atoms)
		atoms_to_return += created_atoms
		created_atoms = null

	for(var/queued_deletion in queued_deletions)
		qdel(queued_deletion)

	testing("[length(queued_deletions)] atoms were queued for deletion.")
	queued_deletions.Cut()

	#ifdef PROFILE_MAPLOAD_INIT_ATOM
	rustg_file_write(json_encode(mapload_init_times), "[GLOB.log_directory]/init_times.json")
	#endif

/// Actually creates the list of atoms. Exists soley so a runtime in the creation logic doesn't cause initalized to totally break
/datum/controller/subsystem/atoms/proc/CreateAtoms(list/atoms, list/atoms_to_return = null, mapload_source = null)
	if(atoms_to_return)
		LAZYINITLIST(created_atoms)

	#ifdef TESTING
	var/count
	#endif

	var/list/mapload_arg = list(TRUE)

	if(atoms)
		#ifdef TESTING
		count = length(atoms)
		#endif

		for(var/I in 1 to length(atoms))
			var/atom/A = atoms[I]
			if(A.atom_flags & INITIALIZED)
				continue
			// Unrolled CHECK_TICK setup to let us enable/disable mapload based off source
				if(TICK_CHECK)
					clear_tracked_initalize(mapload_source)
					stoplag()
					if(mapload_source)
						set_tracked_initalized(INITIALIZATION_INNEW_MAPLOAD, mapload_source)
			PROFILE_INIT_ATOM_BEGIN()
			InitAtom(A, TRUE, mapload_arg)
			PROFILE_INIT_ATOM_END(A)
	else
		#ifdef TESTING
		count = 0
		#endif
		for(var/atom/A as anything in world)
			if(A.atom_flags & INITIALIZED)
				continue
			PROFILE_INIT_ATOM_BEGIN()
			InitAtom(A, FALSE, mapload_arg)
			PROFILE_INIT_ATOM_END(A)
			#ifdef TESTING
			++count
			#endif
			if(TICK_CHECK)
				clear_tracked_initalize(mapload_source)
				stoplag()
				if(mapload_source)
					set_tracked_initalized(INITIALIZATION_INNEW_MAPLOAD, mapload_source)

	#ifdef TESTING
	testing("Initialized [count] atoms")
	#endif

/// Init this specific atom
/datum/controller/subsystem/atoms/proc/InitAtom(atom/A, from_template = FALSE, list/arguments)
	var/the_type = A.type
	if(QDELING(A))
		BadInitializeCalls[the_type] |= BAD_INIT_QDEL_BEFORE
		return TRUE

	// This is handled and battle tested by dreamchecker. Limit to UNIT_TESTS just in case that ever fails.
	#ifdef UNIT_TESTS
	var/start_tick = world.time
	#endif

	var/result = A.Initialize(arglist(arguments))

	#ifdef UNIT_TESTS
	if(start_tick != world.time)
		BadInitializeCalls[the_type] |= BAD_INIT_SLEPT
	#endif

	var/qdeleted = FALSE

	switch(result)
		if(INITIALIZE_HINT_NORMAL)
			EMPTY_BLOCK_GUARD // pass
		if(INITIALIZE_HINT_LATELOAD)
			if(arguments[1]) //mapload
				late_loaders += A
			else
				A.LateInitialize()
		if(INITIALIZE_HINT_QDEL)
			qdel(A)
			qdeleted = TRUE
		else
			BadInitializeCalls[the_type] |= BAD_INIT_NO_HINT

	if(!A) //possible harddel
		qdeleted = TRUE
	else if(!(A.atom_flags & INITIALIZED))
		BadInitializeCalls[the_type] |= BAD_INIT_DIDNT_INIT
	else
		SEND_SIGNAL(A, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZE)
		if(created_atoms && from_template && ispath(the_type, /atom/movable))//we only want to populate the list with movables
			created_atoms += A.GetAllContents()

	return qdeleted || QDELING(A)

/datum/controller/subsystem/atoms/proc/map_loader_begin(source)
	set_tracked_initalized(INITIALIZATION_INSSATOMS, source)

/datum/controller/subsystem/atoms/proc/map_loader_stop(source)
	clear_tracked_initalize(source)

/// Returns the source currently modifying SSatom's init behavior
/datum/controller/subsystem/atoms/proc/get_initialized_source()
	var/state_length = length(initialized_state)
	if(!state_length)
		return null
	return initialized_state[state_length][1]

/// Use this to set initialized to prevent error states where the old initialized is overriden, and we end up losing all context
/// Accepts a state and a source, the most recent state is used, sources exist to prevent overriding old values accidentially
/datum/controller/subsystem/atoms/proc/set_tracked_initalized(state, source)
	if(!length(initialized_state))
		base_initialized = initialized
	initialized_state += list(list(source, state))
	initialized = state

/datum/controller/subsystem/atoms/proc/clear_tracked_initalize(source)
	if(!length(initialized_state))
		return
	for(var/i in length(initialized_state) to 1 step -1)
		if(initialized_state[i][1] == source)
			initialized_state.Cut(i, i+1)
			break

	if(!length(initialized_state))
		initialized = base_initialized
		base_initialized = INITIALIZATION_INNEW_REGULAR
		return
	initialized = initialized_state[length(initialized_state)][2]

/datum/controller/subsystem/atoms/Recover()
	initialized = SSatoms.initialized
	if(initialized == INITIALIZATION_INNEW_MAPLOAD)
		InitializeAtoms()
	initialized_state = SSatoms.initialized_state
	BadInitializeCalls = SSatoms.BadInitializeCalls

/datum/controller/subsystem/atoms/proc/InitLog()
	. = ""
	for(var/path in BadInitializeCalls)
		. += "Path : [path] \n"
		var/fails = BadInitializeCalls[path]
		if(fails & BAD_INIT_DIDNT_INIT)
			. += "- Didn't call atom/Initialize(mapload)\n"
		if(fails & BAD_INIT_NO_HINT)
			. += "- Didn't return an Initialize hint\n"
		if(fails & BAD_INIT_QDEL_BEFORE)
			. += "- Qdel'd before Initialize proc ran\n"
		if(fails & BAD_INIT_SLEPT)
			. += "- Slept during Initialize()\n"

/// Prepares an atom to be deleted once the atoms SS is initialized.
/datum/controller/subsystem/atoms/proc/prepare_deletion(atom/target)
	if (initialized == INITIALIZATION_INNEW_REGULAR)
		// Atoms SS has already completed, just kill it now.
		qdel(target)
	else
		queued_deletions += WEAKREF(target)

/datum/controller/subsystem/atoms/Shutdown()
	var/initlog = InitLog()
	if(initlog)
		text2file(initlog, "[GLOB.log_directory]/initialize.log")
