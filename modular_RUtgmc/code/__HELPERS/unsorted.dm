/proc/get_true_location(atom/loc)
	var/atom/subLoc = loc
	while(subLoc.z == 0)
		if (istype(subLoc.loc, /atom))
			subLoc = subLoc.loc
		else
			return subLoc
	return subLoc

#define get_true_turf(loc) get_turf(get_true_location(loc))

GLOBAL_LIST_EMPTY(loose_yautja_gear)
GLOBAL_LIST_EMPTY(tracked_yautja_gear) // list of pred gear with a tracking element attached

GLOBAL_LIST_EMPTY(mainship_yautja_teleports)
GLOBAL_LIST_EMPTY(mainship_yautja_desc)
GLOBAL_LIST_EMPTY(yautja_teleports)
GLOBAL_LIST_EMPTY(yautja_teleport_descs)

GLOBAL_LIST_INIT_TYPED(all_yautja_capes, /obj/item/clothing/yautja_cape, setup_yautja_capes())

/proc/setup_yautja_capes()
	var/list/cape_list = list()
	for(var/obj/item/clothing/yautja_cape/cape_type as anything in typesof(/obj/item/clothing/yautja_cape))
		cape_list[initial(cape_type.name)] = cape_type
	return cape_list

GLOBAL_VAR_INIT(roles_whitelist, load_role_whitelist())

/proc/load_role_whitelist(filename = "config/role_whitelist.txt")
	var/L[] = file2list(filename)
	var/P[]
	var/W[] = new //We want a temporary whitelist list, in case we need to reload.

	var/i
	var/r
	var/ckey
	var/role
	for(i in L)
		if(!i)
			continue
			i = trim(i)

		if(!length(i))
			continue

		else if(copytext(i, 1, 2) == "#")
			continue

		P = splittext(i, "+")

		if(!P.len)
			continue

		ckey = ckey(P[1]) //Converting their key to canonical form. ckey() does this by stripping all spaces, underscores and converting to lower case.

		role = NONE
		r = 1
		while(++r <= P.len)
			switch(ckey(P[r]))
				if("yautja")
					role |= WHITELIST_YAUTJA
				if("yautjalegacy")
					role |= WHITELIST_YAUTJA_LEGACY
				if("yautjacouncil")
					role |= WHITELIST_YAUTJA_COUNCIL
				if("yautjacouncillegacy")
					role |= WHITELIST_YAUTJA_COUNCIL_LEGACY
				if("yautjaleader")
					role |= WHITELIST_YAUTJA_LEADER

		W[ckey] = role

	return W

//yautja ship AI announcement
/proc/yautja_announcement(message, title = "You receive a message from your ship AI...", sound_to_play = sound('sound/misc/notice1.ogg'))
	var/list/targets = GLOB.human_mob_list + GLOB.dead_mob_list
	for(var/mob/M in targets)
		if(!isobserver(M)) //observers see everything
			var/mob/living/carbon/human/H = M
			if(!isyautja(H) || H.stat != CONSCIOUS)
				continue

		to_chat(M, html = "<span class='big bold'>[title]</span><BR><BR>[span_alert(message)]")
		SEND_SOUND(M, sound_to_play)

/// Will attempt to find what's holding this item if it's being contained by something, ie if it's in a satchel held by a human, this'll return the human
/proc/recursive_holder_check(obj/item/held_item, recursion_limit = 3)
	if(recursion_limit <= 0)
		return held_item
	if(!held_item.loc || isturf(held_item.loc))
		return held_item
	recursion_limit--
	return recursive_holder_check(held_item.loc, recursion_limit)

// returns turf relative to A for a given clockwise angle at set range
// result is bounded to map size
/proc/get_angle_target_turf(atom/A, angle, range)
	if(!istype(A))
		return null
	var/x = A.x
	var/y = A.y

	x += range * sin(angle)
	y += range * cos(angle)

	//Restricts to map boundaries while keeping the final angle the same
	var/dx = A.x - x
	var/dy = A.y - y
	var/ratio

	if(dy == 0) //prevents divide-by-zero errors
		ratio = INFINITY
	else
		ratio = dx / dy

	if(x < 1)
		y += (1 - x) / ratio
		x = 1
	else if (x > world.maxx)
		y += (world.maxx - x) / ratio
		x = world.maxx
	if(y < 1)
		x += (1 - y) * ratio
		y = 1
	else if (y > world.maxy)
		x += (world.maxy - y) * ratio
		y = world.maxy


	x = round(x,1)
	y = round(y,1)

	return locate(x,y,A.z)
