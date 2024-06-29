/obj/machinery/iv_drip/proc/update_beam()
	if(current_beam && !attached)
		QDEL_NULL(current_beam)
	else if(!current_beam && attached && !QDELETED(src))
		current_beam = beam(attached, "iv_tube", 'modular_RUtgmc/icons/effects/beam.dmi')

/obj/machinery/iv_drip/Destroy()
	attached = null
	update_beam()
	. = ..()
