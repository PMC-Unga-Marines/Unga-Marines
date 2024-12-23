/obj/item/spacecash
	name = "0 rubles"
	desc = "You have no rubles."
	gender = PLURAL
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = ""
	opacity = FALSE
	density = FALSE
	anchored = FALSE
	force = 1
	throwforce = 1
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	var/access = list()
	access = ACCESS_MARINE_CAPTAIN
	var/worth = 0

/obj/item/spacecash/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/spacecash) && !istype(I, /obj/item/spacecash/ewallet))
		var/obj/item/spacecash/bundle/bundle
		if(!istype(I, /obj/item/spacecash/bundle))
			var/obj/item/spacecash/cash = I
			user.temporarilyRemoveItemFromInventory(cash)
			bundle = new(loc)
			bundle.worth += cash.worth
			qdel(cash)
		else
			bundle = I
		bundle.worth += worth
		bundle.update_overlays()
		bundle.update_desc()
		if(ishuman(user))
			var/mob/living/carbon/human/h_user = user
			h_user.temporarilyRemoveItemFromInventory(src)
			h_user.temporarilyRemoveItemFromInventory(bundle)
			h_user.put_in_hands(bundle)
		to_chat(user, span_notice("You add [worth] rubles worth of money to the bundles.<br>It holds [bundle.worth] rubles now."))
		qdel(src)

/obj/item/spacecash/bundle
	name = "stack of rubles"
	desc = "They are worth 0 rubles."
	worth = 0

/obj/item/spacecash/bundle/update_desc(updates)
	. = ..()
	desc = "They are worth [worth] rubles."

/obj/item/spacecash/bundle/update_overlays()
	. = ..()
	cut_overlays()
	var/remaining_worth = worth
	var/iteration = 0
	var/list/banknote_denominations = list(500, 200, 100, 50, 10, 5, 1)
	for(var/i in banknote_denominations)
		while(remaining_worth >= i && iteration < 50)
			remaining_worth -= i
			iteration++
			var/image/banknote = image('icons/obj/stack_objects.dmi', "cash[i]")
			var/matrix/M = matrix()
			M.Translate(rand(-6, 6), rand(-4, 8))
			banknote.transform = M
			overlays += banknote

/obj/item/spacecash/bundle/attack_self(mob/user)
	var/oldloc = loc
	var/amount = tgui_input_number(user, "How many rubles do you want to take? (0 to [worth])", "Take Money", 20, worth)
	if(amount == 0)
		return 0
	if(gc_destroyed || loc != oldloc)
		return

	src.worth -= amount
	src.update_appearance()
	if(!worth)
		usr.temporarilyRemoveItemFromInventory(src)
	var/obj/item/spacecash/bundle/bundle = new (usr.loc)
	bundle.worth = amount
	bundle.update_appearance()
	user.put_in_hands(bundle)
	if(!worth)
		qdel(src)

/obj/item/spacecash/bundle/c1
	icon_state = "cash1"
	worth = 1

/obj/item/spacecash/bundle/c10
	icon_state = "cash10"
	worth = 10

/obj/item/spacecash/bundle/c50
	icon_state = "cash50"
	worth = 50

/obj/item/spacecash/bundle/c100
	icon_state = "cash100"
	worth = 100

/obj/item/spacecash/bundle/c200
	icon_state = "cash200"
	worth = 200

/obj/item/spacecash/bundle/c500
	icon_state = "cash500"
	worth = 500

/proc/spawn_money(sum, spawnloc, mob/living/carbon/human/human_user)
	var/obj/item/spacecash/bundle/bundle = new (spawnloc)
	bundle.worth = sum
	bundle.update_appearance()
	if (ishuman(human_user) && !human_user.get_active_held_item())
		human_user.put_in_hands(bundle)

/obj/item/spacecash/ewallet
	name = "\improper Nanotrasen cash card"
	icon_state = "efundcard"
	desc = "A Nanotrasen backed cash card that holds an amount of money."
	var/owner_name = "" //So the ATM can set it so the EFTPOS can put a valid name on transactions.

/obj/item/spacecash/ewallet/examine(mob/user)
	. = ..()
	if(user == loc)
		. += span_notice("Charge card's owner: [owner_name]. Rubles remaining: [worth].")
