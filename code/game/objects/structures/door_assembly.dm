/obj/structure/door_assembly
	name = "airlock assembly"
	icon = 'icons/obj/doors/station/door.dmi'
	icon_state = "construction"
	anchored = 0
	density = 1
	w_class = ITEMSIZE_HUGE
	var/state = 0
	var/base_icon_state = ""
	var/base_name = "airlock"
	var/obj/item/weapon/airlock_electronics/electronics = null
	var/airlock_type = /obj/machinery/door/airlock //the type path of the airlock once completed
	var/glass_type = /obj/machinery/door/airlock/glass
	var/glass = 0 // 0 = glass can be installed. -1 = glass can't be installed. 1 = glass is already installed. Text = mineral plating is installed instead.
	var/created_name = null
	var/panel_icon = 'icons/obj/doors/station/panel.dmi'
	var/fill_icon = 'icons/obj/doors/station/fill_steel.dmi'
	var/glass_icon = 'icons/obj/doors/station/fill_glass.dmi'
	var/paintable = AIRLOCK_PAINTABLE|AIRLOCK_STRIPABLE
	var/door_color = "none"
	var/stripe_color = "none"
	var/symbol_color = "none"

/obj/structure/door_assembly/New()
	update_state()

/obj/structure/door_assembly/door_assembly_com
	base_name = "Command airlock"
	door_color = COLOR_COMMAND_BLUE
	stripe_color = COLOR_GOLD

/obj/structure/door_assembly/door_assembly_sec
	base_name = "Security airlock"
	door_color = COLOR_NT_RED
	stripe_color = COLOR_DARK_ORANGE

/obj/structure/door_assembly/door_assembly_eng
	base_name = "Engineering airlock"
	door_color = COLOR_AMBER
	stripe_color = COLOR_FADED_MAROON

/obj/structure/door_assembly/door_assembly_atmo
	base_name = "Atmospherics airlock"
	door_color = COLOR_AMBER
	stripe_color = COLOR_CYAN

/obj/structure/door_assembly/door_assembly_eat
	base_name = "Engineering atmos airlock"
	door_color = COLOR_AMBER
	stripe_color = COLOR_FADED_MAROON

/obj/structure/door_assembly/door_assembly_med
	base_name = "Medical airlock"
	door_color = COLOR_WHITE
	stripe_color = COLOR_DEEP_SKY_BLUE

/obj/structure/door_assembly/door_assembly_research
	base_name = "Research airlock"
	door_color = COLOR_WHITE
	stripe_color = COLOR_PURPLE_GRAY

/obj/structure/door_assembly/door_assembly_min
	base_name = "Mining airlock"
	door_color = COLOR_PALE_ORANGE
	stripe_color = COLOR_BEASTY_BROWN

/obj/structure/door_assembly/door_assembly_fre
	base_name = "Freezer airlock"
	door_color = COLOR_WHITE

/obj/structure/door_assembly/door_assembly_ext
	icon = 'icons/obj/doors/external/door.dmi'
	fill_icon = 'icons/obj/doors/external/fill_steel.dmi'
	glass_icon = 'icons/obj/doors/external/fill_glass.dmi'
	base_name = "External airlock"
	airlock_type = /obj/machinery/door/airlock/external
	glass_type = /obj/machinery/door/airlock/external/glass
	paintable = 0

/obj/structure/door_assembly/door_assembly_hatch
	icon = 'icons/obj/doors/hatch/door.dmi'
	panel_icon = 'icons/obj/doors/hatch/panel.dmi'
	fill_icon = 'icons/obj/doors/hatch/fill_steel.dmi'
	base_name = "Airtight Hatch"
	airlock_type = /obj/machinery/door/airlock/hatch
	glass = -1

/obj/structure/door_assembly/door_assembly_highsecurity // Borrowing this until WJohnston makes sprites for the assembly
	icon = 'icons/obj/doors/secure/door.dmi'
	fill_icon = 'icons/obj/doors/secure/fill_steel.dmi'
	base_name = "High Security Airlock"
	airlock_type = /obj/machinery/door/airlock/highsecurity
	glass = -1
	paintable = 0

/obj/structure/door_assembly/door_assembly_voidcraft
	icon = 'icons/obj/doors/shuttledoors.dmi'
	base_name = "voidcraft hatch"
	airlock_type = /obj/machinery/door/airlock/voidcraft
	glass = -1

/obj/structure/door_assembly/door_assembly_voidcraft/vertical
	airlock_type = /obj/machinery/door/airlock/voidcraft/vertical

/obj/structure/door_assembly/door_assembly_alien
	icon = 'icons/obj/doors/Dooralien_blue.dmi'
	base_name = "alien airlock"
	airlock_type = /obj/machinery/door/airlock/alien/blue
	glass = -1

/obj/structure/door_assembly/multi_tile
	icon = 'icons/obj/doors/double/door.dmi'
	fill_icon = 'icons/obj/doors/double/fill_steel.dmi'
	glass_icon = 'icons/obj/doors/double/fill_glass.dmi'
	panel_icon = 'icons/obj/doors/double/panel.dmi'
	dir = EAST
	var/width = 1
	airlock_type = /obj/machinery/door/airlock/multi_tile
	glass_type = /obj/machinery/door/airlock/multi_tile/glass

/obj/structure/door_assembly/multi_tile/New()
	if(dir in list(EAST, WEST))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size
	update_state()

/obj/structure/door_assembly/multi_tile/Moved(atom/old_loc, direction, forced = FALSE)
	. = ..()
	if(dir in list(EAST, WEST))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size

/obj/structure/door_assembly/proc/rename_door(mob/living/user)
	var/t = sanitizeSafe(input(user, "Enter the name for the windoor.", src.name, src.created_name), MAX_NAME_LEN)
	if(!in_range(src, user) && src.loc != user)	return
	created_name = t
	update_state()

/obj/structure/door_assembly/attack_robot(mob/living/silicon/robot/user)
	if(Adjacent(user) && (user.module && (istype(user.module,/obj/item/weapon/robot_module/robot/engineering/general)) \
	|| istype(user.module,/obj/item/weapon/robot_module/drone))) //Only dron (and engiborg) needs this.
		rename_door(user)

/obj/structure/door_assembly/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/pen))
		rename_door(user)
		return

	if(istype(W, /obj/item/weapon/weldingtool) && ( (istext(glass)) || (glass == 1) || (!anchored) ))
		var/obj/item/weapon/weldingtool/WT = W
		if (WT.remove_fuel(0, user))
			playsound(src, WT.usesound, 50, 1)
			if(istext(glass))
				user.visible_message("[user] welds the [glass] plating off the airlock assembly.", "You start to weld the [glass] plating off the airlock assembly.")
				if(do_after(user, 40 * WT.toolspeed))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You welded the [glass] plating off!</span>")
					var/M = text2path("/obj/item/stack/material/[glass]")
					new M(src.loc, 2)
					glass = 0
			else if(glass == 1)
				user.visible_message("[user] welds the glass panel out of the airlock assembly.", "You start to weld the glass panel out of the airlock assembly.")
				if(do_after(user, 40 * WT.toolspeed))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You welded the glass panel out!</span>")
					new /obj/item/stack/material/glass/reinforced(src.loc)
					glass = 0
			else if(!anchored)
				user.visible_message("[user] dissassembles the airlock assembly.", "You start to dissassemble the airlock assembly.")
				if(do_after(user, 40 * WT.toolspeed))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You dissasembled the airlock assembly!</span>")
					new /obj/item/stack/material/steel(src.loc, 4)
					qdel (src)
		else
			to_chat(user, "<span class='notice'>You need more welding fuel.</span>")
			return

	else if(W.is_wrench() && state == 0)
		playsound(src, W.usesound, 100, 1)
		if(anchored)
			user.visible_message("[user] begins unsecuring the airlock assembly from the floor.", "You starts unsecuring the airlock assembly from the floor.")
		else
			user.visible_message("[user] begins securing the airlock assembly to the floor.", "You starts securing the airlock assembly to the floor.")

		if(do_after(user, 40 * W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You [anchored? "un" : ""]secured the airlock assembly!</span>")
			anchored = !anchored

	else if(istype(W, /obj/item/stack/cable_coil) && state == 0 && anchored)
		var/obj/item/stack/cable_coil/C = W
		if (C.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one length of coil to wire the airlock assembly.</span>")
			return
		user.visible_message("[user] wires the airlock assembly.", "You start to wire the airlock assembly.")
		if(do_after(user, 40) && state == 0 && anchored)
			if (C.use(1))
				src.state = 1
				to_chat(user, "<span class='notice'>You wire the airlock.</span>")

	else if(W.is_wirecutter() && state == 1 )
		playsound(src, W.usesound, 100, 1)
		user.visible_message("[user] cuts the wires from the airlock assembly.", "You start to cut the wires from airlock assembly.")

		if(do_after(user, 40 * W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You cut the airlock wires.!</span>")
			new/obj/item/stack/cable_coil(src.loc, 1)
			src.state = 0

	else if(istype(W, /obj/item/weapon/airlock_electronics) && state == 1)
		playsound(src, W.usesound, 100, 1)
		user.visible_message("[user] installs the electronics into the airlock assembly.", "You start to install electronics into the airlock assembly.")

		if(do_after(user, 40))
			if(!src) return
			user.drop_item()
			W.loc = src
			to_chat(user, "<span class='notice'>You installed the airlock electronics!</span>")
			src.state = 2
			src.electronics = W

	else if(W.is_crowbar() && state == 2 )
		//This should never happen, but just in case I guess
		if (!electronics)
			to_chat(user, "<span class='notice'>There was nothing to remove.</span>")
			src.state = 1
			return

		playsound(src, W.usesound, 100, 1)
		user.visible_message("\The [user] starts removing the electronics from the airlock assembly.", "You start removing the electronics from the airlock assembly.")

		if(do_after(user, 40 * W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You removed the airlock electronics!</span>")
			src.state = 1
			electronics.loc = src.loc
			electronics = null

	else if(istype(W, /obj/item/stack/material) && !glass)
		var/obj/item/stack/S = W
		var/material_name = S.get_material_name()
		if (S)
			if (S.get_amount() >= 1)
				if(material_name == "rglass")
					playsound(src, 'sound/items/Crowbar.ogg', 100, 1)
					user.visible_message("[user] adds [S.name] to the airlock assembly.", "You start to install [S.name] into the airlock assembly.")
					if(do_after(user, 40) && !glass)
						if (S.use(1))
							to_chat(user, "<span class='notice'>You installed reinforced glass windows into the airlock assembly.</span>")
							glass = 1
				else if(material_name)
					// Ugly hack, will suffice for now. Need to fix it upstream as well, may rewrite mineral walls. ~Z
					if(!(material_name in list("gold", "silver", "diamond", "uranium", "phoron", "sandstone")))
						to_chat(user, "You cannot make an airlock out of that material.")
						return
					if(S.get_amount() >= 2)
						playsound(src, 'sound/items/Crowbar.ogg', 100, 1)
						user.visible_message("[user] adds [S.name] to the airlock assembly.", "You start to install [S.name] into the airlock assembly.")
						if(do_after(user, 40) && !glass)
							if (S.use(2))
								to_chat(user, "<span class='notice'>You installed [material_display_name(material_name)] plating into the airlock assembly.</span>")
								glass = material_name

	else if(W.is_screwdriver() && state == 2 )
		playsound(src, W.usesound, 100, 1)
		to_chat(user, "<span class='notice'>Now finishing the airlock.</span>")

		if(do_after(user, 40 * W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You finish the airlock!</span>")
			var/path
			if(istext(glass))
				path = text2path("/obj/machinery/door/airlock/[glass]")
			else if (glass == 1)
				path = glass_type
			else
				path = airlock_type

			new path(src.loc, src)
			qdel(src)
	else
		..()
	update_state()

/obj/structure/door_assembly/proc/update_state()
	overlays.Cut()
	var/image/filling_overlay
	var/image/panel_overlay
	var/final_name = ""
	if(glass == 1)
		filling_overlay = image(glass_icon, "construction")
	else
		filling_overlay = image(fill_icon, "construction")
	switch (state)
		if(0)
			if (anchored)
				final_name = "Secured "
		if(1)
			final_name = "Wired "
			panel_overlay = image(panel_icon, "construction0")
		if(2)
			final_name = "Near Finished "
			panel_overlay = image(panel_icon, "construction1")
	final_name += "[glass == 1 ? "Window " : ""][istext(glass) ? "[glass] Airlock" : base_name] Assembly"
	name = final_name
	overlays += filling_overlay
	overlays += panel_overlay

// Airlock frames are indestructable, so bullets hitting them would always be stopped.
// To fix this, airlock assemblies will sometimes let bullets pass through, since generally the sprite shows them partially open.
/obj/structure/door_assembly/bullet_act(var/obj/item/projectile/P)
	if(prob(40)) // Chance for the frame to let the bullet keep going.
		return PROJECTILE_CONTINUE
	return ..()
