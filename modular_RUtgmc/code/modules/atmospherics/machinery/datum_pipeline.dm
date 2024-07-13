/datum/pipeline/addMachineryMember(obj/machinery/atmospherics/components/C)
	if(!other_atmosmch.Find(C))
		other_atmosmch += C
		RegisterSignal(C, COMSIG_QDELETING, PROC_REF(clean_machinery_member))
