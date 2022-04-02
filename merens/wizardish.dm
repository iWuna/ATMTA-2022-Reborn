//Specially for ATMTA 2022 by AlexaMerens


#define LANGUAGE_WIZARD		65545

/datum/language/wizardish
	name = "Wizardish"
	desc = "The language of ancient wizards."
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verbs = list("exclaims")
	colour = "slime"
	key = "w"
	flags = RESTRICTED
	syllables = list(
	"Ei-Nathon","Kli-ngon","Log-tagar",
	"Bi-ba","Bo-ba","Munana",
	"La-mina-at","Na-ni","Ani-me",
	"Shoo-na","Nas-Rie","Tu-aletus",
	"Ho-ba","wee-wee","It-turns-me-on",
	"Yes-sir","Cum-ming","Mas-ter",
	"Slava","Uk-raine","Kharkiv",
	"Occup-antos","Ruzke","Su-kakus",
	"Pu-tin","Hublo","Luka-shesku"
	)

/datum/game_mode/proc/grant_wizardish(datum/mind/wiz)
	spawn(0)
		wiz.current.add_language("Wizardish")