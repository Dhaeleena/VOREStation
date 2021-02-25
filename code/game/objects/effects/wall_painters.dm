//Paints the wall it spawns on, then dies
/obj/effect/paint
	name = "coat of paint"
	icon = 'icons/effects/effects.dmi'
	icon_state = "wall_paint_effect"
	layer = MAPPER_DECAL_LAYER

/obj/effect/paint/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/paint/LateInitialize()
	var/turf/simulated/wall/W = get_turf(src)
	if(istype(W))
		W.paint_color = color
		W.update_icon()
	var/obj/structure/wall_frame/WF = locate() in loc
	if(WF)
		WF.paint_color = color
		WF.update_icon()
	qdel(src)

/obj/effect/paint/command //Command Blue
	color = COLOR_COMMAND_BLUE

/obj/effect/paint/security //Security Red, woo!
	color = COLOR_NT_RED

/obj/effect/paint/engineering //Engineering Yellow!
	color = COLOR_AMBER

/obj/effect/paint/medical //Classic Medical Blue!
	color = COLOR_DEEP_SKY_BLUE

/obj/effect/paint/virology //Virology Green!
	color = COLOR_GREEN

/obj/effect/paint/cargo //Kinda the cargo tech jumpsuit color!
	color = COLOR_PALE_ORANGE

/obj/effect/paint/mining //Mining Brown color, also partially seen on regular cargo stuff too!
	color = COLOR_BEASTY_BROWN

/obj/effect/paint/atmos //Atmos Cyan!
	color = COLOR_CYAN

/obj/effect/paint/science //Science's classic purple!
	color = COLOR_VIOLET

/obj/effect/paint/civilian //Civilian Green color
	color = COLOR_CIVIE_GREEN

//Stripes the wall it spawns on, then dies
/obj/effect/paint_stripe
	name = "stripe of paint"
	icon = 'icons/effects/effects.dmi'
	icon_state = "wall_paint_effect"
	layer = MAPPER_DECAL_LAYER

/obj/effect/paint_stripe/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/paint_stripe/LateInitialize()
	var/turf/simulated/wall/W = get_turf(src)
	if(istype(W))
		W.stripe_color = color
		W.update_icon()
	var/obj/structure/wall_frame/WF = locate() in loc
	if(WF)
		WF.stripe_color = color
		WF.update_icon()
	qdel(src)

/obj/effect/paint_stripe/command //Command Blue
	color = COLOR_COMMAND_BLUE

/obj/effect/paint_stripe/security //Security Red, woo!
	color = COLOR_NT_RED

/obj/effect/paint_stripe/engineering //Engineering Yellow!
	color = COLOR_AMBER

/obj/effect/paint_stripe/medical //Classic Medical Blue!
	color = COLOR_DEEP_SKY_BLUE

/obj/effect/paint_stripe/virology //Virology Green!
	color = COLOR_GREEN

/obj/effect/paint_stripe/cargo //Kinda the cargo tech jumpsuit color!
	color = COLOR_PALE_ORANGE

/obj/effect/paint_stripe/mining //Mining Brown color, also partially seen on regular cargo stuff too!
	color = COLOR_BEASTY_BROWN

/obj/effect/paint_stripe/atmos //Atmos Cyan!
	color = COLOR_CYAN

/obj/effect/paint_stripe/science //Science's classic purple!
	color = COLOR_VIOLET

/obj/effect/paint_stripe/civilian //Civilian Green color
	color = COLOR_CIVIE_GREEN