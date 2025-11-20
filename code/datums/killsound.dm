/datum/xenomorph_killsound
	///Name of sound which will be seen in sounds list
	var/name = "None"
	///The actual sound
	var/sound
	///Boosty tier needed to enable the sound
	var/access_needed = BOOSTY_TIER_2

/datum/xenomorph_killsound/meow
	name = "Киси-киси мяу-мяу, киси-киси мя-мя-мяу"
	sound = 'sound/misc/killsound/meow-meow.ogg'
	access_needed = BOOSTY_TIER_3

/datum/xenomorph_killsound/pig
	name = "Свиной визг"
	sound = 'sound/misc/killsound/pig.ogg'
	access_needed = BOOSTY_TIER_3
