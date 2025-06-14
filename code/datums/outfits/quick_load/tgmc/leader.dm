//Base TGMC leader outfit
/datum/outfit/quick/tgmc/leader
	name = "TGMC Squad Leader"
	jobtype = SQUAD_LEADER
	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/hud/health
	w_uniform = /obj/item/clothing/under/marine/black_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/leader
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/leader
	r_pocket = /obj/item/storage/pouch/firstaid/combat_patrol_leader
	l_pocket = /obj/item/storage/pouch/grenade/combat_patrol
	back = /obj/item/storage/backpack/lightpack

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/combat = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
	)
	suit_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/isotonic = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)

/datum/outfit/quick/tgmc/leader/ar12
	name = "AR-12 Patrol Leader"
	desc = "Gives the orders. Equipped with an AR-12 assault rifle with UGL, plenty of grenades, some support kit such as deployable cameras, as well as heavy armor with a 'valkyrie' autodoc module. You can provide excellent support to your squad thanks to your kit and order shouting talents."

	suit_store = /obj/item/weapon/gun/rifle/ar12/rifleman
	belt = /obj/item/storage/belt/marine/ar12

	backpack_contents = list(
		/obj/item/deployable_camera = 1,
		/obj/item/ammo_magazine/packet/p10x24mm = 1,
		/obj/item/explosive/plastique = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/binoculars/fire_support/campaign = 1,
	)

/datum/outfit/quick/tgmc/leader/ar12/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/hud_tablet(H, /datum/job/terragov/squad/leader, H.assigned_squad), SLOT_IN_BACKPACK)

/datum/outfit/quick/tgmc/leader/ar18
	name = "AR-18 Patrol Leader"
	desc = "Gives the orders. Equipped with an AR-18 carbine with plasma pistol attachment, plenty of grenades, as well as heavy armor with a 'valkyrie' autodoc module. You can provide excellent support to your squad thanks to your kit and order shouting talents, while unleashing excellent damage at medium range."

	suit_store = /obj/item/weapon/gun/rifle/ar18/plasma_pistol
	belt = /obj/item/storage/belt/marine/ar18

	backpack_contents = list(
		/obj/item/ammo_magazine/pistol/plasma_pistol = 1,
		/obj/item/ammo_magazine/pistol/plasma_pistol = 1,
		/obj/item/ammo_magazine/pistol/plasma_pistol = 1,
		/obj/item/ammo_magazine/packet/p10x24mm = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 1,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade = 1,
		/obj/item/explosive/grenade = 1,
		/obj/item/explosive/grenade/m15 = 1,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/binoculars/fire_support/campaign = 1,
	)

/datum/outfit/quick/tgmc/leader/combat_rifle
	name = "AR-11 Patrol Leader"
	desc = "Gives the orders. Equipped with an AR-11 combat rifle, plenty of grenades, as well as heavy armor with a 'valkyrie' autodoc module. You can provide excellent support to your squad thanks to your kit and order shouting talents, with excellent damage at all ranges."

	suit_store = /obj/item/weapon/gun/rifle/ar11/standard
	belt = /obj/item/storage/belt/marine/combat_rifle

	backpack_contents = list(
		/obj/item/deployable_camera = 2,
		/obj/item/ammo_magazine/packet/p492x34mm = 1,
		/obj/item/explosive/plastique = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/m15 = 1,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/binoculars/fire_support/campaign = 1,
	)

/datum/outfit/quick/tgmc/leader/combat_rifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/hud_tablet(H, /datum/job/terragov/squad/leader, H.assigned_squad), SLOT_IN_BACKPACK)

/datum/outfit/quick/tgmc/leader/br64
	name = "BR-64 Patrol Leader"
	desc = "Gives the orders. Equipped with an BR-64 battle rifle with UGL, plenty of grenades, as well as heavy armor with a 'valkyrie' autodoc module. The battle rifle offers improved damage and penetration compared to more common rifles, but still retains a grenade launcher that the AR-11 lacks."

	suit_store = /obj/item/weapon/gun/rifle/br64/standard
	belt = /obj/item/storage/belt/marine/br64

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p10x265mm = 2,
		/obj/item/explosive/plastique = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/binoculars/fire_support/campaign = 1,
	)

/datum/outfit/quick/tgmc/leader/auto_shotgun
	name = "SH-15 Patrol Leader"
	desc = "Gives the orders. Equipped with an SH-15 auto shotgun, plenty of grenades, as well as heavy armor with a 'valkyrie' autodoc module. You can provide excellent support to your squad thanks to your kit and order shouting talents, with strong damage and control."

	suit_store = /obj/item/weapon/gun/rifle/sh15/plasma_pistol
	belt = /obj/item/storage/belt/marine/auto_shotgun

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/sh15_slug = 1,
		/obj/item/ammo_magazine/rifle/sh15_flechette = 1,
		/obj/item/ammo_magazine/pistol/plasma_pistol = 3,
		/obj/item/explosive/plastique = 2,
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/m15 = 2,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/binoculars/fire_support/campaign = 1,
	)

/datum/outfit/quick/tgmc/leader/standard_laserrifle
	name = "Laser Rifle Patrol Leader"
	desc = "Gives the orders. Equipped with a laser rifle with UGL for better armor penetration against SOM, some support kit such as deployable cameras, as well as heavy armor with a 'valkyrie' autodoc module. You can provide excellent support to your squad thanks to your kit and order shouting talents."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/rifleman
	belt = /obj/item/storage/belt/marine/te_cells

	backpack_contents = list(
		/obj/item/deployable_camera = 2,
		/obj/item/cell/lasgun/lasrifle = 1,
		/obj/item/explosive/plastique = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)
	webbing_contents = list(
		/obj/item/ammo_magazine/flamer_tank/mini = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/binoculars/fire_support/campaign = 1,
	)

/datum/outfit/quick/tgmc/leader/standard_laserrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/hud_tablet(H, /datum/job/terragov/squad/leader, H.assigned_squad), SLOT_IN_BACKPACK)

/datum/outfit/quick/tgmc/leader/oicw
	name = "AR-55 Patrol Leader"
	desc = "Gives the orders. Equipped with an AR-55 OICW with plenty of grenades for its integrated grenade launcher, some support kit such as deployable cameras, as well as heavy armor with a 'valkyrie' autodoc module. You can provide excellent support to your squad thanks to your kit and order shouting talents."
	quantity = 2

	suit_store = /obj/item/weapon/gun/rifle/tx55/combat_patrol
	belt = /obj/item/storage/belt/marine/oicw

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p10x24mm = 2,
		/obj/item/ammo_magazine/rifle/ar12 = 2,
		/obj/item/ammo_magazine/rifle/tx54 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/storage/box/mre = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/binoculars/fire_support/campaign = 1,
	)
