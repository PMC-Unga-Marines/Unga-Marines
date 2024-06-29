/obj/item/ammo_magazine/packet/long_special
	name = "box of .44 Long Special"
	desc = "A packet containing 40 rounds of .44 Long Special."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "44LSbox"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	current_rounds = 40
	icon_state_mini = "44LSbox"
	max_rounds = 40

/obj/item/ammo_magazine/packet/T25_rifle
	name = "box of 10x26mm high-pressure"
	desc = "A box containing 300 rounds of 10x26mm 'HP' caseless tuned for a smartgun."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_t25"
	default_ammo = /datum/ammo/bullet/rifle/T25
	caliber = CALIBER_10x26_CASELESS
	current_rounds = 300
	max_rounds = 300

/obj/item/ammo_magazine/packet/acp_smg
	name = "box of .45 ACP HP"
	desc = "A box containing common .45 ACP hollow-point rounds."
	icon_state = "box_45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	w_class = WEIGHT_CLASS_SMALL
	caliber = CALIBER_45ACP
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/t500
	name = "packet of .500 Nigro Express"
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "boxt500"
	default_ammo = /datum/ammo/bullet/revolver/t500
	caliber = CALIBER_500
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/t500/qk
	name = "packet of .500 'Queen Killer'"
	icon_state = "boxt500_qk"
	default_ammo = /datum/ammo/bullet/revolver/t500/qk

/obj/item/ammo_magazine/packet/standard_magnum
	name = "packet of .12x7mm"
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_t76"
	default_ammo = /datum/ammo/bullet/revolver/t76
	caliber = CALIBER_12x7
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/p10x24mm/ap
	desc = "A box containing 150 armor piercing rounds of 10x24mm caseless."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_10x24mm_ap"
	default_ammo = /datum/ammo/bullet/rifle/ap

/obj/item/ammo_magazine/packet/p10x25mm/ap
	desc = "A box containing 125 armor piercing rounds of 10x25mm caseless."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_10x25mm_ap"
	default_ammo = /datum/ammo/bullet/rifle/heavy/ap

/obj/item/ammo_magazine/packet/p10x265mm/ap
	desc = "A box containing 100 armor piercing rounds of 10x26.5mm caseless."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_10x265mm_ap"
	default_ammo = /datum/ammo/bullet/rifle/standard_br/ap

/obj/item/ammo_magazine/packet/p10x20mm/ap
	desc = "A packet containing 125 rounds of 10x20mm caseless."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_10x20mm_ap"
	default_ammo = /datum/ammo/bullet/smg/ap

/obj/item/ammo_magazine/packet/sg62_rifle
	name = "box of 10x27mm"
	desc = "A box containing 200 rounds of 10x27mm caseless."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "box_sg62"
	default_ammo = /datum/ammo/bullet/smarttargetrifle
	caliber = CALIBER_10x27_CASELESS
	current_rounds = 200
	max_rounds = 200
