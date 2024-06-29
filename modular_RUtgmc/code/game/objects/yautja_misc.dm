/obj/structure/prop/brazier
	name = "brazier"
	desc = "The fire inside the brazier emits a relatively dim glow to flashlights and flares, but nothing can replace the feeling of sitting next to a fireplace with your friends."
	icon = 'modular_RUtgmc/icons/obj/structures/torch.dmi'
	icon_state = "brazier"
	density = TRUE
	light_on = TRUE
	light_range = 5
	light_power = 2
	light_system = STATIC_LIGHT
	light_color = "#b49a27"

/obj/structure/prop/brazier/Initialize(...)
	. = ..()
	set_light_on(FALSE)
	if(light_on)
		set_light_on(TRUE)

/obj/structure/prop/brazier/frame
	name = "empty brazier"
	desc = "An empty brazier."
	icon_state = "brazier_frame"
	light_range = 0
	light_on = FALSE

/obj/structure/prop/brazier/frame/attackby(obj/item/hit_item, mob/user)
	if(!istype(hit_item, /obj/item/stack/sheet/wood))
		return ..()
	var/obj/item/stack/wooden_boards = hit_item
	if(wooden_boards.amount < 5)
		to_chat(user, span_warning("Not enough wood!"))
		return
	wooden_boards.use(5)
	user.visible_message(span_notice("[user] fills the brazier with wood."))
	new /obj/structure/prop/brazier/frame_woodened(loc)
	qdel(src)

/obj/structure/prop/brazier/frame_woodened
	name = "empty full brazier"
	desc = "An empty brazier. Yet it's also full. What???  Use something hot to ignite it, like a welding tool."
	icon_state = "brazier_frame_filled"
	light_range = 0
	light_on = FALSE

/obj/structure/prop/brazier/frame_woodened/attackby(obj/item/hit_item, mob/user)
	if(hit_item.damtype != BURN)
		return ..()
	user.visible_message(span_notice("[user] ignites the brazier with [hit_item]."))
	new /obj/structure/prop/brazier(loc)
	qdel(src)

/obj/structure/prop/brazier/torch
	name = "torch"
	desc = "It's a torch."
	icon = 'modular_RUtgmc/icons/obj/structures/torch.dmi'
	icon_state = "torch"
	density = FALSE
	light_range = 7
	light_power = 1

/obj/structure/prop/brazier/torch/frame
	name = "unlit torch"
	desc = "It's a torch, but it's not lit.  Use something hot to ignite it, like a welding tool."
	icon_state = "torch_frame"
	light_range = 0

/obj/structure/prop/brazier/torch/frame/attackby(obj/item/hit_item, mob/user)
	if(hit_item.damtype != BURN)
		return ..()
	user.visible_message(span_notice("[user] ignites the torch with [hit_item]."))
	new /obj/structure/prop/brazier/torch(loc)
	qdel(src)

/obj/item/frame/torch_frame
	name = "unlit torch"
	icon = 'modular_RUtgmc/icons/obj/structures/torch.dmi'
	desc = "It's a torch, but it's not lit or placed down. Click on a wall to place it."
	icon_state = "torch_frame"

/obj/item/frame/torch_frame/proc/try_build(turf/on_wall)
	if(get_dist(on_wall, usr) > 1)
		return
	var/ndir = get_dir(usr, on_wall)
	if(!(ndir in GLOB.cardinals))
		return
	var/turf/loc = get_turf(usr)
	if(!isfloorturf(loc))
		to_chat(usr, span_warning("[src.name] cannot be placed on this spot."))
		return
	to_chat(usr, "Attaching [src] to the wall.")
	playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
	var/constrdir = usr.dir
	if(!do_after(usr, 30, TRUE, on_wall, BUSY_ICON_BUILD))
		return
	var/obj/structure/prop/brazier/torch/frame/newlight = new /obj/structure/prop/brazier/torch/frame(get_turf(on_wall))
	newlight.setDir(constrdir)

	usr.visible_message("[usr.name] attaches [src] to the wall.", \
		"You attach [src] to the wall.")
	qdel(src)
