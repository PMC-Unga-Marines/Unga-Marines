//FEB 2024 NOTE: some of these are missing loading_sounds, fix it before using these ingame
//Special ammo magazines for hardpoint modules. Some may not be here since you can use normal magazines on them
/obj/item/ammo_magazine/tank
	icon = 'icons/obj/items/ammo/tank.dmi'
	magazine_flags = NONE
	///loading sound to play when
	var/loading_sound

/obj/item/ammo_magazine/tank/ltb_cannon
	name = "high explosive LTB round"
	desc = "A primary armament cannon magazine"
	caliber = CALIBER_84MM
	icon_state = "ltb"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/ltb
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/ltb_cannon/apfds
	name = "LTB APFDS round (105mm)"
	desc = "A 105mm armor piercing shell with exceptional velocity and penetrating characteristics. Will pierce through walls and targets."
	icon_state = "ltb_apfds"
	default_ammo = /datum/ammo/bullet/tank_apfds

/obj/item/ammo_magazine/tank/towlauncher
	name = "TOW Launcher Magazine"
	desc = "A primary armament rocket magazine"
	caliber = CALIBER_68MM
	icon_state = "quad_rocket"
	icon = 'icons/obj/items/ammo/rocket.dmi'
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/ap //Fun fact, AP rockets seem to be a straight downgrade from normal rockets. Maybe I'm missing something...
	max_rounds = 5

/obj/item/ammo_magazine/tank/ltaap_chaingun
	name = "\improper LTA-AP chaingun Magazine"
	desc = "A primary armament chaingun magazine."
	caliber = CALIBER_762X51
	icon_state = "ltaap"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/bullet/minigun/ltaap
	max_rounds = 150
	loading_sound = 'sound/weapons/guns/interact/working_the_bolt.ogg'

/obj/item/ammo_magazine/tank/secondary_cupola
	name = "HSG-102 Cupola Magazine"
	desc = "A secondary armament MG magazine"
	caliber = CALIBER_10X28
	icon_state = "cupola"
	loading_sound = 'sound/weapons/guns/interact/working_the_bolt.ogg'
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/bullet/cupola
	max_rounds = 75

/obj/item/ammo_magazine/tank/secondary_flamer_tank
	name = "napalm stream tank"
	desc = "A fuel tank containing fuel for the secondary vehicle mounted flamer. This tank contains a more fluid mix that flows easier but flames less area at once."
	caliber = CALIBER_FUEL_THICK
	icon_state = "sflamer"
	max_rounds = 150
	default_ammo = /datum/ammo/flamethrower/armored_spray

/obj/item/ammo_magazine/tank/tank_glauncher
	name = "Grenade Launcher Magazine"
	desc = "A secondary armament grenade magazine"
	caliber = CALIBER_40MM
	icon_state = "glauncher_2"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/grenade_container
	max_rounds = 10

/obj/item/ammo_magazine/tank/tank_glauncher/update_icon_state()
	if(current_rounds >= max_rounds)
		icon_state = "glauncher_2"
	else if(current_rounds <= 0)
		icon_state = "glauncher_0"
	else
		icon_state = "glauncher_1"

/obj/item/ammo_magazine/tank/tank_slauncher
	name = "Smoke Launcher Magazine"
	desc = "A support armament grenade magazine"
	caliber = CALIBER_40MM
	icon_state = "slauncher_1"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/grenade_container/smoke
	max_rounds = 6

/obj/item/ammo_magazine/tank/tank_slauncher/update_icon_state()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"
