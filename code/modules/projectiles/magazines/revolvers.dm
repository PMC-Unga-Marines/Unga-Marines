/obj/item/ammo_magazine/revolver
	name = "\improper R-44 magnum speed loader (.44)"
	desc = "A revolver speed loader."
	default_ammo = /datum/ammo/bullet/revolver
	equip_slot_flags = NONE
	caliber = CALIBER_44
	icon = 'icons/obj/items/ammo/revolver.dmi'
	icon_state = "m44"
	icon_state_mini = "mag_revolver_bronze"
	w_class = WEIGHT_CLASS_SMALL
	max_rounds = 6

/obj/item/ammo_magazine/revolver/rifle
	name = "\improper M1855 speed loader (.44LS)"
	desc = "A speed loader for the M1855, with special design to make it possible to speedload a rifle. Longer version of .44 Magnum, with uranium-neodimium core."
	icon_state = "44LS"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	max_rounds = 8

/obj/item/ammo_magazine/revolver/t500
	name = "\improper R-500 speed loader (.500)"
	icon_state = "t500"
	desc = "A R-500 'Nigredo' revolver speed loader."
	default_ammo = /datum/ammo/bullet/revolver/t500
	caliber = CALIBER_500
	max_rounds = 5

/obj/item/ammo_magazine/revolver/t500/slavs
	name = "\improper R-500 speed loader (.500 'Slavs')"
	icon_state = "t500_sv"
	default_ammo = /datum/ammo/bullet/revolver/t500/slavs

/obj/item/ammo_magazine/revolver/t312
	name = "\improper R-312 White Express speed loader (.500)"
	desc = "A R-312 'Albedo' revolver speed loader."
	icon_state = "t500_we"
	default_ammo = /datum/ammo/bullet/revolver/t312
	caliber = CALIBER_500_EMB
	max_rounds = 5

/obj/item/ammo_magazine/revolver/t312/med
	name = "R-312 EMB speed loader"
	desc = "A R-500 'Albedo' revolver speed loader."

/obj/item/ammo_magazine/revolver/t312/med/adrenaline
	name = "R-312 Adrenaline EMB speed loader"
	icon_state = "t500_adr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/adrenaline

/obj/item/ammo_magazine/revolver/t312/med/rr
	name = "R-312 Russian Red EMB speed loader"
	icon_state = "t500_rr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/rr

/obj/item/ammo_magazine/revolver/t312/med/md
	name = "R-312 Meraderm EMB speed loader"
	icon_state = "t500_md"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/md

/obj/item/ammo_magazine/revolver/t312/med/neu
	name = "R-312 Neuraline EMB speed loader"
	icon_state = "t500_neu"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/neu

/obj/item/ammo_magazine/revolver/marksman
	name = "\improper R-44 marksman speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/marksman
	caliber = CALIBER_44
	icon_state = "m_m44"
	icon_state_mini = "mag_revolver_bronze_red"

/obj/item/ammo_magazine/revolver/heavy
	name = "\improper R-44 PW-MX speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/heavy
	caliber = CALIBER_44
	icon_state = "h_m44"
	icon_state_mini = "mag_revolver_bronze_purple"

/obj/item/ammo_magazine/revolver/r44
	name = "\improper R-44 magnum speed loader (.44)"
	desc = "A revolver speed loader."
	default_ammo = /datum/ammo/bullet/revolver/r44
	equip_slot_flags = NONE
	caliber = CALIBER_44
	icon_state = "tp44"
	icon_state_mini = "mag_revolver"
	w_class = WEIGHT_CLASS_SMALL
	max_rounds = 7

/obj/item/ammo_magazine/revolver/upp
	name = "\improper N-Y speed loader (7.62x38mmR)"
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = CALIBER_762X38
	icon_state = "ny762"
	icon_state_mini = "mag_revolver_blue"


/obj/item/ammo_magazine/revolver/small
	name = "\improper 'Bote' .357 speed loader (.357)"
	desc = "A revolver speed loader loaded with special 357 rounds that bounce on impact. Be careful around friends and family!"
	default_ammo = /datum/ammo/bullet/revolver/ricochet/four
	caliber = CALIBER_357
	icon_state = "sw357"
	icon_state_mini = "mag_revolver_greyred"
	max_rounds = 6

/obj/item/ammo_magazine/revolver/mateba
	name = "\improper Mateba speed loader (.454)"
	default_ammo = /datum/ammo/bullet/revolver/highimpact
	caliber = CALIBER_454
	icon_state = "mateba"
	icon_state_mini = "mag_revolver"
	max_rounds = 6

/obj/item/ammo_magazine/revolver/cmb
	name = "\improper CMB revolver speed loader (.357)"
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = CALIBER_357
	icon_state = "cmb"
	icon_state_mini = "mag_revolver_greypurple"
	max_rounds = 6

/obj/item/ammo_magazine/revolver/judge
	name = "\improper Judge speed loader (.45L)"
	desc = "A revolver speed loader for the Judge, these rounds have a high velocity propellant, leading to next to no scatter and falloff."
	default_ammo = /datum/ammo/bullet/revolver/judge
	caliber = CALIBER_45L
	max_rounds = 5
	icon_state = "m_m44"
	icon_state_mini = "mag_revolver_bronze_red"

/obj/item/ammo_magazine/revolver/judge/buckshot
	name = "\improper Judge buckshot speed loader (.45L)"
	desc = "A revolver speed loader for the Judge, this is filled with tiny pellets inside, with high scatter but large CQC damage."
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_buckshot
	caliber = CALIBER_45L
	icon_state = "h_m44"
	icon_state_mini = "mag_revolver_bronze_purple"

/obj/item/ammo_magazine/revolver/standard_magnum
	name = "\improper R-76 speed loader (12x7mm)"
	desc = "A revolver speed loader for the R-76 Magnum, mind your shoulder, will stun most moderately sized targets on impact."
	default_ammo = /datum/ammo/bullet/revolver/t76
	max_rounds = 5
	caliber = CALIBER_12X7
	icon_state = "t76"
	icon_state_mini = "mag_revolver_red"
