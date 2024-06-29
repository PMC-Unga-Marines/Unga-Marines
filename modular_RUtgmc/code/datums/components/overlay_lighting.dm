#define LIGHTING_ON (1<<0) // ума не приложу почему он не видит такой же дефайн от файла который оверрайдят

/datum/component/overlay_lighting

	var/static/list/light_overlays = list(
		"32" = 'icons/effects/light_overlays/light_32.dmi',
		"64" = 'icons/effects/light_overlays/light_64.dmi',
		"96" = 'icons/effects/light_overlays/light_96.dmi',
		"128" = 'icons/effects/light_overlays/light_128.dmi',
		"160" = 'icons/effects/light_overlays/light_160.dmi',
		"192" = 'icons/effects/light_overlays/light_192.dmi',
		"224" = 'icons/effects/light_overlays/light_224.dmi',
		"256" = 'icons/effects/light_overlays/light_256.dmi',
		"288" = 'icons/effects/light_overlays/light_288.dmi',
		"320" = 'icons/effects/light_overlays/light_320.dmi',
		"352" = 'icons/effects/light_overlays/light_352.dmi',
		"384" = 'icons/effects/light_overlays/light_384.dmi',
		"416" = 'icons/effects/light_overlays/light_416.dmi',
		"448" = 'icons/effects/light_overlays/light_448.dmi',
		"480" = 'icons/effects/light_overlays/light_480.dmi',
		"512" = 'icons/effects/light_overlays/light_512.dmi',
		"544" = 'icons/effects/light_overlays/light_544.dmi',
		"576" = 'icons/effects/light_overlays/light_576.dmi',
		"608" = 'icons/effects/light_overlays/light_608.dmi',
		"640" = 'icons/effects/light_overlays/light_640.dmi',
		"672" = 'icons/effects/light_overlays/light_672.dmi',
		"704" = 'icons/effects/light_overlays/light_704.dmi',
		"736" = 'icons/effects/light_overlays/light_736.dmi',
		"768" = 'icons/effects/light_overlays/light_768.dmi',
		"800" = 'icons/effects/light_overlays/light_800.dmi',
		"832" = 'icons/effects/light_overlays/light_832.dmi',
		"864" = 'icons/effects/light_overlays/light_864.dmi',
		"896" = 'icons/effects/light_overlays/light_896.dmi',
		"928" = 'icons/effects/light_overlays/light_928.dmi',
		)

/datum/component/overlay_lighting/proc/set_range(atom/source, new_range)
	SIGNAL_HANDLER
	if(range == new_range)
		return
	if(range == 0)
		turn_off()
	range = clamp(CEILING(new_range, 0.5), 1, 15)
	var/pixel_bounds = ((range - 1) * 64) + 32
	lumcount_range = CEILING(range, 1)
	if(current_holder && overlay_lighting_flags & LIGHTING_ON)
		current_holder.underlays -= visible_mask
	visible_mask.icon = light_overlays["[pixel_bounds]"]
	if(pixel_bounds == 32)
		visible_mask.transform = null
		return
	var/offset = (pixel_bounds - 32) * 0.5
	var/matrix/transform = new
	transform.Translate(-offset, -offset)
	visible_mask.transform = transform
	if(current_holder && overlay_lighting_flags & LIGHTING_ON)
		current_holder.underlays += visible_mask
	if(overlay_lighting_flags & LIGHTING_ON)
		make_luminosity_update()

#undef LIGHTING_ON
