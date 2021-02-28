//Terribly sorry for the code doubling, but things go derpy otherwise.
/obj/machinery/door/airlock/multi_tile
	airlock_type = "double"
	icon = 'icons/obj/doors/double/door.dmi'
	fill_file = 'icons/obj/doors/double/fill_steel.dmi'
	color_file = 'icons/obj/doors/double/color.dmi'
	color_fill_file = 'icons/obj/doors/double/fill_color.dmi'
	stripe_file = 'icons/obj/doors/double/stripe.dmi'
	stripe_fill_file = 'icons/obj/doors/double/fill_stripe.dmi'
	glass_file = 'icons/obj/doors/double/fill_glass.dmi'
	bolts_file = 'icons/obj/doors/double/lights_bolts.dmi'
	deny_file = 'icons/obj/doors/double/lights_deny.dmi'
	lights_file = 'icons/obj/doors/double/lights_green.dmi'
	panel_file = 'icons/obj/doors/double/panel.dmi'
	welded_file = 'icons/obj/doors/double/welded.dmi'
	emag_file = 'icons/obj/doors/double/emag.dmi'
	width = 2
	appearance_flags = 0
	opacity = 1
	assembly_type = /obj/structure/door_assembly/multi_tile
	var/obj/machinery/filler_object/filler1
	var/obj/machinery/filler_object/filler2
	open_sound_powered = 'sound/machines/door/WideOpen.ogg'
	close_sound_powered = 'sound/machines/door/WideClose.ogg'

/obj/machinery/door/airlock/multi_tile/New()
	..()
	SetBounds()
	if(opacity)
		create_fillers()

/obj/machinery/door/airlock/multi_tile/Destroy()
	QDEL_NULL(filler1)
	QDEL_NULL(filler2)
	return ..()

/obj/machinery/door/airlock/multi_tile/Moved(atom/old_loc, direction, forced = FALSE)
	. = ..()
	SetBounds()

/obj/machinery/door/airlock/multi_tile/open()
	. = ..()

	if(filler1)
		filler1.set_opacity(opacity)
		if(filler2)
			filler2.set_opacity(opacity)

	return .

/obj/machinery/door/airlock/multi_tile/close()
	. = ..()

	if(filler1)
		filler1.set_opacity(opacity)
		if(filler2)
			filler2.set_opacity(opacity)

	return .

/obj/machinery/door/airlock/multi_tile/proc/SetBounds()
	if(dir in list(NORTH, SOUTH))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size

/obj/machinery/door/airlock/multi_tile/proc/create_fillers()
	if(src.dir > 3)
		filler1 = new/obj/machinery/filler_object (src.loc)
		filler2 = new/obj/machinery/filler_object (get_step(src,EAST))
	else
		filler1 = new/obj/machinery/filler_object (src.loc)
		filler2 = new/obj/machinery/filler_object (get_step(src,NORTH))
	filler1.density = 0
	filler2.density = 0
	filler1.set_opacity(opacity)
	filler2.set_opacity(opacity)

/obj/machinery/door/airlock/multi_tile/update_icon(state=0, override=0)
	..()
	if(connections in list(NORTH, SOUTH, NORTH|SOUTH))
		if(connections in list(WEST, EAST, EAST|WEST))
			set_dir(SOUTH)
		else
			set_dir(WEST)
	else
		set_dir(SOUTH)

/obj/machinery/door/airlock/multi_tile/update_connections(var/propagate = 0)
	var/dirs = 0

	for(var/direction in GLOB.cardinal)
		var/turf/T = get_step(src, direction)
		var/success = 0

		if(direction in list(NORTH, EAST))
			T = get_step(T, direction)

		if( istype(T, /turf/simulated/wall))
			success = 1
			if(propagate)
				var/turf/simulated/wall/W = T
				W.update_connections()
				W.update_icon()

		else if( istype(T, /turf/simulated/shuttle/wall))
			success = 1
		else
			for(var/obj/O in T)
				for(var/b_type in blend_objects)
					if( istype(O, b_type))
						success = 1

					if(success)
						break
				if(success)
					break

		if(success)
			dirs |= direction
	connections = dirs

/obj/machinery/door/airlock/multi_tile/glass
	name = "Glass Airlock"
	hitsound = 'sound/effects/Glasshit.ogg'
	opacity = 0
	glass = 1

/obj/machinery/door/airlock/multi_tile/metal
	name = "Airlock"
	icon = 'icons/obj/doors/Door2x1metal.dmi'

/obj/machinery/filler_object
	name = ""
	icon = 'icons/obj/doors/rapid_pdoor.dmi'
	icon_state = ""
	density = 0

/obj/machinery/door/airlock/multi_tile/metal/mait
	icon = 'icons/obj/doors/Door2x1_Maint.dmi'
	//req_one_access = list(access_maint_tunnels) //VOREStaiton Edit - Maintenance is open access
