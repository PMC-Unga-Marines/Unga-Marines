#define CHANGETURF_DEFER_CHANGE (1<<0)
#define CHANGETURF_FORCEOP (1<<1)
#define CHANGETURF_SKIP (1<<2) // A flag for place_on_top to just instance the new turf instead of calling ChangeTurf. Used for uninitialized turfs NOTHING ELSE

//turf_flags values
/// If a turf is an usused reservation turf awaiting assignment
#define UNUSED_RESERVATION_TURF (1<<0)
/// If a turf is a reserved turf
#define RESERVATION_TURF (1<<1)
