/mob/living/proc/adjust_ear_damage(damage = 0, deaf = 0)
	ear_damage = max(0, ear_damage + damage)
	ear_deaf = max((disabilities & DEAF|| ear_damage >= 100) ? 1 : 0, ear_deaf + deaf)

/mob/living/proc/set_ear_damage(damage = 0, deaf = 0)
	if(!isnull(damage))
		ear_damage = damage
	if(!isnull(deaf))
		ear_deaf = max((disabilities & DEAF|| ear_damage >= 100) ? 1 : 0, deaf)
