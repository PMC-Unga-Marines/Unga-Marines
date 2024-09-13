//Random spawners for multiple grouped items such as a gun and it's associated ammo

/obj/effect/spawner/random_set
	name = "Random Object"
	desc = "This item type is used to spawn random objects at round-start"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	/// this variable determines the likelyhood that this random object will not spawn anything
	var/spawn_nothing_percentage = 0
	///the list of what actually gets spawned
	var/list/spawned_gear_list
	///this is formatted as a list, which itself contains any number of lists. Each set of items that should be spawned together must be added as a list in option_list. One of those lists will be randomly chosen to spawn.
	var/list/option_list

// creates a new set of objects and deletes itself
/obj/effect/spawner/random_set/Initialize(mapload)
	. = ..()
	if(!prob(spawn_nothing_percentage))
		var/choice = rand(1, length(option_list)) //chooses an item on the option_list
		spawned_gear_list = option_list[choice] //sets it as the thing(s) to spawn
		for(var/typepath in spawned_gear_list)
			if(spawned_gear_list[typepath])
				new typepath(loc, spawned_gear_list[typepath])
			else
				new typepath(loc)
	return INITIALIZE_HINT_QDEL

//restricted to ballistic weapons available on the ship, no auto-9s here
/obj/effect/spawner/random_set/gun
	name = "Random ballistic weapon set spawner"
	icon = 'icons/effects/random/weaponry.dmi'
	icon_state = "random_rifle"

	option_list = list(
		list(/obj/item/weapon/gun/rifle/ar12,
			/obj/item/ammo_magazine/rifle/ar12,
			/obj/item/ammo_magazine/rifle/ar12,
			/obj/item/ammo_magazine/rifle/ar12,
		),
		list(/obj/item/weapon/gun/rifle/ar18,
			/obj/item/ammo_magazine/rifle/ar18,
			/obj/item/ammo_magazine/rifle/ar18,
			/obj/item/ammo_magazine/rifle/ar18,
		),
		list(/obj/item/weapon/gun/rifle/ar21,
			/obj/item/ammo_magazine/rifle/ar21,
			/obj/item/ammo_magazine/rifle/ar21,
			/obj/item/ammo_magazine/rifle/ar21,
		),
		list(/obj/item/weapon/gun/rifle/ar11/scopeless,
			/obj/item/ammo_magazine/rifle/ar11,
			/obj/item/ammo_magazine/rifle/ar11,
			/obj/item/ammo_magazine/rifle/ar11,
		),
		list(/obj/item/weapon/gun/smg/smg90,
			/obj/item/ammo_magazine/smg/smg90,
			/obj/item/ammo_magazine/smg/smg90,
			/obj/item/ammo_magazine/smg/smg90,
		),
		list(/obj/item/weapon/gun/smg/mp19,
			/obj/item/ammo_magazine/smg/mp19,
			/obj/item/ammo_magazine/smg/mp19,
			/obj/item/ammo_magazine/smg/mp19,
		),
		list(/obj/item/weapon/gun/rifle/dmr37,
			/obj/item/ammo_magazine/rifle/dmr37,
			/obj/item/ammo_magazine/rifle/dmr37,
			/obj/item/ammo_magazine/rifle/dmr37,
		),
		list(/obj/item/weapon/gun/rifle/br64,
			/obj/item/ammo_magazine/rifle/br64,
			/obj/item/ammo_magazine/rifle/br64,
			/obj/item/ammo_magazine/rifle/br64,
		),
		list(/obj/item/weapon/gun/rifle/sr127,
			/obj/item/ammo_magazine/rifle/sr127,
			/obj/item/ammo_magazine/rifle/sr127,
			/obj/item/ammo_magazine/rifle/sr127,
		),
		list(/obj/item/weapon/gun/shotgun/pump/bolt/unscoped,
			/obj/item/ammo_magazine/rifle/bolt,
			/obj/item/ammo_magazine/rifle/bolt,
			/obj/item/ammo_magazine/rifle/bolt,
		),
		list(/obj/item/weapon/gun/shotgun/double/martini,
			/obj/item/ammo_magazine/rifle/martini,
			/obj/item/ammo_magazine/rifle/martini,
			/obj/item/ammo_magazine/rifle/martini,
		),
		list(/obj/item/weapon/gun/pistol/p14,
			/obj/item/ammo_magazine/pistol/p14,
			/obj/item/ammo_magazine/pistol/p14,
			/obj/item/ammo_magazine/pistol/p14,
		),
		list(/obj/item/weapon/gun/pistol/p23,
			/obj/item/ammo_magazine/pistol/p23,
			/obj/item/ammo_magazine/pistol/p23,
			/obj/item/ammo_magazine/pistol/p23,
		),
		list(/obj/item/weapon/gun/revolver/r44,
			/obj/item/ammo_magazine/revolver/r44,
			/obj/item/ammo_magazine/revolver/r44,
			/obj/item/ammo_magazine/revolver/r44,
		),
		list(/obj/item/weapon/gun/pistol/p17,
			/obj/item/ammo_magazine/pistol/p17,
			/obj/item/ammo_magazine/pistol/p17,
			/obj/item/ammo_magazine/pistol/p17,
		),
		list(/obj/item/weapon/gun/pistol/vp70,
			/obj/item/ammo_magazine/pistol/vp70,
			/obj/item/ammo_magazine/pistol/vp70,
			/obj/item/ammo_magazine/pistol/vp70,
		),
		list(/obj/item/weapon/gun/pistol/plasma_pistol,
			/obj/item/ammo_magazine/pistol/plasma_pistol,
			/obj/item/ammo_magazine/pistol/plasma_pistol,
			/obj/item/ammo_magazine/pistol/plasma_pistol,
		),
		list(/obj/item/weapon/gun/shotgun/double/derringer,
			/obj/item/ammo_magazine/pistol/derringer,
			/obj/item/ammo_magazine/pistol/derringer,
			/obj/item/ammo_magazine/pistol/derringer,
		),
		list(/obj/item/weapon/gun/rifle/pepperball,
			/obj/item/ammo_magazine/rifle/pepperball,
			/obj/item/ammo_magazine/rifle/pepperball,
			/obj/item/ammo_magazine/rifle/pepperball,
		),
		list(/obj/item/weapon/gun/shotgun/pump/lever/repeater,
			/obj/item/ammo_magazine/packet/p4570,
			/obj/item/ammo_magazine/packet/p4570,
			/obj/item/ammo_magazine/packet/p4570,
		),
		list(/obj/item/weapon/gun/shotgun/double/marine,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
		),
		list(/obj/item/weapon/gun/rifle/sh15,
			/obj/item/ammo_magazine/rifle/sh15_slug,
			/obj/item/ammo_magazine/rifle/sh15_slug,
			/obj/item/ammo_magazine/rifle/sh15_slug,
		),
		list(/obj/item/weapon/gun/shotgun/combat/standardmarine,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
		),
	)

//random rifles
/obj/effect/spawner/random_set/rifle
	name = "Random rifle set spawner"
	icon = 'icons/effects/random/weaponry.dmi'
	icon_state = "random_rifle"

	option_list = list(
		list(/obj/item/weapon/gun/rifle/ar12,
			/obj/item/ammo_magazine/rifle/ar12,
			/obj/item/ammo_magazine/rifle/ar12,
			/obj/item/ammo_magazine/rifle/ar12,
		),
		list(/obj/item/weapon/gun/rifle/ar18,
			/obj/item/ammo_magazine/rifle/ar18,
			/obj/item/ammo_magazine/rifle/ar18,
			/obj/item/ammo_magazine/rifle/ar18,
		),
		list(/obj/item/weapon/gun/rifle/ar21,
			/obj/item/ammo_magazine/rifle/ar21,
			/obj/item/ammo_magazine/rifle/ar21,
			/obj/item/ammo_magazine/rifle/ar21,
		),
		list(/obj/item/weapon/gun/rifle/ar11/scopeless,
			/obj/item/ammo_magazine/rifle/ar11,
			/obj/item/ammo_magazine/rifle/ar11,
			/obj/item/ammo_magazine/rifle/ar11,
		),
	)

//random shotguns
/obj/effect/spawner/random_set/shotgun
	name = "Random shotgun set spawner"
	icon = 'icons/effects/random/weaponry.dmi'
	icon_state = "random_shotgun"

	option_list = list(
		list(/obj/item/weapon/gun/shotgun/pump/bolt/unscoped,
			/obj/item/ammo_magazine/rifle/bolt,
			/obj/item/ammo_magazine/rifle/bolt,
			/obj/item/ammo_magazine/rifle/bolt,
		),
		list(/obj/item/weapon/gun/shotgun/double/marine,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
		),
		list(/obj/item/weapon/gun/rifle/sh15,
			/obj/item/ammo_magazine/rifle/sh15_slug,
			/obj/item/ammo_magazine/rifle/sh15_slug,
			/obj/item/ammo_magazine/rifle/sh15_slug,
		),
		list(/obj/item/weapon/gun/shotgun/combat/standardmarine,
			/obj/item/ammo_magazine/shotgun/flechette,
			/obj/item/ammo_magazine/shotgun/flechette,
			/obj/item/ammo_magazine/shotgun/flechette,
		),
		list(/obj/item/weapon/gun/shotgun/pump/t35,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
		),
		list(/obj/item/weapon/gun/shotgun/pump/cmb,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
			/obj/item/ammo_magazine/shotgun/buckshot,
		),
	)

//random machineguns
/obj/effect/spawner/random_set/machineguns
	name = "Random machinegun set spawner"
	icon = 'icons/effects/random/weaponry.dmi'
	icon_state = "random_machinegun"

	option_list = list(
		list(/obj/item/weapon/gun/rifle/mg60,
			/obj/item/ammo_magazine/mg60,
			/obj/item/ammo_magazine/mg60,
			/obj/item/ammo_magazine/mg60,
		),
		list(/obj/item/weapon/gun/mg27,
			/obj/item/ammo_magazine/mg27,
			/obj/item/ammo_magazine/mg27,
			/obj/item/ammo_magazine/mg27,
		),
	)

//random sidearms
/obj/effect/spawner/random_set/sidearms
	name = "Random sidearm set spawner"
	icon = 'icons/effects/random/weaponry.dmi'
	icon_state = "random_sidearm"

	option_list = list(
		list(/obj/item/weapon/gun/pistol/p14,
			/obj/item/ammo_magazine/pistol/p14,
			/obj/item/ammo_magazine/pistol/p14,
			/obj/item/ammo_magazine/pistol/p14,
		),
		list(/obj/item/weapon/gun/pistol/p23,
			/obj/item/ammo_magazine/pistol/p23,
			/obj/item/ammo_magazine/pistol/p23,
			/obj/item/ammo_magazine/pistol/p23,
		),
		list(/obj/item/weapon/gun/revolver/r44,
			/obj/item/ammo_magazine/revolver/r44,
			/obj/item/ammo_magazine/revolver/r44,
			/obj/item/ammo_magazine/revolver/r44,
		),
		list(/obj/item/weapon/gun/revolver/cmb, /obj/item/ammo_magazine/revolver/cmb, /obj/item/ammo_magazine/revolver/cmb, /obj/item/ammo_magazine/revolver/cmb,),
		list(/obj/item/weapon/gun/pistol/p17, /obj/item/ammo_magazine/pistol/p17, /obj/item/ammo_magazine/pistol/p17, /obj/item/ammo_magazine/pistol/p17,),
		list(/obj/item/weapon/gun/pistol/vp70, /obj/item/ammo_magazine/pistol/vp70, /obj/item/ammo_magazine/pistol/vp70, /obj/item/ammo_magazine/pistol/vp70,),
	)
