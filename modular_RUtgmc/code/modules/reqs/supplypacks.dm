/*******************************************************************************
OPERATIONS
*******************************************************************************/

/datum/supply_packs/operations/fulton_extraction_pack
	cost = 50

/datum/supply_packs/operations/beacons_orbital
	name = "orbital beacon"
	contains = list(/obj/item/beacon/orbital_bombardment_beacon)
	cost = 30
	available_against_xeno_only = TRUE

/*******************************************************************************
WEAPONS
*******************************************************************************/

/datum/supply_packs/weapons/vector
	name = "Vector"
	contains = list(/obj/item/weapon/gun/smg/vector)
	cost = 200

/datum/supply_packs/weapons/ammo_magazine/vector
	name = "Vector drum magazine"
	contains = list(/obj/item/ammo_magazine/smg/vector)
	cost = 5

/datum/supply_packs/weapons/valihalberd
	name = "VAL-HAL-A"
	contains = list(/obj/item/weapon/twohanded/glaive/halberd/harvester)
	cost = 600

/datum/supply_packs/weapons/t500case
	name = "R-500 bundle"
	contains = list(/obj/item/storage/box/t500case)
	cost = 50

/datum/supply_packs/weapons/t21_extended_mag
	name = "AR-21 extended magazines pack"
	contains = list(/obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended, /obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended, /obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended, /obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended, /obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended, /obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended,/obj/item/ammo_magazine/rifle/standard_skirmishrifle/extended)
	cost = 350
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/t21_ap
	name = "AR-21 armor piercing magazine"
	contains = list(/obj/item/ammo_magazine/rifle/standard_skirmishrifle/ap)
	cost = 25 //30 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/t18_ap
	name = "AR-18 armor piercing magazine"
	contains = list(/obj/item/ammo_magazine/rifle/standard_carbine/ap)
	cost = 23 //36 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/t12_ap
	name = "AR-12 armor piercing magazine"
	contains = list(/obj/item/ammo_magazine/rifle/standard_assaultrifle/ap)
	cost = 29 //50 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/br64_ap
	name = "BR-64 armor piercing magazine"
	contains = list(/obj/item/ammo_magazine/rifle/standard_br/ap)
	cost = 25 //36 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/smg25_ap
	name = "SMG-25 armor piercing magazine"
	contains = list(/obj/item/ammo_magazine/smg/m25/ap)
	cost = 30 //60 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/box_10x24mm_ap
	name = "10x24mm armor piercing ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x24mm/ap)
	cost = 45 //150 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/rifle/T25
	name = "T25 smartrifle"
	contains = list(/obj/item/weapon/gun/rifle/T25)
	cost = 400

/datum/supply_packs/weapons/ammo_magazine/rifle/T25
	name = "T25 smartrifle magazine"
	contains = list(/obj/item/ammo_magazine/rifle/T25)
	cost = 20

/datum/supply_packs/weapons/T25_extended_mag
	name = "T25 extended magazine"
	contains = list(/obj/item/ammo_magazine/rifle/T25/extended)
	cost = 200
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/ammo_magazine/packet/T25_rifle
	name = "T25 smartrifle ammo box"
	contains = list(/obj/item/ammo_magazine/packet/T25_rifle)
	cost = 60

/datum/supply_packs/weapons/box_10x25mm_ap
	name = "10x25mm armor piercing ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x25mm/ap)
	cost = 50 //125 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/box_10x265mm_ap
	name = "10x26.5mm armor piercing ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x265mm/ap)
	cost = 60 //100 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/box_10x20mm_ap
	name = "10x20mm armor piercing ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x20mm/ap)
	cost = 50 //150 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/thermobaric
	name = "RL-57 Thermobaric Launcher Kit"
	contains = list(/obj/item/storage/holster/backholster/rlquad/full)
	cost = 500 + 50 //ammo price
	available_against_xeno_only = TRUE

/datum/supply_packs/weapons/specdemo
	name = "RL-152 SADAR Rocket Launcher kit"
	contains = list(/obj/item/storage/holster/backholster/rlsadar/full)
	cost = SADAR_PRICE + 150 //ammo price
	available_against_xeno_only = TRUE

/datum/supply_packs/weapons/minigun_powerpack
	name = "SG-85 Minigun Powerpack"
	contains = list(/obj/item/ammo_magazine/minigun_powerpack/smartgun)
	cost = 150

/datum/supply_packs/weapons/smarttarget_rifle_ammo
	cost = 25

/datum/supply_packs/weapons/box_10x27mm
	name = "SG-62 smart target rifle ammo box"
	contains = list(/obj/item/ammo_magazine/packet/sg62_rifle)
	cost = 50

/datum/supply_packs/weapons/xray_gun
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/xray)
	cost = 500

/datum/supply_packs/weapons/singleshot_launcher
	name = "GL-81 grenade launcher"
	contains = list(/obj/item/weapon/gun/grenade_launcher/single_shot)
	cost = 150

/datum/supply_packs/weapons/multinade_launcher
	name = "GL-70 grenade launcher"
	contains = list(/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded)
	cost = 450

/*******************************************************************************
EXPLOSIVES
*******************************************************************************/

/datum/supply_packs/explosives/knee_mortar
	name = "T-10K Knee Mortar"
	contains = list(/obj/item/mortar_kit/knee)
	cost = 125

/datum/supply_packs/explosives/knee_mortar_ammo
	name = "TA-10K knee mortar HE shell"
	contains = list(/obj/item/mortal_shell/knee, /obj/item/mortal_shell/knee)
	cost = 5
	available_against_xeno_only = TRUE

/datum/supply_packs/explosives/explosives_trailblazer_phosphorus
	name = "M45 Phosphorous trailblazer grenade box crate"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/trailblazer/phosphorus)
	cost = 600

/datum/supply_packs/explosives/howitzer
	name = "TA-100Y howitzer"
	contains = list(/obj/item/mortar_kit/howitzer)
	cost = 600

/datum/supply_packs/explosives/howitzer_ammo_he
	name = "TA-100Y howitzer HE shell"
	contains = list(/obj/item/mortal_shell/howitzer/he)
	cost = 40

/datum/supply_packs/explosives/howitzer_ammo_incend
	name = "TA-100Y howitzer incendiary shell"
	contains = list(/obj/item/mortal_shell/howitzer/incendiary)
	cost = 40

/datum/supply_packs/explosives/howitzer_ammo_wp
	name = "TA-100Y howitzer white phosporous smoke shell"
	contains = list(/obj/item/mortal_shell/howitzer/white_phos)
	cost = 60

/datum/supply_packs/explosives/howitzer_ammo_plasmaloss
	name = "TA-100Y howitzer tanglefoot shell"
	contains = list(/obj/item/mortal_shell/howitzer/plasmaloss)
	cost = 60
	available_against_xeno_only = TRUE

/*******************************************************************************
ARMOR
*******************************************************************************/

/datum/supply_packs/armor/imager_goggle
	name = "Optical Imager Goggles"
	contains = list(/obj/item/clothing/glasses/night/imager_goggles)
	cost = 50

/datum/supply_packs/armor/modular/attachments/tyr_extra_armor
	name = "Tyr armor module"
	cost = 200

/datum/supply_packs/armor/modular/attachments/valkyrie_autodoc
	cost = 150

/datum/supply_packs/armor/robot/advanced/physical
	name = "Cingulata physical protection armor set"
	contains = list(
		/obj/item/clothing/head/helmet/marine/robot/advanced/physical,
		/obj/item/clothing/suit/storage/marine/robot/advanced/physical,
	)
	cost = 600
	available_against_xeno_only = TRUE

/datum/supply_packs/armor/robot/advanced/acid
	name = "Exidobate acid protection armor set"
	contains = list(
		/obj/item/clothing/head/helmet/marine/robot/advanced/acid,
		/obj/item/clothing/suit/storage/marine/robot/advanced/acid,
	)
	cost = 600
	available_against_xeno_only = TRUE

/datum/supply_packs/armor/robot/advanced/bomb
	name = "Tardigrada bomb protection armor set"
	contains = list(
		/obj/item/clothing/head/helmet/marine/robot/advanced/bomb,
		/obj/item/clothing/suit/storage/marine/robot/advanced/bomb,
	)
	cost = 600
	available_against_xeno_only = TRUE

/datum/supply_packs/armor/robot/advanced/fire
	name = "Urodela fire protection armor set"
	contains = list(
		/obj/item/clothing/head/helmet/marine/robot/advanced/fire,
		/obj/item/clothing/suit/storage/marine/robot/advanced/fire,
	)
	cost = 600
	available_against_xeno_only = TRUE

/*******************************************************************************
CLOTHING
*******************************************************************************/
/datum/supply_packs/clothing/radio_pack
	name = "Radio Operator Pack"
	contains = list(/obj/item/storage/backpack/marine/radiopack)
	cost = 20

/*******************************************************************************
SUPPLIES
*******************************************************************************/

/datum/supply_packs/supplies/pigs
	name = "Pig toys crate"
	contains = list(/obj/item/toy/plush/pig, /obj/item/toy/plush/pig, /obj/item/toy/plush/pig, /obj/item/toy/plush/pig, /obj/item/toy/plush/pig)
	cost = 100
	available_against_xeno_only = TRUE
	containertype = /obj/structure/closet/crate/supply

/*******************************************************************************
FACTORY
*******************************************************************************/
/datum/supply_packs/factory/smartgun_targetrifle_refill
	name = "SG-62 ammo magazine parts refill"
	contains = list(/obj/item/factory_refill/smartgunner_targetrifle_magazine_refill)

/datum/supply_packs/factory/amr_magazine_incend_refill
	name = "T-26 AMR incendiary magazine assembly refill"

/datum/supply_packs/factory/amr_magazine_flak_refill
	name = "T-26 AMR flak magazine assembly refill"

/*******************************************************************************
MEDICAL
*******************************************************************************/

/datum/supply_packs/medical/incision_management
	name = "Incision Management System"
	notes = "contains incision management system."
	contains = list(/obj/item/tool/surgery/scalpel/manager)
	cost = 100
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/tweezers_advanced
	name = "Advanced Tweezers"
	notes = "contains advanced tweezers."
	contains = list(/obj/item/tweezers_advanced)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/defibrillator_gloves
	name = "Advanced defibrillator medical gloves"
	notes = "contains advanced defibrillator medical gloves."
	contains = list(/obj/item/defibrillator/gloves)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/healthanalyzer_gloves
	name = "Health scanner gloves"
	notes = "contains health scanner gloves."
	contains = list(/obj/item/healthanalyzer/gloves)
	cost = 60
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/advanced_medical_kits
	name = "Advanced medical kits"
	notes = "contains pair advanced medical kits from medical vendors."
	contains = list(/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack, /obj/item/stack/medical/heal_pack/advanced/burn_combat_pack)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/combat_medicine
	name = "Battleground medicine"
	notes = "contains 4 hypospray with MD, many injectors peri+ and quick+, neuraline, nanopaste."
	contains = list(
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/stack/nanopaste,
	)
// Кто-то скажет, что это имба, а я вам скажу, что этот набор уже есть в игре буквально самой первой строчкой в медкарго, я просто перепаковал его выставив на общее обозрение.
	cost = 300

/datum/supply_packs/medical/combat_robot_medicine
	name = "Combat repairing for robots"
	notes = "contains 5 nanopaste for robots or technic."
	contains = list(
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
	)
	cost = 230

/datum/supply_packs/medical/soldering_tool
	name = "Soldering tool"
	notes = "contains 1 soldering tool for repair robots."
	contains = list(/obj/item/tool/surgery/solderingtool)
	cost = 30

/datum/supply_packs/medical/nanoblood_hypo
	name = "Nanoblood hypospray"
	notes = "contains 2 hypo with nanoblood."
	contains = list(
		/obj/item/reagent_containers/hypospray/advanced/nanoblood,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood,
	)
	cost = 100
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/meraderm_pills
	name = "Meraderm pills"
	notes = "contains meralyne and dermaline pill bottle."
	contains = list(
		/obj/item/storage/pill_bottle/dermaline,
		/obj/item/storage/pill_bottle/meralyne,
	)
	cost = 250

/datum/supply_packs/medical/bs_beakers
	name = "Bluespace beakers"
	notes = "contains two BS beakers."
	contains = list(
		/obj/item/reagent_containers/glass/beaker/bluespace,
		/obj/item/reagent_containers/glass/beaker/bluespace,
	)
	cost = 50

/datum/supply_packs/medical/bkkt_dispenser
	name = "BKKT Dispenser"
	notes = "contains one BKKT dispenser."
	contains = list(/obj/item/storage/reagent_tank/bktt)
	cost = 120

/datum/supply_packs/medical/antitox_kit
	name = "Anti-tox kit"
	notes = "contains some things against toxins."
	contains = list(
		/obj/item/storage/pill_bottle/hypervene,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/storage/pill_bottle/tricordrazine,
		)
	cost = 20

/datum/supply_packs/medical/imialky_kit
	name = "ImiAlky kit"
	notes = "contains pill bottles imidazoline and alkysine."
	contains = list(
		/obj/item/storage/pill_bottle/imidazoline,
		/obj/item/storage/pill_bottle/alkysine,
		)
	cost = 30

/datum/supply_packs/medical/quick_peri_plus_kit
	name = "QuickPeri+ kit"
	notes = "contains injector quick+ and peri+."
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus,
		)
	cost = 30

/datum/supply_packs/medical/russian_red_kit
	name = "Russian Red pill bottle"
	notes = "contains one pill bottle red russian."
	contains = list(/obj/item/storage/pill_bottle/russian_red)
	cost = 30

/datum/supply_packs/medical/neuraline_kit
	name ="large neuraline kit"
	notes = "contains five neuraline injectors"
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		)
	cost = 250

/datum/supply_packs/medical/neuraline_kit_injector
	name ="Neuraline autoinjector"
	notes = "contains one neuraline injector"
	contains = list(/obj/item/reagent_containers/hypospray/autoinjector/neuraline)
	cost = 70

/datum/supply_packs/medical/bkkt_kit
	name = "BKKT kit"
	notes = "contains pill bottles BKKT."
	contains = list(
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tricordrazine,
		/obj/item/storage/pill_bottle/tramadol,
		)
	cost = 20

/datum/supply_packs/medical/medicine_defibrillator
	name = "Medical defibrillator"
	notes = "contains medical defibrillator."
	contains = list(/obj/item/defibrillator)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/surgery
	contains = list(
		/obj/item/storage/surgical_tray,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/tank/anesthetic,
	)
