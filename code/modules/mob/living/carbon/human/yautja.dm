/mob/living/carbon/human/species/yautja
	chat_color = "#aa0000"

/mob/living/carbon/human/species/yautja/get_paygrade()
	if(client.clan_info)
		return client.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[client.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

/mob/living/carbon/human/species/yautja/hud_set_hunter()
	. = ..()

	var/image/holder = hud_list[HUNTER_CLAN]
	if(!holder)
		return

	holder.icon_state = "predhud"

	if(client?.clan_info?.item?[4])
		var/datum/db_query/player_clan = SSdbcore.NewQuery("SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id", list("clan_id" = client.clan_info.item[4]))
		player_clan.Execute()
		if(player_clan.NextRow())
			holder.color = player_clan.item[5]

	hud_list[HUNTER_CLAN] = holder

/mob/living/carbon/human/species/yautja/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, message_mode)
	. = ..()
	playsound(loc, pick('sound/voice/predator/click1.ogg', 'sound/voice/predator/click2.ogg'), 25, 1)

/mob/living/carbon/human/species/yautja/get_idcard(hand_first = TRUE)
	. = ..()
	if(!.)
		var/obj/item/clothing/gloves/yautja/hunter/bracer = gloves
		if(istype(bracer))
			. = bracer.embedded_id
	return .

/mob/living/carbon/human/species/yautja/get_reagent_tags()
	return species?.reagent_tag

/mob/living/carbon/human/species/yautja/can_be_operated_on(mob/user)
	return TRUE
