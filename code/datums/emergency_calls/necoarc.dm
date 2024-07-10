//NecoArc
/datum/emergency_call/necoarc
	name = "Neco Arc"
	base_probability = 0
	spawn_type = /mob/living/carbon/human/species/necoarc
	shuttle_id = SHUTTLE_DISTRESS_UFO
	alignement_factor = 0

/datum/emergency_call/necoarc/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>Ваши емоуты: *muda, *bubu, *dori, *sa, *sa2, *yanyan, *nya, *isa, *qahu.")
	to_chat(H, "<B>Ваша миссия проста: уничтожить всех людей и любую другую расу, представляющую угрозу.</b>")

/datum/emergency_call/necoarc/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/mob/living/carbon/human/H = .

	M.transfer_to(H, TRUE)
	H.fully_replace_character_name(M.name, H.real_name)

	if(original)
		qdel(original)

	print_backstory(H)
	H.update_hair()

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/necoarc/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Yahoo")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/necoarc/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("Yahoo")]</p>")
