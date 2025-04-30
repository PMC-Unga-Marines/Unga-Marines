/obj/effect/ai_node/spawner/human
	name = "AI human spawner node"
	use_post_spawn = TRUE //Gotta equip those AI you know

/obj/effect/ai_node/spawner/human/deathsquad
	spawn_types = list(/mob/living/carbon/human/node_pathing = 1)
	spawn_amount = 4
	spawn_delay = 10 SECONDS
	max_amount = 10

/obj/effect/ai_node/spawner/human/deathsquad/post_spawn(list/squad)
	var/mob/living/carbon/human/SL = pick_n_take(squad)
	var/datum/job/job = SSjob.GetJobType(/datum/job/deathsquad/leader)
	SL.apply_assigned_role_to_spawn(job)
	job = SSjob.GetJobType(/datum/job/deathsquad/standard)
	for(var/mob/living/carbon/human/squaddie AS in squad)
		squaddie.apply_assigned_role_to_spawn(job)
