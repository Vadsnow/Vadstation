/*
	Datum based languages. Easily editable and modular.
*/

/datum/language
	var/name = "an unknown language" // Fluff name of language if any.
	var/desc = "A language."         // Short description for 'Check Languages'.
	var/speech_verb = "says"         // 'says', 'hisses', 'farts'.
	var/signlang_verb = list()       // list of emotes that might be displayed if this language has NONVERBAL or SIGNLANG flags
	var/colour = "body"         // CSS style to use for strings in this language.
	var/key = "x"                    // Character used to speak in language eg. :o for Soghun.
	var/flags = 0                    // Various language flags.
	var/native                       // If set, non-native speakers will have trouble speaking.

/datum/language/soghun
	name = "Sinta'unathi"
	desc = "The common language of Moghes, composed of sibilant hisses and rattles. Spoken natively by Soghun."
	speech_verb = "hisses"
	colour = "soghun"
	key = "o"
	flags = WHITELISTED

/datum/language/tajaran
	name = "Siik'maas"
	desc = "The traditionally employed tongue of Ahdomai, composed of expressive yowls and chirps. Native to the Tajaran."
	speech_verb = "mrowls"
	colour = "tajaran"
	key = "j"
	flags = WHITELISTED

/datum/language/tajaran_sign
	name = "Siik'tajr"
	desc = "An expressive language that combines yowls and chirps with posture, tail and ears. Spoken by many Tajaran."
	speech_verb = "mrowls"
	colour = "tajaran_signlang"
	key = "y"		//only "dfpqxyz" left.
	
	//need to find a way to resolve possesive macros
	signlang_verb = list("flicks their left ear", "flicks their right ear", "swivels their ears", "twitches their tail", "curls the end of their tail", "arches their tail", "wiggles the end of their tail", "waves their tail about", "holds up a claw", "gestures with their left hand", "gestures with their right hand", "gestures with their tail", "gestures with their ears")
	
	flags = WHITELISTED | NONVERBAL

/datum/language/skrell
	name = "Skrellian"
	desc = "A melodic and complex language spoken by the Skrell of Qerrbalak. Some of the notes are inaudible to humans."
	speech_verb = "warbles"
	colour = "skrell"
	key = "k"
	flags = WHITELISTED

/datum/language/vox
	name = "Vox-pidgin"
	desc = "The common tongue of the various Vox ships making up the Shoal. It sounds like chaotic shrieking to everyone else."
	speech_verb = "shrieks"
	colour = "vox"
	key = "v"
	flags = RESTRICTED

/datum/language/obsedai
	name = "Tummese"
	desc = "The common tongue of the Obsedai. It sounds like deep rumbling and resonant notes to everyone else."
	speech_verb = "rumbles"
	colour = "rough"
	key = "r"
	flags = WHITELISTED

/datum/language/diona
	name = "Rootspeak"
	desc = "A creaking, subvocal language spoken instinctively by the Dionaea. Due to the unique makeup of the average Diona, a phrase of Rootspeak can be a combination of anywhere from one to twelve individual voices and notes."
	speech_verb = "creaks and rustles"
	colour = "soghun"
	key = "q"
	flags = RESTRICTED

/datum/language/human
	name = "Sol Common"
	desc = "A bastardized hybrid of informal English and elements of Mandarin Chinese; the common language of the Sol system."
	colour = "rough"
	key = "1"
	flags = RESTRICTED

// Galactic common languages (systemwide accepted standards).
/datum/language/trader
	name = "Tradeband"
	desc = "Maintained by the various trading cartels in major systems, this elegant, structured language is used for bartering and bargaining."
	speech_verb = "enunciates"
	colour = "say_quote"
	key = "2"

/datum/language/gutter
	name = "Gutter"
	desc = "Much like Standard, this crude pidgin tongue descended from numerous languages and serves as Tradeband for criminal elements."
	speech_verb = "growls"
	colour = "rough"
	key = "3"

// Language handling.
/mob/proc/add_language(var/language)

	var/datum/language/new_language = all_languages[language]

	if(!istype(new_language) || new_language in languages)
		return 0

	languages.Add(new_language)
	return 1

/mob/proc/remove_language(var/rem_language)

	languages.Remove(all_languages[rem_language])

	return 0

// Can we speak this language, as opposed to just understanding it?
/mob/proc/can_speak(datum/language/speaking)

	return (universal_speak || speaking in src.languages)

//TBD
/mob/verb/check_languages()
	set name = "Check Known Languages"
	set category = "IC"
	set src = usr

	var/dat = "<b><font size = 5>Known Languages</font></b><br/><br/>"

	for(var/datum/language/L in languages)
		dat += "<b>[L.name] (:[L.key])</b><br/>[L.desc]<br/><br/>"

	src << browse(dat, "window=checklanguage")
	return