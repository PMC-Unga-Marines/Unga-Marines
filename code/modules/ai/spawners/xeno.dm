/obj/effect/ai_node/spawner/xeno
	name = "Xeno AI spawner"
	spawn_amount = 4
	spawn_delay = 10 SECONDS
	max_amount = 10

//////Generic xeno spawners
////////Tier ones

/obj/effect/ai_node/spawner/xeno/runner
	spawn_types = list(/mob/living/carbon/xenomorph/runner/ai = 1)

/obj/effect/ai_node/spawner/xeno/defender
	spawn_types = list(/mob/living/carbon/xenomorph/defender/ai = 1)

/obj/effect/ai_node/spawner/xeno/sentinel
	spawn_types = list(/mob/living/carbon/xenomorph/sentinel/ai = 1)

/obj/effect/ai_node/spawner/xeno/drone
	spawn_types = list(/mob/living/carbon/xenomorph/drone/ai = 1)

/obj/effect/ai_node/spawner/xeno/tier_one
	spawn_types = list(
		/mob/living/carbon/xenomorph/runner/ai = 1,
		/mob/living/carbon/xenomorph/sentinel/ai = 1,
		/mob/living/carbon/xenomorph/defender/ai = 1,
		/mob/living/carbon/xenomorph/drone/ai = 1,
	)

/////////////Tier twos

/obj/effect/ai_node/spawner/xeno/spitter
	spawn_types = list(/mob/living/carbon/xenomorph/spitter/ai = 1)

/obj/effect/ai_node/spawner/xeno/warrior
	spawn_types = list(/mob/living/carbon/xenomorph/warrior/ai = 1)

/obj/effect/ai_node/spawner/xeno/hivelord
	spawn_types = list(/mob/living/carbon/xenomorph/hivelord/ai = 1)

/obj/effect/ai_node/spawner/xeno/hunter
	spawn_types = list(/mob/living/carbon/xenomorph/hunter/ai = 1)

/* Uncomment when code in
/obj/effect/ai_node/spawner/xeno/bull
	spawn_types = list(/mob/living/carbon/xenomorph/bull/ai = 1)

/obj/effect/ai_node/spawner/xeno/carrier
	spawn_types = list(/mob/living/carbon/xenomorph/carrier/ai = 1)

/obj/effect/ai_node/spawner/xeno/panther
	spawn_types = list(/mob/living/carbon/xenomorph/panther/ai = 1)
*/

/obj/effect/ai_node/spawner/xeno/tier_two
	spawn_types = list(
		/mob/living/carbon/xenomorph/hunter/ai = 1,
		/mob/living/carbon/xenomorph/warrior/ai = 1,
		/mob/living/carbon/xenomorph/spitter/ai = 1,
		/mob/living/carbon/xenomorph/hivelord/ai = 1,
	//	/mob/living/carbon/xenomorph/bull/ai = 1,
	//	/mob/living/carbon/xenomorph/carrier/ai = 1,
	//	/mob/living/carbon/xenomorph/panther/ai = 1,
	)

////////////////////Tier 3s

/obj/effect/ai_node/spawner/xeno/ravager
	spawn_types = list(/mob/living/carbon/xenomorph/ravager/ai = 1)

/obj/effect/ai_node/spawner/xeno/boiler
	spawn_types = list(/mob/living/carbon/xenomorph/boiler/ai = 1)

/obj/effect/ai_node/spawner/xeno/praetorian
	spawn_types = list(/mob/living/carbon/xenomorph/praetorian/ai = 1)

/obj/effect/ai_node/spawner/xeno/crusher
	spawn_types = list(/mob/living/carbon/xenomorph/crusher/ai = 1)

/obj/effect/ai_node/spawner/xeno/chimera
	spawn_types = list(/mob/living/carbon/xenomorph/chimera/ai = 1)

/* Uncomment when code in
/obj/effect/ai_node/spawner/xeno/behemoth
	spawn_types = list(/mob/living/carbon/xenomorph/behemoth/ai = 1)

/obj/effect/ai_node/spawner/xeno/defiler
	spawn_types = list(/mob/living/carbon/xenomorph/defiler/ai = 1)

/obj/effect/ai_node/spawner/xeno/gorger
	spawn_types = list(/mob/living/carbon/xenomorph/gorger/ai = 1)

/obj/effect/ai_node/spawner/xeno/warlock
	spawn_types = list(/mob/living/carbon/xenomorph/warlock/ai = 1)

/obj/effect/ai_node/spawner/xeno/widow
	spawn_types = list(/mob/living/carbon/xenomorph/widow/ai = 1)
*/

/obj/effect/ai_node/spawner/xeno/tier_three
	spawn_types = list(
		/mob/living/carbon/xenomorph/crusher/ai = 1,
		/mob/living/carbon/xenomorph/praetorian/ai = 1,
		/mob/living/carbon/xenomorph/boiler/ai = 1,
		/mob/living/carbon/xenomorph/ravager/ai = 1,
	//	/mob/living/carbon/xenomorph/behemoth/ai = 1,
		/mob/living/carbon/xenomorph/chimera/ai = 1,
	//	/mob/living/carbon/xenomorph/defiler/ai = 1,
	//	/mob/living/carbon/xenomorph/gorger/ai = 1,
	//	/mob/living/carbon/xenomorph/warlock/ai = 1,
	//	/mob/living/carbon/xenomorph/widow/ai = 1,
	)

/////////////Tier 4s

/obj/effect/ai_node/spawner/xeno/queen
	spawn_types = list(/mob/living/carbon/xenomorph/queen/ai = 1)

/* Uncomment when code in
/obj/effect/ai_node/spawner/xeno/shrike
	spawn_types = list(/mob/living/carbon/xenomorph/shrike/ai = 1)

/obj/effect/ai_node/spawner/xeno/king
	spawn_types = list(/mob/living/carbon/xenomorph/king/ai = 1)

/obj/effect/ai_node/spawner/xeno/predalien
	spawn_types = list(/mob/living/carbon/xenomorph/predalien/ai = 1)

/obj/effect/ai_node/spawner/xeno/tier_four
	spawn_types = list(
		/mob/living/carbon/xenomorph/predalien/ai = 1,
		/mob/living/carbon/xenomorph/king/ai = 1,
		/mob/living/carbon/xenomorph/shrike/ai = 1,
		/mob/living/carbon/xenomorph/queen/ai = 1,
	)
*/
