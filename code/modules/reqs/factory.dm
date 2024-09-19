/datum/supply_packs/factory
	group = "Factory"
	containertype = /obj/structure/closet/crate

/datum/supply_packs/factory/assembler
	name = "Assembler"
	contains = list(/obj/machinery/assembler)
	cost = 50

/datum/supply_packs/factory/junk
	name = "Junk fabricator"
	contains = list(/obj/machinery/fabricator/junk)
	cost = 1500 //expensive, but pays for itself in about 15 minutes

/datum/supply_packs/factory/gunpowder
	name = "Gunpowder fabricator"
	contains = list(/obj/machinery/fabricator/gunpowder)
	cost = 800
