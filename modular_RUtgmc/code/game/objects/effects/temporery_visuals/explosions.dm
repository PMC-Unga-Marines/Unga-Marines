/obj/effect/temp_visual/explosion/Initialize(mapload, radius, color, power)
	. = ..()
	set_light(radius, radius, color)
	generate_particles(radius, power)
	if(iswater(get_turf(src)))
		icon_state = null
		return
	var/image/our_image = image(icon, src, icon_state, 10, -32, -32)
	var/matrix/rotate = matrix()
	rotate.Turn(rand(0, 359))
	our_image.transform = rotate
	overlays += our_image //we use an overlay so the explosion and light source are both in the correct location plus so the particles don't rotate with the explosion
	icon_state = null

///Generate the particles
/obj/effect/temp_visual/explosion/proc/generate_particles(radius, power)
	var/turf/turf_type = get_turf(src)
	if(iswater(turf_type))
		smoke_wave = new(src, /particles/wave_water)
		explosion_smoke = new(src, /particles/explosion_water)
		dirt_kickup = new(src, /particles/water_splash)
		falling_debris = new(src, /particles/water_falling)
		sparks = new(src, /particles/water_outwards)
		large_kickup = new(src, /particles/water_splash_large)
	else
		if(power >= EXPLODE_HEAVY)
			smoke_wave = new(src, /particles/smoke_wave)
			explosion_smoke = new(src, /particles/explosion_smoke/deva)
			falling_debris = new(src, /particles/falling_debris)
			large_kickup = new(src, /particles/dirt_kickup_large/deva)
		else if(power >= EXPLODE_MEDIUM)
			smoke_wave = new(src, /particles/smoke_wave)
			explosion_smoke = new(src, /particles/explosion_smoke)
			falling_debris = new(src, /particles/falling_debris)
			large_kickup = new(src, /particles/dirt_kickup_large)
		else
			smoke_wave = new(src, /particles/smoke_wave/small)
			explosion_smoke = new(src, /particles/explosion_smoke/small)
			falling_debris = new(src, /particles/falling_debris/small)
			large_kickup = new(src, /particles/dirt_kickup_large)
		dirt_kickup = new(src, /particles/dirt_kickup)
		sparks = new(src, /particles/sparks_outwards)

	smoke_wave.particles.velocity = generator(GEN_CIRCLE, rand(3, 8) * radius, rand(3, 8) * radius)
	explosion_smoke.layer = layer + 0.1
	sparks.particles.velocity = generator(GEN_CIRCLE, 8 * radius, 8 * radius)
	addtimer(CALLBACK(src, PROC_REF(set_count_short)), 5)
	addtimer(CALLBACK(src, PROC_REF(set_count_long)), 10)
