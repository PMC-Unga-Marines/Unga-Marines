#define SUIT_AUTODOC_DAM_MIN 20
#define SUIT_AUTODOC_DAM_MAX 300
#define COOLDOWN_CHEM_BURN "chem_burn"
#define COOLDOWN_CHEM_OXY "oxy_chems"
#define COOLDOWN_CHEM_BRUTE "brute_chems"
#define COOLDOWN_CHEM_TOX "tox_chems"
#define COOLDOWN_CHEM_PAIN "pain_chems"

/**
	Autodoc component

	The autodoc is an item component that can be eqiupped to inject the wearer with chemicals.

	Parameters
	* chem_cooldown {time} default time between injections of chemicals
	* list/burn_chems {list/datum/reagent/medicine} chemicals available to be injected to treat burn injuries
	* list/oxy_chems {list/datum/reagent/medicine} chemicals available to be injected to treat oxygen injuries
	* list/brute_chems {list/datum/reagent/medicine} chemicals available to be injected to treat brute injuries
	* list/tox_chems {list/datum/reagent/medicine} chemicals available to be injected to treat toxin injuries
	* list/pain_chems {list/datum/reagent/medicine} chemicals available to be injected to treat pain injuries
	* overdose_threshold_mod {float} how close to overdosing will drugs inject to

*/
/datum/component/suit_autodoc
	var/obj/item/healthanalyzer/integrated/analyzer

	var/chem_cooldown = 2.5 MINUTES

	var/enabled = FALSE

	var/damage_threshold = 50
	var/pain_threshold = 70

	var/list/burn_chems
	var/list/oxy_chems
	var/list/brute_chems
	var/list/tox_chems
	var/list/pain_chems

	var/static/list/default_burn_chems = list(
		/datum/reagent/medicine/kelotane,
		/datum/reagent/medicine/tricordrazine)
	var/static/list/default_oxy_chems = list(
		/datum/reagent/medicine/dexalinplus,
		/datum/reagent/medicine/inaprovaline,
		/datum/reagent/medicine/tricordrazine)
	var/static/list/default_brute_chems = list(
		/datum/reagent/medicine/bicaridine,
		/datum/reagent/medicine/quickclot,
		/datum/reagent/medicine/tricordrazine)
	var/static/list/default_tox_chems = list(
		/datum/reagent/medicine/dylovene,
		/datum/reagent/medicine/spaceacillin,
		/datum/reagent/medicine/tricordrazine)
	var/static/list/default_pain_chems = list(
		/datum/reagent/medicine/hydrocodone,
		/datum/reagent/medicine/tramadol)

	var/datum/action/suit_autodoc/toggle/toggle_action
	var/datum/action/suit_autodoc/scan/scan_action
	var/datum/action/suit_autodoc/configure/configure_action

	var/mob/living/carbon/wearer

	var/overdose_threshold_mod = 0.5

/**
	Setup the default cooldown, chemicals and supported limbs
*/
/datum/component/suit_autodoc/Initialize(chem_cooldown, list/brute_chems, list/burn_chems, list/tox_chems, list/oxy_chems, list/pain_chems, overdose_threshold_mod)
	if(!istype(parent, /obj/item))
		return COMPONENT_INCOMPATIBLE

	analyzer = new
	if(!isnull(chem_cooldown))
		src.chem_cooldown = chem_cooldown

	src.brute_chems = brute_chems || default_brute_chems
	src.burn_chems = burn_chems || default_burn_chems
	src.tox_chems = tox_chems || default_tox_chems
	src.oxy_chems = oxy_chems || default_oxy_chems
	src.pain_chems = pain_chems || default_pain_chems

	if(!isnull(overdose_threshold_mod))
		src.overdose_threshold_mod = overdose_threshold_mod

/**
	Cleans up any actions, and internal items used by the autodoc component
*/
/datum/component/suit_autodoc/Destroy(force, silent)
	QDEL_NULL(analyzer)
	QDEL_NULL(toggle_action)
	QDEL_NULL(scan_action)
	QDEL_NULL(configure_action)
	wearer = null
	return ..()

/**
	Registers signals to enable/disable the autodoc when equipped/dropper/etc
*/
/datum/component/suit_autodoc/RegisterWithParent()
	. = ..()
	toggle_action = new(parent)
	scan_action = new(parent)
	configure_action = new(parent)
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignals(parent, list(COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT, COMSIG_ITEM_DROPPED), PROC_REF(dropped))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(equipped))
	RegisterSignal(toggle_action, COMSIG_ACTION_TRIGGER, PROC_REF(action_toggle))
	RegisterSignal(scan_action, COMSIG_ACTION_TRIGGER, PROC_REF(scan_user))
	RegisterSignal(configure_action, COMSIG_ACTION_TRIGGER, PROC_REF(configure))

/**
	Remove signals
*/
/datum/component/suit_autodoc/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_EXAMINE,
		COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT,
		COMSIG_ITEM_DROPPED,
		COMSIG_ITEM_EQUIPPED_TO_SLOT))
	QDEL_NULL(toggle_action)
	QDEL_NULL(scan_action)
	QDEL_NULL(configure_action)

/**
	Hook into the examine of the parent to show additional information about the suit_autodoc
*/
/datum/component/suit_autodoc/proc/examine(datum/source, mob/user, list/details)
	SIGNAL_HANDLER
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_CHEM_BURN))
		details += "Its burn treatment injector is currently refilling.</br>"

	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_CHEM_BRUTE))
		details += "Its trauma treatment injector is currently refilling.</br>"

	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_CHEM_OXY))
		details += "Its oxygenating injector is currently refilling.</br>"

	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_CHEM_TOX))
		details += "Its anti-toxin injector is currently refilling.</br>"

	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_CHEM_PAIN))
		details += "Its painkiller injector is currently refilling.</br>"

/**
	Disables the autodoc and removes actions when dropped
*/
/datum/component/suit_autodoc/proc/dropped(datum/source, mob/user)
	SIGNAL_HANDLER
	if(!iscarbon(user))
		return
	remove_actions()
	disable()
	wearer = null

/**
	Enable the autodoc and give appropriate actions
*/
/datum/component/suit_autodoc/proc/equipped(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if(!iscarbon(equipper)) // living can equip stuff but only carbon has traumatic shock
		return
	wearer = equipper
	enable()
	give_actions()

/**
	Disables to stop processing and calls to the signals from the user.

	Additionally removes limb support if applicable
*/
/datum/component/suit_autodoc/proc/disable(silent = FALSE)
	if(!enabled)
		return
	enabled = FALSE
	toggle_action.set_toggle(FALSE)
	UnregisterSignal(wearer, COMSIG_HUMAN_DAMAGE_TAKEN)
	STOP_PROCESSING(SSobj, src)
	if(!silent)
		wearer.balloon_alert(wearer, "Automedical suite deactivates")
		playsound(parent,'sound/voice/b18/deactivate.ogg', 15, 0, 1)

/**
	Enable processing and calls out to register signals from the user.

	Additionally adds limb support if applicable
*/
/datum/component/suit_autodoc/proc/enable(silent = FALSE)
	if(enabled)
		return
	enabled = TRUE
	toggle_action.set_toggle(TRUE)
	RegisterSignal(wearer, COMSIG_HUMAN_DAMAGE_TAKEN, PROC_REF(damage_taken))
	START_PROCESSING(SSobj, src)
	if(!silent)
		wearer.balloon_alert(wearer, "Automedical suite activates")
		playsound(parent,'sound/voice/b18/activate.ogg', 15, 0, 1)

/**
	Proc for the damange taken signal, calls treat_injuries
*/
/datum/component/suit_autodoc/proc/damage_taken(datum/source, mob/living/carbon/human/wearer, damage)
	SIGNAL_HANDLER
	treat_injuries()

/**
	Process proc called periodically, calls treat_injuries
*/
/datum/component/suit_autodoc/process()
	treat_injuries()

/**
	Handles actually injecting specific checmicals for specific damage types.

	This proc checks the damage is over the appropraite threshold, the cooldowns and if succesful injects
	chemicals into the user and sets the cooldown again
*/
/datum/component/suit_autodoc/proc/inject_chems(list/chems, mob/living/carbon/human/H, cooldown_type, damage, threshold, treatment_message, message_prefix)
	if(!length(chems) || TIMER_COOLDOWN_CHECK(src, cooldown_type) || damage < threshold)
		return

	var/drugs

	for(var/chem in chems)
		var/datum/reagent/R = chem
		var/stomach_reagents = 0
		var/datum/internal_organ/stomach/belly = H.get_organ_slot(ORGAN_SLOT_STOMACH)
		if(belly)
			stomach_reagents = belly.reagents.get_reagent_amount(R)
		var/amount_to_administer = clamp(\
			initial(R.overdose_threshold) - (H.reagents.get_reagent_amount(R) + stomach_reagents),\
			0,\
			initial(R.overdose_threshold) * overdose_threshold_mod)
		if(amount_to_administer)
			H.reagents.add_reagent(R, amount_to_administer)
			drugs += " [initial(R.name)]: [amount_to_administer]U"

	if(LAZYLEN(drugs))
		. = "[message_prefix] administered. [span_bold("Dosage:[drugs]")]<br/>"
		TIMER_COOLDOWN_START(src, cooldown_type, chem_cooldown)
		addtimer(CALLBACK(src, PROC_REF(nextuse_ready), treatment_message), chem_cooldown)

/**
	Trys to inject each chmical into the user.

	Calls each proc and then reports the results if any to the user.
	additionally trys to support any limbs if required
*/
/datum/component/suit_autodoc/proc/treat_injuries()
	if(!wearer)
		CRASH("attempting to treat_injuries with no wearer")

	var/burns = inject_chems(burn_chems, wearer, COOLDOWN_CHEM_BURN, wearer.get_fire_loss(), damage_threshold, "Burn treatment", "Significant tissue burns detected. Restorative injection")
	var/brute = inject_chems(brute_chems, wearer, COOLDOWN_CHEM_BRUTE, wearer.get_brute_loss(), damage_threshold, "Trauma treatment", "Significant tissue bruises detected. Restorative injection")
	var/oxy = inject_chems(oxy_chems, wearer, COOLDOWN_CHEM_OXY, wearer.get_oxy_loss(), damage_threshold, "Oxygenation treatment", "Low blood oxygen detected. Reoxygenating preparation")
	var/tox = inject_chems(tox_chems, wearer, COOLDOWN_CHEM_TOX, wearer.get_tox_loss(), damage_threshold, "Toxicity treatment", "Significant blood toxicity detected. Chelating agents and curatives")
	var/pain = inject_chems(pain_chems, wearer, COOLDOWN_CHEM_PAIN, wearer.painloss, pain_threshold, "Painkiller", "User pain at performance impeding levels. Painkillers")

	if(burns || brute || oxy || tox || pain)
		playsound(parent,'sound/items/hypospray.ogg', 25, 0, 1)
		to_chat(wearer, span_notice("[icon2html(parent, wearer)] beeps:</br>[burns][brute][oxy][tox][pain]Estimated [chem_cooldown/600] minute replenishment time for each dosage."))

/**
	Plays a sound and message to the user informing the user chemicals are ready again
*/
/datum/component/suit_autodoc/proc/nextuse_ready(message)

	var/obj/item/I = parent // guarenteed by Initialize()

	playsound(I,'sound/effects/refill.ogg', 25, 0, 1)

	var/mob/living/carbon/human/H = I.loc // uncertain
	if(!istype(H))
		return

	to_chat(H, span_notice("[I] beeps: [message] reservoir replenished."))

/**
	Add the actions to the user

	Actions include
	- Enable and disable the suit
	- Manually do a health scan
	- Open suit settings
*/
/datum/component/suit_autodoc/proc/give_actions()
	toggle_action.give_action(wearer)
	scan_action.give_action(wearer)
	configure_action.give_action(wearer)

/**
	Remove the actions from the user

	Actions include
	- Enable and disable the suit
	- Manually do a health scan
	- Open suit settings
*/
/datum/component/suit_autodoc/proc/remove_actions()
	if(!wearer)
		return
	toggle_action.remove_action(wearer)
	scan_action.remove_action(wearer)
	configure_action.remove_action(wearer)

/**
	Toggle the suit

	This will enable or disable the suit
*/
/datum/component/suit_autodoc/proc/action_toggle(datum/source)
	SIGNAL_HANDLER
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_TOGGLE))
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_TOGGLE, 2 SECONDS)
	if(enabled)
		disable()
	else
		enable()

/**
	Proc to handle the internal analyzer scanning the user
*/
/datum/component/suit_autodoc/proc/scan_user(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(analyzer, TYPE_PROC_REF(/obj/item, attack), wearer, wearer, TRUE)

/**
	Proc to show the suit configuration page
*/
/datum/component/suit_autodoc/proc/configure(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(interact), wearer)

/**
	Shows the suit configuration
*/
/datum/component/suit_autodoc/interact(mob/user)
	var/dat = {"
	<A href='byond://?src=[REF(src)];automed_on=1'>Turn Automed System: [enabled ? "Off" : "On"]</A><BR>
	<BR>
	<B>Integrated Health Analyzer:</B><BR>
	<A href='byond://?src=[REF(src)];analyzer=1'>Scan Wearer</A><BR>
	<BR>
	<B>Damage Trigger Threshold (Max [SUIT_AUTODOC_DAM_MAX], Min [SUIT_AUTODOC_DAM_MIN]):</B><BR>
	<A href='byond://?src=[REF(src)];automed_damage=-100'>-100</A><BR>
	<A href='byond://?src=[REF(src)];automed_damage=-50'>-50</A>
	<A href='byond://?src=[REF(src)];automed_damage=-10'>-10</A>
	<A href='byond://?src=[REF(src)];automed_damage=-5'>-5</A>
	<A href='byond://?src=[REF(src)];automed_damage=-1'>-1</A> [damage_threshold]
	<A href='byond://?src=[REF(src)];automed_damage=1'>+1</A>
	<A href='byond://?src=[REF(src)];automed_damage=5'>+5</A>
	<A href='byond://?src=[REF(src)];automed_damage=10'>+10</A>
	<A href='byond://?src=[REF(src)];automed_damage=50'>+50</A>
	<A href='byond://?src=[REF(src)];automed_damage=100'>+100</A><BR>
	<BR>
	<B>Pain Trigger Threshold (Max [SUIT_AUTODOC_DAM_MAX], Min [SUIT_AUTODOC_DAM_MIN]):</B><BR>
	<A href='byond://?src=[REF(src)];automed_pain=-100'>-100</A><BR>
	<A href='byond://?src=[REF(src)];automed_pain=-50'>-50</A>
	<A href='byond://?src=[REF(src)];automed_pain=-10'>-10</A>
	<A href='byond://?src=[REF(src)];automed_pain=-5'>-5</A>
	<A href='byond://?src=[REF(src)];automed_pain=-1'>-1</A> [pain_threshold]
	<A href='byond://?src=[REF(src)];automed_pain=1'>+1</A>
	<A href='byond://?src=[REF(src)];automed_pain=5'>+5</A>
	<A href='byond://?src=[REF(src)];automed_pain=10'>+10</A>
	<A href='byond://?src=[REF(src)];automed_pain=50'>+50</A>
	<A href='byond://?src=[REF(src)];automed_pain=100'>+100</A><BR>"}

	var/datum/browser/popup = new(user, "Suit Automedic")
	popup.set_content(dat)
	popup.open()

/**
	If the user is able to interact with the suit

	Always TRUE
*/
/datum/component/suit_autodoc/can_interact(mob/user)
	return TRUE

/**
	Handles the topic interactions with the suit when updating configurations
*/
/datum/component/suit_autodoc/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(wearer != usr)
		return

	if(href_list["automed_on"])
		action_toggle()

	else if(href_list["analyzer"]) //Integrated scanner
		analyzer.attack(wearer, wearer, TRUE)

	else if(href_list["automed_damage"])
		damage_threshold += text2num(href_list["automed_damage"])
		damage_threshold = round(damage_threshold)
		damage_threshold = clamp(damage_threshold,SUIT_AUTODOC_DAM_MIN,SUIT_AUTODOC_DAM_MAX)
	else if(href_list["automed_pain"])
		pain_threshold += text2num(href_list["automed_pain"])
		pain_threshold = round(pain_threshold)
		pain_threshold = clamp(pain_threshold,SUIT_AUTODOC_DAM_MIN,SUIT_AUTODOC_DAM_MAX)

	interact(wearer)

//// Action buttons
/datum/action/suit_autodoc/can_use_action()
	if(QDELETED(owner) || owner.incapacitated() || owner.lying_angle)
		return FALSE
	return TRUE

/datum/action/suit_autodoc/toggle
	name = "Toggle Suit Automedic"
	action_icon_state = "suit_toggle"
	action_type = ACTION_TOGGLE

/datum/action/suit_autodoc/scan
	name = "User Medical Scan"
	action_icon_state = "suit_scan"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_KB_SUITANALYZER,
	)

/datum/action/suit_autodoc/configure
	name = "Configure Suit Automedic"
	action_icon_state = "suit_configure"

#undef SUIT_AUTODOC_DAM_MAX
#undef SUIT_AUTODOC_DAM_MIN
#undef COOLDOWN_CHEM_BURN
#undef COOLDOWN_CHEM_OXY
#undef COOLDOWN_CHEM_BRUTE
#undef COOLDOWN_CHEM_TOX
#undef COOLDOWN_CHEM_PAIN
