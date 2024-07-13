/mob/living/carbon/xenomorph/generate_name()
	var/playtime_mins = client?.get_exp(xeno_caste.caste_name)
	var/rank_name
	switch(playtime_mins)
		if(0 to 300)
			rank_name = "Young"
		if(301 to 1500)
			rank_name = "Mature"
		if(1501 to 4200)
			rank_name = "Elder"
		if(4201 to 9000)
			rank_name = "Ancient"
		if(9001 to INFINITY)
			rank_name = "Prime"
		else
			rank_name = "Young"
	var/prefix = (hive.prefix || xeno_caste.upgrade_name) ? "[hive.prefix][xeno_caste.upgrade_name] " : ""
	name = prefix + "[rank_name ? "[rank_name] " : ""][xeno_caste.display_name] ([nicknumber])"

	real_name = name
	if(mind)
		mind.name = name

/mob/living/carbon/xenomorph/Move(NewLoc, direct)
	. = ..()
	if(!.)
		return
	if(interactee)// moving stops any kind of interaction
		unset_interaction()

/mob/living/carbon/xenomorph/proc/playtime_as_number()
	var/playtime_mins = client?.get_exp(xeno_caste.caste_name)
	switch(playtime_mins)
		if(0 to 300)
			return 0
		if(301 to 1500)
			return 1
		if(1501 to 4200)
			return 2
		if(4201 to 9000)
			return 3
		if(9001 to INFINITY)
			return 4
		else
			return 0

/mob/living/carbon/xenomorph/start_pulling(atom/movable/AM, force = move_force, suppress_message = TRUE, bypass_crit_delay = FALSE)
	if(do_actions)
		return FALSE //We are already occupied with something.
	if(!Adjacent(AM))
		return FALSE //The target we're trying to pull must be adjacent and anchored.
	if(status_flags & INCORPOREAL || AM.status_flags & INCORPOREAL)
		return FALSE //Incorporeal things can't grab or be grabbed.
	if(AM.anchored)
		return FALSE //We cannot grab anchored items.
	if(!isliving(AM) && AM.drag_windup && !do_after(src, AM.drag_windup, NONE, AM, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(src, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = src.health))))
		return //If the target is not a living mob and has a drag_windup defined, calls a do_after. If all conditions are met, it returns. If the user takes damage during the windup, it breaks the channel.
	var/mob/living/L = AM
	if(L.buckled)
		return FALSE //to stop xeno from pulling marines on roller beds.
	if(ishuman(L))
		if(L.stat == DEAD) //Can't drag dead human bodies.
			to_chat(usr, span_xenowarning("This looks gross, better not touch it."))
			return FALSE
		if(L != pulling)
			pull_speed += XENO_DEADHUMAN_DRAG_SLOWDOWN
	SEND_SIGNAL(src, COMSIG_XENOMORPH_GRAB)
	return ..()
