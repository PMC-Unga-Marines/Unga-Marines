/obj/structure/bookcase
	name = "bookcase"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "book-0"
	max_integrity = 200
	resistance_flags = XENO_DAMAGEABLE
	anchored = TRUE
	density = TRUE
	opacity = TRUE
	allow_pass_flags = PASS_AIR

/obj/structure/bookcase/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_PAPER, -40, 5)

/obj/structure/bookcase/Initialize(mapload)
	. = ..()
	for(var/obj/item/I in loc)
		if(istype(I, /obj/item/book))
			I.loc = src
	update_icon()

/obj/structure/bookcase/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/book))
		user.drop_held_item()
		I.forceMove(src)
		update_icon()

	else if(istype(I, /obj/item/tool/pen))
		var/newname = stripped_input(user, "What would you like to title this bookshelf?")
		if(!newname)
			return

		name = ("bookcase ([sanitize(newname)])")

/obj/structure/bookcase/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(length(contents))
		var/obj/item/book/choice = tgui_input_list(user, "Which book would you like to remove from the shelf?", null, contents)
		if(choice)
			if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
				return
			if(ishuman(user))
				if(!user.get_active_held_item())
					user.put_in_hands(choice)
			else
				choice.loc = get_turf(src)
			update_icon()

/obj/structure/bookcase/ex_act(severity)
	if(prob(severity * 0.3))
		for(var/obj/item/book/our_book in contents)
			if(prob(severity * 0.5))
				qdel(our_book)
			else
				our_book.forceMove(get_turf(src))
		qdel(src)

/obj/structure/bookcase/update_icon_state()
	. = ..()
	if(length(contents) < 5)
		icon_state = "book-[length(contents)]"
	else
		icon_state = "book-5"

/obj/structure/bookcase/manuals/medical
	name = "Medical Manuals bookcase"

/obj/structure/bookcase/manuals/medical/Initialize(mapload)
	. = ..()
	new /obj/item/book/manual/medical_cloning(src)
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	update_icon()

/obj/structure/bookcase/manuals/engineering
	name = "Engineering Manuals bookcase"

/obj/structure/bookcase/manuals/engineering/Initialize(mapload)
	. = ..()
	new /obj/item/book/manual/engineering_construction(src)
	new /obj/item/book/manual/engineering_particle_accelerator(src)
	new /obj/item/book/manual/engineering_hacking(src)
	new /obj/item/book/manual/engineering_guide(src)
	new /obj/item/book/manual/atmospipes(src)
	new /obj/item/book/manual/engineering_singularity_safety(src)
	new /obj/item/book/manual/evaguide(src)
	update_icon()

/obj/structure/bookcase/manuals/research_and_development
	name = "R&D Manuals bookcase"

/obj/structure/bookcase/manuals/research_and_development/Initialize(mapload)
	. = ..()
	new /obj/item/book/manual/research_and_development(src)
	update_icon()
