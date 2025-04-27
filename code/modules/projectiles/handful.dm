/obj/item/ammo_magazine/handful
	name = "generic handful of bullets or shells"
	desc = "A handful of rounds to reload on the go."
	equip_slot_flags = null // It only fits into pockets and such.
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 1 // So it doesn't get autofilled for no reason.
	max_rounds = 5 // For shotguns, though this will be determined by the handful type when generated.
	atom_flags = CONDUCT|DIRLOCK
	magazine_flags = MAGAZINE_HANDFUL|MAGAZINE_REFILLABLE
	attack_speed = 3 // should make reloading less painful
	icon = 'icons/obj/items/ammo/handful.dmi'
	icon_state_mini = "bullets"

/obj/item/ammo_magazine/handful/repeater
	name = "handful of heavy impact rifle bullet (.45-70 Government)"
	icon_state = "bullet"
	current_rounds = 8
	max_rounds = 8
	default_ammo = /datum/ammo/bullet/rifle/repeater
	caliber = CALIBER_4570

/obj/item/ammo_magazine/handful/slug
	name = "handful of shotgun slug (12 gauge)"
	icon_state = "shotgun slug"
	current_rounds = 5
	default_ammo = /datum/ammo/bullet/shotgun/slug
	caliber = CALIBER_12G

/obj/item/ammo_magazine/handful/buckshot
	name = "handful of shotgun buckshot shells (12g)"
	icon_state = "shotgun buckshot shell"
	current_rounds = 5
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	caliber = CALIBER_12G

/obj/item/ammo_magazine/handful/flechette
	name = "handful of shotgun flechette shells (12g)"
	icon_state = "shotgun flechette shell"
	current_rounds = 5
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	caliber = CALIBER_12G

/obj/item/ammo_magazine/handful/incendiary
	name = "handful of shotgun incendiary shells (12g)"
	icon_state = "incendiary slug"
	current_rounds = 5
	default_ammo = /datum/ammo/bullet/shotgun/incendiary
	caliber = CALIBER_12G

/obj/item/ammo_magazine/handful/heavy_buckshot
	name = "handful of shotgun buckshot shells (6g)"
	icon_state = "heavy_shotgun_buckshot"
	current_rounds = 5
	default_ammo = /datum/ammo/bullet/shotgun/heavy_buckshot
	caliber = CALIBER_6G

/obj/item/ammo_magazine/handful/barrikada
	name = "handful of shotgun 'Barrikada' shells (6g)"
	icon_state = "heavy_shotgun_barrikada"
	current_rounds = 5
	default_ammo = /datum/ammo/bullet/shotgun/barrikada_slug
	caliber = CALIBER_6G

/obj/item/ammo_magazine/handful/micro_grenade
	name = "handful of airburst micro grenades (10g)"
	icon_state = "micro_grenade_airburst"
	icon_state_mini = "40mm_cyan"
	current_rounds = 3
	max_rounds = 3
	default_ammo = /datum/ammo/bullet/micro_rail/airburst
	caliber = CALIBER_10G_RAIL

/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath
	name = "handful of dragon's breath micro grenades (10g)"
	icon_state = "micro_grenade_incendiary"
	icon_state_mini = "40mm_orange"
	default_ammo = /datum/ammo/bullet/micro_rail/dragonbreath

/obj/item/ammo_magazine/handful/micro_grenade/cluster
	name = "handful of clustermunition micro grenades (10g)"
	icon_state = "micro_grenade_cluster"
	icon_state_mini = "40mm_red"
	default_ammo = /datum/ammo/bullet/micro_rail/cluster

/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst
	name = "handful of smoke burst micro grenades (10g)"
	icon_state = "micro_grenade_smoke"
	icon_state_mini = "40mm_blue"
	default_ammo = /datum/ammo/bullet/micro_rail/smoke_burst
