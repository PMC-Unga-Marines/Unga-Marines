/datum/keybinding/yautja
	category = CATEGORY_YAUTJA
	weight = WEIGHT_MOB


/datum/keybinding/yautja/mark_hunt
	name = "mark_hunt"
	full_name = "Mark For Hunt"
	description = "Mark a target for the hunt."
	keybind_signal = COMSIG_PRED_MARK_HUNT

/datum/keybinding/yautja/mark_panel
	name = "mark_panel"
	full_name = "Mark Panel"
	description = "Allows you to mark your prey."
	keybind_signal = COMSIG_PRED_MARK_PANEL

/datum/keybinding/yautja/zoom
	name = "pred_zoom"
	full_name = "Toggle Mask Zoom"
	description = "Toggle your mask's zoom function."
	keybind_signal = COMSIG_PRED_ZOOM

/datum/keybinding/yautja/togglesight
	name = "pred_togglesight"
	full_name = "Toggle Mask Visors"
	description = "Toggle your mask visor sights. You must only be wearing a type of Yautja visor for this to work."
	keybind_signal = COMSIG_PRED_TOGGLESIGHT

/datum/keybinding/yautja/combistick
	name = "pred_combistick"
	full_name = "Yank combi-stick"
	description = "Yank on your combi-stick's chain, if it's in range. Otherwise... recover it yourself."
	keybind_signal = COMSIG_PRED_COMBISTICK

/datum/keybinding/yautja/smart_disc
	name = "pred_smart_disc"
	full_name = "Call Smart-Disc"
	description = "Call back your smart-disc, if it's in range. If not you'll have to go retrieve it."
	keybind_signal = COMSIG_PRED_SMART_DISC

/datum/keybinding/yautja/translator
	name = "pred_translator"
	full_name = "Translator"
	description = "Emit a message from your bracer to those nearby."
	keybind_signal = COMSIG_PRED_TRANSLATOR

/datum/keybinding/yautja/crystal
	name = "pred_crystal"
	full_name = "Create Stabilising Crystal"
	description = "Create a focus crystal to energize your natural healing processes."
	keybind_signal = COMSIG_PRED_CRYSTAL

/datum/keybinding/yautja/wristblades
	name = "pred_wristblades"
	full_name = "Use Wrist Blades"
	description = "Extend your wrist blades. They cannot be dropped, but can be retracted."
	keybind_signal = COMSIG_PRED_WRISTBLADES

/datum/keybinding/yautja/caster
	name = "pred_caster"
	full_name = "Use Plasma Caster"
	description = "Activate your plasma caster. If it is dropped it will retract back into your armor."
	keybind_signal = COMSIG_PRED_CASTER

/datum/keybinding/yautja/cloack
	name = "pred_cloack"
	full_name = "Toggle Cloaking Device"
	description = "Activate your suit's cloaking device. It will malfunction if the suit takes damage or gets excessively wet."
	keybind_signal = COMSIG_PRED_CLOACK

/datum/keybinding/yautja/sd
	name = "pred_sd"
	full_name = "Final Countdown (!)"
	description = "Activate the explosive device implanted into your bracers. You have failed! Show some honor!"
	keybind_signal = COMSIG_PRED_SD

/datum/keybinding/yautja/sd_mode
	name = "pred_sd_mode"
	full_name = "Change Explosion Type"
	description = "Changes your bracer explosion to either only gib you or be a big explosion."
	keybind_signal = COMSIG_PRED_SD_MODE
