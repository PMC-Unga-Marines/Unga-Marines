//HAIR OVERLAY
/mob/living/carbon/human/species/yautja/update_hair()
	//Reset our hair
	remove_overlay(HAIR_LAYER)

	if(species.species_flags & HAS_NO_HAIR)
		return

	var/datum/limb/head/head_organ = get_limb("head")
	if(!head_organ || (head_organ.limb_status & LIMB_DESTROYED) )
		return

	//masks and helmets can obscure our hair.
	if((head?.flags_inv_hide & HIDEALLHAIR) || (wear_mask?.flags_inv_hide & HIDEALLHAIR))
		return

	//base icons
	var/icon/face_standing = new /icon('icons/mob/human_face.dmi',"bald_s")

	if(h_style && !(head?.flags_inv_hide & HIDETOPHAIR))
		var/datum/sprite_accessory/hair_style = GLOB.yautja_hair_styles_list[h_style]
		if(hair_style && (species.name in hair_style.species_allowed))
			var/icon/hair_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")

			face_standing.Blend(hair_s, ICON_OVERLAY)

	var/mutable_appearance/hair_final = mutable_appearance(face_standing, layer =-HAIR_LAYER)

	if(head?.flags_inv_hide & HIDE_EXCESS_HAIR)
		var/image/mask = image('icons/mob/human_face.dmi', null, "Jeager_Mask")
		mask.render_target = "*[REF(src)]"
		hair_final.overlays += mask
		hair_final.filters += filter(arglist(alpha_mask_filter(0, 0, null, "*[REF(src)]")))

	overlays_standing[HAIR_LAYER] = hair_final
	apply_overlay(HAIR_LAYER)

/mob/living/carbon/human/proc/add_flay_overlay(stage = 1)
	remove_overlay(FLAY_LAYER)
	var/image/flay_icon = new /image('modular_RUtgmc/icons/mob/hunter/dam_human.dmi', "human_[stage]")
	flay_icon.layer = -FLAY_LAYER
	flay_icon.blend_mode = BLEND_INSET_OVERLAY
	overlays_standing[FLAY_LAYER] = flay_icon
	apply_overlay(FLAY_LAYER)
