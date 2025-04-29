/obj/effect/ai_node/spawner/zombie
	name = "tunnel"
	desc = "It reeks of rotten flesh and has stains of old blood and scratches."
	icon = 'icons/Xeno/Effects.dmi'
	icon_state = "hole"
	spawntypes = list(
		/mob/living/carbon/human/species/zombie/ai/patrol = 80,
		/mob/living/carbon/human/species/zombie/ai/fast/patrol = 5,
		/mob/living/carbon/human/species/zombie/ai/tank/patrol = 5,
		/mob/living/carbon/human/species/zombie/ai/smoker/patrol = 5,
		/mob/living/carbon/human/species/zombie/ai/strong/patrol = 5,
	)
	spawnamount = 1
	spawndelay = 8 SECONDS
	maxamount = 15

/obj/effect/ai_node/spawner/zombie/Initialize(mapload)
	. = ..()
	GLOB.zombie_spawners += src

/obj/effect/ai_node/spawner/zombie/Destroy()
	. = ..()
	GLOB.zombie_spawners -= src
