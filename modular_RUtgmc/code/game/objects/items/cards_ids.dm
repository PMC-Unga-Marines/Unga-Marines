/// How many points a marine can spend in job specific vendors by default
#define DEFAULT_TOTAL_BUY_POINTS 45
/// How many points a medic can spend on pills
#define MEDIC_TOTAL_BUY_POINTS 45
/// How many points an engineer can spend
#define ENGINEER_TOTAL_BUY_POINTS 75
/// How many points the field commander can spend
#define COMMANDER_TOTAL_BUY_POINTS 45
/// How many points the synthetic can spend
#define SYNTH_TOTAL_BUY_POINTS 50

/obj/item/card/id/gold
	marine_points = list(
		CAT_SYNTH = SYNTH_TOTAL_BUY_POINTS,
	)

/obj/item/card/id/dogtag/full
	marine_points = list(
		CAT_SGSUP = DEFAULT_TOTAL_BUY_POINTS,
		CAT_ENGSUP = ENGINEER_TOTAL_BUY_POINTS,
		CAT_LEDSUP = DEFAULT_TOTAL_BUY_POINTS,
		CAT_MEDSUP = MEDIC_TOTAL_BUY_POINTS,
		CAT_FCSUP = COMMANDER_TOTAL_BUY_POINTS,
		CAT_SYNTH = SYNTH_TOTAL_BUY_POINTS, //necessary to correctly show max points
	)

#undef DEFAULT_TOTAL_BUY_POINTS
#undef MEDIC_TOTAL_BUY_POINTS
#undef ENGINEER_TOTAL_BUY_POINTS
#undef COMMANDER_TOTAL_BUY_POINTS
#undef SYNTH_TOTAL_BUY_POINTS
