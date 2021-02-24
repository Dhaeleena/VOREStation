/mob
	var/vantag_hud = 0			// Do I have the HUD enabled?
	var/flying = 0				// Allows flight
	var/mob/temporary_form		// For holding onto a temporary form

	var/disconnect_time = null		//Time of client loss, set by Logout(), for timekeeping

/mob/drop_location()
	if(temporary_form)
		return temporary_form.drop_location()
	return ..()