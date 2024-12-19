//A way to give them everything at once that still works with loadouts would be nice, but barring that make sure that your point calculation is set up so they don't get more than what they're supposed to
GLOBAL_LIST_INIT(smartgunner_gear_listed_products, list(
	/obj/item/clothing/glasses/night/m56_goggles = list(CAT_ESS, "KLTD Smart Goggles", 0, "white"),
	/obj/item/weapon/gun/rifle/sg29 = list(CAT_SGSUP, "SG-29 Smart Machine Gun", 29, "orange"), //If a smartgunner buys a SG-29, then they will have 16 points to purchase 4 SG-29 drums
	/obj/item/ammo_magazine/sg29 = list(CAT_SGSUP, "SG-29 Ammo Drum", 4, "orange"),
	/obj/item/weapon/gun/minigun/smart_minigun = list(CAT_SGSUP, "SG-85 Smart Handheld Gatling Gun", 27, "red"), //If a smartgunner buys a SG-85, then they should be able to buy only 1 powerpack and 2 ammo bins
	/obj/item/ammo_magazine/minigun_powerpack/smartgun = list(CAT_SGSUP, "SG-85 Powerpack", 10, "orange2"),
	/obj/item/ammo_magazine/packet/smart_minigun = list(CAT_SGSUP, "SG-85 Ammo Bin", 4, "orange2"),
	/obj/item/weapon/gun/rifle/t25 = list(CAT_SGSUP, "T-25 Smartrifle", 26, "red"), //If smartganner buys a t25 , then they will have 2 mag and 3 ammo box
	/obj/item/ammo_magazine/rifle/t25 =  list(CAT_SGSUP, "T-25 Smartrifle magazine", 2, "orange2"),
	/obj/item/ammo_magazine/packet/t25 = list(CAT_SGSUP, "T-25 Smartrifle ammo box", 5, "orange2"),
	/obj/item/weapon/gun/rifle/sg62 = list(CAT_SGSUP, "SG-62 Target Rifle", 25, "red"), //If a SG buys a SG-62, they'll have 15 points left, should be enough to buy some mags and or extra SR ammo.
	/obj/item/ammo_magazine/rifle/sg62 = list(CAT_SGSUP, "SG-62 Target Rifle Magazine", 3, "orange2"),
	/obj/item/ammo_magazine/packet/sg62 = list(CAT_SGSUP, "SG-62 smart target rifle ammo box", 5, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153 = list(CAT_SGSUP, "SG-153 Spotting Rifle Magazine", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/highimpact = list(CAT_SGSUP, "SG-153 Spotting Rifle High Impact Magazine", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/heavyrubber = list(CAT_SGSUP, "SG-153 Spotting Rifle Heavy Rubber Magazine", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/tungsten = list(CAT_SGSUP, "SG-153 Spotting Rifle Tungsten Magazine", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/flak = list(CAT_SGSUP, "SG-153 Spotting Rifle Flak Magazine", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/plasmaloss = list(CAT_SGSUP, "SG-153 Spotting Rifle Tanglefoot Magazine", 3, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/incendiary = list(CAT_SGSUP, "SG-153 Spotting Rifle Incendiary Magazine", 3, "orange2"),
	/obj/item/ammo_magazine/pistol/p14/smart_pistol = list(CAT_SGSUP, "SP-13 smart pistol ammo", 2, "orange2"),
	/obj/item/storage/belt/marine/auto_catch = list(CAT_SGSUP, "M344 pattern ammo load rig", 10, "orange"),
))
