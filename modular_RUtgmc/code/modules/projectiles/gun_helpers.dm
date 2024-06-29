/obj/item/weapon/gun/proc/update_special_overlay(new_icon_state)
	overlays -= attachment_overlays["special"]
	attachment_overlays["special"] = null
	var/image/gun_image = image(icon, src, new_icon_state)
	attachment_overlays["special"] = gun_image
	overlays += gun_image
