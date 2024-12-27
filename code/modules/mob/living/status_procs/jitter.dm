/mob/living/proc/jitter(amount)
	jitteriness = clamp(jitteriness + amount, 0, 1000)
