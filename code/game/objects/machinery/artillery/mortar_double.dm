/obj/item/mortar_kit/double
	name = "\improper TA-55DB mortar"
	desc = "A manual, crew-operated mortar system intended to rain down 80mm goodness on anything it's aimed at. Needs to be set down first to fire. This one is a double barreled mortar that can hold 4 rounds usually fitted in TAV's."
	icon_state = "mortar_db"
	icon = 'icons/obj/artillery/mortar_double.dmi'
	max_integrity = 400
	item_flags = IS_DEPLOYABLE|TWOHANDED|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	w_class = WEIGHT_CLASS_HUGE
	deployable_item = /obj/machinery/deployable/mortar/double

/obj/machinery/deployable/mortar/double
	reload_time = 2 SECONDS
	fire_amount = 2
	max_rounds = 2
	fire_delay = 0.5 SECONDS
	cool_off_time = 6 SECONDS
	spread = 2
