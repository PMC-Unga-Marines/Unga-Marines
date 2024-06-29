//Human sub-species
#define isnecoarc(H) (is_species(H, /datum/species/necoarc))

//Xeno castes
#define isxenopanther(A) (istype(A, /mob/living/carbon/xenomorph/panther))
#define isxenofacehugger(A) (istype(A, /mob/living/carbon/xenomorph/facehugger))

//Gamemode
#define isdistressgamemode(O) (istype(O, /datum/game_mode/infestation/distress))

#define isresearcher(A) (ishuman(A) && A.job.title == "Medical Researcher")
#define isyautja(H) (is_species(H, /datum/species/yautja))

#define ispredatorjob(J) (istype(J, /datum/job/predator))

#define ispredalien(A) (istype(A, /mob/living/carbon/xenomorph/predalien))
#define isxenopredalienlarva(A) (istype(A, /mob/living/carbon/xenomorph/larva/predalien))
#define isxenohellhound(A) (istype(A, /mob/living/carbon/xenomorph/hellhound))

// Why not using A in list(...)?
#define isxenohive(A) ((A == XENO_HIVE_NONE) || (A == XENO_HIVE_NORMAL) || (A == XENO_HIVE_CORRUPTED) || (A == XENO_HIVE_ALPHA) || (A == XENO_HIVE_BETA) || (A == XENO_HIVE_ZETA) || (A == XENO_HIVE_ADMEME)) || (A == XENO_HIVE_FALLEN) || (A == XENO_HIVE_FORSAKEN) || (A == XENO_HIVE_YAUTJA)
//Objects
#define iscontainmentshutter(A) (istype(A, /obj/machinery/door/poddoor/timed_late/containment/landing_zone))
