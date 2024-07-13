/obj/machinery/cic_maptable/yautja
	name = "hunter globe"
	desc = "A globe designed by the hunters to show them the location of prey across the hunting grounds."
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "globe"

	minimap_flag = MINIMAP_FLAG_XENO|MINIMAP_FLAG_MARINE|MINIMAP_FLAG_MARINE_SOM|MINIMAP_FLAG_EXCAVATION_ZONE|MINIMAP_FLAG_YAUTJA

/obj/machinery/prop/yautja/bubbler
	name = "yautja cauldron"
	desc = "A large, black machine emitting an ominous hum with an attached pot of boiling fluid. Bits of what appears to be leftover lard and balls of hair can be seen floating inside of it."
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "vat"
	density = TRUE

/obj/machinery/prop/yautja/bubbler/examine(mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		. += span_notice("You can use this machine to clean the skin off limbs, and turn them into bones for your armor.")
		. += span_notice("You first need to find a limb. Then you use a ceremonial dagger to prepare it.")
		. += span_notice("After preparing the limb, you put it into the cauldron, removing the flesh, leaving you with a bone.")
		. += span_notice("You will then clean and polish the resulting bones with a polishing rag, making it ready to be attached to your armor.")

/obj/machinery/prop/yautja/bubbler/attackby(obj/potential_limb, mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, span_notice("You have no idea what this does, and you figure it is not time to find out."))
		return

	if(!istype(potential_limb, /obj/item/limb))
		to_chat(user, span_notice("You cannot put this in [src]."))
		return
	var/obj/item/limb/current_limb = potential_limb

	if(!current_limb.flayed)
		to_chat(user, span_notice("This limb is not ready."))
		return
	icon_state = "vat_boiling"
	to_chat(user, span_warning("You place [current_limb] in and start the cauldron."))
	if(!do_after(user, 15 SECONDS, NONE, current_limb, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		to_chat(user, span_notice("You pull [current_limb] back out of the cauldron."))
		icon_state = initial(icon_state)
		return
	icon_state = initial(icon_state)

	var/obj/item/armor_module/limb/skeleton/new_bone = new current_limb.bone_type(get_turf(src))
	if(istype(new_bone, /obj/item/armor_module/limb/skeleton/head))
		new_bone.desc = span_notice("This skull used to be [current_limb.name].")
	qdel(current_limb)

/obj/machinery/microwave/yautja
	name = "alien microwave"
	desc = "Dark alloy sinister machine that heats up cold food."
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'

/obj/machinery/processor/yautja
	name = "food grinder"
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'

/obj/machinery/grill/yautja
	name = "alien grill"
	desc = "For grilling the most delicious prey."
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'

/obj/machinery/vending/dinnerware/yautja
	name = "dinnerplate dispenser"
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	products = list(
		/obj/item/tool/kitchen/tray = 8,
		/obj/item/tool/kitchen/utensil/fork = 6,
		/obj/item/tool/kitchen/knife = 3,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 8,
		/obj/item/clothing/suit/chef/classic = 2,
		/obj/item/clothing/head/chefhat = 1,
		/obj/item/tool/kitchen/utensil/spoon = 2,
		/obj/item/tool/kitchen/utensil/knife = 2,
		/obj/item/tool/kitchen/rollingpin = 2,
		/obj/item/tool/kitchen/knife/butcher = 2,
	)

/obj/machinery/vending/engivend/yautja
	name = "yautja autolathe"
	desc = "Weird alien industrial fabricator."
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "autolathe"
	icon_vend = "autholate_n"
	products = list(
		/obj/item/tool/multitool/yautja = -1,
		/obj/item/tool/analyzer = -1,
		/obj/item/t_scanner = -1,
		/obj/item/taperecorder = -1,
		/obj/item/assembly/igniter = -1,
		/obj/item/assembly/signaler = -1,
		/obj/item/assembly/infra = -1,
		/obj/item/assembly/timer = -1,
		/obj/item/assembly/prox_sensor = -1,
		/obj/item/light_bulb/tube = -1,
		/obj/item/light_bulb/bulb = -1,
		/obj/item/ashtray/glass = -1,
		/obj/item/frame/camera = -1,
		/obj/item/frame/table/reinforced = 10,
		/obj/item/frame/table = 10,
		/obj/item/reagent_containers/glass/bucket = -1,
	)

/obj/machinery/griddle/yautja
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'

/obj/machinery/chem_master/yautja
	name = "chemical distributor"
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'

/obj/structure/xenoautopsy/tank/hugger/yautja
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	broken_state = /obj/structure/xenoautopsy/tank/escaped/yautja

/obj/structure/xenoautopsy/tank/escaped/yautja
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'

//YAUTJA SHIP - CURRENTLY USES STRATA DOORS
/obj/machinery/door/airlock/yautja
	name = "\improper Airlock"
	icon = 'modular_RUtgmc/icons/obj/doors/strata_doors.dmi'
	openspeed = 5
	req_access = null
	req_one_access = null
	no_panel = TRUE
	not_weldable = TRUE
	resistance_flags = RESIST_ALL

/obj/machinery/door/airlock/yautja/secure
	req_one_access = list(ACCESS_YAUTJA_SECURE, ACCESS_YAUTJA_ELDER, ACCESS_YAUTJA_ANCIENT)

/obj/machinery/door/airlock/yautja/secure/elder
	req_one_access = list(ACCESS_YAUTJA_ELDER, ACCESS_YAUTJA_ANCIENT)

/obj/machinery/door/airlock/yautja/secure/ancient
	req_one_access = list(ACCESS_YAUTJA_ANCIENT)

/obj/machinery/door/airlock/sandstone/runed
	name = "\improper Runed Sandstone Airlock"
	icon = 'modular_RUtgmc/icons/obj/doors/doorrunedsand.dmi'
	mineral = "runed sandstone"
	openspeed = 4 SECONDS
	resistance_flags = RESIST_ALL
	color = "#b29082"

/obj/machinery/door/poddoor/shutters/almayer/yautja
	name = "Armory Shutter"
	id = "Yautja Armory"
	resistance_flags = RESIST_ALL

/obj/machinery/door/poddoor/shutters/almayer/yautja/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_YAUTJA_ARMORY_OPENED, PROC_REF(open))

/obj/structure/closet/coffin/predator
	name = "strange coffin"
	desc = "It's a burial receptacle for the dearly departed. Seems to have weird markings on the side..?"
	icon = 'modular_RUtgmc/icons/obj/structures/closet.dmi'
	icon_state = "pred_coffin"
	icon_closed = "pred_coffin"
	icon_opened = "pred_coffin_open"

/obj/structure/bed/chair/hunter
	name = "hunter chair"
	desc = "An exquisitely crafted chair for a large humanoid hunter."
	icon = 'modular_RUtgmc/icons/obj/hunter/chair.dmi'
	icon_state = "chair"
	color = rgb(255,255,255)
	buildstacktype = null
	resistance_flags = UNACIDABLE
