/mob/living/proc/add_stun_absorption(key, duration, priority, message, self_message, examine_message)
//adds a stun absorption with a key, a duration in deciseconds, its priority, and the messages it makes when you're stun/examined, if any
	if(!islist(stun_absorption))
		stun_absorption = list()
	if(stun_absorption[key])
		stun_absorption[key]["end_time"] = world.time + duration
		stun_absorption[key]["priority"] = priority
		stun_absorption[key]["stuns_absorbed"] = 0
	else
		stun_absorption[key] = list("end_time" = world.time + duration, "priority" = priority, "stuns_absorbed" = 0, \
		"visible_message" = message, "self_message" = self_message, "examine_message" = examine_message)

/mob/living/proc/absorb_stun(amount, ignoring_flag_presence)
	if(amount < 0 || stat || ignoring_flag_presence || !islist(stun_absorption))
		return FALSE
	if(!amount)
		amount = 0
	var/priority_absorb_key
	var/highest_priority

	for(var/i in stun_absorption)
		if(stun_absorption[i]["end_time"] <= world.time)
			continue
		if(priority_absorb_key && stun_absorption[i]["priority"] <= highest_priority)
			continue
		priority_absorb_key = stun_absorption[i]
		highest_priority = priority_absorb_key["priority"]
	
	if(!priority_absorb_key)
		return TRUE
	if(!amount) //don't spam up the chat for continuous stuns
		return TRUE
	priority_absorb_key["stuns_absorbed"] += amount
	if(priority_absorb_key["visible_message"] && priority_absorb_key["self_message"])
		visible_message(span_warning("[src][priority_absorb_key["visible_message"]]"), span_boldwarning("[priority_absorb_key["self_message"]]"))
	else if(priority_absorb_key["visible_message"])
		visible_message(span_warning("[src][priority_absorb_key["visible_message"]]"))
	else if(priority_absorb_key["self_message"])
		to_chat(src, span_boldwarning("[priority_absorb_key["self_message"]]"))
	return TRUE
