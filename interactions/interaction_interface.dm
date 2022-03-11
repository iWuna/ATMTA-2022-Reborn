/mob/proc/try_interaction()
	return

/mob/living/carbon/human/MouseDrop_T(mob/M as mob, mob/user as mob)
	if(M == src || src == usr || M != usr)		return
	if(usr.restrained())		return

	user.try_interaction(src)

/mob/verb/interact_with()
	set name = "Interact"
	set desc = "Perform an interaction with someone."
	set category = "IC"
	set src in view()

	if(usr != src && !usr.restrained())
		usr.try_interaction(src)

/mob/living/carbon/human/try_interaction(var/mob/partner)
	var/dat = {"<meta charset="UTF-8">"}
	dat += "<B><HR><FONT size=3>Взаимодействие с [partner]...</FONT></B><HR>"
	dat += "Вы:<br>[list_interaction_attributes()]<hr>"
	dat += "Партнер:<br>[partner.list_interaction_attributes()]<hr>"

	make_interactions()
	for(var/interaction_key in interactions)
		var/datum/interaction/I = interactions[interaction_key]
		if(I.evaluate_user(src) && I.evaluate_target(src, partner))
			dat += I.get_action_link_for(src, partner)

	var/datum/browser/popup = new(usr, "interactions", "Interactions", 340, 480)
	popup.set_content(dat)
	popup.open()