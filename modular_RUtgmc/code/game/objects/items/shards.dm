/obj/item/shard
	shardsize = TRUE

/obj/item/shard/Initialize(mapload)
	. = ..()
	if(shardsize)
		var/size_icon = pick("large", "medium", "small")
		switch(size_icon)
			if("small")
				pixel_x = rand(-12, 12)
				pixel_y = rand(-12, 12)
			if("medium")
				pixel_x = rand(-8, 8)
				pixel_y = rand(-8, 8)
			if("large")
				pixel_x = rand(-5, 5)
				pixel_y = rand(-5, 5)
		icon_state += size_icon
	else
		pixel_x = rand(-12, 12)
		pixel_y = rand(-12, 12)
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/shard/shrapnel
	var/damage_on_move = 0.5
	icon_state = "shrapnel"
	icon = 'modular_RUtgmc/icons/obj/items/shards.dmi'

/obj/item/shard/shrapnel/bone_chips
	name = "bone shrapnel chips"
	desc = "It looks like it came from a prehistoric animal."
	icon_state = "bonechips"
	gender = PLURAL
	damage_on_move = 0.6
	shardsize = FALSE

/obj/item/shard/shrapnel/bone_chips/human
	name = "human bone fragments"
	desc = "Oh god, their bits are everywhere!"
	icon_state = "humanbonechips"
	shardsize = FALSE

/obj/item/shard/shrapnel/bone_chips/xeno
	name = "alien bone fragments"
	desc = "Sharp, jagged fragments of alien bone. Looks like the previous owner exploded violently..."
	icon_state = "alienbonechips"
	shardsize = FALSE
