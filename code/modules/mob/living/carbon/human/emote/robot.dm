/datum/emote/living/carbon/robot // isn't actually robot only
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/robot, /mob/living/carbon/human/species/synthetic, /mob/living/carbon/human/species/early_synthetic)

/datum/emote/living/carbon/robot/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "pips happily!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/robotic/dwoop.ogg'

/datum/emote/living/carbon/robot/yes
	key = "yes"
	message = "emits an affirmative blip."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/robotic/synth_yes.ogg'

/datum/emote/living/carbon/robot/no
	key = "no"
	message = "emits a negative blip."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/robotic/synth_no.ogg'

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
	return pick('sound/voice/robotic/sitcomLaugh1.ogg', 'sound/voice/robotic/sitcomLaugh2.ogg')

/datum/emote/living/carbon/robot/sneeze/get_sound(mob/living/user)
	return
