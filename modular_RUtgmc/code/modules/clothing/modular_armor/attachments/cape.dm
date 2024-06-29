/obj/item/armor_module/armor/cape
	desc = "A chromatic cape to improve on the design of the 7E badge, this cape is capable of two colors, for all your fashion needs. It also is equipped with thermal insulators so it will double as a blanket."
	current_variant = "long"
	icon_state_variants = list(
		"long" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"long",
				"none",
			),
		),
		"regaly" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"regaly",
				"none",
			),
		),
		"onelong" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"onelong",
				"none",
			),
		),
	)

/obj/item/armor_module/armor/cape/examine(user)
	. = ..()
	. += span_notice("Interact with <b>facepaint</b> to color or change the variant.")
	. += span_notice("Attaches to <b>uniform</b>.")

/obj/item/armor_module/armor/cape_highlight
	greyscale_colors = CAPE_PALETTE_GOLD
	colorable_colors = CAPE_PALETTES_LIST
	icon_state_variants = list(
		"long",
		"none",
	)
