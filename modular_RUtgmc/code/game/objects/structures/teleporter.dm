/obj/machinery/deployable/teleporter/examine(mob/user)
	. = ..()
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!kit?.cell)
		. += span_notice("It currently lacks a power cell.")
	if(kit?.linked_teleporter)
		. += span_notice("It is currently linked to a Teleporter #[kit.linked_teleporter.self_tele_tag] at [get_area(kit.linked_teleporter)].")
	else
		. += span_notice("It isn't linked to any other teleporter.")

/obj/machinery/deployable/teleporter/attack_ghost(mob/dead/observer/user)
	. = ..()
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!kit.linked_teleporter)
		return
	user.forceMove(get_turf(kit.linked_teleporter))
