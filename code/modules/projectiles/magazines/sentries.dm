/obj/item/ammo_magazine/sentry
	name = "\improper Магазин TUR-B (10x28мм)"
	desc = "Коробчатый магазин на 200 безгильзовых патронов 10х28 мм для турели \"Базис\". Вставьте в порт турели в случае отстутсвия боеприпасов."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "sentry"
	magazine_flags = NONE //can't be refilled or emptied by hand
	caliber = CALIBER_10X28
	max_rounds = 200
	default_ammo = /datum/ammo/bullet/turret

/obj/item/ammo_magazine/minisentry
	name = "\improper Магазин TUR-M (10x20мм)"
	desc = "Коробчатый магазин на 300 безгильзовых патронов 10х20 мм для турели \"Гном\". Вставьте в порт турели в случае отстутсвия боеприпасов."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "minisentry"
	magazine_flags = NONE //can't be refilled or emptied by hand
	caliber = CALIBER_10X20
	max_rounds = 300
	default_ammo = /datum/ammo/bullet/turret/mini

/obj/item/ammo_magazine/sentry_premade/dumb
	name = "M30 box magazine (10x28mm Caseless)"
	desc = "A box of 50 10x28mm caseless rounds for the ST-571 Sentry Gun. Just feed it into the sentry gun's ammo port when its ammo is depleted."
	w_class = WEIGHT_CLASS_NORMAL
	magazine_flags = NONE //can't be refilled or emptied by hand
	caliber = CALIBER_10X28
	max_rounds = 500
	default_ammo = /datum/ammo/bullet/turret/dumb

/obj/item/ammo_magazine/sentry/fob_sentry
	max_rounds = INFINITY

// Sniper Sentry

/obj/item/ammo_magazine/sentry/sniper
	name = "\improper Магазин TUR-SN (9x39мм)"
	desc = "Коробчатый магазин на 50 безгильзовых патронов 9х39 мм для турели \"Оса\". Вставьте в порт турели в случае отстутсвия боеприпасов."
	icon_state = "sentry_sniper"
	max_rounds = 50
	default_ammo = /datum/ammo/bullet/turret/sniper

/obj/item/ammo_magazine/sentry/shotgun
	name = "\improper Магазин TUR-SH (12G)"
	desc = "Коробчатый магазин на 75 специализированных патронов 12 калибра для турели \"Бык\". Вставьте в порт турели в случае отстутсвия боеприпасов."
	caliber = CALIBER_12G
	icon_state = "sentry_shotgun"
	max_rounds = 75
	default_ammo = /datum/ammo/bullet/turret/buckshot

// Flamer Sentry

/obj/item/ammo_magazine/flamer_tank/large/sentry
	name = "\improper Малый бак TUR-F (Горючее)"
	desc = "Малый бак на 5 литров горючего для турели \"Феникс\". Вставьте в порт турели в случае отстутсвия горючего."
	icon_state = "sentry_flamer"
	icon = 'icons/obj/items/ammo/stationary.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 75
	current_rounds = 75
	reload_delay = 3 SECONDS

	default_ammo = /datum/ammo/flamethrower/turret
