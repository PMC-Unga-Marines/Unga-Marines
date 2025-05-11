/*
*	Everything derived from the common cardboard box.
*	Basically everything except the original is a kit (starts full).
*
*	Contains:
*		Empty box, starter boxes (survival/engineer),
*		Latex glove and sterile mask boxes,
*		Syringe, beaker, dna injector boxes,
*		Blanks, flashbangs, and EMP grenade boxes,
*		Tracking and chemical implant boxes,
*		Prescription glasses and drinking glass boxes,
*		Condiment bottle and silly cup boxes,
*		Donkpocket and monkeycube boxes,
*		ID and security PDA cart boxes,
*		Handcuff, mousetrap, and pillbottle boxes,
*		Snap-pops and matchboxes,
*		Replacement light boxes.
*/

/obj/item/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon = 'icons/obj/items/storage/box.dmi'
	icon_state = "box"
	worn_icon_state = "syringe_kit"
	storage_type = /datum/storage/box
	w_class = WEIGHT_CLASS_BULKY //Changed becuase of in-game abuse
	var/obj/item/spawn_type
	var/spawn_number

/obj/item/storage/box/Initialize(mapload, ...)
	. = ..()
	if(!spawn_type)
		return
	if(!(spawn_type in storage_datum.can_hold))
		// must be set before parent init for typecacheof
		var/list/new_hold_list = storage_datum.can_hold + spawn_type
		storage_datum.set_holdable(can_hold_list = list(new_hold_list))
	for(var/i in 1 to spawn_number)
		new spawn_type(src)

/obj/item/storage/box/survival
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/survival/PopulateContents()
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/tank/emergency_oxygen( src )

/obj/item/storage/box/engineer/PopulateContents()
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/tank/emergency_oxygen/engi( src )

/obj/item/storage/box/gloves
	name = "box of latex gloves"
	desc = "Contains white gloves."
	icon_state = "latex"
	spawn_type = /obj/item/clothing/gloves/latex
	spawn_number = 7
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/masks
	name = "box of sterile masks"
	desc = "This box contains masks of sterility."
	icon_state = "sterile"
	spawn_type = /obj/item/clothing/mask/surgical
	spawn_number = 7
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/syringes
	name = "box of syringes"
	desc = "A box full of syringes."
	desc = "A biohazard alert warning is printed on the box"
	spawn_type = /obj/item/reagent_containers/syringe
	spawn_number = 7
	icon_state = "syringe"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/beakers
	name = "box of beakers"
	icon_state = "beaker"
	spawn_type = /obj/item/reagent_containers/glass/beaker
	spawn_number = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/flashbangs
	name = "box of flashbangs (WARNING)"
	desc = "<B>WARNING: These devices are extremely dangerous and can cause blindness or deafness in repeated use.</B>"
	icon_state = "flashbang"
	spawn_type = /obj/item/explosive/grenade/flashbang
	spawn_number = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/emps
	name = "box of emp grenades"
	desc = "A box with 5 emp grenades."
	icon_state = "flashbang"
	spawn_type = /obj/item/explosive/grenade/emp
	spawn_number = 5

/obj/item/storage/box/rxglasses
	name = "box of prescription glasses"
	desc = "This box contains nerd glasses."
	icon_state = "glasses"
	spawn_type = /obj/item/clothing/glasses/regular
	spawn_number = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/drinkingglasses
	name = "box of drinking glasses"
	desc = "It has a picture of drinking glasses on it."
	spawn_type = /obj/item/reagent_containers/cup/glass/drinking_glass
	spawn_number = 6

/obj/item/storage/box/condimentbottles
	name = "box of condiment bottles"
	desc = "It has a large ketchup smear on it."
	spawn_type = /obj/item/reagent_containers/food/condiment
	spawn_number = 6

/obj/item/storage/box/cups
	name = "box of paper cups"
	desc = "It has pictures of paper cups on the front."
	spawn_type = /obj/item/reagent_containers/food/drinks/sillycup
	spawn_number = 7

/obj/item/storage/box/donkpockets
	name = "box of donk-pockets"
	desc = "<B>Instructions:</B> <I>Heat in microwave. Product will cool if not eaten within seven minutes.</I>"
	icon_state = "donk_kit"
	spawn_type = /obj/item/reagent_containers/food/snacks/donkpocket
	spawn_number = 6
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/monkeycubes
	name = "monkey cube box"
	desc = "Drymate brand monkey cubes. Just add water!"
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "monkeycubebox"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped
	spawn_number = 5

/obj/item/storage/box/monkeycubes/farwacubes
	name = "farwa cube box"
	desc = "Drymate brand farwa cubes, shipped from Ahdomai. Just add water!"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped/farwacube

/obj/item/storage/box/monkeycubes/stokcubes
	name = "stok cube box"
	desc = "Drymate brand stok cubes, shipped from Moghes. Just add water!"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped/stokcube

/obj/item/storage/box/monkeycubes/neaeracubes
	name = "neaera cube box"
	desc = "Drymate brand neaera cubes, shipped from Jargon 4. Just add water!"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube

/obj/item/storage/box/ids
	name = "box of spare IDs"
	desc = "Has so many empty IDs."
	icon_state = "id"
	spawn_type = /obj/item/card/id
	spawn_number = 7

/obj/item/storage/box/ids/dogtag
	name = "box of spare Dogtags"
	desc = "Has so many empty Dogtags."
	icon_state = "id"
	spawn_type = /obj/item/card/id/dogtag
	spawn_number = 7

/obj/item/storage/box/handcuffs
	name = "box of handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "handcuff"
	spawn_type = /obj/item/restraints/handcuffs
	spawn_number = 7

/obj/item/storage/box/zipcuffs
	name = "box of zip cuffs"
	desc = "A box full of zip cuffs."
	icon_state = "handcuff"
	spawn_type = /obj/item/restraints/handcuffs/zip
	spawn_number = 14

/obj/item/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = "<B><FONT color='red'>WARNING:</FONT></B> <I>Keep out of reach of children</I>."
	icon_state = "mousetraps"
	spawn_type = /obj/item/assembly/mousetrap
	spawn_number = 6

/obj/item/storage/box/pillbottles
	name = "box of pill bottles"
	desc = "It has pictures of pill bottles on its front."
	spawn_type = /obj/item/storage/pill_bottle
	spawn_number = 7

/obj/item/storage/box/snappops
	name = "snap pop box"
	desc = "Eight wrappers of fun! Ages 8 and up. Not suitable for children."
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "spbox"
	spawn_type = /obj/item/toy/snappop
	spawn_number = 8

/obj/item/storage/box/snappops/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 8

/obj/item/storage/box/matches
	name = "matchbox"
	desc = "A small box of 'Space-Proof' premium matches."
	icon = 'icons/obj/items/cigarettes.dmi'
	icon_state = "matchbox"
	worn_icon_state = "zippo"
	w_class = WEIGHT_CLASS_TINY
	equip_slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/tool/match
	spawn_number = 14

/obj/item/storage/box/matches/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/tool/match))
		var/obj/item/tool/match/M = I

		if(M.heat || M.burnt)
			return ..()

		if(prob(50))
			playsound(loc, 'sound/items/matchstick_lit.ogg', 15, 1)
			M.light_match()
		else
			playsound(loc, 'sound/items/matchstick_hit.ogg', 15, 1)
		return TRUE
	return ..()

/obj/item/storage/box/autoinjectors
	name = "box of injectors"
	desc = "Contains autoinjectors."
	icon_state = "syringe"
	spawn_type = /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine
	spawn_number = 7

/obj/item/storage/box/quickclot
	name = "box of quick-clot injectors"
	desc = "Contains quick-clot autoinjectors."
	icon_state = "syringe"
	spawn_type = /obj/item/reagent_containers/hypospray/autoinjector/quickclot
	spawn_number = 7

/obj/item/storage/box/lights
	name = "box of replacement bulbs"
	icon_state = "light"
	desc = "This box is shaped on the inside so that only light tubes and bulbs fit."
	worn_icon_state = "syringe_kit"
	storage_type = /datum/storage/box/lights
	spawn_type = /obj/item/light_bulb/bulb
	spawn_number = 21

/obj/item/storage/box/lights/bulbs // mapping placeholder

/obj/item/storage/box/lights/tubes
	name = "box of replacement tubes"
	icon_state = "lighttube"
	w_class = WEIGHT_CLASS_NORMAL
	spawn_type = /obj/item/light_bulb/tube/large
	spawn_number = 21

/obj/item/storage/box/lights/mixed
	name = "box of replacement lights"
	icon_state = "lightmixed"

/obj/item/storage/box/lights/mixed/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/light_bulb/tube/large,
		/obj/item/light_bulb/bulb,
	))
	for(var/i in 1 to 14)
		new /obj/item/light_bulb/tube/large(src)
	for(var/i in 1 to 7)
		new /obj/item/light_bulb/bulb(src)

/obj/item/storage/box/trampop
	name = "box of Tram-pops"
	desc = "Maybe if you behave the doctor will reward you with one."
	icon_state = "trampop"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/tramadol
	spawn_number = 14
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/combat_lolipop
	name = "box of Commed-pops"
	desc = "A small box of lolipops, has a reagent mix made to heal you up slowly. Recommended to be sucked on, rather than eaten."
	icon_state = "lolipop_box_generic"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/combat
	spawn_number = 10
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/combat_lolipop/Initialize(mapload, ...)
	. = ..()
	storage_datum.draw_mode = TRUE

/obj/item/storage/box/combat_lolipop/tricord
	name = "box of Tricord-pops"
	desc = "A small box of lolipops, they have tricord laced in for you up slowly. Recommended to be sucked on, rather than eaten."
	icon_state = "lolipop_box_tricord"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/tricord

/obj/item/storage/box/combat_lolipop/tramadol
	name = "box of Tram-pops"
	desc = "A small box of lolipops, they have tramadol laced in to help kill the pain, Recommended to be sucked on, rather than eaten."
	icon_state = "lolipop_box_tramadol"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/tramadol/combat

////////// MARINES BOXES //////////////////////////

/obj/item/storage/box/explosive_mines
	name = "\improper M20 mine box"
	desc = "A secure box holding anti-personel proximity mines."
	icon_state = "minebox"
	w_class = WEIGHT_CLASS_NORMAL
	spawn_type = /obj/item/explosive/mine
	spawn_number = 5

/obj/item/storage/box/explosive_mines/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 10

/obj/item/storage/box/explosive_mines/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(!length(contents))
		icon_state += "_e"

/obj/item/storage/box/explosive_mines/large
	name = "\improper M20 mine box"
	desc = "A large secure box holding anti-personel proximity mines."
	icon_state = "minebox"
	spawn_type = /obj/item/explosive/mine
	spawn_number = 10

/obj/item/storage/box/explosive_mines/large/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 20

/obj/item/storage/box/explosive_mines/pmc
	name = "\improper M20P mine box"
	spawn_type = /obj/item/explosive/mine/pmc

/obj/item/storage/box/explosive_mines/antitank
	name = "\improper M92 mine box"
	desc = "A secure box holding anti-tank proximity mines."
	icon_state = "atminebox"
	spawn_type = /obj/item/explosive/mine/anti_tank
	spawn_number = 5

/obj/item/storage/box/m94
	name = "\improper M40 FLDP flare pack"
	desc = "A packet of seven M40 FLDP Flares. Carried by TGMC marines to light dark areas that cannot be reached with the usual TNR Shoulder Lamp. Can be launched from an underslung grenade launcher."
	icon_state = "m40"
	w_class = WEIGHT_CLASS_SMALL
	spawn_type = /obj/item/explosive/grenade/flare
	spawn_number = 14

/obj/item/storage/box/m94/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(!length(contents))
		icon_state += "_e"

/obj/item/storage/box/m94/cas
	name = "\improper M50 CFDP signal pack"
	desc = "A packet of seven M40 CFPD signal Flares. Used to mark locations for fire support. Can be launched from an underslung grenade launcher."
	icon_state = "m50"
	spawn_type = /obj/item/explosive/grenade/flare/cas

//ITEMS-----------------------------------//
/obj/item/storage/box/lightstick
	name = "box of lightsticks"
	desc = "Contains blue lightsticks."
	icon_state = "lightstick"
	spawn_type = /obj/item/lightstick
	spawn_number = 7

/obj/item/storage/box/lightstick/red
	desc = "Contains red lightsticks."
	icon_state = "lightstick2"
	spawn_type = /obj/item/lightstick/red
	spawn_number = 7

/obj/item/storage/box/mre
	name = "\improper TGMC MRE"
	desc = "Meal Ready-to-Eat, meant to be consumed in the field, and has an expiration that is two decades past a marine's average combat life expectancy."
	icon_state = "mealpack"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/box/mre
	///If our MRE is opened, it gets a new icon
	var/isopened = 0

/obj/item/storage/box/mre/PopulateContents()
	var/entree = pick("boneless pork ribs", "grilled chicken", "pizza square", "spaghetti", "chicken tenders")
	var/side = pick("meatballs", "cheese spread", "beef turnover", "mashed potatoes")
	var/snack = pick("biscuit", "pretzels", "peanuts", "cracker")
	var/desert = pick("spiced apples", "chocolate brownie", "sugar cookie", "choco bar", "crayon")
	name = "[initial(name)] ([entree])"
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, entree)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, side)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, snack)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, desert)

/obj/item/storage/box/mre/update_icon_state()
	. = ..()
	if(!isopened)
		isopened = 1
		icon_state += "opened"

/obj/item/storage/box/mre/som
	name = "\improper SOM MFR"
	desc = "A Martian Field Ration, guaranteed to have a taste of Mars in every bite."
	icon_state = "som_mealpack"
	storage_type = /datum/storage/box/mre/som

/obj/item/storage/box/holobadge
	name = "holobadge box"
	desc = "A box claiming to contain holobadges."

/obj/item/storage/box/holobadge/PopulateContents()
	. = ..()
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge/cord(src)
	new /obj/item/clothing/tie/holobadge/cord(src)
