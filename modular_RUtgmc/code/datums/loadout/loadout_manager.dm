/datum/loadout_manager/proc/update_attachments(list/datum/item_representation/armor_module/attachments, version)
	for(var/datum/item_representation/armor_module/module AS in attachments)
		if(version < 13)
			if(ispath(module.item_type, /obj/item/armor_module/greyscale))
				module.item_type = text2path(splicetext("[module.item_type]", 24, 33, "armor"))
			module.colors = initial(module.item_type.greyscale_colors)
			if(!istype(module, /datum/item_representation/armor_module/armor) && !istype(module, /datum/item_representation/armor_module/colored))
				continue
			var/datum/item_representation/armor_module/new_module = new
			new_module.attachments = module.attachments
			new_module.item_type = module.item_type
			new_module.colors = module.colors
			attachments.Remove(module)
			attachments.Add(new_module)
		if(version < 14)
			if(ispath(module.item_type, /obj/item/armor_module/armor/cape))
				module.variant = CAPE_LONG
				if(module.item_type == /obj/item/armor_module/armor/cape/kama)
					module.variant = CAPE_KAMA
				else if(module.item_type != /obj/item/armor_module/armor/cape)
					var/datum/item_representation/armor_module/new_cape = new
					new_cape.item_type = /obj/item/armor_module/armor/cape
					new_cape.attachments = module.attachments
					new_cape.colors = module.colors
					attachments.Remove(module)
					attachments.Add(new_cape)
			if(ispath(module.item_type, /obj/item/armor_module/armor/cape_highlight))
				module.variant = CAPE_HIGHLIGHT_NONE
				if(module.item_type == /obj/item/armor_module/armor/cape_highlight/kama)
					module.variant = CAPE_KAMA
				else if(module.item_type != /obj/item/armor_module/armor/cape_highlight)
					var/datum/item_representation/armor_module/armor/new_highlight = new
					new_highlight.item_type = /obj/item/armor_module/armor/cape_highlight
					new_highlight.attachments = module.attachments
					new_highlight.colors = module.colors
					new_highlight.variant = CAPE_HIGHLIGHT_NONE
					attachments.Remove(module)
					attachments.Add(new_highlight)
			if(ispath(module.item_type, /obj/item/armor_module/armor/visor/marine/eva/skull))
				var/datum/item_representation/armor_module/armor/new_glyph = new
				new_glyph.item_type = /obj/item/armor_module/armor/visor_glyph
				module.attachments.Add(new_glyph)
			if(ispath(module.item_type, /obj/item/armor_module/armor/visor/marine/old/eva/skull))
				var/datum/item_representation/armor_module/armor/new_glyph = new
				new_glyph.item_type = /obj/item/armor_module/armor/visor_glyph/old
				module.attachments.Add(new_glyph)
		update_attachments(module.attachments, version)
