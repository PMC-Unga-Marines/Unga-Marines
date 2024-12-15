/obj/vehicle/sealed/armored/multitile
	name = "\improper MT - Banteng"
	desc = "A gigantic wall of metal designed for maximum Xeno destruction. Drag yourself onto it at an entrance to get inside."
	icon = 'icons/obj/armored/3x3/tank.dmi'
	turret_icon = 'icons/obj/armored/3x3/tank_gun.dmi'
	damage_icon_path = 'icons/obj/armored/3x3/tank_damage.dmi'
	icon_state = "tank"
	hitbox = /obj/hitbox
	interior = /datum/interior/armored
	minimap_icon_state = "tank"
	required_entry_skill = SKILL_LARGE_VEHICLE_DEFAULT
	flags_atom = DIRLOCK|BUMP_ATTACKABLE|PREVENT_CONTENTS_EXPLOSION|CRITICAL_ATOM
	flags_armored = ARMORED_HAS_PRIMARY_WEAPON|ARMORED_HAS_SECONDARY_WEAPON|ARMORED_HAS_UNDERLAY|ARMORED_HAS_HEADLIGHTS|ARMORED_PURCHASABLE_ASSAULT
	light_system = MOVABLE_LIGHT
	light_pixel_x = 32
	light_pixel_y= 32
	pixel_x = -56
	pixel_y = -48
	max_integrity = 700
	soft_armor = list(MELEE = 40, BULLET = 99 , LASER = 99, ENERGY = 60, BOMB = 60, BIO = 60, FIRE = 50, ACID = 40)
	hard_armor = list(MELEE = 0, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	permitted_mods = list(/obj/item/tank_module/overdrive, /obj/item/tank_module/ability/zoom)
	permitted_weapons = list(/obj/item/armored_weapon, /obj/item/armored_weapon/ltaap, /obj/item/armored_weapon/secondary_weapon, /obj/item/armored_weapon/secondary_flamer)
	max_occupants = 4
	move_delay = 0.75 SECONDS
	glide_size = 2.5
	ram_damage = 100
	easy_load_list = list(
		/obj/item/ammo_magazine/tank,
	)
	///pass_flags given to desants, in addition to the vehicle's pass_flags
	var/desant_pass_flags = PASS_FIRE|PASS_LOW_STRUCTURE

/obj/vehicle/sealed/armored/multitile/enter_locations(atom/movable/entering_thing)
	return list(get_step_away(get_step(src, REVERSE_DIR(dir)), src, 2))

/obj/vehicle/sealed/armored/multitile/exit_location(atom/movable/M)
	return pick(enter_locations(M))

/obj/vehicle/sealed/armored/multitile/enter_checks(mob/entering_mob, loc_override = FALSE)
	. = ..()
	if(!.)
		return
	return (loc_override || (entering_mob.loc in enter_locations(entering_mob)))

/obj/vehicle/sealed/armored/multitile/add_desant(mob/living/new_desant)
	new_desant.pass_flags |= (desant_pass_flags|pass_flags)

/obj/vehicle/sealed/armored/multitile/remove_desant(mob/living/old_desant)
	old_desant.pass_flags &= ~(desant_pass_flags|pass_flags)

/obj/vehicle/sealed/armored/multitile/ex_act(severity)
	if(QDELETED(src))
		return
	take_damage(severity, BRUTE, BOMB, 0)

/obj/vehicle/sealed/armored/multitile/lava_act()
	if(QDELETED(src))
		return
	take_damage(30, BURN, FIRE)
