/datum/language/yautja
	name = "Sainja"
	desc = "The deep, rumbling, guttural sounds of the Yautja predators. It is difficult to speak for those without facial mandibles."
	speech_verb = "rumbles"
	ask_verb = "rumbles"
	exclaim_verb = "roars"
	icon_state = "pred"
	key = "s"
	space_chance = 20
	default_priority = 90
	syllables = list("!", "?", ".", "@", "$", "%", "^", "&", "*", "-", "=", "+", "e", "b", "y", "p", "|", "z", "~", ">")

/datum/language_holder/yautja
	languages = list(/datum/language/yautja)
	only_speaks_language = /datum/language/yautja

/datum/language_holder/yautja/New()
	. = ..()
	for(var/la in GLOB.all_languages - /datum/language/yautja)
		grant_language(la, TRUE)
