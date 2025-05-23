/obj/item/storage/surgical_tray
	name = "surgical tray"
	desc = "A small metallic tray covered in sterile tarp. Intended to store surgical tools in a neat and clean fashion."
	icon_state = "surgical_tray"
	icon = 'icons/obj/surgery.dmi'
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_BULKY //Should not fit in backpacks
	storage_type = /datum/storage/surgical_tray

/obj/item/storage/surgical_tray/PopulateContents()
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/surgical_membrane(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/suture(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/stack/nanopaste(src)

/obj/item/storage/surgical_tray/update_icon_state()
	. = ..()
	if(!length(contents))
		icon_state = "surgical_tray_e"
	else
		icon_state = "surgical_tray"

/obj/item/storage/surgical_tray/alt
	icon_state = "alt_surgical_tray"

/obj/item/storage/surgical_tray/alt/update_icon_state()
	return
