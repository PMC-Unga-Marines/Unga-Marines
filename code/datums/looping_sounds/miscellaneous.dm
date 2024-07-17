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
