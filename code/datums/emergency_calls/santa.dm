//Santa is back in town
/datum/emergency_call/dedmoroz
	name = "Ded Moroz team"
	base_probability = 50
	alignement_factor = 0


/datum/emergency_call/dedmoroz/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>Ты [pick("усердно работал чтобы доставить подарки всем хорошим мальчикам и девочкам всех мастей", "пережил лед, снег и низкую гравитацию, неустанно работая на благо Деда мороза")].</b>")
	to_chat(H, "<B>В составе кортежа Деда Мороза, вы путешествуете чтобы доставить подарки всем, кто заслуживает награды.</b>")
	to_chat(H, "<B>Дед Мороз путешествует по галактике раз в год, посещая каждую обитаемую планету за один период в 24 стандартных часа. Дед Мороз поддерживает активные силы обороны, чтобы наказывать особо непослушных смертоносной силой. В настоящее время эти силы защиты насчитывают более 30 000 снеговиков и кораблей</b>")
	to_chat(H, "")
	to_chat(H, "<B>Сегодня, направляясь к судну TGMC, [SSmapping.configs[SHIP_MAP].map_name], магический ИИ посоха обнаружил аномально высокий уровень непослушных существ на орбите [SSmapping.configs[GROUND_MAP].map_name]. Дед Мороз решил наказать их в духе Нового года!</b>")
	if(GLOB.round_statistics.number_of_chert >= 1)
		to_chat(H, "<B>Уничтожьте все формы жизни на борту коробля, чтобы спасти Новый год, угля на этот раз будет недостаточно. Единственное наказание, в которое сейчас верит Дед Мороз, это горячий свинец!</B>")
	else
		to_chat(H, "<B>Накажите непослушных </b>Ксеноморфов</b> на борту корабля, угля на этот раз будет недостаточно. Единственное наказание, в которое сейчас верит Дед Мороз, это горячий свинец!</B>")

/datum/emergency_call/dedmoroz/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/mob/living/carbon/human/H = .

	M.transfer_to(H, TRUE)

	if(original)
		qdel(original)

	//
	//Ded moroz himself is a discount deathsquad leader, his snowman are just fodder though and very poorly equipped
	//

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/dedmoroz/leader)
		H.name = "Дед Мороз"
		H.real_name = H.name
		H.apply_assigned_role_to_spawn(J)
		H.set_nutrition(NUTRITION_OVERFED * 2)
		H.grant_language(/datum/language/xenocommon)
		ADD_TRAIT(H, TRAIT_DED_MOROZ, TRAIT_DED_MOROZ)
		var/datum/action/innate/summon_present/present_spawn = new(H)
		present_spawn.give_action(H)
		var/datum/action/innate/summon_present_bomb/present_bomb_spawn = new(H)
		present_bomb_spawn.give_action(H)
		var/datum/action/innate/rejuv_self/selfhealing = new(H)
		selfhealing.give_action(H)
		var/datum/action/innate/summon_snow_man/snowmansummoning = new(H)
		snowmansummoning.give_action(H)
		var/datum/action/innate/heal_snow_man/fixsnowmanslave = new(H)
		fixsnowmanslave.give_action(H)
		var/datum/action/innate/snow_man_swap/swapsnowman = new(H)
		swapsnowman.give_action(H)
		if(GLOB.round_statistics.number_of_chert >= 1)
			to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты Дед Мороз! Уничтожьте всех </b>людей и ксеносов</b> с помощью подавляющей огневой мощи! </b>Не оставляйте никого из них в живых!!</b>.")]</p>")
		else
			to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты Дед Мороз! Накажите всех непослушных </b>ксеносов</b> подавляющей огневой мощью, начиная с их трусливой королевы, спрятавшейся на корабле.")]</p>")
		return

	ADD_TRAIT(H, TRAIT_SNOW_MAN, TRAIT_SNOW_MAN)
	var/datum/job/J = SSjob.GetJobType(/datum/job/dedmoroz)
	H.apply_assigned_role_to_spawn(J)
	H.name = "Снеговик [rand(1,999)]"
	H.real_name = H.name
	var/datum/action/innate/snow_man_recall/recallingsnowman = new(H)
	recallingsnowman.give_action(H)
	print_backstory(H)
	if(GLOB.round_statistics.number_of_chert >= 1)
		to_chat(H, span_notice("Вы являетесь членом верной команды Деда Мороза. Помогите Деду Морозу очистить корабль от </b>всего живого</b>, от людей и ксеносов!"))
	else
		to_chat(H, span_notice("Вы — член верной команды Деда Мороза, помогите Деду Морозу, чем можете!"))

/datum/action/innate/summon_present
	name = "Summon Present"
	action_icon_state = "present"

/datum/action/innate/summon_present/Activate()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	to_chat(dedmoroz_mob, span_notice("Ты начал копаться в своем мешке в поиске подарков."))
	if(!do_after(dedmoroz_mob, 7 SECONDS))
		to_chat(dedmoroz_mob, span_notice("Попытка была тщетна."))
		return
	var/obj/item/a_gift/dedmoroz/spawnedpresent = new(get_turf(dedmoroz_mob))
	dedmoroz_mob.put_in_hands(spawnedpresent)

/datum/action/innate/summon_present_bomb
	name = "Summon Explosive Present"
	action_icon_state = "dangerpresent"

/datum/action/innate/summon_present_bomb/Activate()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	to_chat(dedmoroz_mob, span_warning("Ты начал копаться в своем мешке в поиске взрывного подарка."))
	if(!do_after(dedmoroz_mob, 3 SECONDS))
		to_chat(dedmoroz_mob, span_notice("Попытка была тщетна."))
		return
	var/obj/item/explosive/grenade/gift/spawnedpresentbomb = new (get_turf(dedmoroz_mob))
	dedmoroz_mob.put_in_hands(spawnedpresentbomb)

/datum/action/innate/rejuv_self
	name = "Revitalize Self"
	action_icon_state = "dedmoroz_heal"

/datum/action/innate/rejuv_self/Activate()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	to_chat(dedmoroz_mob, span_notice("Ты начал использовать новогоднию силу для заживления ран."))
	if(!do_after(dedmoroz_mob, 2 MINUTES))
		to_chat(dedmoroz_mob, span_notice("С приливом праздничного настроения ты залечиваешь свои раны, ты как новенький!"))
		return
	dedmoroz_mob.revive()

/datum/action/innate/summon_snow_man
	name = "Summon Snow man"
	action_icon_state = "dedmoroz_summon"

/datum/action/innate/summon_snow_man/Activate()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	to_chat(dedmoroz_mob, span_notice("Ты начал призывать своих помошников."))
	if(!do_after(dedmoroz_mob, 15 SECONDS))
		to_chat(dedmoroz_mob, span_notice("Ты передумал созывать снеговиков, от них все равно не так много пользы."))
		return
	for(var/mob/living/carbon/human/snowman in GLOB.humans_by_zlevel["[dedmoroz_mob.z]"])
		if(HAS_TRAIT(snowman, TRAIT_SNOW_MAN))
			snowman.forceMove(get_turf(dedmoroz_mob))

/datum/action/innate/heal_snow_man
	name = "Heal Snow man"
	action_icon_state = "heal_snow_man"

/datum/action/innate/heal_snow_man/Activate()
	var/list/snowmanlist = list()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	to_chat(dedmoroz_mob, span_notice("Ты концентрируешься на заживления ран снеговиков."))
	if(!do_after(dedmoroz_mob, 10 SECONDS))
		to_chat(dedmoroz_mob, span_notice("Ты решил что есть более важные вещи для концентрации"))
		return
	for(var/mob/living/carbon/human/snowman in GLOB.human_mob_list)
		if(get_dist(dedmoroz_mob, snowman) > 10)
			continue
		if(HAS_TRAIT(snowman, TRAIT_SNOW_MAN))
			snowmanlist += snowman
	for(var/mob/living/carbon/human/blessedsnowman in snowmanlist)
		if(blessedsnowman.stat == DEAD) //this is basically a copypaste of defib logic, but with magic not paddles
			var/heal_target = blessedsnowman.get_death_threshold() - blessedsnowman.health + 1
			var/all_loss = blessedsnowman.getBruteLoss() + blessedsnowman.getFireLoss() + blessedsnowman.getToxLoss()
			blessedsnowman.setOxyLoss(0)
			blessedsnowman.updatehealth()
			if(all_loss && (heal_target > 0))
				var/brute_ratio = blessedsnowman.getBruteLoss() / all_loss
				var/burn_ratio = blessedsnowman.getFireLoss() / all_loss
				var/tox_ratio = blessedsnowman.getToxLoss() / all_loss
				blessedsnowman.adjustBruteLoss(-10)
				blessedsnowman.adjustFireLoss(-10)
				blessedsnowman.adjustToxLoss(-10)
				blessedsnowman.setOxyLoss(0)
				if(tox_ratio)
					blessedsnowman.adjustToxLoss(-(tox_ratio * heal_target))
				blessedsnowman.heal_overall_damage(brute_ratio*heal_target, burn_ratio*heal_target, TRUE)
				blessedsnowman.updatehealth()
				blessedsnowman.set_stat(UNCONSCIOUS)
				blessedsnowman.emote("gasp")
		else //if the snowman is alive heal them some
			to_chat(blessedsnowman, span_notice("Ты чувствуешь расслабляющую энергию Нового года, твои раны исчезли!"))
			blessedsnowman.setOxyLoss(0)
			blessedsnowman.adjustBruteLoss(-30)
			blessedsnowman.adjustFireLoss(-30)
			blessedsnowman.adjustToxLoss(-30)

/datum/action/innate/summon_paperwork
	name = "Summon Paperwork"
	action_icon_state = "paper"

/datum/action/innate/summon_paperwork/Activate()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	to_chat(dedmoroz_mob, span_notice("Ты начал составлять трудовой контракт."))
	if(!do_after(dedmoroz_mob, 3 SECONDS))
		to_chat(dedmoroz_mob, "Ты перестал составлять контракт")
		return
	to_chat(dedmoroz_mob, span_notice("С размахом ты достаешь трудовой договор и ручку"))
	var/obj/item/paper/dedmorozcontract/newcontract = new (get_turf(dedmoroz_mob))
	dedmoroz_mob.put_in_hands(newcontract)
	var/obj/item/tool/pen/newpen = new (get_turf(dedmoroz_mob))
	dedmoroz_mob.put_in_hands(newpen)

/datum/action/innate/snow_man_swap
	name = "Swap with snow man"
	action_icon_state = "dedmoroz_swap"

/datum/action/innate/snow_man_swap/Activate()
	var/list/snowmanlist = list()
	var/mob/living/carbon/human/dedmoroz_mob = usr
	var/storedzlevel
	for(var/mob/living/carbon/human/snowman in GLOB.alive_human_list)
		if(HAS_TRAIT(snowman, TRAIT_SNOW_MAN))
			snowmanlist += snowman
	var/mob/living/carbon/human/swappedsnowman = tgui_input_list(dedmoroz_mob , "Выберете с каким снеговиком поменяться", "Смена с снеговиком", snowmanlist)
	to_chat(dedmoroz_mob, span_warning("Ты начал соберать свою энергию, чтобы поменяться местами с снеговиком..."))
	to_chat(swappedsnowman, span_warning("Ты чувствуешь себя странно, будто находишься в двух местах одновременно..."))
	if(HAS_TRAIT(dedmoroz_mob, TRAIT_TELEPORTED_ACROSS_ZLEVELS))
		if(swappedsnowman.z != dedmoroz_mob.z)
			to_chat(dedmoroz_mob, span_warning("Недавно ты телепортировался на слишком большое расстояние, тебе придется подождать, прежде чем снова телепортироваться на такое расстояние..."))
			return
	if(!do_after(dedmoroz_mob, 5 SECONDS))
		to_chat(dedmoroz_mob, span_notice("Ты перестаешь готовиться поменяться местами со своим любимым снеговиком..."))
		return
	storedzlevel = dedmoroz_mob.z
	var/turf/snowmanturf = get_turf(swappedsnowman)
	var/turf/dedmorozturf = get_turf(dedmoroz_mob)
	dedmoroz_mob.forceMove(snowmanturf)
	swappedsnowman.forceMove(dedmorozturf)
	swappedsnowman.Stun(3 SECONDS)
	if(storedzlevel == dedmoroz_mob.z)
		dedmoroz_mob.Stun(3 SECONDS)
		to_chat(dedmoroz_mob, span_warning("Ты пытаешься собраться с силами после обмена..."))
	else
		dedmoroz_mob.Stun(20 SECONDS)
		ADD_TRAIT(dedmoroz_mob, TRAIT_TELEPORTED_ACROSS_ZLEVELS, TRAIT_DED_MOROZ)
		addtimer(CALLBACK(dedmoroz_mob, TYPE_PROC_REF(/mob/living/carbon/human, remove_teleport_trait), dedmoroz_mob), 3 MINUTES) //extremely snowflaky proc, viewer beware
		to_chat(dedmoroz_mob, span_warning("Напряжение путешествия на такое большое расстояние выводит вас из равновесия...."))
	to_chat(swappedsnowman, span_notice("Пока мир вращается вокруг вас, вы изо всех сил пытаетесь сориентироваться..."))

/datum/action/innate/snow_man_recall
	name = "Return to Santa"
	action_icon_state = "snow_man_recall"

/datum/action/innate/snow_man_recall/Activate()
	var/list/dedmorozlist = list()
	var/mob/living/carbon/human/snowmanmob = usr
	for(var/mob/living/carbon/human/dedmoroz in GLOB.humans_by_zlevel["[snowmanmob.z]"])
		if(HAS_TRAIT(dedmoroz, TRAIT_DED_MOROZ))
			dedmorozlist += dedmoroz
	if(!length(dedmorozlist))
		to_chat(snowmanmob, span_warning("Ты не можешь найти Деда Мороза! Кажется возвращаться уже не к кому..."))
		return
	to_chat(snowmanmob, span_notice("Ты собираешь энергию для возвращение к Деду Морозу..."))
	if(!do_after(snowmanmob, 10 SECONDS))
		to_chat(snowmanmob, span_notice("Ты решил что есть более важные вещи для дел..."))
		return
	var/mob/living/carbon/human/selecteddedmoroz = pick(dedmorozlist)
	snowmanmob.forceMove(get_turf(selecteddedmoroz))
