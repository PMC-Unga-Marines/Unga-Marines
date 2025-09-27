GLOBAL_LIST_EMPTY(hologram_list)

/mob/hologram
	name = "Hologram"
	desc = "It seems to be a visual projection of someone" //jinkies!
	icon = 'icons/mob/mob.dmi'
	icon_state = "hologram"
	canmove = TRUE

	invisibility = INVISIBILITY_OBSERVER
	sight = SEE_SELF
	layer = ABOVE_TREE_LAYER

	var/action_icon_state = "hologram_exit"

	var/mob/linked_mob
	var/datum/action/predator_action/leave_hologram/leave_button

/mob/hologram/Initialize(mapload, mob/M)
	if(!M)
		return INITIALIZE_HINT_QDEL

	. = ..()

	GLOB.hologram_list += src
	RegisterSignal(M, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(handle_move))
	RegisterSignals(M, list(
		COMSIG_HUMAN_DAMAGE_TAKEN,
		COMSIG_XENOMORPH_TAKING_DAMAGE
	), PROC_REF(take_damage))

	linked_mob = M
	linked_mob.reset_perspective()

	name = "[initial(name)] ([M.name])"

	leave_button = new(null, action_icon_state)
	leave_button.linked_hologram = src
	leave_button.give_action(M)

/mob/hologram/proc/take_damage(mob/M, datum/source, amount)
	SIGNAL_HANDLER

	if(amount > 5)
		qdel(src)

/mob/hologram/proc/handle_move(mob/M, NewLoc, direct)
	SIGNAL_HANDLER_DOES_SLEEP

	Move(get_step(loc, direct), direct)
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/mob/hologram/Destroy()
	if(linked_mob)
		linked_mob.reset_perspective()
		linked_mob = null

	if(!QDESTROYING(leave_button))
		QDEL_NULL(leave_button)
	else
		leave_button = null

	GLOB.hologram_list -= src

	return ..()

/datum/action/predator_action/leave_hologram
	name = "Leave"
	action_icon_state = "drone_return"
	background_icon_state = "template_pred"

	var/mob/hologram/linked_hologram

/datum/action/predator_action/leave_hologram/action_activate()
	qdel(src)

/datum/action/predator_action/leave_hologram/Destroy()
	if(!QDESTROYING(linked_hologram))
		QDEL_NULL(linked_hologram)
	return ..()
