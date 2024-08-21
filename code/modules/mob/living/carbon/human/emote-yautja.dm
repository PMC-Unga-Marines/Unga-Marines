/datum/emote/living/carbon/human/species/yautja
	mob_type_allowed_typecache = /mob/living/carbon/human/species/yautja

/datum/emote/living/carbon/human/species/yautja/anytime
	key = "anytime"
	sound = 'sound/voice/predator/anytime.ogg'
	key_third_person = "anytime"
	message = "any time"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/click
	key = "click"
	key_third_person = "click"
	message = "clicks"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/click/get_sound(mob/living/user)
	if(rand(0,100) < 50)
		return 'sound/voice/predator/click1.ogg'
	else
		return 'sound/voice/predator/click2.ogg'

/datum/emote/living/carbon/human/species/yautja/helpme
	key = "helpme"
	sound = 'sound/voice/predator/helpme.ogg'
	key_third_person = "helpme"
	message = "help me!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/iseeyou
	key = "iseeyou"
	sound = 'sound/hallucinations/i_see_you2.ogg'
	key_third_person = "iseeyou"
	message = "i see you!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/itsatrap
	key = "itsatrap"
	sound = 'sound/voice/predator/itsatrap.ogg'
	key_third_person = "itsatrap"
	message = "it's a trap!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/laugh1
	key = "laugh1"
	sound = 'sound/voice/predator/laugh1.ogg'
	key_third_person = "laugh1"
	message = "laughs"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/laugh2
	key = "laugh2"
	sound = 'sound/voice/predator/laugh2.ogg'
	key_third_person = "laugh2"
	message = "laughs"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/laugh3
	key = "laugh3"
	sound = 'sound/voice/predator/laugh3.ogg'
	key_third_person = "laugh3"
	message = "laughs"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/laugh4
	key = "laugh4"
	sound = 'sound/voice/predator/laugh4.ogg'
	key_third_person = "laugh4"
	message = "laughs"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/overhere
	key = "overhere"
	sound = 'sound/voice/predator/overhere.ogg'
	key_third_person = "overhere"
	message = "over here!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/predroar
	key = "predroar"
	key_third_person = "predroars"
	message = "roars!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/predroar/get_sound(mob/living/user)
	return pick('sound/voice/predator/roar1.ogg', 'sound/voice/predator/roar2.ogg')

/datum/emote/living/carbon/human/species/yautja/predroar2
	key = "predroar2"
	key_third_person = "predroars2"
	sound = 'sound/voice/predator/roar3.ogg'
	message = "roars!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/loudroar
	key = "loudroar"
	key_third_person = "loudroar"
	message = "roars loudly!"
	cooldown = 120 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/loudroar/get_sound(mob/living/user)
	return pick('sound/voice/predator/roar4.ogg', 'sound/voice/predator/roar5.ogg')

/datum/emote/living/carbon/human/species/yautja/loudroar/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return

	for(var/mob/current_mob in GLOB.mob_list)
		if(!current_mob.z != user.z || !get_dist(get_turf(current_mob), get_turf(user)) <= 18)
			continue
		var/relative_dir = get_dir(current_mob, user)
		var/final_dir = dir2text(relative_dir)
		to_chat(current_mob, span_highdanger("You hear a loud roar coming from [final_dir ? "the [final_dir]" : "nearby"]!"))

/datum/emote/living/carbon/human/species/yautja/turnaround
	key = "turnaround"
	key_third_person = "turnaround"
	message = "turn around!"
	sound = 'sound/voice/predator/turnaround.ogg'
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/click2
	key = "click2"
	key_third_person = "click2"
	message = "clicks"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/click2/get_sound(mob/living/user)
	return pick('sound/voice/predator/click3.ogg', 'sound/voice/predator/click4.ogg')

/datum/emote/living/carbon/human/species/yautja/aliengrowl
	key = "aliengrowl"
	key_third_person = "aliengrowl"
	message = "growls!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/aliengrowl/get_sound(mob/living/user)
	return pick('sound/voice/alien/growl1.ogg', 'sound/voice/alien/growl2.ogg')

/datum/emote/living/carbon/human/species/yautja/alienhelp
	key = "alienhelp"
	key_third_person = "alienhelp"
	message = "needs help!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/alienhelp/get_sound(mob/living/user)
	return pick('sound/voice/alien/help1.ogg', 'sound/voice/alien/help2.ogg')

/datum/emote/living/carbon/human/species/yautja/comeonout
	key = "comeonout"
	key_third_person = "comeonout"
	message = "come on out!"
	sound = 'sound/voice/predator/come_on_out.ogg'
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/overthere
	key = "overthere"
	key_third_person = "overthere"
	message = "over there!"
	sound = 'sound/voice/predator/over_there.ogg'
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/species/yautja/uglyfreak
	key = "uglyfreak"
	key_third_person = "uglyfreak"
	message = "ugly freak!"
	sound = 'sound/voice/predator/ugly_freak.ogg'
	emote_type = EMOTE_AUDIBLE
