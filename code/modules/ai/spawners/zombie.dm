/obj/effect/ai_node/spawner/zombie
	name = "Zombie AI spawner"

/obj/effect/ai_node/spawner/zombie //BRAINS
	spawntypes = list(
		/mob/living/carbon/human/species/zombie/ai/patrol = 80,
		/mob/living/carbon/human/species/zombie/ai/fast/patrol = 5,
		/mob/living/carbon/human/species/zombie/ai/tank/patrol = 5,
		/mob/living/carbon/human/species/zombie/ai/smoker/patrol = 5,
		/mob/living/carbon/human/species/zombie/ai/strong/patrol = 5,
	)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10
