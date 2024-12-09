/datum/species
	/// Species name
	var/name
	var/name_plural
	/// What kind of species it is considered
	var/species_type = SPECIES_HUMAN

	/// Normal icon file
	var/icobase = 'icons/mob/human_races/r_human.dmi'
	/// Icon state for calculating brute damage icons
	var/brute_damage_icon_state = "human_brute"
	/// Icon state for calculating brute damage icons
	var/burn_damage_icon_state = "human_burn"
	/// Damage mask icon we want to use when drawing wounds
	var/damage_mask_icon = 'icons/mob/dam_mask.dmi'
	/// If set, draws this from icobase when mob is prone.
	var/prone_icon
	/// Icon for eyes
	var/eyes = "eyes_s"

	/// For empty hand harm-intent attack
	var/datum/unarmed_attack/unarmed
	/// For empty hand harm-intent attack if the first fails.
	var/datum/unarmed_attack/secondary_unarmed
	var/datum/hud_data/hud
	var/hud_type
	var/slowdown = 0
	var/taste_sensitivity = TASTE_NORMAL
	var/datum/unarmed_attack/unarmed_type = /datum/unarmed_attack
	var/secondary_unarmed_type = /datum/unarmed_attack/bite
	var/default_language_holder = /datum/language_holder
	var/speech_verb_override
	/// The names of secondary languages that are available to this species.
	var/secondary_langs = list()
	/// A list of sounds to potentially play when speaking.
	var/list/speech_sounds
	var/list/speech_chance
	/// Does this count as a human?
	var/count_human = FALSE

	/// Inventory slots the race can't equip stuff to. Robots cannot wear shoes and gloves, for example.
	var/list/no_equip = list()

	// Some species-specific gibbing data.
	var/gibbed_anim = "gibbed-h"
	var/dusted_anim = "dust-h"
	var/remains_type = /obj/effect/decal/cleanable/ash
	var/death_sound
	var/death_message = "seizes up and falls limp, their eyes dead and lifeless..."

	/// new maxHealth [/mob/living/carbon/human/var/maxHealth] of the human mob once species is applied
	var/total_health = 100
	var/max_stamina = 50

	/// Cold damage level 1 below this point.
	var/cold_level_1 = BODYTEMP_COLD_DAMAGE_LIMIT_ONE
	/// Cold damage level 2 below this point.
	var/cold_level_2 = BODYTEMP_COLD_DAMAGE_LIMIT_TWO
	/// Cold damage level 3 below this point.
	var/cold_level_3 = BODYTEMP_COLD_DAMAGE_LIMIT_THREE

	/// Heat damage level 1 above this point.
	var/heat_level_1 = BODYTEMP_HEAT_DAMAGE_LIMIT_ONE
	/// Heat damage level 2 above this point.
	var/heat_level_2 = BODYTEMP_HEAT_DAMAGE_LIMIT_TWO
	/// Heat damage level 2 above this point.
	var/heat_level_3 = BODYTEMP_HEAT_DAMAGE_LIMIT_THREE

	/// non-IS_SYNTHETIC species will try to stabilize at this temperature. (also affects temperature processing)
	var/body_temperature = BODYTEMP_NORMAL
	/// Used for metabolizing reagents.
	var/reagent_tag

	/// Converts into see_in_dark on update_sight()
	var/darksight = 2

	/// Physical damage reduction/malus.
	var/brute_mod = null
	/// Burn damage reduction/malus.
	var/burn_mod = null

	/// Whether this mob will tell when the user has logged out
	var/is_sentient = TRUE

	/// Generic traits tied to having the species.
	var/list/inherent_traits = list()
	/// Various specific features.
	var/species_flags = NONE

	var/list/preferences = list()
	var/list/screams = list()
	var/list/paincries = list()
	var/list/goredcries = list()
	var/list/gasps = list()
	var/list/coughs = list()
	var/list/burstscreams = list()
	var/list/warcries = list()
	var/list/laughs = list()

	/// Red.
	var/blood_color = "#A10808"
	/// Pink.
	var/flesh_color = "#FFC896"
	/// Used when setting species.
	var/base_color
	/// If the species only has one hair color
	var/hair_color

	// Used in icon caching.
	var/race_key = 0
	var/icon/icon_template

	/// inherent Species-specific verbs.
	var/list/inherent_verbs
	/// inherent species-specific actions
	var/list/inherent_actions
	var/list/has_organ = list(
		ORGAN_SLOT_HEART = /datum/internal_organ/heart,
		ORGAN_SLOT_LUNGS = /datum/internal_organ/lungs,
		ORGAN_SLOT_LIVER = /datum/internal_organ/liver,
		ORGAN_SLOT_STOMACH = /datum/internal_organ/stomach,
		ORGAN_SLOT_KIDNEYS = /datum/internal_organ/kidneys,
		ORGAN_SLOT_BRAIN = /datum/internal_organ/brain,
		ORGAN_SLOT_APPENDIX = /datum/internal_organ/appendix,
		ORGAN_SLOT_EYES = /datum/internal_organ/eyes
	)
	var/lighting_alpha
	var/see_in_dark

	var/datum/namepool/namepool = /datum/namepool
	/// Special death message that gets overwritten if possible.
	var/special_death_message = "You have perished."
	/// Whether it is possible with this race roundstart
	var/joinable_roundstart = FALSE

/datum/species/New()
	if(hud_type)
		hud = new hud_type()
	else
		hud = new()

	if(unarmed_type)
		unarmed = new unarmed_type()
	if(secondary_unarmed_type)
		secondary_unarmed = new secondary_unarmed_type()
	if(species_flags & GREYSCALE_BLOOD)
		brute_damage_icon_state = "grayscale"

/// Handles creation of mob organs and limbs.
/datum/species/proc/create_organs(mob/living/carbon/human/organless_human)

	organless_human.limbs = list()
	organless_human.internal_organs = list()
	organless_human.internal_organs_by_name = list()

	//This is a basic humanoid limb setup.
	var/datum/limb/chest/new_chest = new(null, organless_human)
	organless_human.limbs += new_chest
	var/datum/limb/groin/new_groin = new(new_chest, organless_human)
	organless_human.limbs += new_groin
	organless_human.limbs += new/datum/limb/head(new_chest, organless_human)
	var/datum/limb/l_arm/new_l_arm = new(new_chest, organless_human)
	organless_human.limbs += new_l_arm
	var/datum/limb/r_arm/new_r_arm = new(new_chest, organless_human)
	organless_human.limbs += new_r_arm
	var/datum/limb/l_leg/new_l_leg = new(new_groin, organless_human)
	organless_human.limbs += new_l_leg
	var/datum/limb/r_leg/new_r_leg = new(new_groin, organless_human)
	organless_human.limbs += new_r_leg
	organless_human.limbs += new/datum/limb/hand/l_hand(new_l_arm, organless_human)
	organless_human.limbs += new/datum/limb/hand/r_hand(new_r_arm, organless_human)
	organless_human.limbs += new/datum/limb/foot/l_foot(new_l_leg, organless_human)
	organless_human.limbs += new/datum/limb/foot/r_foot(new_r_leg, organless_human)

	for(var/datum/internal_organ/organ AS in has_organ)
		var/datum/internal_organ/organ_type = has_organ[organ]
		organless_human.internal_organs_by_name[organ] = new organ_type(organless_human)

	if(!(species_flags & ROBOTIC_LIMBS))
		return
	for(var/datum/limb/robotic_limb AS in organless_human.limbs)
		if(robotic_limb.limb_status & LIMB_DESTROYED)
			continue
		robotic_limb.add_limb_flags(LIMB_ROBOT)

///damage override at the species level, called by /mob/living/proc/apply_damage
/datum/species/proc/apply_damage(damage = 0, damagetype = BRUTE, def_zone, blocked = 0, sharp = FALSE, edge = FALSE, updating_health = FALSE, penetration, mob/living/carbon/human/victim, mob/attacker)
	var/datum/limb/organ = null
	if(isorgan(def_zone)) //Got sent a limb datum, convert to a zone define
		organ = def_zone
		def_zone = organ.name

	if(!def_zone)
		def_zone = ran_zone(def_zone)
	if(!organ)
		organ = victim.get_limb(check_zone(def_zone))
	if(!organ)
		return FALSE

	if(isnum(blocked))
		damage -= clamp(damage * (blocked - penetration) * 0.01, 0, damage)
	else
		damage = victim.modify_by_armor(damage, blocked, penetration, def_zone)

	if(victim.protection_aura)
		damage = round(damage * ((20 - victim.protection_aura) / 20))

	if(!damage)
		return FALSE

	switch(damagetype)
		if(BRUTE)
			victim.damageoverlaytemp = 20
			if(brute_mod)
				damage *= brute_mod
			var/old_status = organ.limb_status
			if(organ.take_damage_limb(damage, 0, sharp, edge))
				victim.UpdateDamageIcon()
				record_internal_injury(victim, attacker, old_status, organ.limb_status)
		if(BURN)
			victim.damageoverlaytemp = 20
			if(burn_mod)
				damage *= burn_mod
			if(organ.take_damage_limb(0, damage, sharp, edge))
				victim.UpdateDamageIcon()
				return
			switch(damage)
				if(-INFINITY to 0)
					return FALSE
				if(25 to 50)
					if(prob(20))
						victim.emote("pain")
				if(50 to INFINITY)
					if(prob(60))
						victim.emote("pain")
		if(TOX)
			victim.adjustToxLoss(damage)
		if(OXY)
			victim.adjustOxyLoss(damage)
		if(CLONE)
			victim.adjustCloneLoss(damage)
		if(STAMINA)
			if(species_flags & NO_STAMINA)
				return
			victim.adjustStaminaLoss(damage)

	// Will set our damageoverlay icon to the next level, which will then be set back to the normal level the next mob.Life().
	SEND_SIGNAL(victim, COMSIG_HUMAN_DAMAGE_TAKEN, damage)

	if(updating_health)
		victim.updatehealth()
	return damage

/// Handles how the species hugs another mobs.
/datum/species/proc/hug(mob/living/carbon/human/H, mob/living/target)
	if(H.zone_selected == "head")
		H.visible_message(span_notice("[H] pats [target] on the head."), \
			span_notice("You pat [target] on the head."), null, 4)
	else if(H.zone_selected == "l_hand" && CONFIG_GET(flag/fun_allowed))
		H.visible_message(span_notice("[H] holds [target] 's left hand."), \
			span_notice("You hold [target]'s left hand."), null, 4)
	else if (H.zone_selected == "r_hand" && CONFIG_GET(flag/fun_allowed))
		H.visible_message(span_notice("[H] holds [target] 's right hand."), \
			span_notice("You hold [target]'s right hand."), null, 4)
	else
		H.visible_message(span_notice("[H] hugs [target] to make [target.p_them()] feel better!"), \
			span_notice("You hug [target] to make [target.p_them()] feel better!"), null, 4)

/// Handles setting of the random name.
/datum/species/proc/random_name(gender)
	return GLOB.namepool[namepool].get_random_name(gender)

/datum/species/proc/prefs_name(datum/preferences/prefs)
	return prefs.real_name

/// What will this species do on being gained by human
/datum/species/proc/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	SHOULD_CALL_PARENT(TRUE) //remember to call base procs kids
	for(var/slot_id in no_equip)
		var/obj/item/thing = H.get_item_by_slot(slot_id)
		if(thing && !is_type_in_list(src,thing.species_exception))
			H.dropItemToGround(thing)
	for(var/newtrait in inherent_traits)
		ADD_TRAIT(H, newtrait, SPECIES_TRAIT)
	H.maxHealth += total_health - (old_species ? old_species.total_health : initial(H.maxHealth))

/// Special things to change after we're no longer that species
/datum/species/proc/post_species_loss(mob/living/carbon/human/H)
	SHOULD_CALL_PARENT(TRUE)
	for(var/oldtrait in inherent_traits)
		REMOVE_TRAIT(H, oldtrait, SPECIES_TRAIT)

/// Removes all species-specific verbs and actions
/datum/species/proc/remove_inherent_abilities(mob/living/carbon/human/H)
	if(inherent_verbs)
		remove_verb(H, inherent_verbs)
	if(inherent_actions)
		for(var/action_path in inherent_actions)
			var/datum/action/old_species_action = H.actions_by_path[action_path]
			qdel(old_species_action)
	return

/// Adds all species-specific verbs and actions
/datum/species/proc/add_inherent_abilities(mob/living/carbon/human/H)
	if(inherent_verbs)
		add_verb(H, inherent_verbs)
	if(inherent_actions)
		for(var/action_path in inherent_actions)
			var/datum/action/new_species_action = new action_path(H)
			new_species_action.give_action(H)
	return

/// Handles anything not already covered by basic species assignment.
/datum/species/proc/handle_post_spawn(mob/living/carbon/human/H)
	add_inherent_abilities(H)

/// Handles any species-specific death events.
/datum/species/proc/handle_death(mob/living/carbon/human/H)
	return

//TODO KILL ME
///Snowflake proc for monkeys so they can call attackpaw
/datum/species/proc/spec_unarmedattack(mob/living/carbon/human/user, atom/target)
	return FALSE

//Only used by horrors at the moment. Only triggers if the mob is alive and not dead.
/datum/species/proc/handle_unique_behavior(mob/living/carbon/human/H)
	return

/datum/species/proc/handle_fire(mob/living/carbon/human/H)
	return

/datum/species/proc/update_body(mob/living/carbon/human/H)
	return

/datum/species/proc/update_inv_head(mob/living/carbon/human/H)
	return

/datum/species/proc/update_inv_w_uniform(mob/living/carbon/human/H)
	return

/datum/species/proc/update_inv_wear_suit(mob/living/carbon/human/H)
	return

/datum/species/proc/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(CHECK_BITFIELD(species_flags, NO_CHEM_METABOLIZATION)) //explicit
		H.reagents.del_reagent(chem.type) //for the time being
		return TRUE
	if(CHECK_BITFIELD(species_flags, NO_POISON) && istype(chem, /datum/reagent/toxin))
		H.reagents.remove_reagent(chem.type, chem.custom_metabolism * H.metabolism_efficiency)
		return TRUE
	if(CHECK_BITFIELD(species_flags, NO_OVERDOSE)) //no stacking
		if(chem.overdose_threshold && chem.volume > chem.overdose_threshold)
			H.reagents.remove_reagent(chem.type, chem.volume - chem.overdose_threshold)
	return FALSE

///Called when using the shredding behavior.
/datum/species/proc/can_shred(mob/living/carbon/human/H)
	if(H.a_intent != INTENT_HARM)
		return FALSE

	if(unarmed.is_usable(H))
		if(unarmed.shredding)
			return TRUE
	else if(secondary_unarmed.is_usable(H))
		if(secondary_unarmed.shredding)
			return TRUE
	return FALSE
