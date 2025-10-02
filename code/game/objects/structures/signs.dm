/obj/structure/sign
	icon = 'icons/obj/decals_arrow.dmi'
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	layer = WALL_OBJ_LAYER
	plane = WALL_PLANE
	///if true init to a given x/y offset on a wall, if not leave floating in space. used for multiple signs on a wall to prevent them all from moving to the same offset and overlapping/becoming unreadable.
	var/directional = TRUE
	///The icon sign will change on Initialize.
	var/base_icon = 'icons/obj/decals.dmi'

/obj/structure/sign/Initialize(mapload)
	. = ..()
	if(base_icon)
		icon = base_icon
	if(!directional) //if not directional do not initialize to a x or y offset
		return
	switch(dir)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 30
		if(WEST)
			pixel_x = -30

/obj/structure/sign/ex_act(severity)
	if(severity < EXPLODE_WEAK)
		return
	qdel(src)

/obj/structure/sign/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()

	if(istype(src, /obj/structure/sign/double))
		return
	to_chat(user, "You unfasten the sign with your [I].")
	var/obj/item/sign/S = new(loc)
	S.name = name
	S.desc = desc
	S.icon_state = icon_state
	S.sign_state = icon_state
	qdel(src)

/obj/item/sign
	name = "sign"
	desc = ""
	icon = 'icons/obj/decals.dmi'
	w_class = WEIGHT_CLASS_NORMAL		//big
	var/sign_state = ""

/obj/item/sign/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()

	if(!isturf(user.loc))
		return
	var/direction = tgui_input_list(user, "In which direction?", "Select direction.", list("North", "East", "South", "West"))
	if(!direction)
		return
	var/obj/structure/sign/S = new(user.loc)
	switch(direction)
		if("North")
			S.pixel_y = 32
		if("East")
			S.pixel_x = 32
		if("South")
			S.pixel_y = -32
		if("West")
			S.pixel_x = -32
		else
			return
	S.name = name
	S.desc = desc
	S.icon_state = sign_state
	to_chat(user, "You fasten \the [S] with your [I].")
	qdel(src)

/obj/structure/sign/double/map
	name = "station map"
	desc = "A framed picture of the station."

/obj/structure/sign/double/map/left
	icon_state = "map-left"

/obj/structure/sign/double/map/right
	icon_state = "map-right"

/obj/structure/sign/securearea
	name = "\improper SECURE AREA"
	desc = "A warning sign which reads 'SECURE AREA'."
	icon_state = "securearea"

/obj/structure/sign/securearea/firingrange
	name = "\improper FIRING RANGE"
	desc = "A warning sign which reads 'LIVE AMMUNITION RANGE'."
	icon_state = "firingrange"

/obj/structure/sign/biohazard
	name = "\improper BIOHAZARD"
	desc = "A warning sign which reads 'BIOHAZARD'."
	icon_state = "bio"

/obj/structure/sign/electricshock
	name = "\improper HIGH VOLTAGE"
	desc = "A warning sign which reads 'HIGH VOLTAGE'."
	icon_state = "shock"

/obj/structure/sign/cold
	name = "\improper LOW TEMPERATURE"
	desc = "A warning sign which reads 'LOW TEMPERATURE'."
	icon_state = "cold"

/obj/structure/sign/heat
	name = "\improper HIGH TEMPERATURE"
	desc = "A warning sign which reads 'HIGH TEMPERATURE'."
	icon_state = "heat"

/obj/structure/sign/gas
	name = "\improper GAS WARNING"
	desc = "A warning sign which reads 'GAS MASKS REQUIRED'."
	icon_state = "gasmask"

/obj/structure/sign/examroom
	name = "\improper EXAM"
	desc = "A guidance sign which reads 'EXAM ROOM'."
	icon_state = "examroom"

/obj/structure/sign/vacuum
	name = "\improper HARD VACUUM AHEAD"
	desc = "A warning sign which reads 'HARD VACUUM AHEAD'."
	icon_state = "space"

/obj/structure/sign/deathsposal
	name = "\improper DISPOSAL LEADS TO SPACE"
	desc = "A warning sign which reads 'DISPOSAL LEADS TO SPACE'."
	icon_state = "deathsposal"

/obj/structure/sign/pods
	name = "\improper ESCAPE PODS"
	desc = "A warning sign which reads 'ESCAPE PODS'."
	icon_state = "pods"

/obj/structure/sign/fire
	name = "\improper DANGER: FIRE"
	desc = "A warning sign which reads 'DANGER: FIRE'."
	icon_state = "fire"

/obj/structure/sign/nosmoking_1
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking"

/obj/structure/sign/nosmoking_2
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking2"

/obj/structure/sign/redcross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "redcross"

/obj/structure/sign/greencross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "greencross"

/obj/structure/sign/greencross/star
	icon_state = "lifestar"

/obj/structure/sign/goldenplaque
	name = "The Most Robust Men Award for Robustness"
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	icon_state = "goldenplaque"

/obj/structure/sign/kiddieplaque
	name = "AI developers plaque"
	desc = "Next to the extremely long list of names and job titles, there is a drawing of a little child. The child appears to be disabled. Beneath the image, someone has scratched the word \"PACKETS\""
	icon_state = "kiddieplaque"

/obj/structure/sign/atmosplaque
	name = "\improper FEA Atmospherics Division plaque"
	desc = "This plaque commemorates the fall of the Atmos FEA division. For all the charred, dizzy, and brittle men who have died in its hands."
	icon_state = "atmosplaque"

/obj/structure/sign/double/maltesefalcon	//The sign is 64x32, so it needs two tiles. ;3
	name = "The Maltese Falcon"
	desc = "The Maltese Falcon, Space Bar and Grill."

/obj/structure/sign/double/maltesefalcon/left
	icon_state = "maltesefalcon-left"

/obj/structure/sign/double/maltesefalcon/right
	icon_state = "maltesefalcon-right"

/obj/structure/sign/science
	name = "\improper SCIENCE!"
	desc = "A warning sign which reads 'SCIENCE!'."
	icon_state = "science1"

/obj/structure/sign/science/two
	icon_state = "science2"

/obj/structure/sign/xenobio
	name = "\improper SCIENCE!"
	desc = "A warning sign which reads 'SCIENCE!'."
	icon_state = "xenobio4"

/obj/structure/sign/xenobio/two
	icon_state = "xenobio"

/obj/structure/sign/chemistry
	name = "\improper CHEMISTRY"
	desc = "A warning sign which reads 'CHEMISTRY'."
	icon_state = "chemistry1"

/obj/structure/sign/chemistry2
	icon_state = "chemistry2"

/obj/structure/sign/pharmacy
	name = "\improper PHARMACY"
	desc = "A guidance sign which reads 'PHARMACY'."
	icon_state = "pharmacy"

/obj/structure/sign/botany
	name = "\improper HYDROPONICS"
	desc = "A guidance sign which reads 'HYDROPONICS'."
	icon_state = "hydro1"

/obj/structure/sign/holy
	name = "\improper Chapel sign"
	desc = "A sign labelling a religious area."
	icon_state = "holy"

/obj/structure/sign/custodian
	name = "\improper Janitor sign"
	desc = "A sign labelling an area where the janitor works."
	icon_state = "custodian"

/obj/structure/sign/mait
	name = "\improper Maintenance Tunnel sign"
	desc = "A sign labelling an area where the departments are linked together."
	icon_state = "mait1"

/obj/structure/sign/mait/alt
	name = "\improper Maintenance Tunnel sign"
	desc = "A sign labelling an area where the departments are linked together."
	icon_state = "mait2"

/obj/structure/sign/botany
	name = "\improper BODY DISPOSAL"
	desc = "A guidance sign which reads 'BODY DISPOSAL'."
	icon_state = "bodysposal"

/obj/structure/sign/doors
	name = "\improper DOORS"
	desc = "A guidance sign which reads 'DOORS'."
	icon_state = "doors"

/obj/structure/sign/engie
	name = "\improper ENGINEERING"
	desc = "A guidance sign which reads 'ENGINEERING'."
	icon_state = "engine"

/obj/structure/sign/evac
	name = "\improper EVACUATION"
	desc = "A guidance sign which reads 'EVACUATION'."
	icon_state = "evac"

/obj/structure/sign/hydro
	name = "\improper HYDROPNICS"
	desc = "A guidance sign which reads 'HYDROPNICS'."
	icon_state = "hydro1"

/obj/structure/sign/hydro/two
	icon_state = "hydro2"

/obj/structure/sign/hydro/three
	icon_state = "hydro3"

/obj/structure/sign/restroom
	name = "\improper RESTROOM"
	desc = "A guidance sign which reads 'RESTROOM'."
	icon_state = "restroom"

/obj/structure/sign/security
	name = "\improper SECURITY"
	desc = "A guidance sign which reads 'SECURITY'."
	icon_state = "security"

/obj/structure/sign/testchamber
	name = "\improper TEST CHAMBER"
	desc = "A guidance sign which reads 'TEST CHAMBER'."
	icon_state = "testchamber"


/obj/structure/sign/directions/science
	name = "\improper Science department"
	desc = "A direction sign, pointing out which way the Science department is."
	icon_state = "direction_sci"

/obj/structure/sign/directions/engineering
	name = "\improper Engineering department"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon_state = "direction_eng"

/obj/structure/sign/directions/security
	name = "\improper Security department"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

/obj/structure/sign/directions/medical
	name = "\improper Medical Bay"
	desc = "A direction sign, pointing out which way the Medical Bay is."
	icon_state = "direction_med"

/obj/structure/sign/directions/supply
	name = "cargo sign"
	desc = "A direction sign, pointing out which way the Cargo Bay is."
	icon_state = "direction_supply"

/obj/structure/sign/directions/evac
	name = "\improper Escape Arm"
	desc = "A direction sign, pointing out which way the escape shuttle dock is."
	icon_state = "direction_evac"

/obj/structure/sign/directions/command
	name = "command department sign"
	desc = "A direction sign, pointing out which way the Command department is."
	icon_state = "direction_bridge"

/obj/structure/sign/directions/mining
	name = "mining department sign"
	desc = "A direction sign, pointing out which way the Mining department is."
	icon_state = "direction_mining"

/obj/structure/sign/fixedinplace //direction signs that do not init to a position, handy for when we have to fit 4 signs on a wall at once
	directional = FALSE

/obj/structure/sign/fixedinplace/science
	name = "\improper Science department"
	desc = "A direction sign, pointing out which way the Science department is."
	icon_state = "direction_sci"

/obj/structure/sign/fixedinplace/engineering
	name = "\improper Engineering department"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon_state = "direction_eng"

/obj/structure/sign/fixedinplace/security
	name = "\improper Security department"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

/obj/structure/sign/fixedinplace/medical
	name = "\improper Medical Bay"
	desc = "A direction sign, pointing out which way the Medical Bay is."
	icon_state = "direction_med"

/obj/structure/sign/fixedinplace/supply
	name = "cargo sign"
	desc = "A direction sign, pointing out which way the Cargo Bay is."
	icon_state = "direction_supply"

/obj/structure/sign/fixedinplace/evac
	name = "\improper Escape Arm"
	desc = "A direction sign, pointing out which way the escape shuttle dock is."
	icon_state = "direction_evac"

/obj/structure/sign/fixedinplace/command
	name = "command department sign"
	desc = "A direction sign, pointing out which way the Command department is."
	icon_state = "direction_bridge"

/obj/structure/sign/fixedinplace/mining
	name = "mining department sign"
	desc = "A direction sign, pointing out which way the Mining department is."
	icon_state = "direction_mining"

//end nondirectional signs

/obj/structure/sign/safety/
	name = "sign"
	icon = 'icons/obj/safety_signs_arrow.dmi'
	base_icon = 'icons/obj/safety_signs.dmi'
	desc = "A sign warning of a particular hazard"
	anchored = TRUE
	opacity = FALSE
	density = FALSE

/obj/structure/sign/safety/airlock
	name = "\improper Airlock"
	desc = "A sign denoting the presence of an airlock nearby."
	icon_state = "sign_airlock"

/obj/structure/sign/safety/rad_shield
	name = "\improper Radiation shielded area"
	desc = "A sign denoting the presence of a lead radiation shielding."
	icon_state = "sign_rad_shield"

/obj/structure/sign/safety/no_grav
	name = "\improper Caution: Zero Gravity Area"
	desc = "A warning sign that warns of a Zero Gravity Area"
	icon_state = "sign_nograv"

/obj/structure/sign/safety/grav_suit
	name = "\improper Caution: Artifical Gravity Suit Required"
	desc = "A warning sign advising the use of an artifical gravity suit"
	icon_state = "sign_artgrav_suit"

/obj/structure/sign/safety/electronics
	name = "\improper Caution: Electrical Systems"
	desc = "A warning sign that warns of electrical systems"
	icon_state = "sign_electronics"

/obj/structure/sign/safety/autodoc
	name = "\improper Autodoc"
	desc = "A sign denoting the presence of a automated doctor nearby"
	icon_state = "sign_autodoc"

/obj/structure/sign/safety/bridge
	name = "\improper Bridge"
	desc = "A sign signifying the bridge"
	icon_state = "sign_bridge"

/obj/structure/sign/safety/blast_door
	name = "\improper Caution: Bulkhead"
	desc = "A sign warning of a bulkhead door nearby"
	icon_state = "sign_blastdoor"

/obj/structure/sign/safety/breakroom
	name = "\improper Breakroom"
	desc = "A sign denoting the presence of a breakroom nearby"
	icon_state = "sign_coffee"

/obj/structure/sign/safety/medical
	name = "\improper Medical Bay"
	desc = "A sign that denotes the proximity of a medical facility"
	icon_state = "sign_medical"

/obj/structure/sign/safety/maintenance
	name = "\improper Maintenance Shaft"
	desc = "A sign warning of a nearby maintenance shaft."
	icon_state = "sign_maint"

/obj/structure/sign/safety/galley
	name = "\improper Galley"
	desc = "A sign that denotes the proximity of food nearby."
	icon_state = "sign_galley"

/obj/structure/sign/safety/atmospherics
	name = "\improper Life Support System"
	desc = "A sign that denotes the proximity of a life supprot system."
	icon_state = "sign_life_support"

/obj/structure/sign/safety/vent
	name = "\improper Warning: Exhaust Vent"
	desc = "A warning sign that indicates a hazardous exhaust vent nearby"
	icon_state = "sign_exhaust"

/obj/structure/sign/safety/storage
	name = "\improper Storage Area"
	desc = "A sign that denotes the proximity of a storage facility."
	icon_state = "sign_storage"

/obj/structure/sign/safety/medical_supplies
	name = "\improper First-Aid"
	desc = "A sign denoting the presence of nearby "
	icon_state = "sign_medical_life_support"

/obj/structure/sign/safety/EVA
	name = "\improper EVA Suit Locker"
	desc = "A sign that indicates the presence of a EVA Suit Locker"
	icon_state = "sign_space_suit_locker"

/obj/structure/sign/safety/laser
	name = "\improper Warning: High-Energy Laser"
	desc = "A warning sign that warns of a lethal energy laser nearby"
	icon_state = "sign_laser"

/obj/structure/sign/safety/vacuum
	name = "\improper Warning: Vacuum"
	desc = "A warning sign indicating a pressureless area nearby"
	icon_state = "sign_vacuum"

/obj/structure/sign/safety/ladder
	name = "\improper Warning: Ladder"
	desc = "A sign that denotes the proximity of a ladder"
	icon_state = "sign_ladder"

/obj/structure/sign/safety/pressure
	name = "\improper Warning: Pressurised Area Ahead"
	desc = "A sign that warns of a pressurised area nearby"
	icon_state = "sign_pressurised_area"

/obj/structure/sign/safety/high_radiation
	name = "\improper Warning:HIGH RADIATION LEVELS"
	desc = "A sign that warns of dangerous radiation nearby"
	icon_state = "sign_high_rad"

/obj/structure/sign/safety/rad_hazard
	name = "\improper Warning: Radiation Hazard"
	desc = "A sign that warns of radiation nearby"
	icon_state = "sign_rad_hazard"

/obj/structure/sign/safety/cryogenic
	name = "\improper Cryogenic Vault"
	desc = "A sign that denotes the presence of a cryogenic vault"
	icon_state = "sign_cryo_vault"

/obj/structure/sign/safety/hazard
	name = "\improper Warning: Hazardous Materials"
	desc = "A sign that warns of hazardous materials nearby"
	icon_state = "sign_hazard"

/obj/structure/sign/safety/computer
	name = "\improper Warning: Critical System"
	desc = "A warning sign that warns of facility critical computer systems"
	icon_state = "sign_computer"

/obj/structure/sign/safety/hydro
	name = "\improper Hydrophonics"
	desc = "A sign that denotes the presence of a hydrophonic facility"
	icon_state = "sign_food_fridge"

/obj/structure/sign/safety/fridge
	name = "\improper Refridgerated Storage"
	desc = "A sign that denotes the presence of a refridgeration facility"
	icon_state = "sign_cold_storage"

/obj/structure/sign/safety/radio
	name = "\improper Intercommunication System"
	desc = "A sign notifying the presence of a intercomm system."
	icon_state = "sign_intercomm"

//Marine signs

/obj/structure/sign/ROsign
	name = "\improper TGMC requisitions office guidelines"
	desc = " 1. You are not entitled to service or equipment. Attachments are a privilege, not a right.\n 2. You must be fully dressed to obtain service. Cryosleep underwear is non-permissible.\n 3. The Requsitions Officer has the final say and the right to decline service. Only the Acting Captain may override his decisions.\n 4. Please treat your Requsitions staff with respect. They work hard."
	icon_state = "roplaque"

/obj/structure/sign/prop1
	name = "\improper TerraGov poster"
	desc = "The symbol of the Terran Goverment."
	icon_state = "prop1"

/obj/structure/sign/prop1/Initialize(mapload)
	. = ..()
	icon = 'icons/obj/decals.dmi'

/obj/structure/sign/prop2
	name = "\improper TGMC poster"
	desc = "A deeply faded poster of a group of glamorous TerraGov Marine Corps in uniform. Probably taken pre-Alpha."
	icon_state = "prop2"

/obj/structure/sign/prop3
	name = "\improper TGMC poster"
	desc = "An old recruitment poster for the TGMC. Looking at it floods you with a mixture of pride and sincere regret."
	icon_state = "prop3"

/obj/structure/sign/prop4
	name = "TerraGov: United for Humanity"
	desc = "A poster depicting TerraGov's logo and motto, reminding marines of who's looking out for humankind against the Xenomorph menace."
	icon_state = "prop4"

/obj/structure/sign/sanford
	name = "Employee of the Month Award"
	desc = "This certificate is awarded to <b>Sanford Stephano</b>. For your outstanding service to NT and injecting random individuals with roulettium at will."
	icon_state = "sanford_month"
	dir = NORTH

/obj/structure/sign/sanford/year
	name = "Employee of the Year Award"
	icon_state = "sanford_year"

//=====================//
// SEMIOTIC STANDARD  //
//===================//

/obj/structure/sign/semiotic
	name = "sign"
	icon = 'icons/obj/semiotic_standard.dmi'
	base_icon = null
	desc = "A sign denoting Semiotic Standard. The Interstellar Commerce Commission requires that these symbols be placed pretty much everywhere for your safety."
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	directional = FALSE

/obj/structure/sign/semiotic/airlock
	name = "airlock semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an airlock."
	icon_state = "airlock"

/obj/structure/sign/semiotic/ammunition
	name = "ammunition storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an ammunition storage."
	icon_state = "ammo"

/obj/structure/sign/semiotic/analysis_lab
	name = "analysis laboratory semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an analysis laboratory."
	icon_state = "analysislab"

/obj/structure/sign/semiotic/autodoc
	name = "autodoc semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an autodoc."
	icon_state = "autodoc"

/obj/structure/sign/semiotic/autoopenclose
	name = "automatic opener/closer semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an automatic shutoff valve."
	icon_state = "autoopenclose"

/obj/structure/sign/semiotic/bathmens
	name = "men's bathroom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a men's bathroom."
	icon_state = "bathmens"

/obj/structure/sign/semiotic/bathunisex
	name = "unisex bathroom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a unisex bathroom."
	icon_state = "bathunisex"

/obj/structure/sign/semiotic/bathwomens
	name = "women's bathroom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a women's bathroom."
	icon_state = "bathwomens"

/obj/structure/sign/semiotic/biohazard
	name = "biohazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a biohazard."
	icon_state = "biohazard"

/obj/structure/sign/semiotic/biolab
	name = "biological laboratory semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a biological laboratory."
	icon_state = "biolab"

/obj/structure/sign/semiotic/bridge
	name = "bridge semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a starship's bridge."
	icon_state = "bridge"

/obj/structure/sign/semiotic/bulkhead_door
	name = "bulkhead door semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a bulkhead door."
	icon_state = "bulkheaddoor"

/obj/structure/sign/semiotic/chem_lab
	name = "chemical laboratory semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a chemical laboratory."
	icon_state = "chemlab"

/obj/structure/sign/semiotic/coffee
	name = "coffee semiotic"
	desc = "Semiotic Standard denoting the nearby presence of coffee: the lifeblood of any starship crew."
	icon_state = "coffee"

/obj/structure/sign/semiotic/commline_connection
	name = "point of connection for a communication line semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a comm line connection."
	icon_state = "commlineconnection"

/obj/structure/sign/semiotic/conference_room
	name = "conference room semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a conference room."
	icon_state = "confroom"

/obj/structure/sign/semiotic/cryo
	name = "cryogenic vault semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a cryogenics vault."
	icon_state = "cryo"

/obj/structure/sign/semiotic/debark_lounge
	name = "debarkation lounge semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a debarkation lounge."
	icon_state = "debarkationlounge"

/obj/structure/sign/semiotic/distribution_pipes
	name = "distribution pipes semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a distribution pipeline."
	icon_state = "distpipe"

/obj/structure/sign/semiotic/east
	name = "\improper East semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the East."
	icon_state = "east"

/obj/structure/sign/semiotic/electronics
	name = "astronic systems semiotic"
	desc = "Semiotic Standard denoting the nearby presence of astronic systems. That's a fancy way of saying electrical systems."
	icon_state = "astronics"

/obj/structure/sign/semiotic/elevator
	name = "elevator semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an elevator."
	icon_state = "elevator"

/obj/structure/sign/semiotic/escapepod
	name = "escape pod semiotic"
	desc = "Semiotic Standard denoting an escape pod."
	icon_state = "escapepod"

/obj/structure/sign/semiotic/exhaust
	name = "exhaust semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an engine or generator exhaust."
	icon_state = "exhaust"

/obj/structure/sign/semiotic/fire_haz
	name = "fire hazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a fire hazard."
	icon_state = "firehaz"

/obj/structure/sign/semiotic/firingrange
	name = "firing range semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a live ammunition firing range."
	icon_state = "firingrange"

/obj/structure/sign/semiotic/food_storage
	name = "organic storage (foodstuffs) semiotic"
	desc = "Semiotic Standard denoting the nearby presence of unrefrigerated food storage."
	icon_state = "foodstorage"

/obj/structure/sign/semiotic/galley
	name = "galley semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a galley."
	icon_state = "galley"

/obj/structure/sign/semiotic/hazard
	name = "hazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a hazard. Watch out!"
	icon_state = "hazard"

/obj/structure/sign/semiotic/high_rad
	name = "high radioactivity semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a highly radioactive area."
	icon_state = "highrad"

/obj/structure/sign/semiotic/high_voltage
	name = "high voltage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a high voltage electrical current."
	icon_state = "highvoltage"

/obj/structure/sign/semiotic/hvac
	name = "\improper HVAC semiotic"
	desc = "Semiotic Standard denoting the nearby presence of...an HVAC system. This sign must have been updated to the new standard."
	icon_state = "hvac"

/obj/structure/sign/semiotic/hvac_old
	name = "\improper HVAC semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an HVAC system. This sign is still using the old standard."
	icon_state = "hvacold"

/obj/structure/sign/semiotic/intercom
	name = "intercom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an intercom."
	icon_state = "comm"

/obj/structure/sign/semiotic/ladder
	name = "ladder semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a ladder."
	icon_state = "ladder"

/obj/structure/sign/semiotic/laser
	name = "laser semiotic"
	desc = "Semiotic Standard denoting the nearby presence of lasers. It's usually not as cool as it sounds."
	icon_state = "laser"

/obj/structure/sign/semiotic/life_support
	name = "life support system semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a life support system."
	icon_state = "lifesupport"

/obj/structure/sign/semiotic/maint
	name = "maintenace semiotic"
	desc = "Semiotic Standard denoting the nearby presence of maintenance access."
	icon_state = "maint"

/obj/structure/sign/semiotic/manualopenclose
	name = "manual opener/closer semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a manual shutoff valve."
	icon_state = "manualopenclose"

/obj/structure/sign/semiotic/med_cryo
	name = "medical cryostasis vault semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a medical cryostasis vault."
	icon_state = "medcryo"

/obj/structure/sign/semiotic/med_life_support
	name = "medical life support semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a life support system for a medbay."
	icon_state = "medlifesupport"

/obj/structure/sign/semiotic/medical
	name = "medical semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a medbay."
	icon_state = "medical"

/obj/structure/sign/semiotic/nonpress
	name = "non-pressurized area beyond semiotic"
	desc = "Semiotic Standard denoting that the area beyond isn't pressurized."
	icon_state = "nonpressarea"

/obj/structure/sign/semiotic/nonpress_ag
	name = "artificial gravity area, non-pressurized, suit required semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an area with artificial gravity lacking in pressurization."
	icon_state = "nonpressag"

/obj/structure/sign/semiotic/nonpress_0g
	name = "non-pressurized area, no gravity, suit required semiotic"
	desc = "Semiotic Standard denoting that the area beyond isn't pressurized and has no artificial gravity."
	icon_state = "nonpresszerog"

/obj/structure/sign/semiotic/north
	name = "\improper North semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the North."
	icon_state = "north"

/obj/structure/sign/semiotic/opens_up
	name = "opens upwards semiotic"
	desc = "Semiotic Standard denoting the nearby door opens upwards."
	icon_state = "opensup"

/obj/structure/sign/semiotic/outpatient
	name = "outpatient clinic semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an outpatient clinic."
	icon_state = "outpatient"

/obj/structure/sign/semiotic/fibre_optics
	name = "photonics systems (fibre optics) semiotic"
	desc = "Semiotic Standard denoting the nearby presence of fibre optics lines."
	icon_state = "fibreoptic"

/obj/structure/sign/semiotic/press_area_ag
	name = "pressurized with artificial gravity semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a pressurized area without artificial gravity."
	icon_state = "pressareaag"

/obj/structure/sign/semiotic/press_area
	name = "pressurized area semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a pressurized area."
	icon_state = "pressarea"

/obj/structure/sign/semiotic/rad_haz
	name = "radiation hazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a radiation hazard."
	icon_state = "radhaz"

/obj/structure/sign/semiotic/rad_shield
	name = "area shielded from radiation semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an area shielded from radiation."
	icon_state = "radshield"

/obj/structure/sign/semiotic/radio_rad
	name = "radiation of radio waves semiotic"
	desc = "Semiotic Standard denoting the nearby presence of radiation from a radio tower."
	icon_state = "radiorad"

/obj/structure/sign/semiotic/reception
	name = "reception semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a reception area."
	icon_state = "reception"

/obj/structure/sign/semiotic/reduction
	name = "reduction dilation of area semiotic"
	desc = "Semiotic Standard denoting that the area gets smaller ahead."
	icon_state = "reduction"

/obj/structure/sign/semiotic/ref_bio_storage
	name = "refrigerated biological storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of refrigerated biological storage."
	icon_state = "refbiostorage"

/obj/structure/sign/semiotic/ref_chem_storage
	name = "refrigerated chemical storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of refrigerated chemical storage."
	icon_state = "refchemstorage"

/obj/structure/sign/semiotic/restrictedarea
	name = "restricted area semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a restricted area."
	icon_state = "restrictedarea"

/obj/structure/sign/semiotic/fridge
	name = "refrigerated storage (organic foodstuffs) semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a fridge."
	icon_state = "fridge"

/obj/structure/sign/semiotic/refridgeration
	name = "refrigeration semiotic"
	desc = "Semiotic Standard denoting the nearby presence of non-food refrigeration."
	icon_state = "refridgeration"

/obj/structure/sign/semiotic/rewire
	name = "rewire system semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a rewire system."
	icon_state = "rewire"

/obj/structure/sign/semiotic/security
	name = "security semiotic"
	desc = "Semiotic Standard denoting the nearby presence of law enforcement or a security force."
	icon_state = "security"

/obj/structure/sign/semiotic/south
	name = "\improper South semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the South."
	icon_state = "south"

/obj/structure/sign/semiotic/stairs
	name = "stairs semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a staircase."
	icon_state = "stairs"

/obj/structure/sign/semiotic/storage
	name = "storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a general dry storage room."
	icon_state = "storage"

/obj/structure/sign/semiotic/suit_storage
	name = "pressure suit locker semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a pressure suit storage locker."
	icon_state = "suitstorage"

/obj/structure/sign/semiotic/synth_storage
	name = "synthetic storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a synthetic unit storage room."
	icon_state = "synthstorage"

/obj/structure/sign/semiotic/terminal
	name = "computer terminal semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a computer terminal."
	icon_state = "terminal"

/obj/structure/sign/semiotic/tram
	name = "tram line semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a tram line."
	icon_state = "tramline"

/obj/structure/sign/semiotic/twilight_zone_terminator
	name = "twilight zone terminator semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a twilight zone terminator. It's way less cool than it sounds."
	icon_state = "twilightzoneterminator"

/obj/structure/sign/semiotic/water
	name = "water semiotic"
	desc = "Semiotic Standard denoting the nearby presence of water."
	icon_state = "water"

/obj/structure/sign/semiotic/waterhazard
	name = "water hazard semiotic"
	desc = "Semiotic Standard denoting a water hazard. Keep electronics away."
	icon_state = "waterhaz"

/obj/structure/sign/semiotic/west
	name = "\improper West semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the West."
	icon_state = "west"

/obj/structure/sign/semiotic/zero_g
	name = "artificial gravity absent semiotic"
	desc = "Semiotic Standard denoting the nearby lack of artificial gravity."
	icon_state = "zerog"

/obj/structure/sign/semiotic/flightcontrol
	name = "\improper flight control semiotic"
	desc = "Semiotic Standard denoting an area used by or for flight control systems."
	icon_state = "flightcontrol"

/obj/structure/sign/semiotic/airtraffictower
	name = "\improper air traffic tower semiotic"
	desc = "Semiotic Standard denoting an air traffic tower nearby."
	icon_state = "airtraffictower"

/obj/structure/sign/semiotic/luggageclaim
	name = "\improper luggage claim semiotic"
	desc = "Semiotic Standard denoting the presecense of a luggage claim area nearby."
	icon_state = "luggageclaim"

/obj/structure/sign/semiotic/landingzone
	name = "\improper landing zone semiotic"
	desc = "Semiotic Standard denoting the presecense of a landing zone nearby."
	icon_state = "landingzone"

/obj/structure/sign/semiotic/zero
	name = "zero semiotic"
	desc = "Semiotic Standard denoting the number zero."
	icon_state = "0"

/obj/structure/sign/semiotic/one
	name = "one semiotic"
	desc = "Semiotic Standard denoting the number one."
	icon_state = "1"

/obj/structure/sign/semiotic/two
	name = "two semiotic"
	desc = "Semiotic Standard denoting the number two."
	icon_state = "2"

/obj/structure/sign/semiotic/three
	name = "three semiotic"
	desc = "Semiotic Standard denoting the number three."
	icon_state = "3"

/obj/structure/sign/semiotic/four
	name = "four semiotic"
	desc = "Semiotic Standard denoting the number four."
	icon_state = "4"

/obj/structure/sign/semiotic/five
	name = "five semiotic"
	desc = "Semiotic Standard denoting the number five."
	icon_state = "5"

/obj/structure/sign/semiotic/six
	name = "six semiotic"
	desc = "Semiotic Standard denoting the number six."
	icon_state = "6"

/obj/structure/sign/semiotic/seven
	name = "seven semiotic"
	desc = "Semiotic Standard denoting the number seven."
	icon_state = "7"

/obj/structure/sign/semiotic/eight
	name = "eight semiotic"
	desc = "Semiotic Standard denoting the number eight."
	icon_state = "8"

/obj/structure/sign/semiotic/nine
	name = "nine semiotic"
	desc = "Semiotic Standard denoting the number nine."
	icon_state = "9"
