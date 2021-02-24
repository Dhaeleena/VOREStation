/client/proc/smite_vr(var/mob/living/carbon/human/target in player_list)
	set name = "Smite (Vore)"
	set desc = "Abuse a player with various 'special Vore-brand treatments' from a list."
	set category = "Fun"
	if(!check_rights(R_ADMIN|R_FUN))
		return

	if(!istype(target))
		return

	var/list/smite_types = list(SMITE_SHADEKIN_ATTACK,SMITE_SHADEKIN_NOMF,SMITE_REDSPACE_ABDUCT,SMITE_AUTOSAVE,SMITE_AUTOSAVE_WIDE)

	var/smite_choice = input("Select the type of SMITE for [target]","SMITE Type Choice") as null|anything in smite_types
	if(!smite_choice)
		return

	log_and_message_admins("[key_name(src)] has used SMITE (Vore) ([smite_choice]) on [key_name(target)].")
	feedback_add_details("admin_verb","SMITEV") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	switch(smite_choice)
		if(SMITE_REDSPACE_ABDUCT)
			redspace_abduction(target, src)

		if(SMITE_AUTOSAVE)
			fake_autosave(target, src)

		if(SMITE_AUTOSAVE_WIDE)
			fake_autosave(target, src, TRUE)

		else
			return //Injection? Don't print any messages.

var/redspace_abduction_z

/area/redspace_abduction
	name = "Another Time And Place"
	requires_power = FALSE
	dynamic_lighting = FALSE

/proc/redspace_abduction(mob/living/target, user)
	if(redspace_abduction_z < 0)
		to_chat(user,"<span class='warning'>The abduction z-level is already being created. Please wait.</span>")
		return
	if(!redspace_abduction_z)
		redspace_abduction_z = -1
		to_chat(user,"<span class='warning'>This is the first use of the verb this shift, it will take a minute to configure the abduction z-level. It will be z[world.maxz+1].</span>")
		var/z = ++world.maxz
		for(var/x = 1 to world.maxx)
			for(var/y = 1 to world.maxy)
				var/turf/T = locate(x,y,z)
				new /area/redspace_abduction(T)
				T.ChangeTurf(/turf/unsimulated/fake_space)
				T.plane = -100
				CHECK_TICK
		redspace_abduction_z = z

	if(!target || !user)
		return

	var/size_of_square = 26
	var/halfbox = round(size_of_square*0.5)
	target.transforming = TRUE
	to_chat(target,"<span class='danger'>You feel a strange tug, deep inside. You're frozen in momentarily...</span>")
	to_chat(user,"<span class='notice'>Beginning vis_contents copy to abduction site, player mob is frozen.</span>")
	sleep(1 SECOND)
	//Lower left corner of a working box
	var/llc_x = max(0,halfbox-target.x) + min(target.x+halfbox, world.maxx) - size_of_square
	var/llc_y = max(0,halfbox-target.y) + min(target.y+halfbox, world.maxy) - size_of_square

	//Copy them all
	for(var/x = llc_x to llc_x+size_of_square)
		for(var/y = llc_y to llc_y+size_of_square)
			var/turf/T_src = locate(x,y,target.z)
			var/turf/T_dest = locate(x,y,redspace_abduction_z)
			T_dest.vis_contents.Cut()
			T_dest.vis_contents += T_src
			T_dest.density = T_src.density
			T_dest.opacity = T_src.opacity
			CHECK_TICK

	//Feather the edges
	for(var/x = llc_x to llc_x+1) //Left
		for(var/y = llc_y to llc_y+size_of_square)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	for(var/x = llc_x+size_of_square-1 to llc_x+size_of_square) //Right
		for(var/y = llc_y to llc_y+size_of_square)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	for(var/x = llc_x to llc_x+size_of_square) //Top
		for(var/y = llc_y+size_of_square-1 to llc_y+size_of_square)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	for(var/x = llc_x to llc_x+size_of_square) //Bottom
		for(var/y = llc_y to llc_y+1)
			if(prob(50))
				var/turf/T = locate(x,y,redspace_abduction_z)
				T.density = FALSE
				T.opacity = FALSE
				T.vis_contents.Cut()

	target.forceMove(locate(target.x,target.y,redspace_abduction_z))
	to_chat(target,"<span class='danger'>The tug relaxes, but everything around you looks... slightly off.</span>")
	to_chat(user,"<span class='notice'>The mob has been moved. ([admin_jump_link(target,usr.client.holder)])</span>")

	target.transforming = FALSE

/proc/fake_autosave(var/mob/living/target, var/client/user, var/wide)
	if(!istype(target) || !target.client)
		to_chat(user, "<span class='warning'>Skipping [target] because they are not a /mob/living or have no client.</span>")
		return

	if(wide)
		for(var/mob/living/L in orange(user.view, user.mob))
			fake_autosave(L, user)
		return

	target.setMoveCooldown(10 SECONDS)

	to_chat(target, "<span class='notice' style='font: small-caps bold large monospace!important'>Autosaving your progress, please wait...</span>")
	target << 'sound/effects/ding.ogg'
	
	var/static/list/bad_tips = list(
		"Did you know that black shoes protect you from electrocution while hacking?",
		"Did you know that airlocks always have a wire that disables ID checks?",
		"You can always find at least 3 pairs of glowing purple gloves in maint!",
		"Phoron is not toxic if you've had a soda within 30 seconds of exposure!",
		"Space Mountain Wind makes you immune to damage from space for 30 seconds!",
		"A mask and air tank are all you need to be safe in space!",
		"When exploring maintenance, wearing no shoes makes you move faster!",
		"Did you know that the bartender's shotgun is loaded with harmless ammo?",
		"Did you know that the tesla and singulo only need containment for 5 minutes?")

	var/tip = pick(bad_tips)
	to_chat(target, "<span class='notice' style='font: small-caps bold large monospace!important'>Tip of the day:</span><br><span class='notice'>[tip]</span>")

	var/obj/screen/loader = new(target)
	loader.name = "Autosaving..."
	loader.desc = "A disc icon that represents your game autosaving. Please wait."
	loader.icon = 'icons/obj/discs_vr.dmi'
	loader.icon_state = "quicksave"
	loader.screen_loc = "NORTH-1, EAST-1"
	target.client.screen += loader

	spawn(10 SECONDS)
		if(target)
			to_chat(target, "<span class='notice' style='font: small-caps bold large monospace!important'>Autosave complete!</span>")
			if(target.client)
				target.client.screen -= loader
