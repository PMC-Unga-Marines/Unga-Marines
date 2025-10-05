/*
Doesn't do anything or hold anything anymore.
Generated per the various mags, and then changed based on the number of
casings. .dir is the main thing that controls the icon. It modifies
the icon_state to look like more casings are hitting the ground.
There are 8 directions, 8 bullets are possible so after that it tries to grab the next
icon_state while reseting the direction. After 16 casings, it just ignores new
ones. At that point there are too many anyway. Shells and bullets leave different
items, so they do not intersect. This is far more efficient than using Blend() or
Turn() or Shift() as there is virtually no overhead. ~N
*/
/obj/item/ammo_casing
	name = "spent casing"
	desc = "Empty and useless now."
	icon = 'icons/obj/items/casings.dmi'
	icon_state = "casing_"
	throwforce = 1
	w_class = WEIGHT_CLASS_TINY
	layer = LOW_ITEM_LAYER //Below other objects
	dir = 1 //Always north when it spawns.
	atom_flags = CONDUCT|DIRLOCK
	///This is manipulated in the procs that use these.
	var/current_casings = 1
	///Maximum amount of casings 1 stack can have
	var/max_casings = 16
	///Current icon of the casings stack, increases by 1 with each casing in the stack
	var/current_icon = 0
	///How many variations of this item there are.
	var/number_of_states = 10
	///holder for icon_state so we can do random variations without effecting mapper visibility
	var/initial_icon_state = "cartridge_"

/obj/item/ammo_casing/Initialize(mapload)
	. = ..()
	pixel_x = rand(-2, 2) //Want to move them just a tad.
	pixel_y = rand(-2, 2)
	icon_state = initial_icon_state += "[rand(1, number_of_states)]" //Set the icon to it.

//This does most of the heavy lifting. It updates the icon and name if needed

/obj/item/ammo_casing/update_name(updates)
	. = ..()
	if(max_casings >= current_casings && current_casings == 2)
		name += "s" //In case there is more than one.

/obj/item/ammo_casing/update_icon_state()
	. = ..()
	if(max_casings < current_casings)
		return
	if(round((current_casings - 1) / 8) > current_icon)
		current_icon++
		icon_state += "_[current_icon]"

	var/base_direction = current_casings - (current_icon * 8)
	setDir(base_direction + round(base_direction) / 3)
	switch(current_casings)
		if(3 to 5)
			w_class = WEIGHT_CLASS_SMALL //Slightly heavier.
		if(9 to 10)
			w_class = WEIGHT_CLASS_NORMAL //Can't put it in your pockets and stuff.

///changes .dir to simulate new casings, also sets the new w_class
/obj/item/ammo_casing/proc/update_dir()
	var/base_direction = current_casings - (current_icon * 8)
	setDir(base_direction + round(base_direction) / 3)
	switch(current_casings)
		if(3 to 5)
			w_class = WEIGHT_CLASS_SMALL //Slightly heavier.
		if(9 to 10)
			w_class = WEIGHT_CLASS_NORMAL //Can't put it in your pockets and stuff.

/obj/item/ammo_casing/update_icon()
	update_dir()
	return ..()

//Making child objects so that locate() and istype() doesn't screw up.
/obj/item/ammo_casing/bullet

/obj/item/ammo_casing/cartridge
	name = "spent cartridge"
	icon_state = "cartridge"

/obj/item/ammo_casing/shell
	name = "spent shell"
	initial_icon_state = "shell_"
	icon_state = "shell"
