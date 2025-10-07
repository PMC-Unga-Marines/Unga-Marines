/datum/supply_packs/personal/medic
	job_type = /datum/job/terragov/squad/corpsman
	containertype = /obj/structure/closet/crate/medical

/datum/supply_packs/personal/medic/advanced_medical
	name = "Emergency medical supplies"
	contains = list(
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/stack/nanopaste,
	)
	cost = 12

/datum/supply_packs/personal/medic/medical
	name = "Pills and chemicals"
	contains = list(
		/obj/item/storage/box/autoinjectors,
		/obj/item/storage/box/syringes,
		/obj/item/reagent_containers/glass/bottle/inaprovaline,
		/obj/item/reagent_containers/glass/bottle/dylovene,
		/obj/item/reagent_containers/glass/bottle/bicaridine,
		/obj/item/reagent_containers/glass/bottle/dexalin,
		/obj/item/reagent_containers/glass/bottle/spaceacillin,
		/obj/item/reagent_containers/glass/bottle/kelotane,
		/obj/item/reagent_containers/glass/bottle/tramadol,
		/obj/item/storage/pill_bottle/inaprovaline,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/dexalin,
		/obj/item/storage/pill_bottle/spaceacillin,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/storage/pill_bottle/quickclot,
		/obj/item/storage/box/pillbottles,
	)
	cost = 1

/datum/supply_packs/personal/medic/firstaid
	name = "Advanced first aid kit"
	contains = list(/obj/item/storage/firstaid/adv)
	cost = 2

/datum/supply_packs/personal/medic/cryobag
	name = "Stasis bag"
	contains = list(/obj/item/bodybag/cryobag)
	cost = 2

/datum/supply_packs/personal/medic/advancedKits
	name = "Advanced medical packs"
	notes = "Contains 5 advanced packs of each type and 5 splints."
	contains = list(
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
	)
	cost = 3

/datum/supply_packs/personal/medic/tweezers_advanced
	name = "Advanced Tweezers"
	notes = "contains advanced tweezers."
	contains = list(/obj/item/tweezers_advanced)
	cost = 7

/datum/supply_packs/personal/medic/implanter
	name = "Implanter"
	notes = "contains an implanter for reinsertion of the implant."
	contains = list(/obj/item/implanter/skill/cargo)
	cost = 3

/datum/supply_packs/personal/medic/deployable_optable
	name = "Deployable operating table"
	notes = "Contains an operating table that can be transported and deployed for medical procedures."
	contains = list(/obj/item/deployable_optable)
	cost = 10

/datum/supply_packs/personal/medic/advanced_medical_kits
	name = "Advanced medical kits"
	notes = "contains pair advanced medical kits from medical vendors."
	contains = list(/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack, /obj/item/stack/medical/heal_pack/advanced/burn_combat_pack)
	cost = 3

/datum/supply_packs/personal/medic/combat_medicine
	name = "Battleground medicine"
	notes = "contains 4 hypospray with MD, many injectors peri and quick, neuraline, nanopaste."
	contains = list(
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/stack/nanopaste,
	)
	cost = 12

/datum/supply_packs/personal/medic/combat_robot_medicine
	name = "Combat repairing for robots"
	notes = "contains 5 nanopaste for robots or technic."
	contains = list(
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
	)
	cost = 6

/datum/supply_packs/personal/medic/nanoblood_hypo
	name = "Nanoblood hypospray"
	notes = "contains 2 hypo with nanoblood."
	contains = list(
		/obj/item/reagent_containers/hypospray/advanced/nanoblood,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood,
	)
	cost = 4

/datum/supply_packs/personal/medic/meraderm_pills
	name = "Meraderm pill bottle"
	notes = "contains meralyne and dermaline pill bottle."
	contains = list(
		/obj/item/storage/pill_bottle/dermaline,
		/obj/item/storage/pill_bottle/meralyne,
	)
	cost = 11

/datum/supply_packs/personal/medic/bkkt_dispenser
	name = "BKKT Dispenser"
	notes = "contains one BKKT dispenser."
	contains = list(/obj/item/storage/reagent_tank/bktt)
	cost = 3

/datum/supply_packs/personal/medic/antitox_kit
	name = "Anti-toxin pill bottles kit"
	notes = "contains some things against toxins."
	contains = list(
		/obj/item/storage/pill_bottle/hypervene,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/storage/pill_bottle/tricordrazine,
	)
	cost = 1

/datum/supply_packs/personal/medic/imialky_kit
	name = "ImiAlky pill bottles kit"
	notes = "contains pill bottles imialky."
	contains = list(
		/obj/item/storage/pill_bottle/imialky,
		/obj/item/storage/pill_bottle/imialky,
	)
	cost = 1

/datum/supply_packs/personal/medic/quick_peri_kit
	name = "QuickPeri autoinjector kit"
	notes = "contains quick-clot and peri injectors."
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
	)
	cost = 1

/datum/supply_packs/personal/medic/russian_red_bottle
	name = "Russian Red pill bottle"
	notes = "contains one pill bottle red russian."
	contains = list(/obj/item/storage/pill_bottle/russian_red)
	cost = 21

/datum/supply_packs/personal/medic/neuraline_kit
	name ="Large neuraline autoinjector kit"
	notes = "contains five neuraline injectors"
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
	)
	cost = 21

/datum/supply_packs/personal/medic/neuraline_kit_injector
	name ="Neuraline autoinjector"
	notes = "contains one neuraline injector"
	contains = list(/obj/item/reagent_containers/hypospray/autoinjector/neuraline)
	cost = 5

/datum/supply_packs/personal/medic/bkkt_kit
	name = "BKKT pill bottles kit"
	notes = "contains pill bottles BKKT."
	contains = list(
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tricordrazine,
		/obj/item/storage/pill_bottle/tramadol,
	)
	cost = 1

/datum/supply_packs/personal/medic/t312_adr
	name = "R-312 adrenaline ammo"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/adrenaline, /obj/item/ammo_magazine/revolver/t312/med/adrenaline)
	cost = 2

/datum/supply_packs/personal/medic/t312_rr
	name = "R-312 russian red ammo"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/rr, /obj/item/ammo_magazine/revolver/t312/med/rr)
	cost = 4

/datum/supply_packs/personal/medic/t312_md
	name = "R-312 meraderm ammo"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/md, /obj/item/ammo_magazine/revolver/t312/med/md)
	cost = 3

/datum/supply_packs/personal/medic/t312_neu
	name = "R-312 neuraline ammo"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/neu, /obj/item/ammo_magazine/revolver/t312/med/neu)
	cost = 5

/datum/supply_packs/personal/medic/t312_medkit
	name = "BMSS medkit pouch"
	contains = list(/obj/item/storage/pouch/medkit/t312)
	cost = 1
