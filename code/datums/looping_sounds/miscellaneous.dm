/datum/looping_sound/weldingtool
	start_volume = 30
	start_sound = 'sound/items/weldingtool/RepairTool_Start.ogg'
	start_length = 2
	mid_sounds = list('sound/items/weldingtool/RepairTool_On.ogg'=1)
	mid_length = 6
	end_volume = 30
	end_sound = 'sound/items/weldingtool/RepairTool_Stop.ogg'
	volume = 18

/datum/looping_sound/sentry_scan
	mid_sounds = list('sound/items/turrets/turret_scan.ogg')
	mid_length = 3 SECONDS
	volume = 30
	range = 10

/datum/looping_sound/telephone/ring
	start_sound = 'sound/machines/telephone/dial.ogg'
	start_length = 3.2 SECONDS
	mid_sounds = 'sound/machines/telephone/ring_outgoing.ogg'
	mid_length = 2.1 SECONDS
	volume = 10

/datum/looping_sound/telephone/busy
	start_sound = 'sound/machines/telephone/callstation_unavailable.ogg'
	start_length = 5.7 SECONDS
	mid_sounds = 'sound/machines/telephone/phone_busy.ogg'
	mid_length = 5 SECONDS
	volume = 15

/datum/looping_sound/telephone/hangup
	start_sound = 'sound/machines/telephone/remote_hangup.ogg'
	start_length = 0.6 SECONDS
	mid_sounds = 'sound/machines/telephone/phone_busy.ogg'
	mid_length = 5 SECONDS
	volume = 15
