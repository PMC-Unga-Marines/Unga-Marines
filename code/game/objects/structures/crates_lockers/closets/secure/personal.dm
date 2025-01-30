/obj/structure/closet/secure_closet/personal
	desc = "It's a secure locker for personnel. The first card swiped gains control."
	name = "personal closet"
	req_access = list(ACCESS_CIVILIAN_PUBLIC)

/obj/structure/closet/secure_closet/personal/Initialize(mapload)
	. = ..()
	if(prob(50))
		new /obj/item/storage/backpack(src)
	else
		new /obj/item/storage/backpack/satchel/norm(src)

/obj/structure/closet/secure_closet/personal/patient
	name = "Patient's Closet"

/obj/structure/closet/secure_closet/personal/morgue
	name = "Morgue Closet"

/obj/structure/closet/secure_closet/personal/patient/PopulateContents()
	new /obj/item/clothing/under/color/white( src )
	new /obj/item/clothing/shoes/white( src )

/obj/structure/closet/secure_closet/personal/cabinet
	icon_state = "cabinetdetective_locked"
	icon_closed = "cabinetdetective"
	icon_locked = "cabinetdetective_locked"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_broken"
	icon_off = "cabinetdetective_broken"

/obj/structure/closet/secure_closet/personal/cabinet/update_icon_state()
	. = ..()
	if(broken)
		icon_state = icon_broken
	else
		if(!opened)
			if(locked)
				icon_state = icon_locked
			else
				icon_state = icon_closed
		else
			icon_state = icon_opened

/obj/structure/closet/secure_closet/personal/cabinet/PopulateContents()
	new /obj/item/storage/backpack/satchel( src )
	new /obj/item/radio/headset( src )
