/datum/smite/rounify
	name = "Rounify"

/datum/smite/rounify/effect(client/user, mob/living/target)
	. = ..()
	if(!isxeno(target))
		return
	var/mob/living/carbon/xenomorph/xeno = target
	if(!xeno.rouny_icon)
		to_chat(user, span_warning("Sorry, but this xenomorph doesn't have a rouny icon!"))
		return
	xeno.toggle_rouny_skin()
