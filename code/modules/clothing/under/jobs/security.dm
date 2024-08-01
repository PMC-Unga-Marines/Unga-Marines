/obj/item/clothing/under/rank/warden
	name = "security suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon_state = "wardenred"
	item_state = "r_suit"
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/warden/white
	name = "white security suit"
	desc = "A formal relic of years past before Nanotrasen decided it was cheaper to dye the suits red instead of washing out the blood."
	icon_state = "wardenwhite"
	item_state = "wardenwhite"

/obj/item/clothing/under/rank/security
	name = "security officer's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "securityred"
	item_state = "r_suit"
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/dispatch
	name = "dispatcher's uniform"
	desc = "A dress shirt and khakis with a security patch sewn on."
	icon_state = "dispatch"
	flags_armor_protection = CHEST|GROIN|LEGS
	siemens_coefficient = 0.9
	adjustment_variants = list()

/obj/item/clothing/under/rank/security2
	name = "security officer's uniform"
	desc = "It's made of a slightly sturdier material, to allow for robust protection."
	icon_state = "redshirt2"
	item_state = "r_suit"
	siemens_coefficient = 0.9
	adjustment_variants = list()

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	adjustment_variants = list()

/*
* Detective
*/
/obj/item/clothing/under/rank/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	item_state = "det"
	siemens_coefficient = 0.9
	adjustment_variants = list()

/obj/item/clothing/under/rank/det/grey
	name = "noir suit"
	desc = "A hard-boiled private investigator's grey suit, complete with tie clip."
	icon_state = "greydet"
	item_state = "greydet"
	adjustment_variants = list()

/*
* Head of Security
*/
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	name = "head of security's jumpsuit"
	icon_state = "hosred"
	item_state = "r_suit"
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/head_of_security/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt"
	item_state = "hosalt"

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	adjustment_variants = list()

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "You never asked for anything that stylish."
	name = "head of security's jumpsuit"
	icon_state = "jensen"
	item_state = "jensen"
	siemens_coefficient = 0.6
	adjustment_variants = list()
