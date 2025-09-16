/datum/supply_packs/personal/medic
	var/job_type = /datum/job/terragov/squad/corpsman
	///UI icon for this item
	var/ui_icon = "b18" //placeholder

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
	cost = 300
