//
//TICKET MANAGER
//
GLOBAL_DATUM_INIT(ahelp_tickets, /datum/admin_help_tickets, new)

/datum/admin_help_tickets
	var/list/active_tickets = list()
	var/list/closed_tickets = list()
	var/list/resolved_tickets = list()

	var/obj/effect/statclick/ticket_list/astatclick = new(null, null, AHELP_ACTIVE)
	var/obj/effect/statclick/ticket_list/dstatclick = new(null, null, AHELP_ACTIVE)
	var/obj/effect/statclick/ticket_list/cstatclick = new(null, null, AHELP_CLOSED)
	var/obj/effect/statclick/ticket_list/rstatclick = new(null, null, AHELP_RESOLVED)


/datum/admin_help_tickets/Destroy()
	QDEL_LIST(active_tickets)
	QDEL_LIST(closed_tickets)
	QDEL_LIST(resolved_tickets)
	QDEL_NULL(astatclick)
	QDEL_NULL(dstatclick)
	QDEL_NULL(cstatclick)
	QDEL_NULL(rstatclick)
	return ..()


/datum/admin_help_tickets/proc/TicketByID(id)
	var/list/lists = list(active_tickets, closed_tickets, resolved_tickets)
	for(var/I in lists)
		for(var/J in I)
			var/datum/admin_help/AH = J
			if(AH.id == id)
				return J


/datum/admin_help_tickets/proc/TicketsByCKey(ckey)
	. = list()
	var/list/lists = list(active_tickets, closed_tickets, resolved_tickets)
	for(var/I in lists)
		for(var/J in I)
			var/datum/admin_help/AH = J
			if(AH.initiator_ckey == ckey)
				. += AH


//private
/datum/admin_help_tickets/proc/ListInsert(datum/admin_help/new_ticket)
	var/list/ticket_list
	switch(new_ticket.state)
		if(AHELP_ACTIVE)
			ticket_list = active_tickets
		if(AHELP_CLOSED)
			ticket_list = closed_tickets
		if(AHELP_RESOLVED)
			ticket_list = resolved_tickets
		else
			CRASH("Invalid ticket state: [new_ticket.state]")
	var/num_closed = length(ticket_list)
	if(num_closed)
		for(var/I in 1 to num_closed)
			var/datum/admin_help/AH = ticket_list[I]
			if(AH.id > new_ticket.id)
				ticket_list.Insert(I, new_ticket)
				return
	ticket_list += new_ticket


//opens the ticket listings for one of the 3 states
/datum/admin_help_tickets/proc/BrowseTickets(state)
	var/list/l2b
	var/title
	switch(state)
		if(AHELP_ACTIVE)
			l2b = active_tickets
			title = "Active Tickets"
		if(AHELP_CLOSED)
			l2b = closed_tickets
			title = "Closed Tickets"
		if(AHELP_RESOLVED)
			l2b = resolved_tickets
			title = "Resolved Tickets"
	if(!l2b)
		return
	var/dat = "<A href='byond://?_src_=holder;[HrefToken()];ahelp_tickets=[state]'>Refresh</A><br><br>"
	for(var/I in l2b)
		var/datum/admin_help/AH = I
		if(AH.tier == TICKET_MENTOR && check_rights(R_ADMINTICKET|R_MENTOR, FALSE))
			if(AH.initiator)
				dat += "[span_adminnotice("<span class='adminhelp'>\[[AH.marked ? "X" : "  "]\] #[AH.id] Mentor Ticket")]: <A href='byond://?_src_=holder;[HrefToken()];ahelp=[REF(AH)];ahelp_action=ticket'>[AH.initiator_key_name]: [AH.name]</A></span><br>"
			else
				dat += "[span_adminnotice("<span class='adminhelp'>\[D\] #[AH.id] Mentor Ticket")]: <A href='byond://?_src_=holder;[HrefToken()];ahelp=[REF(AH)];ahelp_action=ticket'>[AH.initiator_key_name]: [AH.name]</A></span><br>"
		else if(AH.tier == TICKET_ADMIN && check_rights(R_ADMINTICKET, FALSE))
			if(AH.initiator)
				dat += "[span_adminnotice("<span class='adminhelp'>\[[AH.marked ? "X" : "  "]\] #[AH.id] Admin Ticket")]: <A href='byond://?_src_=holder;[HrefToken()];ahelp=[REF(AH)];ahelp_action=ticket'>[AH.initiator_key_name]: [AH.name]</A></span><br>"
			else
				dat += "[span_adminnotice("<span class='adminhelp'>\[D\] #[AH.id] Admin Ticket")]: <A href='byond://?_src_=holder;[HrefToken()];ahelp=[REF(AH)];ahelp_action=ticket'>[AH.initiator_key_name]: [AH.name]</A></span><br>"

	var/datum/browser/browser = new(usr, "ahelp_list[state]", "<div align='center'>[title]</div>", 600, 480)
	browser.set_content(dat)
	browser.open(FALSE)


//Tickets statpanel
/datum/admin_help_tickets/proc/stat_entry(client/target)
	SHOULD_CALL_PARENT(TRUE)
	SHOULD_NOT_SLEEP(TRUE)
	var/list/L = list()
	var/num_mentors_active = 0
	var/num_admins_active = 0
	var/num_mentors_closed = 0
	var/num_admins_closed = 0
	var/num_mentors_resolved = 0
	var/num_admins_resolved = 0

	for(var/I in active_tickets)
		var/datum/admin_help/AH = I
		if(AH.tier == TICKET_MENTOR)
			num_mentors_active++
		else if(AH.tier == TICKET_ADMIN)
			num_admins_active++

	for(var/I in closed_tickets)
		var/datum/admin_help/AH = I
		if(AH.tier == TICKET_MENTOR)
			num_mentors_closed++
		else if(AH.tier == TICKET_ADMIN)
			num_admins_closed++

	for(var/I in resolved_tickets)
		var/datum/admin_help/AH = I
		if(AH.tier == TICKET_MENTOR)
			num_mentors_resolved++
		else if(AH.tier == TICKET_ADMIN)
			num_admins_resolved++

	if(check_rights_for(target, R_ADMINTICKET))
		L[++L.len] = list("Active Tickets:", "[astatclick.update("[num_mentors_active + num_admins_active]")]", null, REF(astatclick))
	else if(check_rights_for(target, R_MENTOR))
		L[++L.len] = list("Active Tickets:", "[astatclick.update("[num_mentors_active]")]", null, REF(astatclick))

	for(var/I in active_tickets)
		var/datum/admin_help/AH = I
		var/obj/effect/statclick/updated = AH.statclick.update()
		if(AH.tier == TICKET_MENTOR && check_rights_for(target, R_ADMINTICKET|R_MENTOR))
			if(AH.initiator)
				L[++L.len] = list("\[[AH.marked ? "X" : "  "]\] #[AH.id]. Mentor. [AH.initiator_key_name]:", "[updated.name]", REF(AH))
			else
				L[++L.len] = list("\[D\] #[AH.id]. Mentor. [AH.initiator_key_name]:", "[updated.name]", REF(AH))
		else if(AH.tier == TICKET_ADMIN && check_rights_for(target, R_ADMINTICKET))
			if(AH.initiator)
				L[++L.len] = list("\[[AH.marked ? "X" : "  "]\] #[AH.id]. Admin. [AH.initiator_key_name]:", "[updated.name]", REF(AH))
			else
				L[++L.len] = list("\[D\] #[AH.id]. Admin. [AH.initiator_key_name]:", "[updated.name]", REF(AH))

	if(check_rights_for(target, R_ADMINTICKET))
		L[++L.len] = list("Closed Tickets:", "[cstatclick.update("[num_mentors_closed + num_admins_closed]")]", null, REF(cstatclick))
	else if(check_rights_for(target, R_MENTOR))
		L[++L.len] = list("Closed Tickets:", "[cstatclick.update("[num_mentors_closed]")]", null, REF(cstatclick))

	if(check_rights_for(target, R_ADMINTICKET))
		L[++L.len] = list("Resolved Tickets:", "[rstatclick.update("[num_mentors_resolved + num_admins_resolved]")]", null, REF(rstatclick))
	else if(check_rights_for(target, R_MENTOR))
		L[++L.len] = list("Resolved Tickets:", "[rstatclick.update("[num_mentors_resolved]")]", null, REF(rstatclick))

	return L


//Reassociate still open ticket if one exists
/datum/admin_help_tickets/proc/ClientLogin(client/C)
	C.current_ticket = CKey2ActiveTicket(C.ckey)
	if(C.current_ticket)
		C.current_ticket.initiator = C
		C.current_ticket.AddInteraction("Client reconnected.")


//Dissasociate ticket
/datum/admin_help_tickets/proc/ClientLogout(client/C)
	if(C.current_ticket)
		C.current_ticket.AddInteraction("Client disconnected.")
		C.current_ticket.initiator = null
		C.current_ticket = null


//Get a ticket given a ckey
/datum/admin_help_tickets/proc/CKey2ActiveTicket(ckey)
	for(var/I in active_tickets)
		var/datum/admin_help/AH = I
		if(AH.initiator_ckey == ckey)
			return AH


//
//TICKET LIST STATCLICK
//

/obj/effect/statclick/ticket_list
	var/current_state

/obj/effect/statclick/ticket_list/Initialize(mapload, name, state)
	. = ..()
	current_state = state

/obj/effect/statclick/ticket_list/Click()
	if (!usr.client?.holder)
		message_admins("[key_name_admin(usr)] non-holder clicked on a ticket list statclick! ([src])")
		usr.log_message("non-holder clicked on a ticket list statclick! ([src])", LOG_ADMIN)
		return

	GLOB.ahelp_tickets.BrowseTickets(current_state)

//called by admin topic
/obj/effect/statclick/ticket_list/proc/Action()
	Click()


//
//TICKET DATUM
//

/datum/admin_help
	var/id
	var/name
	var/state = AHELP_ACTIVE

	var/opened_at
	var/closed_at

	var/client/initiator	//the person who ahelped/was bwoinked
	var/initiator_ckey
	var/initiator_key_name
	var/heard_by_no_admins = FALSE

	var/marked = FALSE
	var/tier

	var/list/_interactions	//use AddInteraction() or, preferably, admin_ticket_log()

	var/obj/effect/statclick/ahelp/statclick

	var/tier_cooldown

	var/static/ticket_counter = 0

//call this on its own to create a ticket, don't manually assign current_ticket
//msg is the title of the ticket: usually the ahelp text
//is_bwoink is TRUE if this ticket was started by an admin PM
/datum/admin_help/New(msg_raw, client/C, is_bwoink, tickettier)
	//clean the input msg
	var/msg = sanitize(copytext_char(msg_raw, 1, MAX_MESSAGE_LEN))
	if(!msg || !C || !C.mob)
		qdel(src)
		return

	id = ++ticket_counter
	opened_at = world.time

	name = msg

	tier = tickettier

	initiator = C
	initiator_ckey = initiator.ckey
	initiator_key_name = key_name(initiator, FALSE, TRUE)
	if(initiator.current_ticket)	//This is a bug
		stack_trace("Multiple ahelp current_tickets.")
		initiator.current_ticket.AddInteraction("Ticket erroneously left open by code.")
		initiator.current_ticket.Close(TRUE, TRUE)
	initiator.current_ticket = src

	statclick = new(null, src)
	_interactions = list()

	if(is_bwoink)
		AddInteraction("<font color='#a7f2ef'>[key_name_admin(usr)] PM'd [LinkedReplyName()]</font>")
		if(tier == TICKET_MENTOR)
			message_staff("Ticket [TicketHref("#[id]")] created.")
		else if(tier == TICKET_ADMIN)
			message_admins("Ticket [TicketHref("#[id]")] created.")
		marked = usr.client.key
	else
		MessageNoRecipient(msg_raw)

		//send it to TGS if nobody is on and tell us how many were on
		var/ticket_type = (tier == TICKET_ADMIN) ? "Admin" : "Mentor"
		var/admin_number_present = send2tgs_adminless_only(initiator_ckey, "[ticket_type] Ticket #[id]: [sanitizediscord(name)]")
		log_admin_private("Ticket #[id]: [key_name(initiator)]: [name] - heard by [admin_number_present] non-AFK staff.")
		if(admin_number_present <= 0)
			to_chat(C, span_notice("No active admins are online, your adminhelp was sent through TGS to admins who are available. This may use IRC or Discord."))
			heard_by_no_admins = TRUE

	GLOB.ahelp_tickets.active_tickets += src


/datum/admin_help/Destroy()
	RemoveActive()
	GLOB.ahelp_tickets.closed_tickets -= src
	GLOB.ahelp_tickets.resolved_tickets -= src
	return ..()


/datum/admin_help/proc/AddInteraction(formatted_message)
	if(heard_by_no_admins && usr && usr.ckey != initiator_ckey)
		heard_by_no_admins = FALSE
		send2adminchat(initiator_ckey, "Ticket #[id]: Answered by [key_name(usr)]")
	_interactions += "[stationTimestamp()]: [formatted_message]"

//private
/datum/admin_help/proc/FullMonty(ref_src)
	if(!ref_src)
		ref_src = "[REF(src)]"
	. = ADMIN_FULLMONTY_NONAME(initiator.mob)
	if(CONFIG_GET(flag/popup_admin_pm))
		. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];adminpopup=[REF(initiator)]'>POPUP</A>)"

//private
/datum/admin_help/proc/HalfMonty(ref_src)
	if(!ref_src)
		ref_src = "[REF(src)]"
	. = "[ADMIN_JMP(initiator.mob)] [ADMIN_FLW(initiator.mob)] [ADMIN_SM(initiator.mob)]"


//private
/datum/admin_help/proc/ClosureLinks(ref_src)
	if(!ref_src)
		ref_src = "[REF(src)]"
	. = " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=mark'>MARK</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=reject'>REJECT</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=icissue'>IC</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=close'>CLOSE</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=resolve'>RESOLVE</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=tier'>TIER</A>)"


//private
/datum/admin_help/proc/ClosureLinksMentor(ref_src)
	if(!ref_src)
		ref_src = "[REF(src)]"
	. = " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=mark'>MARK</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=close'>CLOSE</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=resolve'>RESOLVE</A>)"
	. += " (<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=tier'>TIER</A>)"


//private
/datum/admin_help/proc/LinkedReplyName(ref_src)
	if(!ref_src)
		ref_src = "[REF(src)]"
	return "<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=reply'>[initiator_key_name]</A>"


//private
/datum/admin_help/proc/TicketHref(msg, ref_src, action = "ticket")
	if(!ref_src)
		ref_src = "[REF(src)]"
	return "<A href='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=[action]'>[msg]</A>"


//message from the initiator without a target, all admins will see this
//won't bug irc/discord
/datum/admin_help/proc/MessageNoRecipient(msg)
	msg = sanitize(copytext_char(msg, 1, MAX_MESSAGE_LEN))
	var/ref_src = "[REF(src)]"
	//message to be sent to all admins


	AddInteraction("<font color='#ff8c8c'>[LinkedReplyName(ref_src)]: [msg]</font>")
	log_admin_private("Ticket #[id]: [key_name(initiator)]: [msg]")

	//Send this to the relevant people
	for(var/client/X in GLOB.admins)
		var/admin_msg = span_adminnotice("[span_adminhelp("Admin Ticket [TicketHref("#[id]", ref_src)]")]<b>: [LinkedReplyName(ref_src)] [FullMonty(ref_src)]:</b> [span_linkify("[keywords_lookup(msg)]")]")
		var/mentor_msg = span_adminnotice("[span_adminhelp("Mentor Ticket [TicketHref("#[id]", ref_src)]")]<b>: [LinkedReplyName(ref_src)] [check_other_rights(X, R_ADMINTICKET, FALSE) ? FullMonty(ref_src) : HalfMonty(ref_src)] [check_other_rights(X, R_ADMINTICKET, FALSE) ? ClosureLinks(ref_src) : ClosureLinksMentor(ref_src)]:</b> [span_linkify("[keywords_lookup(msg)]")]")
		if(tier == TICKET_MENTOR && check_other_rights(X, R_ADMINTICKET|R_MENTOR, FALSE))
			if(X.prefs.toggles_sound & SOUND_ADMINHELP)
				SEND_SOUND(X, sound('sound/effects/mentorhelp.ogg', channel = CHANNEL_ADMIN))
			window_flash(X)
			to_chat(X,
				type = MESSAGE_TYPE_ADMINPM,
				html = mentor_msg)
		if(tier == TICKET_ADMIN && check_other_rights(X, R_ADMINTICKET, FALSE))
			if(X.prefs.toggles_sound & SOUND_ADMINHELP)
				SEND_SOUND(X, sound('sound/effects/adminhelp.ogg', channel = CHANNEL_ADMIN))
			window_flash(X)
			to_chat(X,
				type = MESSAGE_TYPE_ADMINPM,
				html = admin_msg)

	//show it to the person adminhelping too
	to_chat(initiator,
		type = MESSAGE_TYPE_ADMINPM,
		html = span_adminnotice("PM to-<b>[tier == TICKET_ADMIN ? "Admins" : "Mentors"]</b>: [span_linkify("[msg]")]"))

//Reopen a closed ticket
/datum/admin_help/proc/Reopen(irc)
	if(!irc && tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	if(state == AHELP_ACTIVE)
		to_chat(usr, span_warning("This ticket is already open."))
		return
	var/ref
	if(irc)
		ref = key_name_admin(usr)
	else
		ref = ADMIN_TPMONTY(usr)

	if(GLOB.ahelp_tickets.CKey2ActiveTicket(initiator_ckey))
		to_chat(usr, span_warning("This user already has an active ticket, cannot reopen this one."))
		return

	statclick = new(null, src)
	GLOB.ahelp_tickets.active_tickets += src
	GLOB.ahelp_tickets.closed_tickets -= src
	GLOB.ahelp_tickets.resolved_tickets -= src
	state = AHELP_ACTIVE
	closed_at = null
	if(initiator)
		initiator.current_ticket = src

	if(tier == TICKET_MENTOR)
		message_staff("Ticket [TicketHref("#[id]")] has been made reopened by [ref].")
	else if(tier == TICKET_ADMIN)
		message_admins("Ticket [TicketHref("#[id]")] has been made reopened by [ref].")

	AddInteraction("<font color='#cea7f1'>Reopened by [key_name_admin(usr)]</font>")
	log_admin_private("Ticket (#[id]) reopened by [key_name(usr)].")
	to_chat(initiator, span_adminhelp("Your ticket has been reopened."))
	TicketPanel()	//can only be done from here, so refresh it


//Change the tier
/datum/admin_help/proc/Tier(irc)
	if(tier_cooldown > world.time)
		to_chat(usr, span_warning("Please wait a moment before changing the tier."))
		return
	if(!irc && tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	var/ref
	if(irc)
		ref = key_name_admin(usr)
	else
		ref = ADMIN_TPMONTY(usr)
	var/msg
	if(tier == TICKET_MENTOR)
		tier = TICKET_ADMIN
		msg = "an admin ticket"
		AddInteraction("<font color='#ff8c8c'>Made admin ticket by: [key_name_admin(usr)].</font>")
		message_admins("Ticket [TicketHref("#[id]")] has been made [msg] by [ref].")
		to_chat(initiator, span_adminhelp("Your ticket has been tiered to an adminhelp."))
	else if(tier == TICKET_ADMIN)
		tier = TICKET_MENTOR
		msg = "a mentor ticket"
		AddInteraction("<font color='#ff8c8c'>Made mentor ticket by: [key_name_admin(usr)].</font>")
		message_staff("Ticket [TicketHref("#[id]")] has been made [msg] by [ref].")
		to_chat(initiator, span_adminhelp("Your ticket has been tiered to a mentorhelp."))
		if(!irc)
			for(var/client/X in GLOB.admins)
				if(!is_mentor(X))
					continue
				if(X.prefs.toggles_sound & SOUND_ADMINHELP)
					SEND_SOUND(X, sound('sound/effects/adminhelp.ogg', channel = CHANNEL_ADMIN))
				window_flash(X)
	tier_cooldown = world.time + 5 SECONDS
	log_admin_private("Ticket (#[id]) has been made [msg] by [key_name(usr)].")


//Mark it
/datum/admin_help/proc/Mark()
	if(state != AHELP_ACTIVE)
		return
	if(tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	if(marked)
		if(marked == usr.client.key)
			if(alert("Do you want to unmark this ticket?", "Confirmation", "Yes", "No") != "Yes")
				return
			marked = null
			if(tier == TICKET_MENTOR)
				message_staff("Ticket [TicketHref("#[id]")] has been unmarked by [ADMIN_TPMONTY(usr)].")
			else if(tier == TICKET_ADMIN)
				message_admins("Ticket [TicketHref("#[id]")] has been unmarked by [ADMIN_TPMONTY(usr)].")
			log_admin_private("Ticket (#[id]) has been unmarked by [key_name(usr)].")
			to_chat(initiator, span_adminhelp("Your ticket has been unmarked."))
			return
		else if(alert("This ticket has already been marked by [marked], do you want to replace them?", "Confirmation", "Yes", "No") != "Yes")
			return
		if(tier == TICKET_MENTOR)
			message_staff("Ticket [TicketHref("#[id]")] has been re-marked by [ADMIN_TPMONTY(usr)].")
		else if(tier == TICKET_ADMIN)
			message_admins("Ticket [TicketHref("#[id]")] has been re-marked by [ADMIN_TPMONTY(usr)].")
		marked = usr.client.key
		log_admin_private("Ticket (#[id]) has been re-marked by [key_name(usr)].")
		to_chat(initiator, span_adminhelp("Your ticket has been marked by another admin."))
		return
	marked = usr.client.key
	if(tier == TICKET_MENTOR)
		message_staff("Ticket [TicketHref("#[id]")] has been marked by [ADMIN_TPMONTY(usr)].")
	else if(tier == TICKET_ADMIN)
		message_admins("Ticket [TicketHref("#[id]")] has been marked by [ADMIN_TPMONTY(usr)].")
	log_admin_private("Ticket (#[id]) has been marked by [key_name(usr)].")
	to_chat(initiator, span_adminhelp("Your ticket has been marked by an admin."))


//private
/datum/admin_help/proc/RemoveActive()
	if(state != AHELP_ACTIVE)
		return
	closed_at = world.time
	QDEL_NULL(statclick)
	GLOB.ahelp_tickets.active_tickets -= src
	if(initiator?.current_ticket == src)
		initiator.current_ticket = null
	SEND_SIGNAL(src, COMSIG_ADMIN_HELP_MADE_INACTIVE)

//Mark open ticket as closed/meme
/datum/admin_help/proc/Close(silent, irc)
	if(!irc && tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	if(state != AHELP_ACTIVE)
		return
	var/ref
	if(irc)
		ref = key_name_admin(usr)
	else
		ref = ADMIN_TPMONTY(usr)
	RemoveActive()
	state = AHELP_CLOSED
	GLOB.ahelp_tickets.ListInsert(src)
	AddInteraction("<font color='#ff8c8c'>Closed by [key_name_admin(usr)].</font>")
	if(!silent)
		log_admin_private("Ticket (#[id]) closed by [key_name(usr)].")
		to_chat(initiator, span_adminhelp("Your ticket has been closed."))
		if(tier == TICKET_MENTOR)
			message_staff("Ticket [TicketHref("#[id]")] closed by [ref].")
		else if(tier == TICKET_ADMIN)
			message_admins("Ticket [TicketHref("#[id]")] closed by [ref].")


//Mark open ticket as resolved/legitimate, returns ahelp verb
/datum/admin_help/proc/Resolve(silent, irc)
	if(!irc && tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	if(state != AHELP_ACTIVE)
		return

	var/ref
	if(irc)
		ref = key_name_admin(usr)
	else
		ref = ADMIN_TPMONTY(usr)

	RemoveActive()
	state = AHELP_RESOLVED
	GLOB.ahelp_tickets.ListInsert(src)

	AddInteraction("<font color='#9adb92'>Resolved by [key_name_admin(usr)].</font>")
	if(tier == TICKET_MENTOR)
		to_chat(initiator, span_adminhelp("Your mentor ticket has been resolved, if you need to ask something again, feel free to send another one."))
	else if(tier == TICKET_ADMIN)
		to_chat(initiator, span_adminhelp("Your ticket has been resolved by an admin. The Adminhelp verb will be returned to you shortly."))
		addtimer(CALLBACK(initiator, TYPE_PROC_REF(/client, giveadminhelpverb)), 50)
	if(!silent)
		log_admin_private("Ticket (#[id]) resolved by [key_name(usr)].")
		if(tier == TICKET_MENTOR)
			message_staff("Ticket [TicketHref("#[id]")] resolved by [ref].")
		else if(tier == TICKET_ADMIN)
			message_admins("Ticket [TicketHref("#[id]")] resolved by [ref].")


//Close and return ahelp verb, use if ticket is incoherent
/datum/admin_help/proc/Reject(irc)
	if(!irc && tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	if(state != AHELP_ACTIVE)
		return

	var/ref
	if(irc)
		ref = key_name_admin(usr)
	else
		ref = ADMIN_TPMONTY(usr)

	if(initiator)
		initiator.giveadminhelpverb()

		SEND_SOUND(initiator, sound('sound/effects/adminhelp.ogg', channel = CHANNEL_ADMIN))
		if(tier == TICKET_MENTOR)
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red' size='2'><b>- Mentorhelp Rejected! -</b></font>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "Your issue may have been non-sensical. Please try describing it more in detail.")
		else if(tier == TICKET_ADMIN)
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red' size='4'><b>- Adminhelp Rejected! -</b></font>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red'><b>Your admin help was rejected.</b> The adminhelp verb has been returned to you so that you may try again.</font>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "Please try to be calm, clear, and descriptive in admin helps, do not assume the admin has seen any related events, and clearly state the names of anybody you are reporting.")

	message_admins("Ticket [TicketHref("#[id]")] rejected by [ref].")
	log_admin_private("Ticket (#[id]) rejected by [key_name(usr)].")
	AddInteraction("Rejected by [key_name_admin(usr)].")
	Close(TRUE, irc)


//Resolve ticket with IC Issue message
/datum/admin_help/proc/ICIssue(irc)
	if(!irc && tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return

	if(state != AHELP_ACTIVE)
		return

	var/ref
	if(irc)
		ref = key_name_admin(usr)
	else
		ref = ADMIN_TPMONTY(usr)

	if(initiator)
		if(tier == TICKET_MENTOR)
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red' size='4'><b>- Mentorhelp marked as IC! -</b></font><br>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red'>You most likely asked about important in-game information the staff cannot reveal.</font>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red'>Feel free to ask again, but remember that information critical to the round won't be revealed.</font>")
		else if(tier == TICKET_ADMIN)
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red' size='4'><b>- Adminhelp marked as IC! -</b></font><br>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red'>Whatever your query was, you will have to find out using IC mean, the staff won't reveal anything relevant.</font>")
			to_chat(initiator,
				type = MESSAGE_TYPE_ADMINPM,
				html = "<font color='red'>Your issue has been determined by an administrator to be in-character and does not require their intervention at this time, nor may they solve it without out-of-character intrusion into the round. You should find out a solution to the problem in the game, according to the rules.</font>")

	message_admins("Ticket [TicketHref("#[id]")] marked as IC by [ref].")
	log_admin_private("Ticket (#[id]) marked as IC by [key_name(usr)].")
	AddInteraction("Marked as IC issue by [key_name_admin(usr)]")
	Resolve(TRUE, irc)


//Show the ticket panel
/datum/admin_help/proc/TicketPanel()
	if(!check_rights(R_ADMINTICKET, FALSE) && !is_mentor(usr.client))
		return

	if(tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		var/datum/browser/browser = new(usr, "ahelp[id]", "<div align='center'>Access Denied</div>", 620, 480)
		browser.set_content("Access Denied")
		browser.open(FALSE)

	var/dat
	var/ref_src = "[REF(src)]"
	dat += "<h4><font color='white'>[tier == TICKET_MENTOR ? "Mentor" : "Admin"] Ticket #[id]:</font> [LinkedReplyName(ref_src)]</h4>"
	dat += "<b>State: "
	switch(state)
		if(AHELP_ACTIVE)
			dat += "<font color='#ff8c8c'>OPEN</font>"
		if(AHELP_RESOLVED)
			dat += "<font color='#9adb92'>RESOLVED</font>"
		if(AHELP_CLOSED)
			dat += "CLOSED"
		else
			dat += "UNKNOWN"
	if(marked)
		dat += " <font color='#ff8c8c'>MARKED BY [marked]</font> "
	else
		dat += " UNMARKED "
	dat += "</b>\t[TicketHref("Refresh", ref_src)]\t[TicketHref("Re-Title", ref_src, "retitle")]"
	if(state != AHELP_ACTIVE)
		dat += "\t[TicketHref("Reopen", ref_src, "reopen")]"
	dat += "<br><br>Opened at: [stationTimestamp(wtime = opened_at)] (Approx [DisplayTimeText(world.time - opened_at)] ago)"
	if(closed_at)
		dat += "<br>Closed at: [stationTimestamp(wtime = closed_at)] (Approx [DisplayTimeText(world.time - closed_at)] ago)"
	dat += "<br>Current time: [stationTimestamp()]"
	dat += "<br><br>"
	if(initiator)
		if(check_rights(R_ADMINTICKET, FALSE))
			dat += "<b>Actions:</b> [FullMonty(ref_src)] [ADMIN_IF(initiator.mob)]<br>[ClosureLinks(ref_src)]<br>"
		else if(check_rights(R_MENTOR, FALSE))
			dat += "<b>Actions:</b> [HalfMonty(ref_src)] [ADMIN_IF(initiator.mob)]<br>[ClosureLinksMentor(ref_src)]<br>"
	else
		if(check_rights(R_ADMINTICKET, FALSE))
			dat += "<b>DISCONNECTED</b>\t[ClosureLinks(ref_src)]<br>"
		else if(check_rights(R_MENTOR, FALSE))
			dat += "<b>DISCONNECTED</b>\t[ClosureLinksMentor(ref_src)]<br>"
	dat += "<br><b>Log:</b><br><br>"
	for(var/I in _interactions)
		dat += "[I]<br>"

	var/datum/browser/browser = new(usr, "ahelp[id]", "<div align='center'>Ticket #[id]</div>", 620, 480)
	browser.set_content(dat)
	browser.open(FALSE)


/datum/admin_help/proc/Retitle()
	if(tier == TICKET_ADMIN && !check_rights(R_ADMINTICKET, FALSE))
		return
	var/new_title = input(usr, "Enter a title for the ticket", "Rename Ticket", name) as text|null
	if(new_title)
		name = new_title
		if(tier == TICKET_MENTOR)
			message_staff("Ticket [TicketHref("#[id]")] titled [name] by [ADMIN_TPMONTY(usr)].")
		else if(tier == TICKET_ADMIN)
			message_admins("Ticket [TicketHref("#[id]")] titled [name] by [ADMIN_TPMONTY(usr)].")
		//not saying the original name cause it could be a long ass message
		log_admin_private("Ticket (#[id]) titled [name] by [key_name(usr)].")
	TicketPanel()	//we have to be here to do this


//Forwarded action from admin/Topic
/datum/admin_help/proc/Action(action)
	switch(action)
		if("ticket")
			TicketPanel()
		if("retitle")
			Retitle()
		if("reject")
			Reject()
		if("reply")
			usr.client.ticket_reply(initiator)
		if("icissue")
			ICIssue()
		if("close")
			Close()
		if("resolve")
			Resolve()
		if("reopen")
			Reopen()
		if("tier")
			Tier()
		if("mark")
			Mark()


//
// TICKET STATCLICK
//

/obj/effect/statclick/ahelp
	var/datum/admin_help/ahelp_datum


/obj/effect/statclick/ahelp/Initialize(mapload, datum/admin_help/AH)
	ahelp_datum = AH
	. = ..()


/obj/effect/statclick/ahelp/update()
	return ..(ahelp_datum.name)


/obj/effect/statclick/ahelp/Click()
	ahelp_datum?.TicketPanel()


/obj/effect/statclick/ahelp/Destroy()
	ahelp_datum = null
	return ..()


//
// CLIENT PROCS
//

/client/proc/giveadminhelpverb()
	add_verb(src, /client/verb/adminhelp)
	deltimer(adminhelptimerid)
	adminhelptimerid = 0


// Used for methods where input via arg doesn't work
/client/proc/get_adminhelp()
	var/msg = input(src, "Please describe your problem concisely and an admin will help as soon as they're able.", "Adminhelp contents") as text
	adminhelp(msg)


/client/verb/adminhelp(msg as message)
	set category = "Admin"
	set name = "Adminhelp"

	//handle muting and automuting
	if(prefs.muted & MUTE_ADMINHELP || is_banned_from(ckey, "Adminhelp"))
		to_chat(src, span_warning("Error: You cannot send adminhelps (Muted)."))
		return

	if(handle_spam_prevention(msg, MUTE_ADMINHELP))
		return

	msg = trim(msg)

	if(!msg)
		return

	if(current_ticket)
		if(alert(usr, "You already have a ticket open. Is this for the same issue?",,"Yes","No") != "No")
			if(current_ticket)
				current_ticket.MessageNoRecipient(msg)
				return
			else
				to_chat(usr, span_warning("Ticket not found, creating new one..."))
		else
			current_ticket.AddInteraction("[key_name_admin(usr)] opened a new ticket.")
			current_ticket.Close(TRUE, TRUE)

	new /datum/admin_help(msg, src, FALSE, TICKET_ADMIN)


/client/verb/mentorhelp(msg as message)
	set category = "Admin"
	set name = "Mentorhelp"

	//handle muting and automuting
	if(prefs.muted & MUTE_ADMINHELP || is_banned_from(ckey, "Adminhelp"))
		to_chat(src, span_warning("Error: You cannot send mentorhelps (Muted)."))
		return

	if(handle_spam_prevention(msg, MUTE_ADMINHELP))
		return

	msg = trim(msg)

	if(!msg)
		return

	if(current_ticket)
		if(alert(usr, "You already have a ticket open. Is this for the same issue?",,"Yes","No") != "No")
			if(current_ticket)
				current_ticket.MessageNoRecipient(msg)
				return
			else
				to_chat(usr, span_warning("Ticket not found, creating new one..."))
		else
			current_ticket.AddInteraction("[key_name_admin(usr)] opened a new ticket.")
			current_ticket.Close(TRUE, TRUE)

	new /datum/admin_help(msg, src, FALSE, TICKET_MENTOR)


/client/verb/choosehelp()
	set category = null
	set name = "choosehelp"

	var/message = input("What do you need help with? Please describe your issue in detail.", "Request Help") as null|message
	if(!message)
		return

	switch(input("Who do you want to contact?", "Request Help") as null|anything in list("Mentors", "Admins"))
		if("Mentors")
			mentorhelp(message)
		if("Admins")
			adminhelp(message)


//
// LOGGING
//

//Use this proc when an admin takes action that may be related to an open ticket on what
//what can be a client, ckey, or mob
/proc/admin_ticket_log(what, message)
	var/client/C
	var/mob/Mob = what
	if(istype(Mob))
		C = Mob.client
	else
		C = what
	if(istype(C) && C.current_ticket)
		C.current_ticket.AddInteraction(message)
		return C.current_ticket
	if(istext(what))	//ckey
		var/datum/admin_help/AH = GLOB.ahelp_tickets.CKey2ActiveTicket(what)
		if(AH)
			AH.AddInteraction(message)
			return AH


//
// HELPER PROCS
//

/proc/get_admin_counts(requiredflags = R_BAN)
	. = list("total" = list(), "noflags" = list(), "afk" = list(), "stealth" = list(), "present" = list())
	for(var/client/X in GLOB.admins)
		.["total"] += X
		if(requiredflags != 0 && !check_other_rights(X, requiredflags, FALSE))
			.["noflags"] += X
		else if(X.is_afk())
			.["afk"] += X
		else if(X.holder.fakekey)
			.["stealth"] += X
		else
			.["present"] += X


/proc/send2tgs_adminless_only(source, msg, requiredflags = R_BAN)
	var/list/adm = get_admin_counts(requiredflags)
	var/list/activemins = adm["present"]
	. = length(activemins)
	if(. <= 0)
		var/final = ""
		var/list/afkmins = adm["afk"]
		var/list/stealthmins = adm["stealth"]
		var/list/powerlessmins = adm["noflags"]
		var/list/allmins = adm["total"]
		if(!length(afkmins) && !length(stealthmins) && !length(powerlessmins))
			final = "ROUND:[GLOB.round_id], [msg] - No admins online"
		else
			final = "ROUND:[GLOB.round_id], [msg] - No available admins - Stealth: ([english_list(stealthmins)]) | AFK: ([english_list(afkmins)]) | Mentors: ([english_list(powerlessmins)]) | Total: [length(allmins)]"
		send2adminchat(source, final)


/proc/tgsadminwho()
	var/list/adm = get_admin_counts()
	var/list/activemins = adm["present"]
	var/list/afkmins = adm["afk"]
	var/list/stealthmins = adm["stealth"]
	var/list/powerlessmins = adm["noflags"]
	var/list/allmins = adm["total"]
	if(!length(activemins) && !length(afkmins) && !length(stealthmins) && !length(powerlessmins))
		return "No admins online"

	return "Present admins: ([english_list(activemins)]) | Stealth: ([english_list(stealthmins)]) | AFK: ([english_list(afkmins)]) | Mentors: ([english_list(powerlessmins)]) | Total: [length(allmins)]"


/proc/keywords_lookup(msg, external)
	//This is a list of words which are ignored by the parser when comparing message contents for names. MUST BE IN LOWER CASE!
	var/list/adminhelp_ignored_words = list("unknown", "the", "a", "an", "of", "monkey", "alien", "as", "i")

	//explode the input msg into a list
	var/list/msglist = splittext(msg, " ")

	//generate keywords lookup
	var/list/surnames = list()
	var/list/forenames = list()
	var/list/ckeys = list()
	var/founds = ""
	for(var/x in GLOB.mob_list)
		var/mob/M = x
		var/list/indexing = list(M.real_name, M.name)
		if(M.mind)
			indexing += M.mind.name

		for(var/string in indexing)
			var/list/L = splittext(string, " ")
			var/surname_found = 0
			//surnames
			for(var/i = length(L), i >= 1, i--)
				var/word = ckey(L[i])
				if(word)
					surnames[word] = M
					surname_found = i
					break
			//forenames
			for(var/i = 1 to (surname_found - 1))
				var/word = ckey(L[i])
				if(word)
					forenames[word] = M
			//ckeys
			ckeys[M.ckey] = M

	var/ai_found = 0
	msg = ""
	var/list/mobs_found = list()
	for(var/original_word in msglist)
		var/word = ckey(original_word)
		if(word)
			if(!(word in adminhelp_ignored_words))
				if(word == "ai")
					ai_found = 1
				else
					var/mob/found = ckeys[word]
					if(!found)
						found = surnames[word]
						if(!found)
							found = forenames[word]
					if(found)
						if(!(found in mobs_found))
							mobs_found += found
							if(!ai_found && isAI(found))
								ai_found = 1
							founds += "Name: [found.name]([found.real_name]) Key: [found.key] Ckey: [found.ckey] "
							msg += "[original_word]<font size='1'>(<A href='byond://?_src_=holder;[HrefToken(TRUE)];moreinfo=[REF(found)]'>?</A>|<A href='byond://?_src_=holder;[HrefToken(TRUE)];observefollow=[REF(found)]'>FLW</A>)</font> "
							continue
		msg += "[original_word] "
	if(external)
		if(founds == "")
			return "Search Failed"
		else
			return founds

	return msg

/**
 * Checks a given message to see if any of the words contain an active admin's ckey with an @ before it
 *
 * Returns nothing if no pings are found, otherwise returns an associative list with ckey -> client
 * Also modifies msg to underline the pings, then stores them in the key [ADMINSAY_PING_UNDERLINE_NAME_INDEX] for returning
 *
 * Arguments:
 * * msg - the message being scanned
 * * adminonly - if it should only look for ASAY admins and not just a holder
 */
/proc/check_admin_pings(msg, adminonly = FALSE)
	//explode the input msg into a list
	var/list/msglist = splittext(msg, " ")
	var/list/admins_to_ping = list()

	var/i = 0
	for(var/word in msglist)
		i++
		if(word[1] != "@")
			continue
		var/ckey_check = lowertext(copytext(word, 2))
		var/client/client_check = GLOB.directory[ckey_check]
		if(client_check?.holder)
			if(adminonly && (!(client_check.holder.rank.rights & R_ASAY)))
				continue
			msglist[i] = "<u>[word]</u>"
			admins_to_ping[ckey_check] = client_check

	if(length(admins_to_ping))
		admins_to_ping[ADMINSAY_PING_UNDERLINE_NAME_INDEX] = jointext(msglist, " ") // without tuples, we must make do!
		return admins_to_ping
