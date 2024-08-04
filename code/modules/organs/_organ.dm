/obj/item/organ
	name = "organ"
	desc = "It looks like it probably just plopped out."
	icon = 'icons/obj/items/organs.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/items/bodyparts_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/bodyparts_right.dmi',
	)
	/// Reference to the mob owning the organs
	var/mob/living/carbon/human/owner = null
	/// Reference to the limb we're inside of
	var/datum/limb/parent_limb = BODY_ZONE_CHEST
	/// amount of damage to the organ
	var/damage = 0
	/// amount of damage after which the organ gets bruised flag
	var/min_bruised_damage = 10
	/// amount of damage after which the organ gets broken flag
	var/min_broken_damage = 30
	/// State of the organ
	var/organ_status = ORGAN_HEALTHY
	/// What slot does it go in?
	var/slot

/* Do something with this
/datum/internal_organ/New(mob/living/carbon/carbon_mob)
	..()
	if(!istype(carbon_mob))
		return

	carbon_mob.internal_organs |= src
	owner = carbon_mob

	var/mob/living/carbon/human/human = carbon_mob
	var/datum/limb/limb = human.get_limb(parent_limb)
	LAZYDISTINCTADD(limb.internal_organs, src)
*/

/obj/item/organ/Destroy()
	clean_owner()
	return ..()

///Signal handler to prevent hard del
/obj/item/organ/proc/clean_owner()
	SIGNAL_HANDLER
	owner = null

/obj/item/organ/proc/get_damage(amount, silent = FALSE)
	if(SSticker.mode?.flags_round_type & MODE_NO_PERMANENT_WOUNDS)
		return
	if(amount <= 0)
		heal_organ_damage(-amount)
		return
	damage += amount

	var/datum/limb/parent = owner.get_limb(parent_limb)
	if(!silent)
		owner.custom_pain("Something inside your [parent.display_name] hurts a lot.", 1)
	set_organ_status()

/obj/item/organ/proc/heal_organ_damage(amount)
	damage = max(damage - amount, 0)
	set_organ_status()

/// Set the correct organ state
/obj/item/organ/proc/set_organ_status()
	if(damage > min_broken_damage)
		if(organ_status != ORGAN_BROKEN)
			organ_status = ORGAN_BROKEN
			return TRUE
		return FALSE
	if(damage > min_bruised_damage)
		if(organ_status != ORGAN_BRUISED)
			organ_status = ORGAN_BRUISED
			return TRUE
		return FALSE
	if(organ_status != ORGAN_HEALTHY)
		organ_status = ORGAN_HEALTHY
		return TRUE
