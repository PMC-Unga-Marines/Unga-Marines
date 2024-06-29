/datum/emote/living/carbon/human/sneeze/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'modular_RUtgmc/sound/misc/human_female_sneeze_1.ogg'
	else
		return 'modular_RUtgmc/sound/misc/human_male_sneeze_1.ogg'


/datum/emote/living/carbon/human/sigh/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'modular_RUtgmc/sound/voice/human_female_sigh_1.ogg'
	else
		return 'modular_RUtgmc/sound/voice/human_male_sigh_1.ogg'


/datum/emote/living/carbon/human/giggle/get_sound(mob/living/user)
	if(isrobot(user))
		if(user.gender == FEMALE)
			return 'modular_RUtgmc/sound/voice/robotic/female_giggle.ogg'
		else
			return 'modular_RUtgmc/sound/voice/robotic/male_giggle.ogg'
	if(user.gender == FEMALE)
		return 'modular_RUtgmc/sound/voice/human_female_giggle_1.ogg'
	else
		return 'modular_RUtgmc/sound/voice/human_male_giggle_1.ogg'


/datum/emote/living/carbon/human/yawn/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'modular_RUtgmc/sound/voice/human_female_yawn_1.ogg'
	else
		return 'modular_RUtgmc/sound/voice/human_male_yawn_1.ogg'


/datum/emote/living/carbon/human/moan/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'modular_RUtgmc/sound/voice/human_female_moan_1.ogg'
	else
		return 'modular_RUtgmc/sound/voice/human_male_moan_1.ogg'


/datum/emote/living/carbon/human/cry/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'modular_RUtgmc/sound/voice/human_female_cry_1.ogg'
	else
		return 'modular_RUtgmc/sound/voice/human_male_cry_1.ogg'

/datum/emote/living/carbon/human/laugh/get_sound(mob/living/user)
	if(isrobot(user))
		if(user.gender == FEMALE)
			return 'modular_RUtgmc/sound/voice/robotic/female_laugh.ogg'
		else
			return pick('modular_RUtgmc/sound/voice/robotic/male_laugh_1.ogg', 'modular_RUtgmc/sound/voice/robotic/male_laugh_2.ogg')
	return ..()

/datum/emote/living/carbon/human/medic/get_sound(mob/living/carbon/human/user)
	if(isrobot(user))
		if(user.gender == MALE)
			if(prob(95))
				return 'modular_RUtgmc/sound/voice/robotic/male_medic.ogg'
			else
				return 'modular_RUtgmc/sound/voice/robotic/male_medic2.ogg'
		else
			return 'modular_RUtgmc/sound/voice/robotic/female_medic.ogg'
	return ..()

/datum/emote/living/carbon/human/whistle
	key = "whistle"
	key_third_person = "whistles"
	message = "whistle"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/whistle/get_sound(mob/living/user)
	if(isrobot(user))
		return
	return 'modular_RUtgmc/sound/voice/sound_voice_human_whistle1.ogg'

/datum/emote/living/carbon/human/crack
	key = "crack"
	key_third_person = "cracks"
	message = "cracks their knuckles."
	emote_type = EMOTE_AUDIBLE
	flags_emote = EMOTE_RESTRAINT_CHECK|EMOTE_MUZZLE_IGNORE|EMOTE_ARMS_CHECK
	sound = 'modular_RUtgmc/sound/misc/sound_misc_knuckles.ogg'

//Robotic

/datum/emote/living/carbon/robot
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/robot, /mob/living/carbon/human/species/synthetic, /mob/living/carbon/human/species/early_synthetic)

/datum/emote/living/carbon/robot/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "pips happily!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/robotic/dwoop.ogg'

/datum/emote/living/carbon/robot/yes
	key = "yes"
	message = "emits an affirmative blip."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/robotic/synth_yes.ogg'

/datum/emote/living/carbon/robot/no
	key = "no"
	message = "emits a negative blip."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/robotic/synth_no.ogg'

/datum/emote/living/carbon/robot/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-sigh.ogg'

/datum/emote/living/carbon/robot/buzz2
	key = "buzz2"
	message = "buzzes twice."
	message_param = "buzzes twice at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-two.ogg'

/datum/emote/living/carbon/robot/beep
	key = "beep"
	message = "beeps sharply."
	message_param = "beeps sharply at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/twobeep.ogg'

/datum/emote/living/carbon/robot/chime
	key = "chime"
	key_third_person = "chimes"
	message = "chimes."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/chime.ogg'

/datum/emote/living/carbon/robot/honk
	key = "honk"
	key_third_person = "honks"
	message = "honks."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/items/bikehorn.ogg'

/datum/emote/living/carbon/robot/ping
	key = "ping"
	key_third_person = "pings"
	message = "pings."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/ping.ogg'

/datum/emote/living/carbon/robot/sad
	key = "sad"
	message = "plays a sad trombone..."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/sadtrombone.ogg'

/datum/emote/living/carbon/robot/warn
	key = "warn"
	key_third_person = "warns"
	message = "blares an alarm!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/warning-buzzer.ogg'

/datum/emote/living/carbon/robot/laughtrack
	key = "laughtrack"
	message = "plays a laughtrack."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/robot/laughtrack/get_sound(mob/living/user)
	return pick('modular_RUtgmc/sound/voice/robotic/sitcomLaugh1.ogg', 'modular_RUtgmc/sound/voice/robotic/sitcomLaugh2.ogg')

//Neco Ark

/datum/emote/living/carbon/necoarc
	mob_type_allowed_typecache = /mob/living/carbon/human/species/necoarc

/datum/emote/living/carbon/necoarc/mudamuda
	key = "muda"
	key_third_person = "muda muda"
	message = "Muda Muda"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco Muda muDa.ogg'


/datum/emote/living/carbon/necoarc/bubu //then add to the grenade throw
	key = "bubu"
	key_third_person = "bu bu"
	message = "bu buuu"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco bu buuu.ogg'


/datum/emote/living/carbon/necoarc/dori
	key = "dori"
	key_third_person = "dori dori dori"
	message = "dori dori dori"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco dori dori dori.ogg'


/datum/emote/living/carbon/necoarc/sayesa
	key = "sa"
	key_third_person = "sa yesa"
	message = "Sa Yesa!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco Sa Yesa 1.ogg'


/datum/emote/living/carbon/necoarc/sayesa/two
	key = "sa2"
	key_third_person = "sa yesa2"
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco Sa Yesa 2.ogg'


/datum/emote/living/carbon/necoarc/yanyan
	key = "yanyan"
	key_third_person = "yanyan yaan"
	message = "yanyan yaan"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco yanyan yaan.ogg'


/datum/emote/living/carbon/necoarc/nya
	key = "nya"
	message = "nya"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco-Arc sound effect.ogg'


/datum/emote/living/carbon/necoarc/isa
	key = "isa"
	message = "iiiiisAAAAA!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco iiiiisAAAAA.ogg'


/datum/emote/living/carbon/necoarc/qahu
	key = "qahu"
	key_third_person = "quiajuuu"
	message = "qahuuuuu!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_RUtgmc/sound/voice/necoarc/Neco quiajuuubn.ogg'
