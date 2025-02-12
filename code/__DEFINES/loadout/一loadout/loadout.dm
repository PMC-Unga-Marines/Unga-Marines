/// If the globals are defined before the needed ones, they end up empty and loadouts don't work
/// This is ugly, but I don't think theres any other way to bypass this
/// I used a japanese kanji symbol "一" so it's guaranteed to be last in the folder, and isn't as ugly as "zzz"

///Assoc list linking the job title with their specific clothes vendor
GLOBAL_LIST_INIT(job_specific_clothes_vendor, list(
	SQUAD_MARINE = GLOB.marine_clothes_listed_products,
	SQUAD_ROBOT = GLOB.robot_clothes_listed_products,
	SQUAD_ENGINEER = GLOB.engineer_clothes_listed_products,
	SQUAD_CORPSMAN = GLOB.medic_clothes_listed_products,
	SQUAD_SMARTGUNNER = GLOB.smartgunner_clothes_listed_products,
	SQUAD_LEADER = GLOB.leader_clothes_listed_products,
	FIELD_COMMANDER = GLOB.commander_clothes_listed_products,
	SYNTHETIC = GLOB.synthetic_clothes_listed_products,
))

///Assoc list linking the job title with their specific points vendor
GLOBAL_LIST_INIT(job_specific_points_vendor, list(
	SQUAD_MARINE = GLOB.marine_gear_listed_products,
	SQUAD_ROBOT = GLOB.robot_gear_listed_products,
	SQUAD_ENGINEER = GLOB.engineer_gear_listed_products,
	SQUAD_CORPSMAN = GLOB.medic_gear_listed_products,
	SQUAD_SMARTGUNNER = GLOB.smartgunner_gear_listed_products,
	SQUAD_LEADER = GLOB.leader_gear_listed_products,
	FIELD_COMMANDER = GLOB.commander_gear_listed_products,
	SYNTHETIC = GLOB.synthetic_gear_listed_products,
))
