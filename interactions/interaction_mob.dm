/mob/proc/has_hands()
	return 0

/mob/living/carbon/human/has_hands()
	return 1//(can_use_hand("l_hand") || can_use_hand("r_hand"))

/mob/proc/has_mouth()
	return 1

/mob/proc/mouth_is_free()
	return 1

/mob/proc/foot_is_free()
	return 1

///mob/living/carbon/human/has_mouth()
//	var/datum/organ/external/head/head = get_organ("head")
//	return head && !(head.status & ORGAN_DESTROYED)

/mob/living/carbon/human/mouth_is_free()
	return !wear_mask

/mob/living/carbon/human/foot_is_free()
	return !shoes

/atom/movable/attack_hand(mob/living/user)
	. = ..()
	if(can_buckle && has_buckled_mobs())
		if(user_unbuckle_mob(user))
			return 1