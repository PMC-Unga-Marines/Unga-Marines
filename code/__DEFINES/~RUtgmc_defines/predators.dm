#define PREDATOR_TO_TOTAL_SPAWN_RATIO 1/20

#define INIT_ORDER_PREDSHIPS  -22

// Yautja Access Levels
/// Requires a visible ID chip to open
#define ACCESS_YAUTJA_SECURE 250
/// Elders+ only
#define ACCESS_YAUTJA_ELDER 251
/// Ancients only
#define ACCESS_YAUTJA_ANCIENT 252

#define ACCESSORY_SLOT_ARMOR_C "chest_armor"

#define ACCESSORY_SLOT_ARMOR_A "arm_armor"
#define ACCESSORY_SLOT_ARMOR_L "leg_armor"
#define ACCESSORY_SLOT_ARMOR_S "armor_storage"
#define ACCESSORY_SLOT_ARMOR_M "misc_armor"

#define ACCESSORY_SLOT_ARMOR_Y_C "chest_bones"
#define ACCESSORY_SLOT_ARMOR_Y_S "spine_bones"
#define ACCESSORY_SLOT_ARMOR_Y_H "head_bones"
#define ACCESSORY_SLOT_ARMOR_Y_RL "right_leg_bones"
#define ACCESSORY_SLOT_ARMOR_Y_LL "left_leg_bones"
#define ACCESSORY_SLOT_ARMOR_Y_RH "right_hand_bones"
#define ACCESSORY_SLOT_ARMOR_Y_LH "left_hand_bones"

#define FACTION_YAUTJA "Yautja"
#define XENO_HIVE_FORSAKEN "forsaken_hive"
#define XENO_HIVE_YAUTJA "yautja_hive"

#define JOB_PREDATOR "Predator"

#define CATEGORY_YAUTJA "YAUTJA"
#define HUNTERSHIPS_TEMPLATE_PATH "_maps/~RUTGMC/predship/huntership.dmm"

#define DUMMY_PRED_SLOT_PREFERENCES "dummy_preference_preview_second"

#define PRED_MATERIALS list("ebony", "silver", "bronze", "crimson", "bone")
#define PRED_TRANSLATORS list("Modern", "Retro", "Combo")
#define PRED_LEGACIES list("None", "Dragon", "Swamp", "Enforcer", "Collector")
#define PRED_SKIN_COLOR list("Tan", "Green", "Purple", "Blue", "Red", "Black")

#define PRED_YAUTJA_CAPE "yautja cape"
#define PRED_YAUTJA_CEREMONIAL_CAPE "yautja ceremonial cape"
#define PRED_YAUTJA_THIRD_CAPE "yautja third-cape"
#define PRED_YAUTJA_HALF_CAPE "yautja half-cape"
#define PRED_YAUTJA_QUARTER_CAPE "yautja quarter-cape"
#define PRED_YAUTJA_PONCHO "yautja poncho"

#define SD_TYPE_BIG   0
#define SD_TYPE_SMALL 1

///Sound volume defines
#define BLOCK_SOUND_VOLUME 70
#define CLAN_PERMISSION_USER_VIEW 1

/// Modify ranks within clan
#define CLAN_PERMISSION_USER_MODIFY 2

#define CLAN_PERMISSION_USER_ALL (CLAN_PERMISSION_USER_MODIFY|CLAN_PERMISSION_USER_VIEW)

/// View all clans
#define CLAN_PERMISSION_ADMIN_VIEW 4
/// Modify all clans
#define CLAN_PERMISSION_ADMIN_MODIFY 8
/// Move people to and from clans
#define CLAN_PERMISSION_ADMIN_MOVE  16
/// Manages the ancients
#define CLAN_PERMISSION_ADMIN_MANAGER 32

#define CLAN_PERMISSION_ADMIN_ANCIENT (CLAN_PERMISSION_ADMIN_VIEW|CLAN_PERMISSION_ADMIN_MODIFY|CLAN_PERMISSION_ADMIN_MOVE)
#define CLAN_PERMISSION_ADMIN_ALL (CLAN_PERMISSION_ADMIN_ANCIENT|CLAN_PERMISSION_ADMIN_MANAGER)

#define CLAN_PERMISSION_MODIFY (CLAN_PERMISSION_ADMIN_MODIFY|CLAN_PERMISSION_USER_MODIFY)
#define CLAN_PERMISSION_VIEW (CLAN_PERMISSION_USER_VIEW|CLAN_PERMISSION_ADMIN_VIEW)

#define CLAN_PERMISSION_ALL (CLAN_PERMISSION_USER_ALL|CLAN_PERMISSION_ADMIN_ALL)

/// Unused for the moment
#define CLAN_RANK_UNBLOODED "Unblooded"
/// Clanless
#define CLAN_RANK_YOUNG "Young Blood"
/// New to the clan
#define CLAN_RANK_BLOODED "Blooded"

#define CLAN_RANK_ELITE "Elite"
#define CLAN_RANK_ELDER "Elder"
#define CLAN_RANK_LEADER "Clan Leader"

/// Must be given by someone with CLAN_PERMISSION_ADMIN_MODIFY
#define CLAN_RANK_ADMIN "Ancient"

#define CLAN_RANK_UNBLOODED_INT 1
#define CLAN_RANK_YOUNG_INT 2
#define CLAN_RANK_BLOODED_INT 3
#define CLAN_RANK_ELITE_INT 4
#define CLAN_RANK_ELDER_INT 5
#define CLAN_RANK_LEADER_INT 6
#define CLAN_RANK_ADMIN_INT 7

/// Hard limit
#define CLAN_LIMIT_NUMBER 1
/// Scales with clan size
#define CLAN_LIMIT_SIZE 2

GLOBAL_LIST_INIT_TYPED(clan_ranks, /datum/yautja_rank, list(
	CLAN_RANK_UNBLOODED = new /datum/yautja_rank/unblooded(),
	CLAN_RANK_YOUNG = new /datum/yautja_rank/young(),
	CLAN_RANK_BLOODED = new /datum/yautja_rank/blooded(),
	CLAN_RANK_ELITE = new /datum/yautja_rank/elite(),
	CLAN_RANK_ELDER = new /datum/yautja_rank/elder(),
	CLAN_RANK_LEADER = new /datum/yautja_rank/leader(),
	CLAN_RANK_ADMIN = new /datum/yautja_rank/ancient()
))

GLOBAL_LIST_INIT(clan_ranks_ordered, list(
	CLAN_RANK_UNBLOODED = CLAN_RANK_UNBLOODED_INT,
	CLAN_RANK_YOUNG = CLAN_RANK_YOUNG_INT,
	CLAN_RANK_BLOODED = CLAN_RANK_BLOODED_INT,
	CLAN_RANK_ELITE = CLAN_RANK_ELITE_INT,
	CLAN_RANK_ELDER = CLAN_RANK_ELDER_INT,
	CLAN_RANK_LEADER = CLAN_RANK_LEADER_INT,
	CLAN_RANK_ADMIN = CLAN_RANK_ADMIN_INT
))

#define CLAN_HREF "clan_href"
#define CLAN_TARGET_HREF "clan_target_href"

#define CLAN_ACTION "clan_action"

/// Set name of clan
#define CLAN_ACTION_CLAN_RENAME "rename"
/// Set description of clan
#define CLAN_ACTION_CLAN_SETDESC "setdesc"
/// Set honor of clan
#define CLAN_ACTION_CLAN_SETHONOR "sethonor"

#define CLAN_ACTION_CLAN_DELETE "delete"
#define CLAN_ACTION_CLAN_SETCOLOR "setcolor"

/// Set a player's clan
#define CLAN_ACTION_PLAYER_MOVECLAN "moveclan"
/// Set a player's rank. Resets when moved from clan to Young Blood
#define CLAN_ACTION_PLAYER_MODIFYRANK "modifyrank"

#define CLAN_ACTION_PLAYER_PURGE "purge"

#define NO_CLAN_LIST list(\
			clan_id = null,\
			clan_name = "Clanless",\
			clan_description = "This is a list of players without a clan",\
			clan_honor = null,\
			clan_keys = list(),\
			\
			player_delete_clan = FALSE,\
			player_sethonor_clan = FALSE,\
			player_rename_clan = FALSE,\
			player_setdesc_clan = FALSE,\
			player_modify_ranks = FALSE,\
			\
			player_move_clans = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MOVE)\
		)

#define CLAN_SHIP_PUBLIC -1
