/obj/machinery/computer/med_data
	name = "Medical Records"
	desc = "This can be used to check medical records."
	icon_state = "computer"
	screen_overlay = "medcomp"
	req_one_access = list(ACCESS_MARINE_MEDBAY, ACCESS_NT_CORPORATE)
	circuit = /obj/item/circuitboard/computer/med_data
	var/obj/item/card/id/scan = null
	var/authenticated = null
	var/rank = null
	var/screen = null
	var/datum/data/record/active1 = null
	var/datum/data/record/active2 = null
	var/a_id = null
	var/temp = null
	var/printing = null

/obj/machinery/computer/med_data/verb/eject_id()
	set category = "IC.Object"
	set name = "Eject ID Card"
	set src in oview(1)

	if(!usr || usr.stat || usr.lying_angle)
		return

	if(scan)
		to_chat(usr, "You remove \the [scan] from \the [src].")
		scan.loc = get_turf(src)
		if(!usr.get_active_held_item() && istype(usr,/mob/living/carbon/human))
			usr.put_in_hands(scan)
		scan = null
	else
		to_chat(usr, "There is nothing to remove from the console.")

/obj/machinery/computer/med_data/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/card/id) && !scan)
		if(!user.drop_held_item())
			return
		I.forceMove(src)
		scan = I
		to_chat(user, "You insert [I].")

/obj/machinery/computer/med_data/interact(mob/user)
	. = ..()
	if(.)
		return
	var/dat
	if(temp)
		dat = "<TT>[temp]</TT><BR><BR><A href='byond://?src=[text_ref(src)];temp=1'>Clear Screen</A>"
	else
		dat = "Confirm Identity: <A href='byond://?src=[text_ref(src)];scan=1'>[scan ? "[scan.name]": "----------"]</A><HR>"
		if(authenticated)
			switch(screen)
				if(1.0)
					dat += {"
						<A href='byond://?src=[text_ref(src)];search=1'>Search Records</A>
						<BR><A href='byond://?src=[text_ref(src)];screen=2'>List Records</A>
						<BR>
						<BR><A href='byond://?src=[text_ref(src)];screen=5'>Medbot Tracking</A>
						<BR>
						<BR><A href='byond://?src=[text_ref(src)];screen=3'>Record Maintenance</A>
						<BR><A href='byond://?src=[text_ref(src)];logout=1'>{Log Out}</A><BR>
					"}
				if(2.0)
					dat += "<B>Record List</B>:<HR>"
					if(!isnull(GLOB.datacore.general))
						for(var/datum/data/record/R in sortRecord(GLOB.datacore.general))
							dat += "<A href='byond://?src=[text_ref(src)];d_rec=[text_ref(R)]'>[R.fields["id"]]: [R.fields["name"]]<BR></A>"
							//Foreach goto(132)
					dat += "<HR><A href='byond://?src=[text_ref(src)];screen=1'>Back</A>"
				if(3.0)
					dat += "<B>Records Maintenance</B><HR>\n<A href='byond://?src=[text_ref(src)];back=1'>Backup To Disk</A><BR>\n<A href='byond://?src=[text_ref(src)];u_load=1'>Upload From disk</A><BR>\n<A href='byond://?src=[text_ref(src)];del_all=1'>Delete All Records</A><BR>\n<BR>\n<A href='byond://?src=[text_ref(src)];screen=1'>Back</A>"
				if(4.0)
					if(istype(active1.fields["photo_front"], /obj/item/photo))
						var/obj/item/photo/P1 = active1.fields["photo_front"]
						DIRECT_OUTPUT(user, browse_rsc(P1.picture.picture_image, "photo_front"))
					if(istype(active1.fields["photo_side"], /obj/item/photo))
						var/obj/item/photo/P2 = active1.fields["photo_side"]
						DIRECT_OUTPUT(user, browse_rsc(P2.picture.picture_image, "photo_side"))
					dat += "<CENTER><B>Medical Record</B></CENTER><BR>"
					if((istype(active1, /datum/data/record) && GLOB.datacore.general.Find(active1)))
						dat += "<table><tr><td>Name: [active1.fields["name"]] \
								ID: [active1.fields["id"]]<BR>\n	\
								Sex: <A href='byond://?src=[text_ref(src)];field=sex'>[active1.fields["sex"]]</A><BR>\n	\
								Age: <A href='byond://?src=[text_ref(src)];field=age'>[active1.fields["age"]]</A><BR>\n	\
								Fingerprint: <A href='byond://?src=[text_ref(src)];field=fingerprint'>[active1.fields["fingerprint"]]</A><BR>\n	\
								Physical Status: <A href='byond://?src=[text_ref(src)];field=p_stat'>[active1.fields["p_stat"]]</A><BR>\n	\
								Mental Status: <A href='byond://?src=[text_ref(src)];field=m_stat'>[active1.fields["m_stat"]]</A><BR></td><td align = center valign = top> \
								Photo:<br><img src=photo_front height=64 width=64 border=5><img src=photo_side height=64 width=64 border=5></td></tr></table>"
					else
						dat += "<B>General Record Lost!</B><BR>"
					if((istype(active2, /datum/data/record) && GLOB.datacore.medical.Find(active2)))
						dat += "<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: <A href='byond://?src=[text_ref(src)];field=b_type'>[active2.fields["b_type"]]</A><BR>\nDNA: <A href='byond://?src=[text_ref(src)];field=b_dna'>[active2.fields["b_dna"]]</A><BR>\n<BR>\nMinor Disabilities: <A href='byond://?src=[text_ref(src)];field=mi_dis'>[active2.fields["mi_dis"]]</A><BR>\nDetails: <A href='byond://?src=[text_ref(src)];field=mi_dis_d'>[active2.fields["mi_dis_d"]]</A><BR>\n<BR>\nMajor Disabilities: <A href='byond://?src=[text_ref(src)];field=ma_dis'>[active2.fields["ma_dis"]]</A><BR>\nDetails: <A href='byond://?src=[text_ref(src)];field=ma_dis_d'>[active2.fields["ma_dis_d"]]</A><BR>\n<BR>\nAllergies: <A href='byond://?src=[text_ref(src)];field=alg'>[active2.fields["alg"]]</A><BR>\nDetails: <A href='byond://?src=[text_ref(src)];field=alg_d'>[active2.fields["alg_d"]]</A><BR>\n<BR>\nCurrent Diseases: <A href='byond://?src=[text_ref(src)];field=cdi'>[active2.fields["cdi"]]</A>(per disease info placed in log/comment section)<BR>\nDetails: <A href='byond://?src=[text_ref(src)];field=cdi_d'>[active2.fields["cdi_d"]]</A><BR>\n<BR>\nImportant Notes:<BR>\n\t<A href='byond://?src=[text_ref(src)];field=notes'>[decode(active2.fields["notes"])]</A><BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>"
						var/counter = 1
						while(active2.fields["com_[counter]"])
							dat += "[active2.fields["com_[counter]"]]<BR><A href='byond://?src=[text_ref(src)];del_c=[counter]'>Delete Entry</A><BR><BR>"
							counter++
						dat += "<A href='byond://?src=[text_ref(src)];add_c=1'>Add Entry</A><BR><BR>"
						dat += "<A href='byond://?src=[text_ref(src)];del_r=1'>Delete Record(Medical Only)</A><BR><BR>"
					else
						dat += "<B>Medical Record Lost!</B><BR>"
						dat += "<A href='byond://?src=[text_ref(src)];new=1'>New Record</A><BR><BR>"
					dat += "\n<A href='byond://?src=[text_ref(src)];print_p=1'>Print Record</A><BR>\n<A href='byond://?src=[text_ref(src)];screen=2'>Back</A><BR>"
				if(5)
					dat += "<center><b>Medical Robot Monitor</b></center>"
					dat += "<a href='byond://?src=[text_ref(src)];screen=1'>Back</a>"
					dat += "<br><b>Medical Robots:</b>"
					var/bdat = null
					if(!bdat)
						dat += "<br><center>None detected</center>"
					else
						dat += "<br>[bdat]"
		else
			dat += "<A href='byond://?src=[text_ref(src)];login=1'>{Log In}</A>"

	var/datum/browser/popup = new(user, "med_rec", "<div align='center'>Medical Records</div>")
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/med_data/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(!(GLOB.datacore.general.Find(active1)))
		active1 = null

	if(!(GLOB.datacore.medical.Find(active2)))
		active2 = null

	if(href_list["temp"])
		temp = null

	if(href_list["scan"])
		if(scan)

			if(ishuman(usr))
				scan.loc = usr.loc

				if(!usr.get_active_held_item())
					usr.put_in_hands(scan)

				scan = null

			else
				scan.loc = loc
				scan = null

		else
			var/obj/item/I = usr.get_active_held_item()
			if(istype(I, /obj/item/card/id))
				if(usr.drop_held_item())
					I.forceMove(src)
					scan = I

	else if(href_list["logout"])
		authenticated = null
		screen = null
		active1 = null
		active2 = null

	else if(href_list["login"])

		if(isAI(usr))
			active1 = null
			active2 = null
			authenticated = usr.name
			rank = "AI"
			screen = 1

		else if(istype(scan, /obj/item/card/id))
			active1 = null
			active2 = null

			if(check_access(scan))
				authenticated = scan.registered_name
				rank = scan.assignment
				screen = 1

	if(authenticated)

		if(href_list["screen"])
			screen = text2num(href_list["screen"])
			if(screen < 1)
				screen = 1
			active1 = null
			active2 = null

		if(href_list["del_all"])
			temp = "Are you sure you wish to delete all records?<br>\n\t<A href='byond://?src=[text_ref(src)];temp=1;del_all2=1'>Yes</A><br>\n\t<A href='byond://?src=[text_ref(src)];temp=1'>No</A><br>"

		if(href_list["del_all2"])
			for(var/datum/data/record/R in GLOB.datacore.medical)
				GLOB.datacore.medical -= R
				qdel(R)
				//Foreach goto(494)
			temp = "All records deleted."

		if(href_list["field"])
			var/a1 = active1
			var/a2 = active2
			switch(href_list["field"])
				if("fingerprint")
					if(istype(active1, /datum/data/record))
						var/t1 = stripped_input(usr, "Please input fingerprint hash:", "Med. records", active1.fields["fingerprint"])
						if(topic_field_checks(t1, usr, a1, active1))
							return
						active1.fields["fingerprint"] = t1
				if("sex")
					if(istype(active1, /datum/data/record))
						if(active1.fields["sex"] == "Male")
							active1.fields["sex"] = "Female"
						else
							active1.fields["sex"] = "Male"
				if("age")
					if(istype(active1, /datum/data/record))
						var/t1 = tgui_input_number(usr, "Please input age:", "Med. records", active1.fields["age"])
						if(topic_field_checks(t1, usr, a1, active1))
							return
						active1.fields["age"] = t1
				if("mi_dis")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please input minor disabilities list:", "Med. records", active2.fields["mi_dis"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["mi_dis"] = t1
				if("mi_dis_d")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please summarize minor dis.:", "Med. records", active2.fields["mi_dis_d"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["mi_dis_d"] = t1
				if("ma_dis")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please input major diabilities list:", "Med. records", active2.fields["ma_dis"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["ma_dis"] = t1
				if("ma_dis_d")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please summarize major dis.:", "Med. records", active2.fields["ma_dis_d"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["ma_dis_d"] = t1
				if("alg")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please state allergies:", "Med. records", active2.fields["alg"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["alg"] = t1
				if("alg_d")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please summarize allergies:", "Med. records", active2.fields["alg_d"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["alg_d"] = t1
				if("cdi")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please state diseases:", "Med. records", active2.fields["cdi"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["cdi"] = t1
				if("cdi_d")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please summarize diseases:", "Med. records", active2.fields["cdi_d"])
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["cdi_d"] = t1
				if("notes")
					if(istype(active2, /datum/data/record))
						var/t1 = copytext(html_encode(trim(input("Please summarize notes:", "Med. records", html_decode(active2.fields["notes"]), null)  as message)),1,MAX_MESSAGE_LEN)
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["notes"] = t1
				if("p_stat")
					if(istype(active1, /datum/data/record))
						temp = "<B>Physical Condition:</B><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;p_stat=deceased'>*Deceased*</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;p_stat=ssd'>*SSD*</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;p_stat=active'>Active</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;p_stat=unfit'>Physically Unfit</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;p_stat=disabled'>Disabled</A><BR>"
				if("m_stat")
					if(istype(active1, /datum/data/record))
						temp = "<B>Mental Condition:</B><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;m_stat=insane'>*Insane*</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;m_stat=unstable'>*Unstable*</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;m_stat=watch'>*Watch*</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;m_stat=stable'>Stable</A><BR>"
				if("b_type")
					if(istype(active2, /datum/data/record))
						temp = "<B>Blood Type:</B><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;b_type=an'>A-</A> <A href='byond://?src=[text_ref(src)];temp=1;b_type=ap'>A+</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;b_type=bn'>B-</A> <A href='byond://?src=[text_ref(src)];temp=1;b_type=bp'>B+</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;b_type=abn'>AB-</A> <A href='byond://?src=[text_ref(src)];temp=1;b_type=abp'>AB+</A><BR>\n\t<A href='byond://?src=[text_ref(src)];temp=1;b_type=on'>O-</A> <A href='byond://?src=[text_ref(src)];temp=1;b_type=op'>O+</A><BR>"
				if("b_dna")
					if(istype(active2, /datum/data/record))
						var/t1 = stripped_input(usr, "Please input DNA hash:", "Med. records", active2.fields["b_dna"], MAX_MESSAGE_LEN)
						if(topic_field_checks(t1, usr, a2, active2))
							return
						active2.fields["b_dna"] = t1

		if(href_list["p_stat"])
			if(active1)
				switch(href_list["p_stat"])
					if("deceased")
						active1.fields["p_stat"] = "*Deceased*"
					if("ssd")
						active1.fields["p_stat"] = "*SSD*"
					if("active")
						active1.fields["p_stat"] = "Active"
					if("unfit")
						active1.fields["p_stat"] = "Physically Unfit"
					if("disabled")
						active1.fields["p_stat"] = "Disabled"

		if(href_list["m_stat"])
			if(active1)
				switch(href_list["m_stat"])
					if("insane")
						active1.fields["m_stat"] = "*Insane*"
					if("unstable")
						active1.fields["m_stat"] = "*Unstable*"
					if("watch")
						active1.fields["m_stat"] = "*Watch*"
					if("stable")
						active1.fields["m_stat"] = "Stable"

		if(href_list["b_type"])
			if(active2)
				switch(href_list["b_type"])
					if("an")
						active2.fields["b_type"] = "A-"
					if("bn")
						active2.fields["b_type"] = "B-"
					if("abn")
						active2.fields["b_type"] = "AB-"
					if("on")
						active2.fields["b_type"] = "O-"
					if("ap")
						active2.fields["b_type"] = "A+"
					if("bp")
						active2.fields["b_type"] = "B+"
					if("abp")
						active2.fields["b_type"] = "AB+"
					if("op")
						active2.fields["b_type"] = "O+"

		if(href_list["del_r"])
			if(active2)
				temp = "Are you sure you wish to delete the record(Medical Portion Only)?<br>\n\t<A href='byond://?src=[text_ref(src)];temp=1;del_r2=1'>Yes</A><br>\n\t<A href='byond://?src=[text_ref(src)];temp=1'>No</A><br>"

		if(href_list["del_r2"])
			if(active2)
				qdel(active2)
				active2 = null

		if(href_list["d_rec"])
			var/datum/data/record/R = locate(href_list["d_rec"])
			var/datum/data/record/M = locate(href_list["d_rec"])
			if(!(GLOB.datacore.general.Find(R)))
				temp = "Record Not Found!"
				return
			for(var/datum/data/record/E in GLOB.datacore.medical)
				if((E.fields["name"] == R.fields["name"] || E.fields["id"] == R.fields["id"]))
					M = E
			active1 = R
			active2 = M
			screen = 4

		if(href_list["new"])
			if((istype(active1, /datum/data/record) && !(istype(active2, /datum/data/record))))
				var/datum/data/record/R = new /datum/data/record()
				R.fields["name"] = active1.fields["name"]
				R.fields["id"] = active1.fields["id"]
				R.name = "Medical Record #[R.fields["id"]]"
				R.fields["b_type"] = "Unknown"
				R.fields["b_dna"] = "Unknown"
				R.fields["mi_dis"] = "None"
				R.fields["mi_dis_d"] = "No minor disabilities have been declared."
				R.fields["ma_dis"] = "None"
				R.fields["ma_dis_d"] = "No major disabilities have been diagnosed."
				R.fields["alg"] = "None"
				R.fields["alg_d"] = "No allergies have been detected in this patient."
				R.fields["cdi"] = "None"
				R.fields["cdi_d"] = "No diseases have been diagnosed at the moment."
				R.fields["notes"] = "No notes."
				GLOB.datacore.medical += R
				active2 = R
				screen = 4

		if(href_list["add_c"])
			if(!(istype(active2, /datum/data/record)))
				return
			var/a2 = active2
			var/t1 = stripped_input("Add Comment:", "Med. records")
			if(topic_field_checks(t1, usr, a2, active2))
				return
			var/counter = 1
			while(active2.fields["com_[counter]"])
				counter++
			active2.fields["com_[counter]"] = "Made by [authenticated]([rank]) on [time2text(world.realtime, "DDD MMM DD hh:mm:ss")], [GAME_YEAR]<BR>[t1]"

		if(href_list["del_c"])
			if((istype(active2, /datum/data/record) && active2.fields["com_[href_list["del_c"]]"]))
				active2.fields["com_[href_list["del_c"]]"] = "<B>Deleted</B>"

		if(href_list["search"])
			var/t1 = stripped_input(usr, "Search String:(Name, DNA, or ID)", "Med. records")
			if((!(t1) || usr.stat || !(authenticated) || usr.restrained() ||((!in_range(src, usr)) && !issilicon(usr))))
				return
			active1 = null
			active2 = null
			t1 = lowertext(t1)
			for(var/datum/data/record/R in GLOB.datacore.medical)
				if((lowertext(R.fields["name"]) == t1 || t1 == lowertext(R.fields["id"]) || t1 == lowertext(R.fields["b_dna"])))
					active2 = R
			if(!(active2))
				temp = "Could not locate record [t1]."
			else
				for(var/datum/data/record/E in GLOB.datacore.general)
					if((E.fields["name"] == active2.fields["name"] || E.fields["id"] == active2.fields["id"]))
						active1 = E
				screen = 4

		if(href_list["print_p"])
			if(!(printing))
				printing = 1
				var/datum/data/record/record1 = null
				var/datum/data/record/record2 = null
				if((istype(active1, /datum/data/record) && GLOB.datacore.general.Find(active1)))
					record1 = active1
				if((istype(active2, /datum/data/record) && GLOB.datacore.medical.Find(active2)))
					record2 = active2
				sleep(5 SECONDS)
				var/obj/item/paper/P = new /obj/item/paper(loc)
				P.info = "<CENTER><B>Medical Record</B></CENTER><BR>"
				if(record1)
					P.info += "Name: [record1.fields["name"]] ID: [record1.fields["id"]]<BR>\nSex: [record1.fields["sex"]]<BR>\nAge: [record1.fields["age"]]<BR>\nFingerprint: [record1.fields["fingerprint"]]<BR>\nPhysical Status: [record1.fields["p_stat"]]<BR>\nMental Status: [record1.fields["m_stat"]]<BR>"
					P.name = "Medical Record([record1.fields["name"]])"
				else
					P.info += "<B>General Record Lost!</B><BR>"
					P.name = "Medical Record"
				if(record2)
					P.info += "<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: [record2.fields["b_type"]]<BR>\nDNA: [record2.fields["b_dna"]]<BR>\n<BR>\nMinor Disabilities: [record2.fields["mi_dis"]]<BR>\nDetails: [record2.fields["mi_dis_d"]]<BR>\n<BR>\nMajor Disabilities: [record2.fields["ma_dis"]]<BR>\nDetails: [record2.fields["ma_dis_d"]]<BR>\n<BR>\nAllergies: [record2.fields["alg"]]<BR>\nDetails: [record2.fields["alg_d"]]<BR>\n<BR>\nCurrent Diseases: [record2.fields["cdi"]](per disease info placed in log/comment section)<BR>\nDetails: [record2.fields["cdi_d"]]<BR>\n<BR>\nImportant Notes:<BR>\n\t[decode(record2.fields["notes"])]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>"
					var/counter = 1
					while(record2.fields["com_[counter]"])
						P.info += "[record2.fields["com_[counter]"]]<BR>"
						counter++
				else
					P.info += "<B>Medical Record Lost!</B><BR>"
				P.info += "</TT>"
				printing = null

	updateUsrDialog()

/obj/machinery/computer/med_data/proc/topic_field_checks(input, mob/user, record, old_record)
	if(!input)
		return FALSE
	if(!authenticated)
		return FALSE
	if(user.stat)
		return FALSE
	if(user.restrained())
		return FALSE
	if(!in_range(src, user) && !issilicon(user))
		return FALSE
	if(old_record != record)
		return FALSE
	return TRUE

/obj/machinery/computer/med_data/emp_act(severity)
	if(machine_stat & (BROKEN|NOPOWER))
		return ..()

	for(var/datum/data/record/R in GLOB.datacore.medical)
		if(prob(10 / severity))
			switch(rand(1,6))
				if(1)
					R.fields["name"] = GLOB.namepool[/datum/namepool].get_random_name(pick(MALE, FEMALE))
				if(2)
					R.fields["sex"] = pick("Male", "Female")
				if(3)
					R.fields["age"] = rand(5, 85)
				if(4)
					R.fields["b_type"] = pick("A-", "B-", "AB-", "O-", "A+", "B+", "AB+", "O+")
				if(5)
					R.fields["p_stat"] = pick("*SSD*", "Active", "Physically Unfit", "Disabled")
				if(6)
					R.fields["m_stat"] = pick("*Insane*", "*Unstable*", "*Watch*", "Stable")
			continue

		else if(prob(1))
			GLOB.datacore.medical -= R
			qdel(R)
			continue
	return ..()

/obj/machinery/computer/med_data/laptop
	name = "Medical Laptop"
	desc = "Cheap Nanotrasen Laptop."
	icon_state = "computer_small"
	screen_overlay = "medlaptop"
	density = FALSE
