/**********************************
*******Interactions code by HONKERTRON feat TestUnit********
**Contains a lot ammount of ERP and MEHANOYEBLYA**
**CREDIT TO ATMTA STATION FOR MOST OF THIS CODE, I ONLY MADE IT WORK IN /vg/ - Matt
** Rewritten 30/08/16 by Zuhayr, sry if I removed anything important.
**I removed ERP and replaced it with handholding. Nothing of worth was lost. - Vic
**Fuck you, Vic. ERP is back. - TT
***********************************/


// Rectum? Damn near killed 'em.
var/list/interactions

/proc/make_interactions(var/interaction)
	if(!interactions)
		interactions = list()
		for(var/itype in typesof(/datum/interaction)-/datum/interaction)
			var/datum/interaction/I = new itype()
			interactions[I.command] = I

/mob/proc/list_interaction_attributes()
	var/dat = {"<meta charset=UTF-8">"}
	if(has_hands())
		dat += "Цель имеет руки."
	if(has_mouth())
		if(dat != "")
			dat += "<br>"
		dat += "Цель имеет рот, который [mouth_is_free() ? "не прикрыт" : "прикрыт"]."
	return dat

/datum/interaction
	var/command = "interact"
	var/description = "Interact with them."
	var/simple_message
	var/simple_style = "notice"
	var/write_log_user
	var/write_log_target

	var/interaction_sound
	var/interaction_sound_age_pitch

	var/max_distance = 1
	var/require_user_mouth
	var/require_user_hands
	var/require_target_mouth
	var/require_target_hands
	var/needs_physical_contact

/datum/interaction/proc/evaluate_user(var/mob/user, var/silent=1)

	if(require_user_mouth)
		if(!user.has_mouth())
			if(!silent) user << "<span class = 'warning'>У вас нет рта!.</span>"
			return 0
		if(!user.mouth_is_free())
			if(!silent) user << "<span class = 'warning'>Ваш рот прикрыт.</span>"
			return 0
	if(require_user_hands && !user.has_hands())
		if(!silent) user << "<span class = 'warning'>У вас нет рук.</span>"
		return 0
	return 1

/datum/interaction/proc/evaluate_target(var/mob/user, var/mob/target, var/silent=1)

	if(require_target_mouth)
		if(!target.has_mouth())
			if(!silent) user << "<span class = 'warning'>У цели нет рта.</span>"
			return 0
		if(!target.mouth_is_free())
			if(!silent) user << "<span class = 'warning'>Рот цели прикрыт.</span>"
			return 0
	if(require_target_hands && !target.has_hands())
		if(!silent) user << "<span class = 'warning'>У цели нет рук.</span>"
		return 0
	return 1

/datum/interaction/proc/get_action_link_for(var/mob/user, var/mob/target)
	return "<a href='?src=\ref[src];action=1;action_user=\ref[user];action_target=\ref[target]'>[description]</a><br>"

/datum/interaction/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["action"])
		do_action(locate(href_list["action_user"]), locate(href_list["action_target"]))
		return 1
	return 0

/datum/interaction/proc/do_action(var/mob/user, var/mob/target)
	if(get_dist(user, target) > max_distance)
		user << "<span class='warning'>Цель слишком далеко.</span>"
		return
	if(needs_physical_contact && !(user.Adjacent(target) && target.Adjacent(user)))
		user << "<span class='warning'>Вы не можете добраться до цели.</span>"
		return
	if(!evaluate_user(user, silent=0))
		return
	if(!evaluate_target(user, target, silent=0))
		return

	display_interaction(user, target)

	post_interaction(user, target)

/datum/interaction/proc/display_interaction(var/mob/user, var/mob/target)
	if(simple_message)
		var/use_message = replacetext_char(simple_message, "USER", "\the [user]")
		use_message = replacetext_char(use_message, "TARGET", "\the [target]")
		user.visible_message("<span class='[simple_style]'>[capitalize(use_message)]</span>")

/datum/interaction/proc/post_interaction(var/mob/user, var/mob/target)
	if(interaction_sound)
		if(interaction_sound_age_pitch)
			playsound(get_turf(user), interaction_sound, 50, 1, -1)//, pitch = user.get_age_pitch())
		else
			playsound(get_turf(user), interaction_sound, 50, 1, -1)
	return
/*
/atom/movable/attack_hand(mob/living/user)
	. = ..()
	if(can_buckle && buckled_mob)
		if(user_unbuckle_mob(user))
			return 1

/atom/movable/MouseDrop_T(mob/living/M, mob/living/user)
	. = ..()
	if(can_buckle && istype(M) && !buckled_mob)
		if(user_buckle_mob(M, user))
			return 1


/atom/movable/attack_hand(mob/living/user)
	. = ..()
	if(can_buckle && buckled_mob)
		if(user_unbuckle_mob(user))
			return 1

/atom/movable/MouseDrop_T(mob/living/M, mob/living/user)
	. = ..()
	if(can_buckle && istype(M) && !buckled_mob)
		if(user_buckle_mob(M, user))
			return 1
*/