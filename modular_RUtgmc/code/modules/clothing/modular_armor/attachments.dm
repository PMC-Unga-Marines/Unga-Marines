/obj/item/armor_module/armor/proc/extra_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("<b>Right click</b> the [parent] with <b>facepaint</b> to color [src].")
