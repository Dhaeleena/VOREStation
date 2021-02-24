// Basically see-through walls. Used for windows
// If nothing has been built on the low wall, you can climb on it

/obj/structure/wall_frame
	name = "low wall"
	desc = "A low wall section which serves as the base of windows, amongst other things."
	icon = 'icons/obj/wall_frame.dmi'
	icon_state = "frame"

	anchored = 1
	density = 1
	can_atmos_pass = ATMOS_PASS_NO
	climbable = 1
	layer = TABLE_LAYER

	var/health
	var/maxhealth = 100
	var/paint_color
	var/stripe_color

	blend_objects = list(/obj/machinery/door, /turf/simulated/wall) // Objects which to blend with
	noblend_objects = list(/obj/machinery/door/window)
	material = DEFAULT_WALL_MATERIAL

/obj/structure/wall_frame/Initialize(var/new_loc, var/materialtype)
	..(new_loc)

	if(!materialtype)
		materialtype = DEFAULT_WALL_MATERIAL
	material = get_material_by_name(materialtype)
	health = maxhealth

	update_connections(1)
	update_icon()

/obj/structure/wall_frame/Destroy()
	var/turf/location = loc
	. = ..()
	for(var/obj/structure/wall_frame/W in orange(1, location))
		W.update_connections()
		W.update_icon()


/obj/structure/wall_frame/examine(mob/user)
	. = ..()

	if(health == maxhealth)
		to_chat(user, "<span class='notice'>It seems to be in fine condition.</span>")
	else
		var/dam = health / maxhealth
		if(dam <= 0.7)
			to_chat(user, "<span class='notice'>It's got a few dents and scratches.</span>")
		else if(dam <= 0.3)
			to_chat(user, "<span class='warning'>A few pieces of panelling have fallen off.</span>")
		else
			to_chat(user, "<span class='danger'>It's nearly falling to pieces.</span>")
	if(paint_color)
		to_chat(user, "<span class='notice'>It has a smooth coat of paint applied.</span>")

/obj/structure/wall_frame/attackby(obj/item/W, mob/user)
	src.add_fingerprint(user)

	//grille placing
	if(istype(W, /obj/item/stack/rods))
		for(var/obj/structure/window/WINDOW in loc)
			if(WINDOW.dir == get_dir(src, user))
				to_chat(user, "<span class='notice'>There is a window in the way.</span>")
				return
		place_grille(user, loc, W)
		return

	/*window placing //Commented out until Window Code is reworked.
	else if(istype(W,/obj/item/stack/material))
		var/obj/item/stack/material/ST = W
		if(ST.material.opacity > 0.7)
			return 0
		place_window(user, loc, ST)
    */

	if(W.is_wrench())
		for(var/obj/structure/S in loc)
			if(istype(S, /obj/structure/window))
				to_chat(user, "<span class='notice'>There is still a window on the low wall!</span>")
				return
			else if(istype(S, /obj/structure/grille))
				to_chat(user, "<span class='notice'>There is still a grille on the low wall!</span>")
				return
		playsound(src.loc, W.usesound, 75, 1)
		to_chat(user, "<span class='notice'>Now disassembling the low wall...</span>")
		if(do_after(user, 40,src))
			to_chat(user, "<span class='notice'>You dissasembled the low wall!</span>")
			dismantle()

	return ..()

/obj/structure/wall_frame/proc/place_grille(mob/user, loc, obj/item/stack/rods/ST)
	if(ST.get_amount() < 2)
		to_chat(user, "<span class='warning'>You need at least two rods to do this.</span>")
		return
	to_chat(user, "<span class='notice'>Assembling grille...</span>")
	if (!do_after(user, 10))
		return
	if(!ST.use(2))
		return
	var/obj/structure/grille/F = new /obj/structure/grille(loc)
	to_chat(user, "<span class='notice'>You assemble a grille</span>")
	F.add_fingerprint(user)

/* //This has been trimmed down from Bay to only make full walls on the wall frame. Commented out for now due to Window Code not exactly being helpful to make variable material windows... -Jon
/obj/structure/wall_frame/proc/place_window(mob/user, loc, obj/item/stack/material/ST)
	if (!ST.can_use(2))
		to_chat(user, "<span class='notice'>You do not have enough sheets.</span>")
		return
	for(var/obj/structure/window/WINDOW in loc)
		if(WINDOW.is_fulltile())
			to_chat(user, "<span class='notice'>There is already a window there.</span>")
			return
	to_chat(user, "<span class='notice'>You start placing the window.</span>")
	if(do_after(user,20))
		for(var/obj/structure/window/WINDOW in loc)
			if(WINDOW.is_fulltile())
				to_chat(user, "<span class='notice'>There is already a window there.</span>")
				return

		if (ST.use(2))
			var/obj/structure/window/WD = new(loc, dir_to_set, FALSE, ST.material.name, ST.reinf_material && ST.reinf_material.name)
			to_chat(user, "<span class='notice'>You place [WD].</span>")
			WD.construction_state = 0
			WD.set_anchored(FALSE)
		else
			to_chat(user, "<span class='notice'>You do not have enough sheets.</span>")
			return
*/

/obj/structure/wall_frame/CanPass(atom/movable/mover, turf/target)
	if(istype(mover,/obj/item/projectile))
		return 1
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1

// icon related

/obj/structure/wall_frame/update_icon()
	overlays.Cut()
	var/image/I

	var/new_color = (paint_color ? paint_color : material.icon_colour)
	color = new_color

	for(var/i = 1 to 4)
		if(other_connections[i] != "0")
			I = image('icons/obj/wall_frame.dmi', "frame_other[connections[i]]", dir = 1<<(i-1))
		else
			I = image('icons/obj/wall_frame.dmi', "frame[connections[i]]", dir = 1<<(i-1))
		overlays += I

	if(stripe_color)
		for(var/i = 1 to 4)
			if(other_connections[i] != "0")
				I = image('icons/obj/wall_frame.dmi', "stripe_other[connections[i]]", dir = 1<<(i-1))
			else
				I = image('icons/obj/wall_frame.dmi', "stripe[connections[i]]", dir = 1<<(i-1))
			I.color = stripe_color
			overlays += I

/obj/structure/wall_frame/bullet_act(var/obj/item/projectile/Proj)
	var/proj_damage = Proj.get_structure_damage()
	var/damage = min(proj_damage, 100)
	take_damage(damage)
	return

/obj/structure/wall_frame/hitby(AM as mob|obj)
	..()
	var/tforce = 0
	if(ismob(AM))
		tforce = 40
	else
		var/obj/item/I = AM
		tforce = I.throwforce
	if (tforce < 15)
		return
	take_damage(tforce)

/obj/structure/wall_frame/take_damage(damage)
	health -= damage
	if(health <= 0)
		dismantle()

/obj/structure/wall_frame/proc/dismantle()
	new /obj/item/stack/material/steel(get_turf(src), 3)
	qdel(src)

/obj/structure/wall_frame/get_color()
	return paint_color

/obj/structure/wall_frame/set_color(var/color)
	paint_color = color
	update_icon()

//Subtypes
/obj/structure/wall_frame/standard
	paint_color = "#666666"

/obj/structure/wall_frame/titanium
	material = MAT_TITANIUM

/obj/structure/wall_frame/hull
	paint_color = "#666677"

/obj/structure/wall_frame/hull/vox
	paint_color = "#8daf6a"

/obj/structure/wall_frame/hull/ascent
	paint_color = "#800080"

/obj/structure/wall_frame/hull/verne
	paint_color = "#666666"