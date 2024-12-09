/obj/effect/spawner/random/weaponry
	name = "Random base clothing spawner"
	icon = 'icons/effects/random/weaponry.dmi'
	icon_state = "random_sidearm"
	loot = list(
		/obj/structure/prop/mainship/errorprop,
	)

/obj/effect/spawner/random/weaponry/gun //restricted to ballistic weapons available on the ship, no auto-9s here
	name = "Random ballistic ammunition spawner"
	icon_state = "random_rifle"
	loot = list(
		/obj/item/weapon/gun/rifle/ar12,
		/obj/item/weapon/gun/rifle/type71,
		/obj/item/weapon/gun/rifle/dmr37,
		/obj/item/weapon/gun/rifle/br64,
		/obj/item/weapon/gun/rifle/sr127,
		/obj/item/weapon/gun/shotgun/pump/bolt/unscoped,
		/obj/item/weapon/gun/shotgun/double/martini,
		/obj/item/weapon/gun/pistol/p14,
		/obj/item/weapon/gun/pistol/p23,
		/obj/item/weapon/gun/revolver/r44,
		/obj/item/weapon/gun/pistol/p17,
		/obj/item/weapon/gun/pistol/vp70,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/double/derringer,
		/obj/item/weapon/gun/rifle/pepperball,
		/obj/item/weapon/gun/shotgun/pump/lever/repeater,
		/obj/item/weapon/gun/shotgun/double/marine,
		/obj/item/weapon/gun/rifle/sh15,
		/obj/item/weapon/gun/shotgun/combat/standardmarine,
	)


///random shotguns
/obj/effect/spawner/random/weaponry/gun/shotgun
	name = "Random shotgun spawner"
	icon_state = "random_shotgun"
	loot = list(
		/obj/item/weapon/gun/shotgun/pump/lever/repeater,
		/obj/item/weapon/gun/shotgun/pump/bolt/unscoped,
		/obj/item/weapon/gun/shotgun/pump/cmb,
		/obj/item/weapon/gun/shotgun/double/marine,
		/obj/item/weapon/gun/rifle/sh15,
		/obj/item/weapon/gun/shotgun/combat/standardmarine,
		/obj/item/weapon/gun/shotgun/pump/t35,
	)

/obj/effect/spawner/random/weaponry/gun/egun
	name = "Random energy gun spawner"
	icon_state = "random_egun"
	loot = list(
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle = 25,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper = 25,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine = 25,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser = 25,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol = 25,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla = 5,
		/obj/item/weapon/gun/energy/lasgun/M43 = 5,
	)

/obj/effect/spawner/random/weaponry/gun/egun/lowchance
	spawn_loot_chance = 20

///random machineguns
/obj/effect/spawner/random/weaponry/gun/machineguns
	name = "Random machinegun spawner"
	icon_state = "random_machinegun"
	loot = list(
		/obj/item/weapon/gun/rifle/mg42,
		/obj/item/weapon/gun/rifle/mg60,
		/obj/item/weapon/gun/mg27,
	)

///random rifles
/obj/effect/spawner/random/weaponry/gun/rifles
	name = "Random rifle spawner"
	icon_state = "random_rifle"
	loot = list(
		/obj/item/weapon/gun/rifle/ar12,
		/obj/item/weapon/gun/rifle/type71,
		/obj/item/weapon/gun/shotgun/pump/lever/repeater,
		/obj/item/weapon/gun/rifle/garand,
		/obj/item/weapon/gun/rifle/mpi_km,
		/obj/item/weapon/gun/rifle/m16,
		/obj/item/weapon/gun/rifle/sniper/svd,
		/obj/item/weapon/gun/rifle/m412,
		/obj/item/weapon/gun/rifle/m41a,
		/obj/item/weapon/gun/rifle/type71/seasonal,
		/obj/item/weapon/gun/rifle/alf_machinecarbine,
	)

///random sidearms
/obj/effect/spawner/random/weaponry/gun/sidearms
	name = "Random sidearm spawner"
	icon_state = "random_sidearm"
	loot = list(
		/obj/item/weapon/gun/pistol/p14,
		/obj/item/weapon/gun/pistol/p23,
		/obj/item/weapon/gun/revolver/r44,
		/obj/item/weapon/gun/revolver/cmb,
		/obj/item/weapon/gun/pistol/vp70,
		/obj/item/weapon/gun/pistol/p17,
		/obj/item/weapon/gun/revolver/standard_magnum,
		/obj/item/weapon/gun/shotgun/double/derringer,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/pistol/highpower,
		/obj/item/weapon/gun/revolver/small,
		/obj/item/weapon/gun/revolver/single_action/m44,
		/obj/item/weapon/gun/revolver/judge,
		/obj/item/weapon/gun/revolver/upp,
		/obj/item/weapon/gun/pistol/g22,
		/obj/item/weapon/gun/pistol/vp78,
		/obj/item/weapon/gun/pistol/heavy,
		/obj/item/weapon/gun/pistol/m1911,
	)

///random melee weapons
/obj/effect/spawner/random/weaponry/melee
	name = "Random melee weapons spawner"
	icon_state = "random_melee"
	loot = list(
		/obj/item/weapon/claymore/mercsword/machete,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/weapon/baseballbat,
		/obj/item/weapon/baseballbat/metal,
		/obj/item/weapon/broken_bottle,
		/obj/item/tool/hatchet,
		/obj/item/tool/kitchen/knife,
		/obj/item/tool/kitchen/knife/butcher,
		/obj/item/weapon/twohanded/fireaxe,
		/obj/item/weapon/twohanded/spear/tactical,
		/obj/item/weapon/twohanded/spear/tactical/tacticool,
	)

/obj/effect/spawner/random/weaponry/shiv
	name = "Random shiv spawner"
	icon_state = "random_shiv"
	spawn_loot_chance = 5
	spawn_random_offset = TRUE
	loot = list(
		/obj/item/tool/kitchen/knife/shiv = 80,
		/obj/item/tool/kitchen/knife/shiv/plasma = 12,
		/obj/item/tool/kitchen/knife/shiv/titanium = 5,
		/obj/item/tool/kitchen/knife/shiv/plastitanium = 3,
	)

///BALLISTIC WEAPON AMMO///

///random ammunition
/obj/effect/spawner/random/weaponry/ammo
	name = "Random ballistic ammunition spawner"
	icon_state = "random_ammo"
	loot = list(
		/obj/item/ammo_magazine/rifle/ar12,
		/obj/item/ammo_magazine/rifle/dmr37,
		/obj/item/ammo_magazine/rifle/br64,
		/obj/item/ammo_magazine/rifle/sr127,
		/obj/item/ammo_magazine/rifle/bolt,
		/obj/item/ammo_magazine/rifle/martini,
		/obj/item/ammo_magazine/pistol/p14,
		/obj/item/ammo_magazine/pistol/p23,
		/obj/item/ammo_magazine/revolver/r44,
		/obj/item/ammo_magazine/pistol/p17,
		/obj/item/ammo_magazine/pistol/vp70,
		/obj/item/ammo_magazine/pistol/plasma_pistol,
		/obj/item/ammo_magazine/pistol/derringer,
		/obj/item/ammo_magazine/rifle/pepperball,
		/obj/item/ammo_magazine/shotgun/flechette,
		/obj/item/ammo_magazine/rifle/sh15_slug,
	)

///for specific ranged weapon ammo spawners we don't spawn anything that marines couldn't get back on their ship

///random shotgun ammunition
/obj/effect/spawner/random/weaponry/ammo/shotgun
	name = "Random shotgun ammunition spawner"
	icon_state = "random_shotgun_ammo"
	loot = list(
		/obj/item/ammo_magazine/shotgun/buckshot = 10,
		/obj/item/ammo_magazine/shotgun/flechette = 5,
		/obj/item/ammo_magazine/shotgun/incendiary = 1,
	)

///random machinegun ammunition
/obj/effect/spawner/random/weaponry/ammo/machinegun
	name = "Random machinegun ammunition spawner"
	icon_state = "random_machinegun_ammo"
	loot = list(
		/obj/item/ammo_magazine/mg42,
		/obj/item/ammo_magazine/mg60,
		/obj/item/ammo_magazine/mg27,
		/obj/item/ammo_magazine/hmg08,
	)

///random rifle ammunition
/obj/effect/spawner/random/weaponry/ammo/rifle
	name = "Random rifle ammunition spawner"
	icon_state = "random_rifle_ammo"
	loot = list(
		/obj/item/ammo_magazine/rifle/ar12,
		/obj/item/ammo_magazine/rifle/ar18,
		/obj/item/ammo_magazine/rifle/ar21,
		/obj/item/ammo_magazine/rifle/ar11,
	)

///random sidearm ammunition
/obj/effect/spawner/random/weaponry/ammo/sidearm
	name = "Random sidearm ammunition spawner"
	icon_state = "random_sidearm_ammo"
	loot = list(
		/obj/item/ammo_magazine/pistol/p14,
		/obj/item/ammo_magazine/pistol/p23,
		/obj/item/ammo_magazine/revolver/r44,
		/obj/item/ammo_magazine/pistol/vp70,
		/obj/item/ammo_magazine/pistol/derringer,
		/obj/item/ammo_magazine/revolver/cmb,
		/obj/item/ammo_magazine/pistol/p17,
	)

/obj/effect/spawner/random/weaponry/explosive/plastiqueexplosive
	name = "plastique explosive spawner"
	icon_state = "random_plastiqueexplosive"
	spawn_loot_chance = 45
	loot = list(
		/obj/item/explosive/plastique = 7,
		/obj/item/detpack = 2,
		/obj/item/assembly/signaler/receiver = 1,
	)

/obj/effect/spawner/random/weaponry/explosive/plastiqueexplosive/multiple
	spawn_loot_chance = 20
	icon_state = "random_plastiqueexplosive_multiple_two"
	spawn_loot_count = 2

/obj/effect/spawner/random/weaponry/explosive/plastiqueexplosive/multiple/four
	spawn_loot_chance = 10
	icon_state = "random_plastiqueexplosive_multiple_four"
	spawn_loot_count = 4

/obj/effect/spawner/random/weaponry/explosive/grenade
	name = "grenade spawner"
	icon_state = "random_grenade"
	spawn_loot_chance = 90
	loot = list(
		/obj/item/explosive/grenade = 7,
		/obj/item/explosive/grenade/incendiary = 2,
		/obj/item/explosive/grenade/m15 = 1,
	)

/obj/effect/spawner/random/weaponry/explosive/grenade/incendiaryweighted
	loot = list(
		/obj/item/explosive/grenade/incendiary = 7,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/m15 = 1,
	)
/obj/effect/spawner/random/weaponry/explosive/grenade/multiplefour
	icon_state = "random_grenade_multiple_four"
	spawn_random_offset = TRUE
	spawn_loot_chance = 75
	spawn_loot_count = 4

/obj/effect/spawner/random/weaponry/explosive/rocketlauncher
	name = "rocket launcher spawner"
	icon_state = "random_rocketlauncher"
	spawn_loot_chance = 95
	spawn_random_offset = TRUE
	loot = list(
		/obj/item/weapon/gun/launcher/rocket/oneuse = 15,
		/obj/item/weapon/gun/launcher/rocket = 5,
		/obj/item/weapon/gun/launcher/rocket/sadar = 2,
	)

/obj/effect/spawner/random/weaponry/weapon_recharger
	name = "random weapon recharger"
	icon_state = "random_wrecharger"
	spawn_loot_chance = 45
	loot = list(
		/obj/structure/prop/mainship/weapon_recharger,
	)
