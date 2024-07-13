/obj/effect/vendor_bundle/stretcher
	desc = "A collapsed medevac stretcher that can be carried around, beacon included."

/obj/effect/vendor_bundle/gorka_engineer
	gear_to_spawn = list(
		/obj/item/clothing/under/marine/ru/gorka_eng,
		/obj/item/clothing/shoes/marine/full,
		/obj/item/storage/box/MRE,
	)

/obj/effect/vendor_bundle/gorka_medic
	gear_to_spawn = list(
		/obj/item/clothing/under/marine/ru/gorka_med,
		/obj/item/clothing/shoes/marine/full,
		/obj/item/storage/box/MRE,
	)
/* RU TGMC EDIT
/obj/effect/vendor_bundle/mimir/two
	desc = "A set of advanced anti-gas gear setup to protect one from gas threats."
	gear_to_spawn = list(
		/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet,
		/obj/item/clothing/mask/gas/tactical,
	)
RU TGMC EDIT */
/obj/effect/vendor_bundle/tyr/two
	desc = "A set of advanced gear for improved close-quarters combat longevitiy."
	gear_to_spawn = list(
		/obj/item/armor_module/module/tyr_head,
		/obj/item/armor_module/module/tyr_extra_armor,
	)

/obj/effect/vendor_bundle/veteran_uniform
	name = "Full set of TGMC veteran uniform"
	desc = "TerraGov Marine Corps Veteran Uniform Set. Modified mostly by hand, but still quite stylish."
	gear_to_spawn = list(
		/obj/item/clothing/mask/gas/ru/veteran,
		/obj/item/clothing/under/marine/ru/veteran,
		/obj/item/clothing/gloves/marine/veteran/marine,
		/obj/item/clothing/shoes/marine/ru/headskin,
	)

/obj/effect/vendor_bundle/separatist_uniform
	name = "Full set of civilian militia uniform"
	desc = "A set of civilian militia uniforms. Old, but still fashionable."
	gear_to_spawn = list(
		/obj/item/clothing/mask/gas/ru/separatist,
		/obj/item/clothing/under/marine/ru/separatist,
		/obj/item/clothing/gloves/marine/separatist,
		/obj/item/clothing/shoes/marine/ru/separatist,
	)

/obj/machinery/marine_selector/clothes/commander/Initialize(mapload)
	. = ..()
	listed_products = GLOB.commander_clothes_listed_products
