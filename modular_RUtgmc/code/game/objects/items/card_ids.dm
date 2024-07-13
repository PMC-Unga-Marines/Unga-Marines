/obj/item/card/id/proc/set_user_data(mob/living/carbon/human/human_user)
	if(!istype(human_user))
		return

	registered_name = human_user.real_name
	blood_type = human_user.blood_type
