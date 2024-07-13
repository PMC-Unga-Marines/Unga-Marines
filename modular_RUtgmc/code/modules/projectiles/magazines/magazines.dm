/obj/item/ammo_magazine/revolver/rifle
	name = "\improper M1855 speed loader (.44LS)"
	desc = "A speed loader for the M1855, with special design to make it possible to speedload a rifle. Longer version of .44 Magnum, with uranium-neodimium core."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "44LS"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	max_rounds = 8

/obj/item/ammo_magazine/rifle/T25
	name = "\improper T-25 magazine (10x26mm)"
	desc = "A 10mm assault rifle magazine."
	caliber = CALIBER_10x26_CASELESS
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "T25"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/T25
	max_rounds = 80
	icon_state_mini = "mag_rifle_big"

/obj/item/ammo_magazine/smg/vector
	name = "\improper Vector drum magazine (.45ACP)"
	desc = "A .45ACP HP caliber drum magazine for the Vector, with even more dakka."
	default_ammo = /datum/ammo/bullet/smg/acp
	w_class = WEIGHT_CLASS_SMALL
	caliber = CALIBER_45ACP
	icon_state = "ppsh_ext"
	max_rounds = 40 // HI-Point .45 ACP Drum mag

/obj/item/ammo_magazine/revolver/t500
	name = "\improper R-500 speed loader (.500)"
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "t500"
	desc = "A R-500 BF revolver speed loader."
	default_ammo = /datum/ammo/bullet/revolver/t500
	flags_equip_slot = NONE
	caliber = CALIBER_500
	w_class = WEIGHT_CLASS_SMALL
	max_rounds = 5

/obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended
	name = "\improper AR-21 extended skirmish rifle magazine"
	desc = "A extended magazine filled with 10x25mm rifle rounds for the AR-21."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "t21_ext"
	max_rounds = 50
	icon_state_mini = "mag_rifle_big_yellow"
	//bonus_overlay = "t21_ext"

/obj/item/ammo_magazine/rifle/T25/extended
	name = "\improper T-25 extended magazine (10x26mm)"
	desc = "A 10mm extended assault rifle magazine."
	icon_state = "T25_ext"
	max_rounds = 120
	icon_state_mini = "mag_rifle_big_yellow"
	//bonus_overlay = "T25_ext"

/obj/item/ammo_magazine/rifle/standard_carbine/ap
	name = "\improper AR-18 AP magazine (10x24mm)"
	desc = "A 10mm armor piercing carbine magazine."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "t18_ap"
	//bonus_overlay = "t18_ap"
	default_ammo = /datum/ammo/bullet/rifle/ap
	max_rounds = 36

/obj/item/ammo_magazine/rifle/standard_assaultrifle/ap
	name = "\improper AR-12 AP magazine (10x24mm)"
	desc = "A 10mm armor piercing assault rifle magazine."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "t12_ap"
	//bonus_overlay = "t12_ap"
	default_ammo = /datum/ammo/bullet/rifle/ap
	max_rounds = 50

/obj/item/ammo_magazine/rifle/standard_br/ap
	name = "\improper BR-64 AP magazine (10x26.5mm)"
	desc = "A 10mm armor piercing battle rifle magazine."
	caliber = CALIBER_10x265_CASELESS
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "t64_ap"
	//bonus_overlay = "t64_ap"
	default_ammo = /datum/ammo/bullet/rifle/standard_br/ap
	icon_state_mini = "mag_rifle_big"

/obj/item/ammo_magazine/rifle/standard_skirmishrifle/ap
	name = "\improper AR-21 skirmish AP rifle magazine"
	desc = "A magazine filled with 10x25mm armor piercing rifle rounds for the AR-21."
	icon = 'modular_RUtgmc/icons/obj/items/ammo.dmi'
	icon_state = "t21_ap"
	//bonus_overlay = "t21_ap"
	default_ammo = /datum/ammo/bullet/rifle/heavy/ap

/obj/item/ammo_magazine/rifle/som/ap
	name = "\improper V-31 AP magazine (10x24mm)"
	desc = "A 10mm rifle magazine designed for the V-31, loaded with armor piercing rounds."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "v31_ap"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/hv
	max_rounds = 50
	icon_state_mini = "mag_rifle_big_green"

