/obj/effect/landmark/excavation_site_spawner
	name = "excavation site spawner"
	icon_state = "clockwork_orange"
	///Excavation rewards datum that is used when excavation is performed
	var/datum/excavation_rewards/rewards_typepath

/obj/effect/landmark/excavation_site_spawner/Initialize(mapload)
	. = ..()
	GLOB.excavation_site_spawners += src

/obj/effect/landmark/excavation_site_spawner/Destroy()
	. = ..()
	GLOB.excavation_site_spawners -= src

///Setup an excavation
/obj/effect/landmark/excavation_site_spawner/proc/spawn_excavation_site()
	rewards_typepath = pick(/datum/excavation_rewards, /datum/excavation_rewards/xeno)
	if(initial(rewards_typepath.map_icon))
		SSminimaps.add_marker(src, MINIMAP_FLAG_EXCAVATION_ZONE, image('icons/UI_icons/map_blips.dmi', null, initial(rewards_typepath.map_icon), MINIMAP_BLIPS_LAYER))

///Perform an excavation and revert the spawner to inactive state
/obj/effect/landmark/excavation_site_spawner/proc/excavate_site()
	var/datum/excavation_rewards/rewards_instance = new rewards_typepath
	rewards_instance.drop_rewards(src)
	qdel(rewards_instance)
	rewards_typepath = null
	SSminimaps.remove_marker(src)

///Excavation rewards buckets
/datum/excavation_rewards
	///Min amount of rewards
	var/rewards_min = 2
	///Max amount of rewards
	var/rewards_max = 4
	///Minimaps icon name of the excavation site
	var/map_icon = "excav_money"
	///List of rewards for the excavation
	var/list/rewards = list(
		/obj/item/research_resource/money,
	)

///Generate rewards
/datum/excavation_rewards/proc/drop_rewards(obj/effect/landmark/excavation_site_spawner/excav_site)
	var/iterations = rand(rewards_min, rewards_max)
	for(var/i in 1 to iterations)
		var/typepath = pick(rewards)
		new typepath(excav_site.loc)

/datum/excavation_rewards/xeno
	map_icon = "excav_xeno"
	rewards = list(
		/obj/item/research_resource/xeno/tier_one,
	)
