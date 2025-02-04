/proc/fix255(var/message)
    return replace(message, "�", "&#255;")

/proc/fix1103(var/message)
    return replace(message, "�", "&#1103;")

/mob/proc/say()
	return

/mob/verb/whisper()
	return

/mob/verb/say_verb(message as text)
	set name = "say"
	usr.say(fix255(message))

/mob/proc/say_dead(var/message)
	var/name = real_name
	var/alt_name = ""

	if (istype(src, /mob/living/carbon/human) && name != real_name)
		if (src:wear_id && src:wear_id:registered)
			alt_name = " (as [src:wear_id:registered])"
		else
			alt_name = " (as Unknown)"
	else if (istype(src, /mob/dead/observer))
		name = "Ghost"
		alt_name = " ([real_name])"
	else if (istype(src, /mob/dead/official))
		name = "Centcom official"
	else if (!istype(src, /mob/living/carbon/human))
		name = name

	message = say_quote(fix255(message))

	var/rendered = "<span class='game deadsay'><span class='prefix'>DEAD:</span> <span class='name'>[name]</span>[alt_name] <span class='message'>[message]</span></span>"

	for (var/client/C)
		if (istype(C.mob, /mob/new_player))
			continue
		if ((C.mob && C.mob.stat == 2) || (C.holder && C.deadchat)) //admins can toggle deadchat on and off. This is a proc in admin.dm and is only give to Administrators and above
			C.mob.show_message(rendered, 2)

/mob/proc/say_understands(var/mob/other)
	if (stat == 2)
		return 1
	else if (istype(other, type) || istype(other, /obj/machinery/bot/secbot))
		return 1
	return 0

/mob/proc/say_quote(var/text, var/mode)
	var/ending = copytext(text, length(text))
	if (stuttering)
		return "stammers, \"[text]\"";
	if (brainloss >= 60)
		return "gibbers, \"[text]\"";
	if(mode && mode != "")
		return "[mode], \"[text]\""
	if (ending == "?")
		return "asks, \"[text]\"";
	if (ending == "!")
		return "exclaims, \"[text]\"";

	return "says, \"[fix255(text)]\"";

/mob/proc/say_unknown(var/text)
	return null

/mob/proc/say_test(var/text)
	var/ending = copytext(text, length(text))
	if (ending == "?")
		return "1"
	else if (ending == "!")
		return "2"
	return "0"
/mob/proc/emote(var/act)
	return
