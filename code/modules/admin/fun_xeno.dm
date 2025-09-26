var/last_lightning_strike = 0
var/list/forbidden_words = list("пидор", "пидр", "нигер", "русня", "faggot", "черномазый", "черножопый", "педераст", "педик", "жид", "москаль", "ниггер", "негр", "сионист", "девственник", "инцел", "симп", "укроп", "куколд", "чинк", "кацап", "хохол", "чурка", "нерусь", "гомик", "пиндос", "узкоглазый", "rusnya", "black-ass", "nigger", "nigga", "pindos", "narrow-eyed", "hohol")

/mob/living/carbon/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	. = ..()

	if(last_lightning_strike && world.time < last_lightning_strike + 5 SECONDS)
		return .

	var/found = FALSE
	var/processed_msg = lowertext(message)

	processed_msg = replacetext(processed_msg, " ", "")
	processed_msg = replacetext(processed_msg, ".", "")
	processed_msg = replacetext(processed_msg, ",", "")
	processed_msg = replacetext(processed_msg, "!", "")
	processed_msg = replacetext(processed_msg, "?", "")
	processed_msg = replacetext(processed_msg, ":", "")
	processed_msg = replacetext(processed_msg, ";", "")
	processed_msg = replacetext(processed_msg, "-", "")
	processed_msg = replacetext(processed_msg, "_", "")
	processed_msg = replacetext(processed_msg, "*", "")
	processed_msg = replacetext(processed_msg, "(", "")
	processed_msg = replacetext(processed_msg, ")", "")
	processed_msg = replacetext(processed_msg, "]", "")
	processed_msg = replacetext(processed_msg, "{", "")
	processed_msg = replacetext(processed_msg, "}", "")
	processed_msg = replacetext(processed_msg, "@", "")
	processed_msg = replacetext(processed_msg, "#", "")
	processed_msg = replacetext(processed_msg, "$", "")
	processed_msg = replacetext(processed_msg, "%", "")
	processed_msg = replacetext(processed_msg, "^", "")
	processed_msg = replacetext(processed_msg, "&", "")
	processed_msg = replacetext(processed_msg, "=", "")
	processed_msg = replacetext(processed_msg, "+", "")
	processed_msg = replacetext(processed_msg, "~", "")
	processed_msg = replacetext(processed_msg, "`", "")
	processed_msg = replacetext(processed_msg, "'", "")
	processed_msg = replacetext(processed_msg, "\"", "")
	processed_msg = replacetext(processed_msg, "/", "")
	processed_msg = replacetext(processed_msg, "|", "")

	processed_msg = replacetext(processed_msg, " ", "")
	processed_msg = replacetext(processed_msg, "a", "а")
	processed_msg = replacetext(processed_msg, "e", "е")
	processed_msg = replacetext(processed_msg, "o", "о")
	processed_msg = replacetext(processed_msg, "p", "р")
	processed_msg = replacetext(processed_msg, "c", "с")
	processed_msg = replacetext(processed_msg, "y", "у")
	processed_msg = replacetext(processed_msg, "x", "х")

	for(var/word in forbidden_words)
		if(findtext(processed_msg, word))
			found = TRUE
			break

	if(. && found)
		last_lightning_strike = world.time
		spawn(0)
			trigger_bolt_on_message(src)

	return .

/proc/trigger_bolt_on_message(mob/user)
	var/turf/lightning_source = get_step(get_step(user, NORTH), NORTH)
	lightning_source.beam(user, icon_state="lightning[rand(1,12)]", time = 5)

	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.adjust_fire_loss(75)

	playsound(get_turf(lightning_source), 'sound/effects/lightningbolt.ogg', 50, TRUE, 10)

	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.Knockdown(10 SECONDS)
		C.jitter(150)

	to_chat(user, span_userdanger("The gods have punished you for your sins!"), confidential = TRUE)
