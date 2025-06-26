//Species unarmed attacks
/datum/unarmed_attack
	/// Empty hand hurt intent verb.
	var/attack_verb = list("attacks")
	/// Extra empty hand attack damage.
	var/damage = 0
	/// Sound that plays when you land a punch
	var/attack_sound = "punch"
	/// Sound that plays when you miss a punch
	var/miss_sound = 'sound/weapons/punchmiss.ogg'
	/// Calls the old attack_alien() behavior on objects/mobs when on harm intent.
	var/shredding = 0
	/// Whether our unarmed attack cuts
	var/sharp = 0
	/// Whether our unarmed attack is more likely to dismember
	var/edge = 0

/datum/unarmed_attack/proc/is_usable(mob/living/carbon/human/user)
	if(user.restrained())
		return FALSE

	// Check if they have a functioning hand.
	var/datum/limb/E = user.get_limb("l_hand")
	if(E?.is_usable())
		return TRUE

	E = user.get_limb("r_hand")
	if(E?.is_usable())
		return TRUE
	return FALSE

/datum/unarmed_attack/bite
	attack_verb = list("bites") // 'x has biteed y', needs work.
	attack_sound = 'sound/weapons/bite.ogg'
	shredding = 0
	damage = 5
	sharp = 1
	edge = 1

/datum/unarmed_attack/bite/is_usable(mob/living/carbon/human/user)
	if(user.wear_mask && istype(user.wear_mask, /obj/item/clothing/mask/muzzle))
		return FALSE
	return TRUE

/datum/unarmed_attack/punch
	attack_verb = list("punches")
	damage = 3

/datum/unarmed_attack/punch/strong
	attack_verb = list("punches","busts","jabs")
	damage = 10

/datum/unarmed_attack/claws
	attack_verb = list("scratches", "claws")
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	damage = 5
	sharp = 1
	edge = 1

/datum/unarmed_attack/claws/strong
	attack_verb = list("slashes")
	damage = 10
	shredding = 1

/datum/unarmed_attack/bite/strong
	attack_verb = list("mauls")
	damage = 15
	shredding = 1
