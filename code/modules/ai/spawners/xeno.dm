/obj/effect/ai_node/spawner/xeno
	name = "Xeno AI spawner"
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

//////Generic xeno spawners
////////Tier ones

/obj/effect/ai_node/spawner/xeno/runner
	spawntypes = list(/mob/living/carbon/xenomorph/runner/ai = 1)

/obj/effect/ai_node/spawner/xeno/defender
	spawntypes = list(/mob/living/carbon/xenomorph/defender/ai = 1)

/obj/effect/ai_node/spawner/xeno/sentinel
	spawntypes = list(/mob/living/carbon/xenomorph/sentinel/ai = 1)

/obj/effect/ai_node/spawner/xeno/drone
	spawntypes = list(/mob/living/carbon/xenomorph/drone/ai = 1)

/obj/effect/ai_node/spawner/xeno/tier_one
	spawntypes = list(
		/mob/living/carbon/xenomorph/runner/ai = 1,
		/mob/living/carbon/xenomorph/sentinel/ai = 1,
		/mob/living/carbon/xenomorph/defender/ai = 1,
		/mob/living/carbon/xenomorph/drone/ai = 1,
	)

/////////////Tier twos

/obj/effect/ai_node/spawner/xeno/spitter
	spawntypes = list(/mob/living/carbon/xenomorph/spitter/ai = 1)

/obj/effect/ai_node/spawner/xeno/warrior
	spawntypes = list(/mob/living/carbon/xenomorph/warrior/ai = 1)

/obj/effect/ai_node/spawner/xeno/hivelord
	spawntypes = list(/mob/living/carbon/xenomorph/hivelord/ai = 1)

/obj/effect/ai_node/spawner/xeno/hunter
	spawntypes = list(/mob/living/carbon/xenomorph/hunter/ai = 1)

/* Uncomment when code in
/obj/effect/ai_node/spawner/xeno/bull
	spawntypes = list(/mob/living/carbon/xenomorph/bull/ai = 1)

/obj/effect/ai_node/spawner/xeno/carrier
	spawntypes = list(/mob/living/carbon/xenomorph/carrier/ai = 1)

/obj/effect/ai_node/spawner/xeno/panther
	spawntypes = list(/mob/living/carbon/xenomorph/panther/ai = 1)
*/

/obj/effect/ai_node/spawner/xeno/tier_two
	spawntypes = list(
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
	spawntypes = list(/mob/living/carbon/xenomorph/ravager/ai = 1)

/obj/effect/ai_node/spawner/xeno/boiler
	spawntypes = list(/mob/living/carbon/xenomorph/boiler/ai = 1)

/obj/effect/ai_node/spawner/xeno/praetorian
	spawntypes = list(/mob/living/carbon/xenomorph/praetorian/ai = 1)

/obj/effect/ai_node/spawner/xeno/crusher
	spawntypes = list(/mob/living/carbon/xenomorph/crusher/ai = 1)

/obj/effect/ai_node/spawner/xeno/chimera
	spawntypes = list(/mob/living/carbon/xenomorph/chimera/ai = 1)

/* Uncomment when code in
/obj/effect/ai_node/spawner/xeno/behemoth
	spawntypes = list(/mob/living/carbon/xenomorph/behemoth/ai = 1)

/obj/effect/ai_node/spawner/xeno/defiler
	spawntypes = list(/mob/living/carbon/xenomorph/defiler/ai = 1)

/obj/effect/ai_node/spawner/xeno/gorger
	spawntypes = list(/mob/living/carbon/xenomorph/gorger/ai = 1)

/obj/effect/ai_node/spawner/xeno/warlock
	spawntypes = list(/mob/living/carbon/xenomorph/warlock/ai = 1)

/obj/effect/ai_node/spawner/xeno/widow
	spawntypes = list(/mob/living/carbon/xenomorph/widow/ai = 1)
*/

/obj/effect/ai_node/spawner/xeno/tier_three
	spawntypes = list(
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
	spawntypes = list(/mob/living/carbon/xenomorph/queen/ai = 1)

/* Uncomment when code in
/obj/effect/ai_node/spawner/xeno/shrike
	spawntypes = list(/mob/living/carbon/xenomorph/shrike/ai = 1)

/obj/effect/ai_node/spawner/xeno/king
	spawntypes = list(/mob/living/carbon/xenomorph/king/ai = 1)

/obj/effect/ai_node/spawner/xeno/predalien
	spawntypes = list(/mob/living/carbon/xenomorph/predalien/ai = 1)

/obj/effect/ai_node/spawner/xeno/tier_four
	spawntypes = list(
		/mob/living/carbon/xenomorph/predalien/ai = 1,
		/mob/living/carbon/xenomorph/king/ai = 1,
		/mob/living/carbon/xenomorph/shrike/ai = 1,
		/mob/living/carbon/xenomorph/queen/ai = 1,
	)
*/
