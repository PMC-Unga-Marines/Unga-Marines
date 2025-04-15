/obj/item/storage/wallet
	name = "wallet"
	desc = "It can hold a few small and personal things."
	icon_state = "wallet"
	icon = 'icons/obj/items/storage/wallet.dmi'
	w_class = WEIGHT_CLASS_TINY
	equip_slot_flags = ITEM_SLOT_ID
	storage_type = /datum/storage/wallet
	var/obj/item/card/id/front_id = null

/obj/item/storage/wallet/update_icon_state()
	. = ..()
	if(front_id)
		switch(front_id.icon_state)
			if("id")
				icon_state = "walletid"
				return
			if("silver")
				icon_state = "walletid_silver"
				return
			if("gold")
				icon_state = "walletid_gold"
				return
			if("centcom")
				icon_state = "walletid_centcom"
				return
	icon_state = "wallet"

/obj/item/storage/wallet/random/PopulateContents()
	var/item1_type = pick(
		/obj/item/spacecash/bundle/c10,
		/obj/item/spacecash/bundle/c100,
		/obj/item/spacecash/bundle/c200,
		/obj/item/spacecash/bundle/c50,
		/obj/item/spacecash/bundle/c500,
	)
	var/item2_type
	if(prob(50))
		item2_type = pick(
			/obj/item/spacecash/bundle/c10,
			/obj/item/spacecash/bundle/c100,
			/obj/item/spacecash/bundle/c200,
			/obj/item/spacecash/bundle/c50,
			/obj/item/spacecash/bundle/c500,
		)
	var/item3_type = pickweight(
		/obj/item/coin/gold = 1,
		/obj/item/coin/silver = 2,
		/obj/item/coin/iron = 3,
	)
	if(item1_type)
		new item1_type(src)
	if(item2_type)
		new item2_type(src)
	if(item3_type)
		new item3_type(src)
