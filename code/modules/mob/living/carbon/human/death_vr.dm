//Surprisingly this is only called for humans, but whatever!
/hook/death/proc/digestion_check(var/mob/living/carbon/human/H, var/gibbed)
	//Not in a belly? Well, too bad!
	if(!isbelly(H.loc))
		return TRUE
	
	//What belly!
	var/obj/belly/B = H.loc
	
	//Were they digesting and we have a mind you can update?
	//Technically allows metagaming by allowing buddies to turn on digestion for like 2 seconds
	//  to finish off critically wounded friends to avoid resleeving sickness, but like
	//  *kill those people* ok?
	if(B.digest_mode == DM_DIGEST)
		H.mind?.vore_death = TRUE

	//Hooks need to return true otherwise they're considered having failed
	return TRUE
