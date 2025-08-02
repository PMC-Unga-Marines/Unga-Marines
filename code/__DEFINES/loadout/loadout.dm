#define CAT_ESS "ESSENTIALS"
#define CAT_STD "STANDARD EQUIPMENT"
#define CAT_UNI "UNIFORM"
#define CAT_GLO "GLOVES"
#define CAT_SHO "SHOES"
#define CAT_HEL "HATS"
#define CAT_AMR "ARMOR"
#define CAT_EAR "EAR"
#define CAT_BAK "BACKPACK"
#define CAT_POU "POUCHES"
#define CAT_WEB "WEBBING"
#define CAT_BEL "BELT"
#define CAT_GLA "GLASSES"
#define CAT_MAS "MASKS"
#define CAT_MOD "JAEGER STORAGE MODULES"
#define CAT_ARMMOD "JAEGER ARMOR MODULES"

// Synth Special Categories
#define CAT_SMR "SUITS AND ARMOR" // Synth's suits
#define CAT_SHN "HATS" // Synth's non-protective hats

#define CAT_MEDSUP "MEDICAL SUPPLIES"
#define CAT_ENGSUP "ENGINEERING SUPPLIES"
#define CAT_LEDSUP "LEADER SUPPLIES"
#define CAT_SGSUP "SMARTGUNNER SUPPLIES"
#define CAT_FCSUP "COMMANDER SUPPLIES"
#define CAT_SYNTH "SYNTHETIC SUPPLIES"
#define CAT_MARINE "MARINE SUPPLIES"
#define CAT_ROBOT "COMBAT ROBOT SUPPLIES"
#define CAT_LOAD "LOADOUT"

/// How many points a marine can spend by default
#define MARINE_TOTAL_BUY_POINTS 45
/// How many points the robot can spend
#define ROBOT_TOTAL_BUY_POINTS 45
/// How many points the leader can spend
#define LEADER_TOTAL_BUY_POINTS 45
/// How many points the leader can spend
#define SMARTGUNNER_TOTAL_BUY_POINTS 45
/// How many points a medic can spend on pills
#define MEDIC_TOTAL_BUY_POINTS 45
/// How many points an engineer can spend
#define ENGINEER_TOTAL_BUY_POINTS 75
/// How many points the field commander can spend
#define COMMANDER_TOTAL_BUY_POINTS 45
/// How many points the synthetic can spend
#define SYNTH_TOTAL_BUY_POINTS 50

GLOBAL_LIST_INIT(default_marine_points, list(
	CAT_MARINE = MARINE_TOTAL_BUY_POINTS,
	CAT_ROBOT = ROBOT_TOTAL_BUY_POINTS,
	CAT_SGSUP = SMARTGUNNER_TOTAL_BUY_POINTS,
	CAT_ENGSUP = ENGINEER_TOTAL_BUY_POINTS,
	CAT_LEDSUP = LEADER_TOTAL_BUY_POINTS,
	CAT_MEDSUP = MEDIC_TOTAL_BUY_POINTS,
	CAT_FCSUP = COMMANDER_TOTAL_BUY_POINTS,
	CAT_SYNTH = SYNTH_TOTAL_BUY_POINTS,
))

#define VENDOR_FACTION_NEUTRAL "Neutral"
#define VENDOR_FACTION_CRASH "Crash"
#define VENDOR_FACTION_VALHALLA "Valhalla"

GLOBAL_LIST_INIT(marine_selector_cats, list(
	CAT_MOD = 1,
	CAT_UNI = 1,
	CAT_GLO = 1,
	CAT_SHO = 1,
	CAT_ARMMOD = 1,
	CAT_STD = 1,
	CAT_HEL = 1,
	CAT_AMR = 1,
	CAT_SMR = 1,
	CAT_SHN = 1,
	CAT_EAR = 1,
	CAT_BAK = 1,
	CAT_WEB = 1,
	CAT_BEL = 1,
	CAT_GLA = 1,
	CAT_MAS = 1,
	CAT_ESS = 1,
	CAT_POU = 2,
))

#define METAL_PRICE_IN_GEAR_VENDOR 2
#define PLASTEEL_PRICE_IN_GEAR_VENDOR 4
#define SANDBAG_PRICE_IN_GEAR_VENDOR 3

//List of all visible and accessible slot on the loadout maker
GLOBAL_LIST_INIT(visible_item_slot_list, list(
	slot_head_str,
	slot_back_str,
	slot_wear_mask_str,
	slot_glasses_str,
	slot_w_uniform_str,
	slot_wear_suit_str,
	slot_gloves_str,
	slot_shoes_str,
	slot_s_store_str,
	slot_belt_str,
	slot_l_store_str,
	slot_r_store_str,
))

///List of all additional item slot used by the admin loadout build mode
GLOBAL_LIST_INIT(additional_admin_item_slot_list, list(
	slot_l_hand_str,
	slot_r_hand_str,
	slot_wear_id_str,
	slot_ear_str,
))

///All the vendor types which the automated loadout vendor can take items from.
GLOBAL_LIST_INIT(loadout_linked_vendor, list(
	VENDOR_FACTION_NEUTRAL = list(
		/obj/machinery/vending/weapon,
		/obj/machinery/vending/uniform_supply,
		/obj/machinery/vending/armor_supply,
		/obj/machinery/vending/marineFood,
		/obj/machinery/vending/MarineMed,
		/obj/machinery/vending/cigarette,
		/obj/machinery/vending/tool,
	),
	VENDOR_FACTION_VALHALLA = list(
		/obj/machinery/vending/weapon/valhalla,
		/obj/machinery/vending/uniform_supply/valhalla,
		/obj/machinery/vending/armor_supply/valhalla,
		/obj/machinery/vending/marineFood,
		/obj/machinery/vending/MarineMed/valhalla,
		/obj/machinery/vending/cigarette/valhalla,
		/obj/machinery/vending/tool/nopower/valhalla,
	),
	SQUAD_CORPSMAN = list(
		/obj/machinery/vending/medical/shipside,
	),
	VENDOR_FACTION_CRASH = list(
		/obj/machinery/vending/weapon/crash,
		/obj/machinery/vending/uniform_supply,
		/obj/machinery/vending/armor_supply,
		/obj/machinery/vending/marineFood,
		/obj/machinery/vending/MarineMed,
		/obj/machinery/vending/cigarette,
		/obj/machinery/vending/tool,
	)
))

GLOBAL_LIST_INIT(loadout_role_essential_set, list(
	SQUAD_ROBOT = list(
		/obj/item/tool/surgery/solderingtool = 1,
	),
	SQUAD_ENGINEER = list(
		/obj/item/weapon/gun/sentry/basic = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/explosive/grenade/chem_grenade/razorburn_small = 1,
		/obj/item/clothing/gloves/marine/insulated = 1,
		/obj/item/cell/high = 1,
		/obj/item/lightreplacer = 1,
		/obj/item/circuitboard/apc = 1,
		/obj/item/tool/surgery/solderingtool = 1,
	),
	SQUAD_CORPSMAN = list(
		/obj/item/bodybag/cryobag = 1,
		/obj/item/defibrillator = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/roller/medevac = 1,
		/obj/item/medevac_beacon = 1,
		/obj/item/roller = 1,
		/obj/item/tweezers = 1,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone = 1,
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/tool/surgery/solderingtool = 1,
	),
	SQUAD_SMARTGUNNER = list(
		/obj/item/clothing/glasses/night/m56_goggles = 1,
	),
	SQUAD_LEADER = list(
		/obj/item/explosive/plastique = 1,
		/obj/item/supply_beacon = 2,
		/obj/item/orbital_bombardment_beacon = 1,
		/obj/item/whistle = 1,
		/obj/item/binoculars/tactical = 1,
		/obj/item/pinpointer = 1,
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/clothing/head/modular/m10x/leader = 1,
	),
	FIELD_COMMANDER = list(
		/obj/item/explosive/plastique = 1,
		/obj/item/supply_beacon = 1,
		/obj/item/orbital_bombardment_beacon = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/roller/medevac = 1,
		/obj/item/medevac_beacon = 1,
		/obj/item/whistle = 1,
		/obj/item/clothing/glasses/hud/health = 1,
	),
	SYNTHETIC = list(
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/tool/weldingtool/hugetank = 1,
		/obj/item/lightreplacer = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/tool/handheld_charger = 1,
		/obj/item/defibrillator = 1,
		/obj/item/medevac_beacon = 1,
		/obj/item/roller/medevac = 1,
		/obj/item/roller = 1,
		/obj/item/bodybag/cryobag = 1,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone = 1,
		/obj/item/tweezers = 1,
		/obj/item/tool/surgery/solderingtool = 1,
		/obj/item/supplytablet = 1,
	),
))

///Storage items that will always have their default content
GLOBAL_LIST_INIT(loadout_instantiate_default_contents, typecacheof(list(
	/obj/item/storage/box/mre,
	/obj/item/storage/pill_bottle/packet,
	/obj/item/storage/pill_bottle,
	/obj/item/storage/box/m94,
	/obj/item/storage/fancy/chemrettes,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/storage/pouch/surgery,
	/obj/item/armor_module/storage/uniform/surgery_webbing,
)))

//Defines use for the visualisation of loadouts
#define NO_OFFSET "0%"
#define NO_SCALING 1
#define MODULAR_ARMOR_OFFSET_Y "-10%"
#define MODULAR_ARMOR_SCALING 1.2

///The maximum number of loadouts one player can have
#define MAXIMUM_LOADOUT 50

/// The current loadout version
#define CURRENT_LOADOUT_VERSION 15

GLOBAL_LIST_INIT(accepted_loadout_versions, list(5, 6, 7, 8, 9, 10, 11, 13, 14, 15))
