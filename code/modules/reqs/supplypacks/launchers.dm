/datum/supply_packs/launchers
	containertype = /obj/structure/closet/crate/ammo
	group = "Launchers"

/datum/supply_packs/launchers/rpgoneuse
	name = "RL-72 disposable RPG"
	contains = list(/obj/item/weapon/gun/launcher/rocket/oneuse)
	cost = 100

/datum/supply_packs/launchers/recoillesskit
	name = "RL-160 recoilless rifle kit"
	contains = list(/obj/item/storage/holster/backholster/rpg/full)
	cost = 400

/datum/supply_packs/launchers/shell_regular
	name = "RL-160 RR HE shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless)
	cost = 30

/datum/supply_packs/launchers/shell_le
	name = "RL-160 RR LE shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/light)
	cost = 30

/datum/supply_packs/launchers/shell_heat
	name = "RL-160 HEAT shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/heat)
	cost = 30

/datum/supply_packs/launchers/shell_smoke
	name = "RL-160 RR smoke shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/smoke)
	cost = 30

/datum/supply_packs/launchers/shell_cloak
	name = "RL-160 RR cloak shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/cloak)
	cost = 30

/datum/supply_packs/launchers/shell_tangle
	name = "RL-160 RR tanglefoot shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/plasmaloss)
	cost = 30

/datum/supply_packs/launchers/thermobaric
	name = "RL-57 quad thermobaric launcher"
	contains = list(/obj/item/weapon/gun/launcher/rocket/m57a4/t57)
	cost = 500

/datum/supply_packs/launchers/thermobaric_wp
	name = "RL-57 thermobaric WP rocket array"
	contains = list(/obj/item/ammo_magazine/rocket/m57a4)
	cost = 50

/datum/supply_packs/launchers/thermobaric
	name = "RL-57 thermobaric launcher kit"
	contains = list(/obj/item/storage/holster/backholster/rlquad/full)
	cost = 550 //launcher + ammo price

/datum/supply_packs/launchers/sadar
	name = "RL-152 SADAR rocket launcher"
	contains = list(/obj/item/weapon/gun/launcher/rocket/sadar)
	cost = SADAR_PRICE

/datum/supply_packs/launchers/rpg_regular
	name = "RL-152 SADAR HE rocket"
	contains = list(/obj/item/ammo_magazine/rocket/sadar)
	cost = 50

/datum/supply_packs/launchers/rpg_regular_unguided
	name = "RL-152 SADAR HE rocket (unguided)"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/unguided)
	cost = 50

/datum/supply_packs/launchers/rpg_ap
	name = "RL-152 SADAR AP rocket"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/ap)
	cost = 60

/datum/supply_packs/launchers/rpg_wp
	name = "RL-152 SADAR WP rocket"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/wp)
	cost = 40

/datum/supply_packs/launchers/rpg_wp_unguided
	name = "RL-152 SADAR WP rocket (unguided)"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/wp/unguided)
	cost = 40

/datum/supply_packs/launchers/specdemo
	name = "RL-152 SADAR rocket launcher kit"
	contains = list(/obj/item/storage/holster/backholster/rlsadar/full)
	cost = SADAR_PRICE + 150 //ammo price

/datum/supply_packs/launchers/tx54
	name = "GL-54 airburst grenade launcher"
	contains = list(/obj/item/weapon/gun/rifle/tx54)
	cost = 300

/datum/supply_packs/launchers/tx54_airburst
	name = "GL-54 airburst grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54)
	cost = 20

/datum/supply_packs/launchers/tx54_incendiary
	name = "GL-54 incendiary grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/incendiary)
	cost = 60

/datum/supply_packs/launchers/tx54_smoke
	name = "GL-54 tactical smoke grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/smoke)
	cost = 12

/datum/supply_packs/launchers/tx54_smoke/dense
	name = "GL-54 dense smoke grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/smoke/dense)
	cost = 8

/datum/supply_packs/launchers/tx54_smoke/tangle
	name = "GL-54 tanglefoot grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/smoke/tangle)
	cost = 48

/datum/supply_packs/launchers/singleshot_launcher
	name = "GL-81 grenade launcher"
	contains = list(/obj/item/weapon/gun/grenade_launcher/single_shot)
	cost = 150

/datum/supply_packs/launchers/multinade_launcher
	name = "GL-70 grenade launcher"
	contains = list(/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded)
	cost = 300
