//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/carrier_shared_jelly
	name = "Shared Jelly"
	desc = "If you are under the effect of Resin Jelly, all thrown huggers gain fire immunity. Each thrown hugger reduce the duration of the effect by 3/2/1 seconds."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_SHARED_JELLY
	buff_desc = "Fire immunity for thrown huggers"
	caste_restrictions = list("carrier")

/datum/xeno_mutation/carrier_hugger_overflow
	name = "Hugger Overflow"
	desc = "While you have 8/7/6 or more stored huggers, you will automatically drop one underneath you when you become staggered."
	category = "Survival"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_HUGGER_OVERFLOW
	buff_desc = "Auto-drop huggers when staggered"
	caste_restrictions = list("carrier")

/datum/xeno_mutation/carrier_recurring_panic
	name = "Recurring Panic"
	desc = "If you're not resting, Carrier Panic will automatically attempt to activate when possible. The cooldown duration is set to 20% of its original value. It only consumes 50/40/30% of your maximum plasma."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_RECURRING_PANIC
	buff_desc = "Auto-activate panic with reduced cost"
	caste_restrictions = list("carrier")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/carrier_leapfrog
	name = "Leapfrog"
	desc = "Thrown huggers can now leap 1 tile at a time. All activation times are 0.8/0.7/0.6x of their original value, but will never be faster than 0.5s."
	category = "Offensive"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_LEAPFROG
	buff_desc = "Huggers can leap, faster activation"
	caste_restrictions = list("carrier")

/datum/xeno_mutation/carrier_claw_delivered
	name = "Claw Delivered"
	desc = "Huggers from your eggs now have a reduced cast time against humans. The cast time is set to 60/50/40% of its original value."
	category = "Offensive"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_CLAW_DELIVERED
	buff_desc = "Faster hugger attachment to humans"
	caste_restrictions = list("carrier")

/datum/xeno_mutation/carrier_fake_huggers
	name = "Fake Huggers"
	desc = "Thrown huggers will accompanied by a fake facehugger which will mimic their behavior. Their color will be changed to match 50/70/90% of the original hugger's color."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_FAKE_HUGGERS
	buff_desc = "Fake huggers accompany real ones"
	caste_restrictions = list("carrier")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/carrier_oviposition
	name = "Oviposition"
	desc = "Egg Lay now creates eggs with your selected type of hugger inside. The plasma cost is set to 50/40/30% of its their original value and its cooldown is set to 50% of its original value. You lose the ability, Spawn Huggers."
	category = "Specialized"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_OVIPOSITION
	buff_desc = "Eggs contain selected huggers, lose spawn ability"
	caste_restrictions = list("carrier")

/datum/xeno_mutation/carrier_life_for_life
	name = "Life for Life"
	desc = "Spawn Facehugger's cooldown is set to 70% of its original value and costs zero plasma, but will deal 50/40/30 true damage to you."
	category = "Specialized"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_LIFE_FOR_LIFE
	buff_desc = "Free spawn hugger with health cost"
	caste_restrictions = list("carrier")

/datum/xeno_mutation/carrier_swarm_trap
	name = "Swarm Trap"
	desc = "Your newly created traps can fit an additional 1/2/3 huggers, but the stun duration divided by the amount of the hugger inside the trap."
	category = "Specialized"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CARRIER_SWARM_TRAP
	buff_desc = "More huggers per trap, reduced stun duration"
	caste_restrictions = list("carrier")
