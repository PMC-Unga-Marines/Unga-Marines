#define TEMPERATURE_DAMAGE_COEFFICIENT 1.5	//This is used in reagents that affect body temperature. Temperature damage is multiplied by this amount.

#define BODYTEMP_NORMAL 310.15		//The natural temperature for a body
#define BODYTEMP_AUTORECOVERY_DIVISOR 20 //This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery. This is applied each tick, so long as the mob is alive.
#define BODYTEMP_AUTORECOVERY_MINIMUM 1 //Minimum amount of kelvin moved toward 310.15K per tick. So long as abs(310.15 - bodytemp) is more than 50.
#define BODYTEMP_COLD_DIVISOR 6 //Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to lose bodytemp faster.
#define BODYTEMP_HEAT_DIVISOR 6 //Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to gain bodytemp faster.
#define BODYTEMP_COOLING_MAX -30 //The maximum number of degrees that your body can cool in 1 tick, when in a cold area.
#define BODYTEMP_HEATING_MAX 30 //The maximum number of degrees that your body can heat up in 1 tick, when in a hot area.

#define BODYTEMP_HEAT_DAMAGE_LIMIT_ONE 360.15 // The limit the human body can take before it starts taking damage from heat.
#define BODYTEMP_HEAT_DAMAGE_LIMIT_TWO 400.15
#define BODYTEMP_HEAT_DAMAGE_LIMIT_THREE 1000

#define BODYTEMP_COLD_DAMAGE_LIMIT_ONE 260.15 // The limit the human body can take before it starts taking damage from coldness.
#define BODYTEMP_COLD_DAMAGE_LIMIT_TWO 240.15
#define BODYTEMP_COLD_DAMAGE_LIMIT_THREE 120.15

#define T0C 273.15					// 0degC
#define T20C 293.15					// 20degC
#define TCMB 2.7					// -270.3degC
#define ICE_COLONY_TEMPERATURE 255.15	//-18degC

//used for device_type vars
#define UNARY 1
#define BINARY 2
#define TRINARY 3
#define QUATERNARY 4

//MULTIPIPES
//IF YOU EVER CHANGE THESE CHANGE SPRITES TO MATCH.
#define PIPING_LAYER_MIN 1
#define PIPING_LAYER_MAX 3
#define PIPING_LAYER_DEFAULT 2
#define PIPING_LAYER_P_X 5
#define PIPING_LAYER_P_Y 5
#define PIPING_LAYER_LCHANGE 0.05

#define PIPING_ALL_LAYER (1<<0)	//intended to connect with all layers, check for all instead of just one.
#define PIPING_ONE_PER_TURF (1<<1) 	//can only be built if nothing else with this flag is on the tile already.
#define PIPING_DEFAULT_LAYER_ONLY (1<<2)	//can only exist at PIPING_LAYER_DEFAULT
#define PIPING_CARDINAL_AUTONORMALIZE (1<<3)	//north/south east/west doesn't matter, auto normalize on build.

// Ventcrawling bitflags, handled in var/vent_movement
///Allows for ventcrawling to occur. All atmospheric machines have this flag on by default. Cryo is the exception
#define VENTCRAWL_ALLOWED	(1<<0)
///Allows mobs to enter or leave from atmospheric machines. On for passive, unary, and scrubber vents.
#define VENTCRAWL_ENTRANCE_ALLOWED (1<<1)
///Used to check if a machinery is visible. Called by update_pipe_vision(). On by default for all except cryo.
#define VENTCRAWL_CAN_SEE	(1<<2)

#define PIPE_VISIBLE_LEVEL 2
#define PIPE_HIDDEN_LEVEL 1

#define VENT_SOUND_DELAY 3 SECONDS
