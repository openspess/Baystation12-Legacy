/mob/living/carbon/human/emote(var/act)
	act = fix255(act)

	if(src.stat == 2 && act != "stopbreath")
		return

	var/param = null

	if (findtext(act, " ", 1, null))
		var/t1 = findtext(act, " ", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	var/muzzled = istype(wear_mask, /obj/item/clothing/mask/muzzle)
	var/m_type = 1 //visible emote (1), or hearable emote (2)

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

	var/message = ""
	switch(act)
		if ("blink")
			message = "<B>[src]</B> blinks."
			m_type = 1

		if ("blink_r")
			message = "<B>[src]</B> blinks rapidly."
			m_type = 1

		if ("bow")
			if (!buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (findtext(A.name,param,1,0))
							M = A
							break
				if (!M)
					param = null

				if (M)
					message = "<B>[src]</B> bows to [M]."
				else
					message = "<B>[src]</B> bows."
			m_type = 1

		if ("custom")
			m_type = 0
			if(copytext(param,1,2) == "v")
				m_type = 1
			else if(copytext(param,1,2) == "h")
				m_type = 2
			else
				var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
				if (input2 == "Visible")
					m_type = 1
				else if (input2 == "Hearable")
					m_type = 2
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			if(m_type)
				param = trim(copytext(param,2))
			else
				param = trim(param)
			var/input
			if(param == "")
				input = input("Choose an emote to display.")
			else
				input = param
			if(input != "")
				message = "<B>[src]</B> [input]"

		if ("salute")
			if (!buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (findtext(A.name,param,1,0))
							M = A
							break
				if (!M)
					param = null

				if (param)
					message = "<B>[src]</B> salutes to [param]."
				else
					message = "<B>[src]</b> salutes."
			m_type = 1

		if ("choke")
			if (!muzzled)
				message = "<B>[src]</B> chokes!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a strong noise."
				m_type = 2

		if ("clap")
			if (!restrained())
				message = "<B>[src]</B> claps."
				m_type = 2
		if ("flap")
			if (!restrained())
				message = "<B>[src]</B> flaps his wings."
				m_type = 2

		if ("aflap")
			if (!restrained())
				message = "<B>[src]</B> flaps his wings ANGRILY!"
				m_type = 2

		if ("drool")
			message = "<B>[src]</B> drools."
			m_type = 1

		if ("eyebrow")
			message = "<B>[src]</B> raises an eyebrow."
			m_type = 1

		if ("chuckle")
			if (!muzzled)
				message = "<B>[src]</B> chuckles."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("twitch")
			message = "<B>[src]</B> twitches violently."
			m_type = 1

		if ("twitch_s")
			message = "<B>[src]</B> twitches."
			m_type = 1

		if ("faint")
			message = "<B>[src]</B> faints."
			sleeping = 1
			m_type = 1

		if ("cough")
			if (!muzzled)
				message = "<B>[src]</B> coughs!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a strong noise."
				m_type = 2

		if ("frown")
			message = "<B>[src]</B> frowns."
			m_type = 1

		if ("nod")
			message = "<B>[src]</B> nods."
			m_type = 1

		if ("blush")
			message = "<B>[src]</B> blushes."
			m_type = 1

		if ("gasp")
			if (!muzzled)
				message = "<B>[src]</B> gasps!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise."
				m_type = 2
		if ("breathe")
			message = "<B>[src]</B> breathes."
			m_type = 1
			holdbreath = 0
		if ("stopbreath")
			message = "<B>[src]</B> stops breathing..."
			m_type = 1
		if ("holdbreath")
			message = "<B>[src]</B> stops breathing..."
			m_type = 1
			holdbreath = 1
		if("struckdown")
			message = "<B>[src]</B>, Station Dweller, has been struck down."
			m_type = 2

		if ("giggle")
			if (!muzzled)
				message = "<B>[src]</B> giggles."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("glare")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (findtext(A.name,param,1,0))
						M = A
						break
			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> glares at [param]."
			else
				message = "<B>[src]</B> glares."

		if ("stare")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (findtext(A.name,param,1,0))
						M = A
						break
			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> stares at [param]."
			else
				message = "<B>[src]</B> stares."

		if ("look")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (findtext(A.name,param,1,0))
						M = A
						break

			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> looks at [param]."
			else
				message = "<B>[src]</B> looks."
			m_type = 1

		if ("grin")
			message = "<B>[src]</B> grins."
			m_type = 1

		if ("cry")
			if (!muzzled)
				message = "<B>[src]</B> cries."
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise. \He frowns."
				m_type = 2

		if ("sigh")
			if (!muzzled)
				message = "<B>[src]</B> sighs."
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise."
				m_type = 2

		if ("laugh")
			if (!muzzled)
				message = "<B>[src]</B> laughs."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("mumble")
			message = "<B>[src]</B> mumbles."
			m_type = 2

		if ("grumble")
			if (!muzzled)
				message = "<B>[src]</B> grumbles."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("groan")
			if (!muzzled)
				message = "<B>[src]</B> groans!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a loud noise."
				m_type = 2

		if ("howl")
			if (!muzzled)
				message = "<B>[src]</b> howls!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a loud noise."
				m_type = 2


		if ("moan")
			message = "<B>[src]</B> moans!"
			m_type = 2

		if ("johnny")
			var/M
			if (param)
				M = param
			if (!M)
				param = null
			else
				message = "<B>[src]</B> says, \"[M], please. He had a family.\" [name] takes a drag from a cigarette and blows his name out in smoke."
				m_type = 2

		if ("point")
			if (!restrained())
				var/mob/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (findtext(A.name,param,1,0))
							M = A
							break

				if (!M)
					message = "<B>[src]</B> points."
				else
					M.point()

				if (M)
					message = "<B>[src]</B> points to [M]."
				else
			m_type = 1

		if ("raise")
			if (!restrained())
				message = "<B>[src]</B> raises a hand."
			m_type = 1

		if("shake")
			message = "<B>[src]</B> shakes \his head."
			m_type = 1

		if ("shrug")
			message = "<B>[src]</B> shrugs."
			m_type = 1

		if ("signal")
			if (!restrained())
				var/t1 = round(text2num(param))
				if (isnum(t1))
					if (t1 <= 5 && (!r_hand || !l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
					else if (t1 <= 10 && (!r_hand && !l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
			m_type = 1

		if ("smile")
			message = "<B>[src]</B> smiles."
			m_type = 1

		if ("shiver")
			message = "<B>[src]</B> shivers."
			m_type = 2

		if ("pale")
			message = "<B>[src]</B> goes pale for a second."
			m_type = 1

		if ("tremble")
			message = "<B>[src]</B> trembles in fear!"
			m_type = 1

		if ("sneeze")
			if (!muzzled)
				message = "<B>[src]</B> sneezes."
				m_type = 2
			else
				message = "<B>[src]</B> makes a strange noise."
				m_type = 2

		if ("sniff")
			message = "<B>[src]</B> sniffs."
			m_type = 2

		if ("snore")
			if (!muzzled)
				message = "<B>[src]</B> snores."
				m_type = 2
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("whimper")
			if (!muzzled)
				message = "<B>[src]</B> whimpers."
				m_type = 2
			else
				message = "<B>[src]</B> makes a weak noise."
				m_type = 2

		if ("wink")
			message = "<B>[src]</B> winks."
			m_type = 1

		if ("yawn")
			if (!muzzled)
				message = "<B>[src]</B> yawns."
				m_type = 2

		if ("collapse")
			message = "<B>[src]</B> collapses!"
			m_type = 2

		if("hug")
			m_type = 1
			if (!restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (findtext(A.name,param,1,0))
							M = A
							break
				if (M == src)
					M = null

				if (M)
					message = "<B>[src]</B> hugs [M]."
				else
					message = "<B>[src]</B> hugs \himself."

		if ("handshake")
			m_type = 1
			if (!restrained() && !r_hand)
				var/mob/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (findtext(A.name,param,1,0))
							M = A
							break
				if (M == src)
					M = null

				if (M)
					if (M.canmove && !M.r_hand && !M.restrained())
						message = "<B>[src]</B> shakes hands with [M]."
					else
						message = "<B>[src]</B> holds out \his hand to [M]."

		if("daps")
			m_type = 1
			if (!restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (findtext(A.name,param,1,0))
							M = A
							break
				if (M)
					message = "<B>[src]</B> gives daps to [M]."
				else
					message = "<B>[src]</B> sadly can't find anybody to give daps to, and daps \himself. Shameful."

		if ("scream")
			if (!muzzled)
				message = "<B>[src]</B> screams!"
				m_type = 2
			else
				message = "<B>[src]</B> makes a very loud noise."
				m_type = 2

		if ("hungry")
			if(prob(1))
				message = "<B>Blue Elf</B> needs food Badly"
			else
				message = "<B>[src]'s</B> stomach growls"
		if ("thirsty")
			if(prob(1))
				message = "<B>[src]</B> cancels destory station: Drinking"
			else
				message = "<B>[src]</B> thirsty"
		if ("vomit")
			message = vomit(1) //this way it can do all of food and thign overeating
			m_type = 1

		if ("help")
			src << "blink, blink_r, blush, bow-(none)/mob, burp, choke, chuckle, clap, collapse, cough,\ncry, custom, deathgasp, drool, eyebrow, frown, gasp, giggle, groan, grumble, handshake, hug-(none)/mob, glare-(none)/mob,\ngrin, laugh, look-(none)/mob, moan, mumble, nod, pale, point-atom, raise, salute, shake, shiver, shrug,\nsigh, signal-#1-10, smile, sneeze, sniff, snore, stare-(none)/mob, tremble, twitch, twitch_s, whimper,\nwink, yawn"

		else
			src << "\blue Unusable emote '[act]'. Say *help for a list."

	if (isobj(src.loc)) // In case the mob is located in an object which may alter sounds coming from it (bodybags for instance)
		message = src.loc:alterMobEmote(message, act, m_type, src)

		if (message != "")
			if (m_type & 1)
				for (var/mob/O in viewers(src.loc, null))
					O.show_message(message, m_type)
			else if (m_type & 2)
				for (var/mob/O in hearers(src.loc, null))
					O.show_message(message, m_type)

	else if (message != "")
		if (m_type & 1)
			for (var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
		else if (m_type & 2)
			for (var/mob/O in hearers(src, null))
				O.show_message(message, m_type)