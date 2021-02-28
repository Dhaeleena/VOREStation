/obj/machinery/door/airlock/glass_external/public
	req_one_access = list()

/obj/machinery/door/airlock/alien/blue
	name = "hybrid airlock"
	desc = "You're fairly sure this is a door."
	catalogue_data = list(/datum/category_item/catalogue/anomalous/precursor_a/alien_airlock)
	icon = 'icons/obj/doors/Dooralien_blue.dmi'
	explosion_resistance = 20
	secured_wires = TRUE
	hackProof = TRUE
	assembly_type = /obj/structure/door_assembly/door_assembly_alien
	req_one_access = list()

/obj/machinery/door/airlock/alien/blue/locked
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/alien/blue/public // Entry to UFO.
	req_one_access = list()
	normalspeed = FALSE // So it closes faster and hopefully keeps the warm air inside.
	hackProof = TRUE //VOREStation Edit - No borgos

/obj/machinery/door/airlock/proc/toggle()
	if(glass)
		glass = 0
		if(!operating && density)
			animate(src, src.window_color=GLASS_COLOR_TINTED, time=5)
			set_opacity(1)
	else
		glass = 1
		if(!operating)
			animate(src, src.window_color=src.window_material.icon_colour, time=5)
			set_opacity(0)

/obj/machinery/button/windowtint/doortint
	name = "door tint control"
	desc = "A remote control switch for polarized glass doors."

/obj/machinery/button/windowtint/doortint/toggle_tint()
	use_power(5)
	active = !active
	update_icon()

	for(var/obj/machinery/door/airlock/D in range(src,range))
		if(D.polarized && (D.id == src.id || !D.id))
			spawn(0)
				D.toggle()
				return

/obj/machinery/door/airlock/glass/security/polarized
	name = "Electrochromic Security Airlock"
	polarized = 1

/obj/machinery/door/airlock/glass/medical/polarized
	name = "Electrochromic Medical Airlock"
	polarized = 1

/obj/machinery/door/airlock/glass/command/polarized
	name = "Electrochormic Command Airlock"
	polarized = 1
