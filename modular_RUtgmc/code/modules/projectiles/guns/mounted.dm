//-------------------------------------------------------
//MG-27 Medium Machine Gun

/obj/item/weapon/gun/standard_mmg
	unload_sound =   'modular_RUtgmc/sound/weapons/guns/machineguns/MG-27/MG27_boxout.ogg'
	reload_sound =   'modular_RUtgmc/sound/weapons/guns/machineguns/MG-27/MG27_boxin.ogg'
	cocked_sound = 	 'modular_RUtgmc/sound/weapons/guns/machineguns/MG-27/MG27_boltpull.ogg'
	silenced_sound = 'modular_RUtgmc/sound/weapons/guns/machineguns/MG-27/MG27_SIL.ogg'
	wield_sound = 	 'modular_RUtgmc/sound/weapons/guns/machineguns/Deploy_Wave_MACHINEGUN.ogg'
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/unremovable/mmg,
		/obj/item/attachable/stock/t27,
	)

// This is a deployed IFF-less MACHINEGUN, has 500 rounds, drums do not fit anywhere but your belt slot and your back slot. But it has 500 rounds. That's nice.

/obj/item/weapon/gun/heavymachinegun
	deployable_item = /obj/machinery/deployable/mounted/moveable/fast
	reload_sound = 'modular_RUtgmc/sound/weapons/guns/machineguns/HMG-08/HMG-08_jam.ogg'

///HSG-102, now with full auto. It is not a superclass of deployed guns, however there are a few varients.
/obj/item/weapon/gun/tl102
	reload_sound = 'modular_RUtgmc/sound/weapons/guns/machineguns/HMG-08/HMG-08_jam.ogg'
	deploy_time = 3 SECONDS
