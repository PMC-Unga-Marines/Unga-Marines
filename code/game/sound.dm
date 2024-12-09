
///Default override for echo
/sound
	echo = list(
		0, // Direct
		0, // DirectHF
		-10000, // Room, -10000 means no low frequency sound reverb
		-10000, // RoomHF, -10000 means no high frequency sound reverb
		0, // Obstruction
		0, // ObstructionLFRatio
		0, // Occlusion
		0.25, // OcclusionLFRatio
		1.5, // OcclusionRoomRatio
		1.0, // OcclusionDirectRatio
		0, // Exclusion
		1.0, // ExclusionLFRatio
		0, // OutsideVolumeHF
		0, // DopplerFactor
		0, // RolloffFactor
		0, // RoomRolloffFactor
		1.0, // AirAbsorptionFactor
		0, // Flags (1 = Auto Direct, 2 = Auto Room, 4 = Auto RoomHF)
	)
	// todo pls port tg style enviromental sound
	//environment = SOUND_ENVIRONMENT_NONE //Default to none so sounds without overrides dont get reverb
	environment = list(
		100.0, 0.5, \
		-250, -1000, 0, \
		1.5, 0.75, 1.0, \
		-2000, 0.01, \
		500, 0.015, \
		0.25, 0.1, \
		0.25, 0.1, \
		-10.0, \
		5000.0, 250.0, \
		1.0, 10.0, 10.0, 255, \
	)

/**Proc used to play a sound.
 * Arguments:
 * * source: what played the sound.
 * * soundin: the .ogg to use.
 * * vol: the initial volume of the sound, 0 is no sound at all, 75 is loud queen screech.
 * * vary: to make the frequency var of the sound vary (mostly unused).
 * * sound_range: the maximum theoretical range (in tiles) of the sound, by default is equal to the volume.
 * * falloff: how the sound's volume decreases with distance, low is fast decrease and high is slow decrease. \
A good representation is: 'byond applies a volume reduction to the sound every X tiles', where X is falloff.
 */
/proc/playsound(atom/source, soundin, vol, vary, sound_range, falloff, is_global, frequency, channel = 0, ambient_sound = FALSE)
	var/turf/turf_source = get_turf(source)

	if(!turf_source || !soundin || !vol)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || SSsounds.random_available_channel()

	if(!sound_range)
		sound_range = round(0.5 * vol) //if no specific range, the max range is equal to half the volume.

	if(!frequency)
		frequency = GET_RANDOM_FREQ
	var/sound/S = sound(get_sfx(soundin))

	var/list/listeners = SSmobs.clients_by_zlevel[turf_source.z].Copy()
	for(var/mob/ai_eye AS in GLOB.aiEyes)
		var/turf/eye_turf = get_turf(ai_eye)
		if(!eye_turf || eye_turf.z != turf_source.z)
			continue
		listeners += ai_eye

	for(var/mob/listener AS in listeners|SSmobs.dead_players_by_zlevel[turf_source.z])
		if(get_dist(listener, turf_source) > sound_range)
			continue
		if(ambient_sound && !(listener.client?.prefs?.toggles_sound & SOUND_AMBIENCE))
			continue
		listener.playsound_local(turf_source, soundin, vol, vary, frequency, falloff, is_global, channel, S)


	//We do tanks separately, since they are not actually on the source z, and we need some other stuff to get accurate directional sound
	for(var/obj/vehicle/sealed/armored/armor AS in GLOB.tank_list)
		if(!armor.interior || armor.z != turf_source.z || get_dist(armor.loc, turf_source) > sound_range)
			continue
		if(!length(armor.interior.occupants))
			continue
		var/turf/middle_turf = armor.interior.loaded_turfs[floor(length(armor.interior.loaded_turfs) * 0.5)]
		var/turf/origin_point = locate(clamp(middle_turf.x - armor.x + turf_source.x, 1, world.maxx), clamp(middle_turf.y - armor.y + turf_source.y, 1, world.maxy), middle_turf.z)
		//origin point is regardless of vehicle orientation for player QOL and simple sanity

		for(var/mob/crew AS in armor.interior.occupants)
			if(!crew.client)
				continue
			if(ambient_sound && !(crew.client.prefs.toggles_sound & SOUND_AMBIENCE))
				continue
			crew.playsound_local(origin_point, soundin, vol*0.5, vary, frequency, falloff, is_global, channel, S)

//todo rename S to sound_to_use
/mob/proc/playsound_local(turf/turf_source, soundin, vol, vary, frequency, falloff, is_global, channel = 0, sound/S, distance_multiplier = 1, mob/sound_reciever)
	if(!sound_reciever)
		sound_reciever = src
	if(!sound_reciever.client)
		return FALSE

	if(!S)
		S = sound(get_sfx(soundin))
	S.wait = 0 //No queue
	S.channel = channel || SSsounds.random_available_channel()
	S.volume = vol

	if(vary)
		S.frequency = frequency ? frequency : GET_RANDOM_FREQ

	if(isturf(turf_source))
		// 3D sounds, the technology is here!
		var/turf/T = get_turf(src)

		//sound volume falloff with distance
		var/distance = get_dist(T, turf_source)

		distance *= distance_multiplier

		if(S.volume <= 2*distance)
			return FALSE //no volume or too far away to hear such a volume level.

		var/dx = turf_source.x - T.x // Hearing from the right/left
		S.x = dx * distance_multiplier
		var/dz = turf_source.y - T.y // Hearing from infront/behind
		S.z = dz * distance_multiplier
		//The y value is for above your head, but there is no ceiling in 2d spessmens.
		S.y = 1
		S.falloff = falloff ? falloff : FALLOFF_SOUNDS * max(round(S.volume * 0.05), 1)

	if(!is_global)
		S.environment = SOUND_ENVIRONMENT_ROOM

	SEND_SOUND(sound_reciever, S)


/mob/living/playsound_local(turf/turf_source, soundin, vol, vary, frequency, falloff, is_global, channel = 0, sound/S, distance_multiplier = 1, mob/sound_reciever)
	if(ear_deaf > 0)
		return FALSE
	return ..()

/mob/proc/stop_sound_channel(chan)
	SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = chan))

/mob/proc/set_sound_channel_volume(channel, volume)
	var/sound/S = sound(null, FALSE, FALSE, channel, volume)
	S.status = SOUND_UPDATE
	SEND_SOUND(src, S)

/client/proc/play_title_music(vol = 85)
	if(!SSticker?.login_music)
		return FALSE
	if(prefs && (prefs.toggles_sound & SOUND_LOBBY))
		SEND_SOUND(src, sound(SSticker.login_music, repeat = 0, wait = 0, volume = vol, channel = CHANNEL_LOBBYMUSIC)) // MAD JAMS


///Play sound for all online mobs on a given Z-level. Good for ambient sounds.
/proc/playsound_z(z, soundin, _volume)
	soundin = sound(get_sfx(soundin), channel = SSsounds.random_available_channel(), volume = _volume)
	for(var/mob/M AS in GLOB.player_list)
		if(isnewplayer(M))
			continue
		if (M.z == z)
			SEND_SOUND(M, soundin)

///Play a sound for all cliented humans and ghosts by zlevel
/proc/playsound_z_humans(z, soundin, _volume)
	soundin = sound(get_sfx(soundin), channel = SSsounds.random_available_channel(), volume = _volume)
	for(var/mob/living/carbon/human/H AS in GLOB.humans_by_zlevel["[z]"])
		if(H.client)
			SEND_SOUND(H, soundin)
	for(var/mob/dead/observer/O AS in SSmobs.dead_players_by_zlevel[z])
		if(O.client)
			SEND_SOUND(O, soundin)

///Play a sound for all cliented xenos and ghosts by hive on a zlevel
/proc/playsound_z_xenos(z, soundin, _volume, hive_type = XENO_HIVE_NORMAL)
	soundin = sound(get_sfx(soundin), channel = SSsounds.random_available_channel(), volume = _volume)
	for(var/mob/living/carbon/xenomorph/X AS in GLOB.hive_datums[hive_type].xenos_by_zlevel["[z]"])
		if(X.client)
			SEND_SOUND(X, soundin)
	for(var/mob/dead/observer/O AS in SSmobs.dead_players_by_zlevel[z])
		if(O.client)
			SEND_SOUND(O, soundin)

// The pick() proc has a built-in chance that can be added to any option by adding ,X; to the end of an option, where X is the % chance it will play.
/proc/get_sfx(S)
	if(!istext(S))
		return S
	switch(S)
		// General effects
		if("shatter")
			S = pick('sound/effects/glassbr1.ogg','sound/effects/glassbr2.ogg','sound/effects/glassbr3.ogg')
		if("explosion_large")
			S = pick('sound/effects/explosion/large1.ogg','sound/effects/explosion/large2.ogg','sound/effects/explosion/large3.ogg','sound/effects/explosion/large4.ogg','sound/effects/explosion/large5.ogg','sound/effects/explosion/large6.ogg')
		if("explosion_micro")
			S = pick('sound/effects/explosion/micro1.ogg','sound/effects/explosion/micro2.ogg','sound/effects/explosion/micro3.ogg')
		if("explosion_small")
			S = pick('sound/effects/explosion/small1.ogg','sound/effects/explosion/small2.ogg','sound/effects/explosion/small3.ogg','sound/effects/explosion/small4.ogg')
		if("explosion_med")
			S = pick('sound/effects/explosion/medium1.ogg','sound/effects/explosion/medium2.ogg','sound/effects/explosion/medium3.ogg','sound/effects/explosion/medium4.ogg','sound/effects/explosion/medium5.ogg','sound/effects/explosion/medium6.ogg')
		if("explosion_small_distant")
			S = pick('sound/effects/explosion/small_far1.ogg','sound/effects/explosion/small_far2.ogg','sound/effects/explosion/small_far3.ogg','sound/effects/explosion/small_far4.ogg')
		if("explosion_large_distant")
			S = pick('sound/effects/explosion/far1.ogg','sound/effects/explosion/far2.ogg','sound/effects/explosion/far3.ogg','sound/effects/explosion/far4.ogg','sound/effects/explosion/far5.ogg')
		if("explosion_creak")
			S = pick('sound/effects/creak1.ogg','sound/effects/creak2.ogg')
		if("sparks")
			S = pick('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg')
		if("rustle")
			S = pick('sound/effects/rustle1.ogg','sound/effects/rustle2.ogg','sound/effects/rustle3.ogg','sound/effects/rustle4.ogg','sound/effects/rustle5.ogg')
		if("punch")
			S = pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg')
		if("bone_break")
			S = pick('sound/effects/bone_break1.ogg','sound/effects/bone_break2.ogg','sound/effects/bone_break3.ogg','sound/effects/bone_break4.ogg','sound/effects/bone_break5.ogg','sound/effects/bone_break6.ogg','sound/effects/bone_break7.ogg')
		if("clownstep")
			S = pick('sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg')
		if("swing_hit")
			S = pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg')
		if("pageturn")
			S = pick('sound/effects/pageturn1.ogg', 'sound/effects/pageturn2.ogg','sound/effects/pageturn3.ogg')
		if("gasbreath")
			S = pick('sound/effects/gasmaskbreath.ogg', 'sound/effects/gasmaskbreath2.ogg')
		if("terminal_type")
			S = pick('sound/machines/terminal_button01.ogg', 'sound/machines/terminal_button02.ogg', 'sound/machines/terminal_button03.ogg', \
				'sound/machines/terminal_button04.ogg', 'sound/machines/terminal_button05.ogg', 'sound/machines/terminal_button06.ogg', \
				'sound/machines/terminal_button07.ogg', 'sound/machines/terminal_button08.ogg')
		if("vending")
			S = pick('sound/machines/vending_cans.ogg', 'sound/machines/vending_drop.ogg')
		if("incendiary_explosion")
			S = pick('sound/effects/explosion/incendiary1.ogg', 'sound/effects/explosion/incendiary2.ogg', 'sound/effects/explosion/incendiary3.ogg')
		if("molotov")
			S = pick('sound/effects/molotov_detonate_1.ogg', 'sound/effects/molotov_detonate_2.ogg', 'sound/effects/molotov_detonate_3.ogg')
		if("flashbang")
			S = pick('sound/effects/flashbang_explode_1.ogg', 'sound/effects/flashbang_explode_2.ogg')
		// Weapons/bullets
		if("ballistic_hit")
			S = pick('sound/bullets/bullet_impact1.ogg','sound/bullets/bullet_impact2.ogg','sound/bullets/bullet_impact3.ogg')
		if("ballistic hitmarker")
			S = pick('sound/bullets/bullet_impact4.ogg','sound/bullets/bullet_impact5.ogg','sound/bullets/bullet_impact6.ogg','sound/bullets/bullet_impact7.ogg')
		if("ballistic_armor")
			S = pick('sound/bullets/bullet_armor1.ogg','sound/bullets/bullet_armor2.ogg','sound/bullets/bullet_armor3.ogg','sound/bullets/bullet_armor4.ogg')
		if("ballistic_miss")
			S = pick('sound/bullets/bullet_miss1.ogg','sound/bullets/bullet_miss2.ogg','sound/bullets/bullet_miss3.ogg','sound/bullets/bullet_miss4.ogg')
		if("ballistic_bounce")
			S = pick('sound/bullets/bullet_ricochet1.ogg','sound/bullets/bullet_ricochet2.ogg','sound/bullets/bullet_ricochet3.ogg','sound/bullets/bullet_ricochet4.ogg','sound/bullets/bullet_ricochet5.ogg','sound/bullets/bullet_ricochet6.ogg','sound/bullets/bullet_ricochet7.ogg','sound/bullets/bullet_ricochet8.ogg')
		if("rocket_bounce")
			S = pick('sound/bullets/rocket_ricochet1.ogg','sound/bullets/rocket_ricochet2.ogg','sound/bullets/rocket_ricochet3.ogg')
		if("energy_hit")
			S = pick('sound/bullets/energy_impact1.ogg')
		if("alloy_hit")
			S = pick('sound/bullets/spear_impact1.ogg')
		if("alloy_armor")
			S = pick('sound/bullets/spear_armor1.ogg')
		if("alloy_bounce")
			S = pick('sound/bullets/spear_ricochet1.ogg','sound/bullets/spear_ricochet2.ogg')
		if("gun_silenced")
			S = pick('sound/weapons/guns/fire/silenced_shot1.ogg','sound/weapons/guns/fire/silenced_shot2.ogg')
		if("gun_smartgun")
			S = pick('sound/weapons/guns/fire/smartgun1.ogg', 'sound/weapons/guns/fire/smartgun2.ogg', 'sound/weapons/guns/fire/smartgun3.ogg')
		if("gun_flamethrower")
			S = pick('sound/weapons/guns/fire/flamethrower1.ogg', 'sound/weapons/guns/fire/flamethrower2.ogg', 'sound/weapons/guns/fire/flamethrower3.ogg')
		if("gun_ar12")
			S = pick('sound/weapons/guns/fire/tgmc/kinetic/gun_ar12_1.ogg','sound/weapons/guns/fire/tgmc/kinetic/gun_ar12_2.ogg','sound/weapons/guns/fire/tgmc/kinetic/gun_ar12_3.ogg')
		if("gun_fb12") // idk why i called it "fb-12", ah too late now
			S = pick('sound/weapons/guns/fire/tgmc/kinetic/gun_fb12_1.ogg','sound/weapons/guns/fire/tgmc/kinetic/gun_fb12_2.ogg','sound/weapons/guns/fire/tgmc/kinetic/gun_fb12_3.ogg')
		if("shotgun_som")
			S = pick('sound/weapons/guns/fire/v51_1.ogg','sound/weapons/guns/fire/v51_2.ogg','sound/weapons/guns/fire/v51_3.ogg','sound/weapons/guns/fire/v51_4.ogg')
		if("gun_pulse")
			S = pick('sound/weapons/guns/fire/m41a_1.ogg','sound/weapons/guns/fire/m41a_2.ogg','sound/weapons/guns/fire/m41a_3.ogg','sound/weapons/guns/fire/m41a_4.ogg','sound/weapons/guns/fire/m41a_5.ogg','sound/weapons/guns/fire/m41a_6.ogg')
		if("rpg_fire")
			S = pick('sound/weapons/guns/fire/rpg_1.ogg', 'sound/weapons/guns/fire/rpg_2.ogg', 'sound/weapons/guns/fire/rpg_3.ogg')
		if("ac_fire")
			S = pick('sound/weapons/guns/fire/autocannon_1.ogg', 'sound/weapons/guns/fire/autocannon_2.ogg', 'sound/weapons/guns/fire/autocannon_3.ogg')
		if("svd_fire")
			S = pick('sound/weapons/guns/fire/svd1.ogg', 'sound/weapons/guns/fire/svd2.ogg', 'sound/weapons/guns/fire/svd3.ogg')
		if("fal_fire")
			S = pick('sound/weapons/guns/fire/fal1.ogg', 'sound/weapons/guns/fire/fal2.ogg')
		if("mp38_fire")
			S = pick('sound/weapons/guns/fire/mp38_1.ogg', 'sound/weapons/guns/fire/mp38_2.ogg')

		// Xeno
		if("acid_hit")
			S = pick('sound/bullets/acid_impact1.ogg')
		if("acid_bounce")
			S = pick('sound/bullets/acid_impact1.ogg')
		if("alien_claw_flesh")
			S = pick('sound/weapons/alien_claw_flesh1.ogg','sound/weapons/alien_claw_flesh2.ogg','sound/weapons/alien_claw_flesh3.ogg')
		if("alien_claw_metal")
			S = pick('sound/weapons/alien_claw_metal1.ogg','sound/weapons/alien_claw_metal2.ogg','sound/weapons/alien_claw_metal3.ogg')
		if("alien_bite")
			S = pick('sound/weapons/alien_bite1.ogg','sound/weapons/alien_bite2.ogg')
		if("alien_tail_attack")
			S = 'sound/weapons/alien_tail_attack.ogg'
		if("alien_footstep_large")
			S = pick('sound/effects/footstep/alien/large1.ogg','sound/effects/footstep/alien/large2.ogg','sound/effects/footstep/alien/large3.ogg')
		if("alien_charge")
			S = pick('sound/effects/footstep/alien/charge1.ogg','sound/effects/footstep/alien/charge2.ogg','sound/effects/footstep/alien/charge3.ogg')
		if("alien_resin_build")
			S = pick('sound/effects/alien/resin_build1.ogg','sound/effects/alien/resin_build2.ogg','sound/effects/alien/resin_build3.ogg')
		if("alien_resin_break")
			S = pick('sound/effects/alien/resin_break1.ogg','sound/effects/alien/resin_break2.ogg')
		if("alien_resin_move") // be aware, this isn't a footstep, footsteps are located elsewhere
			S = pick('sound/effects/alien/resin_move1.ogg', 'sound/effects/alien/resin_move2.ogg')
		if("alien_talk")
			S = pick('sound/voice/alien/talk.ogg','sound/voice/alien/talk2.ogg','sound/voice/alien/talk3.ogg')
		if("larva_talk")
			S = pick('sound/voice/alien/larva/talk1.ogg','sound/voice/alien/larva/talk2.ogg','sound/voice/alien/larva/talk3.ogg', 'sound/voice/alien/larva/talk4.ogg')
		if("predalien_talk")
			S = pick('sound/voice/alien/predalien/click1.ogg','sound/voice/alien/predalien/click2.ogg','sound/voice/alien/predalien/click3.ogg')
		if("alien_growl")
			S = pick('sound/voice/alien/growl1.ogg','sound/voice/alien/growl2.ogg','sound/voice/alien/growl3.ogg','sound/voice/alien/growl4.ogg')
		if("alien_hiss")
			S = pick('sound/voice/alien/hiss1.ogg','sound/voice/alien/hiss2.ogg','sound/voice/alien/hiss3.ogg')
		if("alien_tail_swipe")
			S = pick('sound/effects/alien/tail_swipe1.ogg','sound/effects/alien/tail_swipe2.ogg','sound/effects/alien/tail_swipe3.ogg')
		if("alien_help")
			S = pick('sound/voice/alien/help1.ogg','sound/voice/alien/help2.ogg')
		if("alien_drool")
			S = pick('sound/voice/alien/drool1.ogg','sound/voice/alien/drool2.ogg')
		if("alien_roar")
			S = pick('sound/voice/alien/roar1.ogg','sound/voice/alien/roar2.ogg','sound/voice/alien/roar3.ogg','sound/voice/alien/roar4.ogg','sound/voice/alien/roar5.ogg','sound/voice/alien/roar6.ogg','sound/voice/alien/roar7.ogg','sound/voice/alien/roar8.ogg','sound/voice/alien/roar9.ogg','sound/voice/alien/roar10.ogg','sound/voice/alien/roar11.ogg','sound/voice/alien/roar12.ogg')
		if("alien_roar_larva")
			S = pick('sound/voice/alien/larva/roar1.ogg','sound/voice/alien/larva/roar2.ogg','sound/voice/alien/larva/roar3.ogg','sound/voice/alien/larva/roar4.ogg')
		if("queen")
			S = pick('sound/voice/alien/queen/command.ogg','sound/voice/alien/queen/command2.ogg','sound/voice/alien/queen/command3.ogg')
		if("alien_ventpass")
			S = pick('sound/effects/alien/ventpass1.ogg', 'sound/effects/alien/ventpass2.ogg')
		if("behemoth_step_sounds")
			S = pick('sound/effects/footstep/alien/large1.ogg', 'sound/effects/footstep/alien/large2.ogg', 'sound/effects/footstep/alien/large3.ogg')
		if("behemoth_rolling")
			S = 'sound/effects/alien/behemoth/roll.ogg'
		if("behemoth_earth_pillar_hit")
			S = pick('sound/effects/alien/behemoth/earth_pillar_hit_1.ogg', 'sound/effects/alien/behemoth/earth_pillar_hit_2.ogg', 'sound/effects/alien/behemoth/earth_pillar_hit_3.ogg', 'sound/effects/alien/behemoth/earth_pillar_hit_4.ogg', 'sound/effects/alien/behemoth/earth_pillar_hit_5.ogg', 'sound/effects/alien/behemoth/earth_pillar_hit_6.ogg')

		// Human
		if("male_scream")
			S = pick('sound/voice/human/male/scream_1.ogg','sound/voice/human/male/scream_2.ogg','sound/voice/human/male/scream_3.ogg','sound/voice/human/male/scream_4.ogg','sound/voice/human/male/scream_5.ogg','sound/voice/human/male/scream_6.ogg', 'sound/voice/human/male/scream_7.ogg')
		if("male_pain")
			S = pick('sound/voice/human/male/pain_1.ogg','sound/voice/human/male/pain_2.ogg','sound/voice/human/male/pain_3.ogg','sound/voice/human/male/pain_4.ogg','sound/voice/human/male/pain_5.ogg','sound/voice/human/male/pain_6.ogg','sound/voice/human/male/pain_7.ogg','sound/voice/human/male/pain_8.ogg', 'sound/voice/human/male/pain_9.ogg', 'sound/voice/human/male/pain_10.ogg', 'sound/voice/human/male/pain_11.ogg')
		if("male_gored")
			S = pick('sound/voice/human/male/gored_1.ogg','sound/voice/human/male/gored_2.ogg', 'sound/voice/human/male/gored3.ogg')
		if("male_fragout")
			S = pick('sound/voice/human/male/grenadethrow_1.ogg', 'sound/voice/human/male/grenadethrow_2.ogg', 'sound/voice/human/male/grenadethrow_3.ogg')
		if("male_warcry")
			S = pick('sound/voice/human/male/warcry_1.ogg','sound/voice/human/male/warcry_2.ogg','sound/voice/human/male/warcry_3.ogg','sound/voice/human/male/warcry_4.ogg','sound/voice/human/male/warcry_5.ogg','sound/voice/human/male/warcry_6.ogg','sound/voice/human/male/warcry_7.ogg','sound/voice/human/male/warcry_8.ogg','sound/voice/human/male/warcry_9.ogg','sound/voice/human/male/warcry_10.ogg','sound/voice/human/male/warcry_11.ogg','sound/voice/human/male/warcry_12.ogg','sound/voice/human/male/warcry_13.ogg','sound/voice/human/male/warcry_14.ogg','sound/voice/human/male/warcry_15.ogg','sound/voice/human/male/warcry_16.ogg','sound/voice/human/male/warcry_17.ogg','sound/voice/human/male/warcry_18.ogg','sound/voice/human/male/warcry_19.ogg','sound/voice/human/male/warcry_20.ogg','sound/voice/human/male/warcry_21.ogg','sound/voice/human/male/warcry_22.ogg','sound/voice/human/male/warcry_23.ogg','sound/voice/human/male/warcry_24.ogg','sound/voice/human/male/warcry_25.ogg','sound/voice/human/male/warcry_26.ogg','sound/voice/human/male/warcry_27.ogg','sound/voice/human/male/warcry_28.ogg','sound/voice/human/male/warcry_29.ogg')
		if("female_scream")
			S = pick('sound/voice/human/female/scream_1.ogg','sound/voice/human/female/scream_2.ogg','sound/voice/human/female/scream_3.ogg','sound/voice/human/female/scream_4.ogg','sound/voice/human/female/scream_5.ogg')
		if("female_pain")
			S = pick('sound/voice/human/female/pain_1.ogg','sound/voice/human/female/pain_2.ogg','sound/voice/human/female/pain_3.ogg')
		if("female_gored")
			S = pick('sound/voice/human/female/gored_1.ogg','sound/voice/human/female/gored_2.ogg')
		if("female_fragout")
			S = pick("sound/voice/human/female/grenadethrow_1.ogg", 'sound/voice/human/female/grenadethrow_2.ogg', 'sound/voice/human/female/grenadethrow_3.ogg')
		if("female_warcry")
			S = pick('sound/voice/human/female/warcry_1.ogg','sound/voice/human/female/warcry_2.ogg','sound/voice/human/female/warcry_3.ogg','sound/voice/human/female/warcry_4.ogg','sound/voice/human/female/warcry_5.ogg','sound/voice/human/female/warcry_6.ogg','sound/voice/human/female/warcry_7.ogg','sound/voice/human/female/warcry_8.ogg','sound/voice/human/female/warcry_9.ogg','sound/voice/human/female/warcry_10.ogg','sound/voice/human/female/warcry_11.ogg','sound/voice/human/female/warcry_12.ogg','sound/voice/human/female/warcry_13.ogg','sound/voice/human/female/warcry_14.ogg','sound/voice/human/female/warcry_15.ogg','sound/voice/human/female/warcry_16.ogg','sound/voice/human/female/warcry_17.ogg','sound/voice/human/female/warcry_18.ogg','sound/voice/human/female/warcry_19.ogg')
		if("male_hugged")
			S = pick("sound/voice/human/male/facehugged1.ogg", 'sound/voice/human/male/facehugged2.ogg', 'sound/voice/human/male/facehugged3.ogg')
		if("female_hugged")
			S = pick("sound/voice/human/female/facehugged1.ogg", 'sound/voice/human/female/facehugged2.ogg')
		if("male_gasp")
			S = pick("sound/voice/human/male/gasp1.ogg", 'sound/voice/human/male/gasp2.ogg', 'sound/voice/human/male/gasp3.ogg')
		if("female_gasp")
			S = pick("sound/voice/human/female/gasp1.ogg", 'sound/voice/human/female/gasp2.ogg')
		if("male_cough")
			S = pick("sound/voice/human/male/cough1.ogg", 'sound/voice/human/male/cough2.ogg')
		if("female_cough")
			S = pick("sound/voice/human/female/cough1.ogg", 'sound/voice/human/female/cough2.ogg')
		if("male_preburst")
			S = pick("sound/voice/human/male/preburst1.ogg", 'sound/voice/human/male/preburst2.ogg', 'sound/voice/human/male/preburst3.ogg', 'sound/voice/human/male/preburst4.ogg', 'sound/voice/human/male/preburst5.ogg', 'sound/voice/human/male/preburst6.ogg', 'sound/voice/human/male/preburst7.ogg', 'sound/voice/human/male/preburst8.ogg', 'sound/voice/human/male/preburst9.ogg', 'sound/voice/human/male/preburst10.ogg')
		if("female_preburst")
			S = pick("sound/voice/human/female/preburst1.ogg", 'sound/voice/human/female/preburst2.ogg', 'sound/voice/human/female/preburst3.ogg')
		if("male_laugh")
			S = pick('sound/voice/human/male/laugh_1.ogg', 'sound/voice/human/male/laugh_2.ogg', 'sound/voice/human/male/laugh_3.ogg', 'sound/voice/human/male/laugh_4.ogg', 'sound/voice/human/male/laugh_5.ogg', 'sound/voice/human/male/laugh_6.ogg', 'sound/voice/human/male/laugh_7.ogg', 'sound/voice/human/male/laugh_8.ogg', 'sound/voice/human/male/laugh_9.ogg')
		if("female_laugh")
			S = pick('sound/voice/human/female/laugh_1.ogg', 'sound/voice/human/female/laugh_2.ogg', 'sound/voice/human/female/laugh_3.ogg', 'sound/voice/human/female/laugh_4.ogg', 'sound/voice/human/female/laugh_5.ogg', 'sound/voice/human/female/laugh_6.ogg', 'sound/voice/human/female/laugh_7.ogg')
		if("jump")
			S = pick('sound/effects/bounce_1.ogg','sound/effects/bounce_2.ogg','sound/effects/bounce_3.ogg','sound/effects/bounce_4.ogg')

		//robot race
		if("robot_scream")
			S = pick('sound/voice/robot/robot_scream1.ogg', 'sound/voice/robot/robot_scream2.ogg', 'sound/voice/robot/robot_scream2.ogg')
		if("robot_pain")
			S = pick('sound/voice/robot/robot_pain1.ogg', 'sound/voice/robot/robot_pain2.ogg', 'sound/voice/robot/robot_pain3.ogg')
		if("robot_warcry")
			S = pick('sound/voice/robot/robot_warcry1.ogg', 'sound/voice/robot/robot_warcry2.ogg', 'sound/voice/robot/robot_warcry3.ogg')
		if("robot_male_laugh")
			S = pick('sound/voice/robotic/male_laugh1.ogg', 'sound/voice/robotic/male_laugh2.ogg', 'sound/voice/robotic/male_laugh3.ogg', 'sound/voice/robotic/male_laugh4.ogg', 'sound/voice/robotic/male_laugh5.ogg', 'sound/voice/robotic/male_laugh6.ogg', 'sound/voice/robotic/male_laugh7.ogg', 'sound/voice/robotic/male_laugh8.ogg', 'sound/voice/robotic/male_laugh9.ogg', )
		if("robot_female_laugh")
			S = pick('sound/voice/robotic/female_laugh1.ogg', 'sound/voice/robotic/female_laugh2.ogg', 'sound/voice/robotic/female_laugh3.ogg', 'sound/voice/robotic/female_laugh4.ogg', 'sound/voice/robotic/female_laugh5.ogg', 'sound/voice/robotic/female_laugh6.ogg', 'sound/voice/robotic/female_laugh7.ogg', )

		//yautja race
		if("pred_scream")
			S = pick('sound/voice/predator/roar1.ogg','sound/voice/predator/roar2.ogg','sound/voice/predator/roar3.ogg','sound/voice/predator/roar4.ogg','sound/voice/predator/roar5.ogg')
		if("pred_pain")
			S = pick('sound/voice/predator/pain1.ogg','sound/voice/predator/pain2.ogg','sound/voice/predator/pain3.ogg','sound/voice/predator/pain4.ogg','sound/voice/predator/pain5.ogg')
		if("pred_hugged")
			S = pick('sound/voice/predator/facehugged.ogg')
		if("pred_preburst")
			S = pick('sound/voice/predator/pain_rare1.ogg')
		if("pred_warcry")
			S = pick('sound/voice/predator/warcry.ogg')
		if("pred_laugh")
			S = pick('sound/voice/predator/laugh1.ogg', 'sound/voice/predator/laugh2.ogg', 'sound/voice/predator/laugh3.ogg', 'sound/voice/predator/laugh4.ogg')

		//pred items
		if("clan_sword_hit")
			S = pick('sound/weapons/clan_sword_hit_1.ogg', 'sound/weapons/clan_sword_hit_2.ogg')
		if("chain_swing")
			S = pick('sound/items/chain_swing1.ogg', 'sound/items/chain_swing2.ogg', 'sound/items/chain_swing3.ogg')
	return S
