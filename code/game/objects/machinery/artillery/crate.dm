/obj/structure/closet/crate/mortar_ammo
	name = "\improper T-50S mortar ammo crate"
	desc = "A crate containing live mortar shells with various payloads. DO NOT DROP. KEEP AWAY FROM FIRE SOURCES."
	icon_state = "closed_mortar_crate"
	icon_opened = "open_mortar_crate"
	icon_closed = "closed_mortar_crate"

/obj/structure/closet/crate/mortar_ammo/full/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/he(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/incendiary(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/flare(src)

	new /obj/item/mortal_shell/smoke(src)
	new /obj/item/mortal_shell/smoke(src)
	new /obj/item/mortal_shell/plasmaloss(src)
	new /obj/item/mortal_shell/plasmaloss(src)

/obj/structure/closet/crate/mortar_ammo/mortar_kit
	name = "\improper TA-50S mortar kit"
	desc = "A crate containing a basic set of a mortar and some shells, to get an engineer started."

/obj/structure/closet/crate/mortar_ammo/mortar_kit/PopulateContents()
	new /obj/item/storage/holster/backholster/mortar/full(src)
	for(var/i in 1 to 8)
		new /obj/item/mortal_shell/he(src)
	for(var/i in 1 to 8)
		new /obj/item/mortal_shell/incendiary(src)
	new /obj/item/mortal_shell/plasmaloss(src)
	new /obj/item/mortal_shell/plasmaloss(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/smoke(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/flare(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/binoculars/tactical/range(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/hud_tablet/artillery(src)

/obj/structure/closet/crate/mortar_ammo/mlrs_kit
	name = "\improper TA-40L MLRS kit"
	desc = "A crate containing a basic, somehow compressed kit consisting of an entire multiple launch rocket system and some rockets, to get a artilleryman started."

/obj/structure/closet/crate/mortar_ammo/mlrs_kit/PopulateContents()
	new /obj/item/mortar_kit/mlrs(src)
	new /obj/item/storage/box/mlrs_rockets(src)
	new /obj/item/storage/box/mlrs_rockets_gas(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/binoculars/tactical/range(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/hud_tablet/artillery(src)

/obj/item/storage/box/mlrs_rockets
	name = "\improper TA-40L rocket crate"
	desc = "A large case containing rockets in a compressed setting for the TA-40L MLRS. Drag this sprite into you to open it up!\nNOTE: You cannot put items back inside this case."

/obj/item/storage/box/mlrs_rockets/Initialize(mapload)
	. = ..()
	storage_datum.storage_slots = 16

/obj/item/storage/box/mlrs_rockets/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs(src)

/obj/item/storage/box/mlrs_rockets_gas
	name = "\improper TA-40L X-50 rocket crate"
	desc = "A large case containing rockets in a compressed setting for the TA-40L MLRS. Drag this sprite into you to open it up!\nNOTE: You cannot put items back inside this case."

/obj/item/storage/box/mlrs_rockets_gas/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs/gas(src)

/obj/item/storage/box/mlrs_rockets_tangle
	name = "\improper TA-40L T-33 rocket crate"
	desc = "A large case containing rockets in a compressed setting for the TA-40L MLRS. Drag this sprite into you to open it up!\nNOTE: You cannot put items back inside this case."

/obj/item/storage/box/mlrs_rockets_tangle/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs/tangle(src)

/obj/structure/closet/crate/mortar_ammo/howitzer_kit
	name = "\improper TA-100Y howitzer kit"
	desc = "A crate containing a basic, somehow compressed kit consisting of an entire howitzer and some shells, to get a artilleryman started."

/obj/structure/closet/crate/mortar_ammo/howitzer_kit/PopulateContents()
	new /obj/item/mortar_kit/howitzer(src)
	for(var/i in 1 to 8)
		new /obj/item/mortal_shell/howitzer/incendiary(src)
	for(var/i in 1 to 10)
		new /obj/item/mortal_shell/howitzer/he(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/howitzer/white_phos(src)
	for(var/i in 1 to 4)
		new	/obj/item/mortal_shell/howitzer/plasmaloss(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/flare(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/binoculars/tactical/range(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/hud_tablet/artillery(src)
