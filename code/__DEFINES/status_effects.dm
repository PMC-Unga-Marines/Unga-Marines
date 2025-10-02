
//These are all the different status effects. Use the paths for each effect in the defines.

#define STATUS_EFFECT_MULTIPLE 0 //if it allows multiple instances of the effect

#define STATUS_EFFECT_UNIQUE 1 //if it allows only one, preventing new instances

#define STATUS_EFFECT_REPLACE 2 //if it allows only one, but new instances replace

#define STATUS_EFFECT_REFRESH 3 // if it only allows one, and new instances just instead refresh the timer

///////////
// BUFFS //
///////////

//Carapace
#define STATUS_EFFECT_CARAPACE /datum/status_effect/carapace
#define STATUS_EFFECT_CARAPACE_TWO /datum/status_effect/carapace/tier2
#define STATUS_EFFECT_CARAPACE_THREE /datum/status_effect/carapace/tier3

//Regeneration
#define STATUS_EFFECT_REGENERATION /datum/status_effect/regeneration
#define STATUS_EFFECT_REGENERATION_TWO /datum/status_effect/regeneration/tier2

//Vampirism
#define STATUS_EFFECT_VAMPIRISM /datum/status_effect/vampirism
#define STATUS_EFFECT_VAMPIRISM_TWO /datum/status_effect/vampirism/tier2

//Celerity
#define STATUS_EFFECT_CELERITY /datum/status_effect/celerity

//Ionize
#define STATUS_EFFECT_IONIZE /datum/status_effect/ionize
#define STATUS_EFFECT_IONIZE_TWO /datum/status_effect/ionize/tier2

//Crush
#define STATUS_EFFECT_CRUSH /datum/status_effect/crush

//Toxin
#define STATUS_EFFECT_TOXIN /datum/status_effect/toxin
#define STATUS_EFFECT_TOXIN_TWO /datum/status_effect/toxin/tier2

//Pheromones
#define STATUS_EFFECT_PHERO /datum/status_effect/pheromones
#define STATUS_EFFECT_PHERO_TWO /datum/status_effect/pheromones/tier2
#define STATUS_EFFECT_PHERO_THREE /datum/status_effect/pheromones/tier3

//Trail
#define STATUS_EFFECT_TRAIL /datum/status_effect/trail

#define STATUS_EFFECT_GUN_SKILL_ACCURACY_BUFF /datum/status_effect/stacking/gun_skill/accuracy/buff // Increases the accuracy of the mob
#define STATUS_EFFECT_GUN_SKILL_SCATTER_BUFF /datum/status_effect/stacking/gun_skill/scatter/buff // Increases the scatter of the mob
#define STATUS_EFFECT_XENO_ESSENCE_LINK /datum/status_effect/stacking/essence_link
#define STATUS_EFFECT_XENO_SALVE_REGEN /datum/status_effect/salve_regen
#define STATUS_EFFECT_XENO_ENHANCEMENT /datum/status_effect/drone_enhancement
#define STATUS_EFFECT_XENO_REJUVENATE /datum/status_effect/xeno_rejuvenate
#define STATUS_EFFECT_XENO_PSYCHIC_LINK /datum/status_effect/xeno_psychic_link
#define STATUS_EFFECT_XENO_CARNAGE /datum/status_effect/xeno_carnage
#define STATUS_EFFECT_XENO_FEAST /datum/status_effect/xeno_feast
#define STATUS_EFFECT_XENO_BATONPASS /datum/status_effect/baton_pass
#define STATUS_EFFECT_RESIN_JELLY_COATING /datum/status_effect/resin_jelly_coating
#define STATUS_EFFECT_PLASMA_SURGE /datum/status_effect/plasma_surge
#define STATUS_EFFECT_HEALING_INFUSION /datum/status_effect/healing_infusion
#define STATUS_EFFECT_DRAIN_SURGE /datum/status_effect/drain_surge

// Bull mutations
#define STATUS_EFFECT_BULL_UNSTOPPABLE /datum/status_effect/bull_unstoppable
#define STATUS_EFFECT_BULL_SPEED_DEMON /datum/status_effect/bull_speed_demon
#define STATUS_EFFECT_BULL_RAILGUN /datum/status_effect/bull_railgun

// Behemoth mutations
#define STATUS_EFFECT_BEHEMOTH_ROCKY_LAYERS /datum/status_effect/behemoth_rocky_layers
#define STATUS_EFFECT_BEHEMOTH_REFINED_PALATE /datum/status_effect/behemoth_refined_palate
#define STATUS_EFFECT_BEHEMOTH_AVALANCHE /datum/status_effect/behemoth_avalanche

// Boiler mutations
#define STATUS_EFFECT_BOILER_STAGGERED_PANIC /datum/status_effect/boiler_staggered_panic
#define STATUS_EFFECT_BOILER_THICK_CONTAINMENT /datum/status_effect/boiler_thick_containment
#define STATUS_EFFECT_BOILER_DIM_CONTAINMENT /datum/status_effect/boiler_dim_containment
#define STATUS_EFFECT_BOILER_GASEOUS_SPRAY /datum/status_effect/boiler_gaseous_spray
#define STATUS_EFFECT_BOILER_HIP_FIRE /datum/status_effect/boiler_hip_fire
#define STATUS_EFFECT_BOILER_RAPID_FIRE /datum/status_effect/boiler_rapid_fire
#define STATUS_EFFECT_BOILER_ACID_TRAIL /datum/status_effect/boiler_acid_trail
#define STATUS_EFFECT_BOILER_CHEMICAL_MIXING /datum/status_effect/boiler_chemical_mixing
#define STATUS_EFFECT_BOILER_BINOCULARS /datum/status_effect/boiler_binoculars

// Carrier mutations
#define STATUS_EFFECT_CARRIER_SHARED_JELLY /datum/status_effect/carrier_shared_jelly
#define STATUS_EFFECT_CARRIER_HUGGER_OVERFLOW /datum/status_effect/carrier_hugger_overflow
#define STATUS_EFFECT_CARRIER_RECURRING_PANIC /datum/status_effect/carrier_recurring_panic
#define STATUS_EFFECT_CARRIER_LEAPFROG /datum/status_effect/carrier_leapfrog
#define STATUS_EFFECT_CARRIER_CLAW_DELIVERED /datum/status_effect/carrier_claw_delivered
#define STATUS_EFFECT_CARRIER_FAKE_HUGGERS /datum/status_effect/carrier_fake_huggers
#define STATUS_EFFECT_CARRIER_OVIPOSITION /datum/status_effect/carrier_oviposition
#define STATUS_EFFECT_CARRIER_LIFE_FOR_LIFE /datum/status_effect/carrier_life_for_life
#define STATUS_EFFECT_CARRIER_SWARM_TRAP /datum/status_effect/carrier_swarm_trap

// Crusher mutations
#define STATUS_EFFECT_CRUSHER_TOUGH_ROCK /datum/status_effect/crusher_tough_rock
#define STATUS_EFFECT_CRUSHER_HEAVY_IMPACT /datum/status_effect/crusher_heavy_impact
#define STATUS_EFFECT_CRUSHER_RAMPAGE /datum/status_effect/crusher_rampage
#define STATUS_EFFECT_CRUSHER_BERSERKER /datum/status_effect/crusher_berserker
#define STATUS_EFFECT_CRUSHER_DEVASTATING_CHARGE /datum/status_effect/crusher_devastating_charge
#define STATUS_EFFECT_CRUSHER_EARTH_SHAKER /datum/status_effect/crusher_earth_shaker

// Queen mutations
#define STATUS_EFFECT_QUEEN_HEALTHY_BULWARK /datum/status_effect/queen_healthy_bulwark
#define STATUS_EFFECT_QUEEN_ROYAL_GUARD /datum/status_effect/queen_royal_guard
#define STATUS_EFFECT_QUEEN_ENHANCED_PHEROMONES /datum/status_effect/queen_enhanced_pheromones
#define STATUS_EFFECT_QUEEN_PSYCHIC_DOMINANCE /datum/status_effect/queen_psychic_dominance
#define STATUS_EFFECT_QUEEN_HIVE_MIND /datum/status_effect/queen_hive_mind
#define STATUS_EFFECT_QUEEN_ROYAL_DECREE /datum/status_effect/queen_royal_decree

// Defender mutations
#define STATUS_EFFECT_DEFENDER_CARAPACE_WAXING /datum/status_effect/defender_carapace_waxing
#define STATUS_EFFECT_DEFENDER_BRITTLE_UPCLOSE /datum/status_effect/defender_brittle_upclose
#define STATUS_EFFECT_DEFENDER_ADAPTIVE_ARMOR /datum/status_effect/defender_adaptive_armor
#define STATUS_EFFECT_DEFENDER_SHIELD_BASH /datum/status_effect/defender_shield_bash
#define STATUS_EFFECT_DEFENDER_COUNTER_STRIKE /datum/status_effect/defender_counter_strike
#define STATUS_EFFECT_DEFENDER_GUARDIAN_AURA /datum/status_effect/defender_guardian_aura
#define STATUS_EFFECT_DEFENDER_IMPREGNABLE_FORTRESS /datum/status_effect/defender_impregnable_fortress

// Drone mutations
#define STATUS_EFFECT_DRONE_SCOUT /datum/status_effect/drone_scout
#define STATUS_EFFECT_DRONE_CONSTRUCTION_MASTER /datum/status_effect/drone_construction_master
#define STATUS_EFFECT_DRONE_WEAVER /datum/status_effect/drone_weaver
#define STATUS_EFFECT_DRONE_ESSENCE_LINK /datum/status_effect/drone_essence_link
#define STATUS_EFFECT_DRONE_ENHANCED_HEALING /datum/status_effect/drone_enhanced_healing
#define STATUS_EFFECT_DRONE_HIVE_ARCHITECT /datum/status_effect/drone_hive_architect
#define STATUS_EFFECT_DRONE_PLASMA_SIPHON /datum/status_effect/drone_plasma_siphon

// Hunter mutations
#define STATUS_EFFECT_HUNTER_FLEETING_MIRAGE /datum/status_effect/hunter_fleeting_mirage
#define STATUS_EFFECT_HUNTER_SHADOW_STEP /datum/status_effect/hunter_shadow_step
#define STATUS_EFFECT_HUNTER_PREDATOR_INSTINCTS /datum/status_effect/hunter_predator_instincts
#define STATUS_EFFECT_HUNTER_BLOODLUST /datum/status_effect/hunter_bloodlust
#define STATUS_EFFECT_HUNTER_STEALTH_MASTER /datum/status_effect/hunter_stealth_master
#define STATUS_EFFECT_HUNTER_GHOST_STRIKE /datum/status_effect/hunter_ghost_strike
#define STATUS_EFFECT_HUNTER_PHASE_SHIFT /datum/status_effect/hunter_phase_shift

// Ravager mutations
#define STATUS_EFFECT_RAVAGER_LITTLE_MORE /datum/status_effect/ravager_little_more
#define STATUS_EFFECT_RAVAGER_BERSERKER_RAGE /datum/status_effect/ravager_berserker_rage
#define STATUS_EFFECT_RAVAGER_DEEP_SLASH /datum/status_effect/ravager_deep_slash
#define STATUS_EFFECT_RAVAGER_FRENZY /datum/status_effect/ravager_frenzy
#define STATUS_EFFECT_RAVAGER_BLOOD_FRENZY /datum/status_effect/ravager_blood_frenzy
#define STATUS_EFFECT_RAVAGER_DEVASTATING_BLOW /datum/status_effect/ravager_devastating_blow
#define STATUS_EFFECT_RAVAGER_UNSTOPPABLE_FORCE /datum/status_effect/ravager_unstoppable_force

// Runner mutations
#define STATUS_EFFECT_RUNNER_UPFRONT_EVASION /datum/status_effect/runner_upfront_evasion
#define STATUS_EFFECT_RUNNER_BORROWED_TIME /datum/status_effect/runner_borrowed_time
#define STATUS_EFFECT_RUNNER_INGRAINED_EVASION /datum/status_effect/runner_ingrained_evasion
#define STATUS_EFFECT_RUNNER_LIGHTNING_REFLEXES /datum/status_effect/runner_lightning_reflexes
#define STATUS_EFFECT_RUNNER_SWIFT_STRIKE /datum/status_effect/runner_swift_strike
#define STATUS_EFFECT_RUNNER_ADRENALINE_RUSH /datum/status_effect/runner_adrenaline_rush
#define STATUS_EFFECT_RUNNER_PHASE_DASH /datum/status_effect/runner_phase_dash
#define STATUS_EFFECT_RUNNER_BLUR /datum/status_effect/runner_blur

// Sentinel mutations
#define STATUS_EFFECT_SENTINEL_COMFORTING_ACID /datum/status_effect/sentinel_comforting_acid
#define STATUS_EFFECT_SENTINEL_HEALING_STING /datum/status_effect/sentinel_healing_sting
#define STATUS_EFFECT_SENTINEL_TOXIC_IMMUNITY /datum/status_effect/sentinel_toxic_immunity
#define STATUS_EFFECT_SENTINEL_VENOMOUS_STRIKE /datum/status_effect/sentinel_venomous_strike
#define STATUS_EFFECT_SENTINEL_ACID_SPRAY /datum/status_effect/sentinel_acid_spray
#define STATUS_EFFECT_SENTINEL_POISON_MASTER /datum/status_effect/sentinel_poison_master
#define STATUS_EFFECT_SENTINEL_TOXIC_AURA /datum/status_effect/sentinel_toxic_aura
#define STATUS_EFFECT_SENTINEL_PLAGUE_BEARER /datum/status_effect/sentinel_plague_bearer

// Spitter mutations
#define STATUS_EFFECT_SPITTER_ACID_SWEAT /datum/status_effect/spitter_acid_sweat
#define STATUS_EFFECT_SPITTER_CORROSIVE_ARMOR /datum/status_effect/spitter_corrosive_armor
#define STATUS_EFFECT_SPITTER_ACID_RESISTANCE /datum/status_effect/spitter_acid_resistance
#define STATUS_EFFECT_SPITTER_RAPID_FIRE /datum/status_effect/spitter_rapid_fire
#define STATUS_EFFECT_SPITTER_ACID_SPLASH /datum/status_effect/spitter_acid_splash
#define STATUS_EFFECT_SPITTER_CORROSIVE_SPIT /datum/status_effect/spitter_corrosive_spit
#define STATUS_EFFECT_SPITTER_ACID_RAIN /datum/status_effect/spitter_acid_rain
#define STATUS_EFFECT_SPITTER_PLASMA_SIPHON /datum/status_effect/spitter_plasma_siphon

// Warrior mutations
#define STATUS_EFFECT_WARRIOR_ZOOMIES /datum/status_effect/warrior_zoomies
#define STATUS_EFFECT_WARRIOR_BERSERKER_RAGE /datum/status_effect/warrior_berserker_rage
#define STATUS_EFFECT_WARRIOR_UNBREAKABLE /datum/status_effect/warrior_unbreakable
#define STATUS_EFFECT_WARRIOR_ENHANCED_STRENGTH /datum/status_effect/warrior_enhanced_strength
#define STATUS_EFFECT_WARRIOR_DEVASTATING_BLOW /datum/status_effect/warrior_devastating_blow
#define STATUS_EFFECT_WARRIOR_BLOOD_FRENZY /datum/status_effect/warrior_blood_frenzy
#define STATUS_EFFECT_WARRIOR_GUARDIAN_INSTINCTS /datum/status_effect/warrior_guardian_instincts
#define STATUS_EFFECT_WARRIOR_UNSTOPPABLE_FORCE /datum/status_effect/warrior_unstoppable_force

// Widow mutations
#define STATUS_EFFECT_WIDOW_HIVE_TOUGHNESS /datum/status_effect/widow_hive_toughness
#define STATUS_EFFECT_WIDOW_WEB_MASTER /datum/status_effect/widow_web_master
#define STATUS_EFFECT_WIDOW_SPIDER_SENSE /datum/status_effect/widow_spider_sense
#define STATUS_EFFECT_WIDOW_VENOMOUS_BITE /datum/status_effect/widow_venomous_bite
#define STATUS_EFFECT_WIDOW_WEB_TRAP /datum/status_effect/widow_web_trap
#define STATUS_EFFECT_WIDOW_SWARM_COMMANDER /datum/status_effect/widow_swarm_commander
#define STATUS_EFFECT_WIDOW_ARACHNOPHOBIA /datum/status_effect/widow_arachnophobia
#define STATUS_EFFECT_WIDOW_HIVE_MIND /datum/status_effect/widow_hive_mind

// Defiler mutations
#define STATUS_EFFECT_DEFILER_PANIC_GAS /datum/status_effect/defiler_panic_gas
#define STATUS_EFFECT_DEFILER_TOXIC_IMMUNITY /datum/status_effect/defiler_toxic_immunity
#define STATUS_EFFECT_DEFILER_GAS_MASTER /datum/status_effect/defiler_gas_master
#define STATUS_EFFECT_DEFILER_VENOMOUS_STRIKE /datum/status_effect/defiler_venomous_strike
#define STATUS_EFFECT_DEFILER_POISON_MASTER /datum/status_effect/defiler_poison_master
#define STATUS_EFFECT_DEFILER_TOXIC_AURA /datum/status_effect/defiler_toxic_aura
#define STATUS_EFFECT_DEFILER_PLAGUE_BEARER /datum/status_effect/defiler_plague_bearer
#define STATUS_EFFECT_DEFILER_HIVE_POISONER /datum/status_effect/defiler_hive_poisoner

// Gorger mutations
#define STATUS_EFFECT_GORGER_UNMOVING_LINK /datum/status_effect/gorger_unmoving_link
#define STATUS_EFFECT_GORGER_ENHANCED_ABSORPTION /datum/status_effect/gorger_enhanced_absorption
#define STATUS_EFFECT_GORGER_PSYCHIC_SHIELD /datum/status_effect/gorger_psychic_shield
#define STATUS_EFFECT_GORGER_PSYCHIC_DRAIN /datum/status_effect/gorger_psychic_drain
#define STATUS_EFFECT_GORGER_MIND_CONTROL /datum/status_effect/gorger_mind_control
#define STATUS_EFFECT_GORGER_PSYCHIC_EXPLOSION /datum/status_effect/gorger_psychic_explosion
#define STATUS_EFFECT_GORGER_HIVE_LINK /datum/status_effect/gorger_hive_link
#define STATUS_EFFECT_GORGER_PSYCHIC_DOMINANCE /datum/status_effect/gorger_psychic_dominance

// Hivelord mutations
#define STATUS_EFFECT_HIVELORD_HARDENED_TRAVEL /datum/status_effect/hivelord_hardened_travel
#define STATUS_EFFECT_HIVELORD_COSTLY_TRAVEL /datum/status_effect/hivelord_costly_travel
#define STATUS_EFFECT_HIVELORD_CONSTRUCTION_MASTER /datum/status_effect/hivelord_construction_master
#define STATUS_EFFECT_HIVELORD_WEAVER /datum/status_effect/hivelord_weaver
#define STATUS_EFFECT_HIVELORD_RESIN_MASTER /datum/status_effect/hivelord_resin_master
#define STATUS_EFFECT_HIVELORD_HIVE_ARCHITECT /datum/status_effect/hivelord_hive_architect
#define STATUS_EFFECT_HIVELORD_PLASMA_SIPHON /datum/status_effect/hivelord_plasma_siphon
#define STATUS_EFFECT_HIVELORD_HIVE_MIND /datum/status_effect/hivelord_hive_mind

// King mutations
#define STATUS_EFFECT_KING_STONE_ARMOR /datum/status_effect/king_stone_armor
#define STATUS_EFFECT_KING_ROYAL_GUARD /datum/status_effect/king_royal_guard
#define STATUS_EFFECT_KING_ENHANCED_PHEROMONES /datum/status_effect/king_enhanced_pheromones
#define STATUS_EFFECT_KING_MINION_KING /datum/status_effect/king_minion_king
#define STATUS_EFFECT_KING_PSYCHIC_DOMINANCE /datum/status_effect/king_psychic_dominance
#define STATUS_EFFECT_KING_ROYAL_DECREE /datum/status_effect/king_royal_decree
#define STATUS_EFFECT_KING_HIVE_MIND /datum/status_effect/king_hive_mind
#define STATUS_EFFECT_KING_PSYCHIC_OVERLORD /datum/status_effect/king_psychic_overlord

// Praetorian mutations
#define STATUS_EFFECT_PRAETORIAN_ADAPTIVE_ARMOR /datum/status_effect/praetorian_adaptive_armor
#define STATUS_EFFECT_PRAETORIAN_ENHANCED_REGENERATION /datum/status_effect/praetorian_enhanced_regeneration
#define STATUS_EFFECT_PRAETORIAN_ROYAL_GUARD /datum/status_effect/praetorian_royal_guard
#define STATUS_EFFECT_PRAETORIAN_ENHANCED_STRENGTH /datum/status_effect/praetorian_enhanced_strength
#define STATUS_EFFECT_PRAETORIAN_PSYCHIC_DOMINANCE /datum/status_effect/praetorian_psychic_dominance
#define STATUS_EFFECT_PRAETORIAN_ROYAL_DECREE /datum/status_effect/praetorian_royal_decree
#define STATUS_EFFECT_PRAETORIAN_HIVE_MIND /datum/status_effect/praetorian_hive_mind
#define STATUS_EFFECT_PRAETORIAN_PSYCHIC_OVERLORD /datum/status_effect/praetorian_psychic_overlord

// Shrike mutations
#define STATUS_EFFECT_SHRIKE_LONE_HEALER /datum/status_effect/shrike_lone_healer
#define STATUS_EFFECT_SHRIKE_SHARED_CURE /datum/status_effect/shrike_shared_cure
#define STATUS_EFFECT_SHRIKE_ENHANCED_HEALING /datum/status_effect/shrike_enhanced_healing
#define STATUS_EFFECT_SHRIKE_PSYCHIC_DOMINANCE /datum/status_effect/shrike_psychic_dominance
#define STATUS_EFFECT_SHRIKE_ROYAL_DECREE /datum/status_effect/shrike_royal_decree
#define STATUS_EFFECT_SHRIKE_HIVE_MIND /datum/status_effect/shrike_hive_mind
#define STATUS_EFFECT_SHRIKE_PSYCHIC_OVERLORD /datum/status_effect/shrike_psychic_overlord
#define STATUS_EFFECT_SHRIKE_DIVINE_INTERVENTION /datum/status_effect/shrike_divine_intervention

// Warlock mutations
#define STATUS_EFFECT_WARLOCK_CAUTIOUS_MIND /datum/status_effect/warlock_cautious_mind
#define STATUS_EFFECT_WARLOCK_ENHANCED_SHIELD /datum/status_effect/warlock_enhanced_shield
#define STATUS_EFFECT_WARLOCK_PSYCHIC_IMMUNITY /datum/status_effect/warlock_psychic_immunity
#define STATUS_EFFECT_WARLOCK_DRAINING_BLAST /datum/status_effect/warlock_draining_blast
#define STATUS_EFFECT_WARLOCK_PSYCHIC_DOMINANCE /datum/status_effect/warlock_psychic_dominance
#define STATUS_EFFECT_WARLOCK_MIND_CONTROL /datum/status_effect/warlock_mind_control
#define STATUS_EFFECT_WARLOCK_PSYCHIC_OVERLORD /datum/status_effect/warlock_psychic_overlord
#define STATUS_EFFECT_WARLOCK_REALITY_WARPER /datum/status_effect/warlock_reality_warper

#define STATUS_EFFECT_MINDMEND /datum/status_effect/mindmeld

#define STATUS_EFFECT_REKNIT_FORM /datum/status_effect/reknit_form

/////////////
// DEBUFFS //
/////////////

#define STATUS_EFFECT_STAGGER /datum/status_effect/incapacitating/stagger //reduces human gun damage or impairs xeno ability use

#define STATUS_EFFECT_STUN /datum/status_effect/incapacitating/stun //the affected is unable to move or use items

#define STATUS_EFFECT_KNOCKDOWN /datum/status_effect/incapacitating/knockdown //the affected is unable to stand up

#define STATUS_EFFECT_IMMOBILIZED /datum/status_effect/incapacitating/immobilized //the affected is unable to move

#define STATUS_EFFECT_PARALYZED /datum/status_effect/incapacitating/paralyzed //the affected is unable to move, use items, or stand up.

#define STATUS_EFFECT_UNCONSCIOUS /datum/status_effect/incapacitating/unconscious //the affected is unconscious

#define STATUS_EFFECT_SLEEPING /datum/status_effect/incapacitating/sleeping //the affected is asleep

#define STATUS_EFFECT_ADMINSLEEP /datum/status_effect/incapacitating/adminsleep //the affected is admin slept

#define STATUS_EFFECT_CONFUSED /datum/status_effect/incapacitating/confused // random direction chosen when trying to move

#define STATUS_EFFECT_GUN_SKILL_ACCURACY_DEBUFF /datum/status_effect/gun_skill/accuracy/debuff // Decreases the accuracy of the mob

#define STATUS_EFFECT_GUN_SKILL_SCATTER_DEBUFF /datum/status_effect/gun_skill/scatter/debuff // Decreases the scatter of the mob

#define STATUS_EFFECT_MUTED /datum/status_effect/mute //Mutes the affected mob

#define STATUS_EFFECT_IRRADIATED /datum/status_effect/incapacitating/irradiated //the affected has been irradiated, harming them over time

#define STATUS_EFFECT_INTOXICATED /datum/status_effect/stacking/intoxicated //Damage over time

#define STATUS_EFFECT_DANCER_TAGGED /datum/status_effect/incapacitating/dancer_tagged //Additional damage/effects by Praetorian Dancer's abilities

#define STATUS_EFFECT_REPAIR_MODE /datum/status_effect/incapacitating/repair_mode //affected is blinded and stunned, but heals over time
///damage and sunder over time
#define STATUS_EFFECT_MELTING /datum/status_effect/stacking/melting
#define STATUS_EFFECT_MELTING_FIRE /datum/status_effect/stacking/melting_fire
///damage over time
#define STATUS_EFFECT_MICROWAVE /datum/status_effect/stacking/microwave
///armor reduction
#define STATUS_EFFECT_SHATTER /datum/status_effect/shatter
//widow's ability
#define STATUS_EFFECT_SPIDER_VENOM /datum/status_effect/incapacitating/spider_venom

/////////////
// NEUTRAL //
/////////////

// none for now

// Stasis helpers

#define IS_IN_STASIS(mob) (mob.has_status_effect(STATUS_EFFECT_STASIS))
