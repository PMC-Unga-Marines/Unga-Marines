#define MODE_GENERAL_QUICKBUILD_POINTS (1<<1)
#define MODE_PERSONAL_QUICKBUILD_POINTS (1<<2)

#define MAX_FACEHUGGERS 5

//Time (after shutters open) before siloless timer can start
#define MINIMUM_TIME_SILO_LESS_COLLAPSE 15 MINUTES

//Distress mode collapse duration
#define DISTRESS_SILO_COLLAPSE 5 MINUTES

#define WHITELIST_YAUTJA (1<<0)
///Old holders of YAUTJA_ELDER
#define WHITELIST_YAUTJA_LEGACY (1<<1)
#define WHITELIST_YAUTJA_COUNCIL (1<<2)
///Old holders of YAUTJA_COUNCIL for 3 months
#define WHITELIST_YAUTJA_COUNCIL_LEGACY (1<<3)
#define WHITELIST_YAUTJA_LEADER (1<<4)
#define WHITELIST_PREDATOR (WHITELIST_YAUTJA|WHITELIST_YAUTJA_LEGACY|WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_COUNCIL_LEGACY|WHITELIST_YAUTJA_LEADER)

#define WHITELIST_NORMAL	"Normal"
#define WHITELIST_COUNCIL	"Council"
#define WHITELIST_LEADER	"Leader"

#define WHITELIST_HIERARCHY	list(WHITELIST_NORMAL, WHITELIST_COUNCIL, WHITELIST_LEADER)

/proc/get_desired_status(desired_status, status_limit)
	var/found_desired = FALSE
	var/found_limit = FALSE

	for(var/status in WHITELIST_HIERARCHY)
		if(status == desired_status)
			found_desired = TRUE
			break
		if(status == status_limit)
			found_limit = TRUE
			break

	if(found_desired)
		return desired_status
	else if(found_limit)
		return status_limit

	return desired_status

#define MODE_SHIPSIDE_SD (1<<16)
#define MODE_PREDATOR (1<<17)
