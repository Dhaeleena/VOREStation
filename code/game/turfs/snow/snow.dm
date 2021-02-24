/turf/snow
    name = "snow"

    dynamic_lighting = 0
    icon = 'icons/turf/snow.dmi'
    icon_state = "snow"

    oxygen = MOLES_O2STANDARD * 1.15
    nitrogen = MOLES_N2STANDARD * 1.15

    temperature = TN60C
    var/list/crossed_dirs = list()

#define FOOTSTEP_SPRITE_AMT 2

/turf/snow/Entered(atom/A)
    if(ismob(A))
        var/mdir = "[A.dir]"
        if(crossed_dirs[mdir])
            crossed_dirs[mdir] = min(crossed_dirs[mdir] + 1, FOOTSTEP_SPRITE_AMT)
        else
            crossed_dirs[mdir] = 1

        update_icon()

    . = ..()

/turf/snow/update_icon()
    cut_overlays()
    for(var/d in crossed_dirs)
        var/amt = crossed_dirs[d]

        for(var/i in 1 to amt)
            add_overlay(image(icon, "footprint[i]", text2num(d)))

/turf/snow/snowblue
	name = "snow"
	icon_state = "snowblue"

/turf/snow/gravsnow
	name = "snow"
	icon_state = "gravsnow"

/turf/snow/snowwhite
	name = "snow"
	icon_state = "snow_white"

/turf/snow/snowwhite/rock
	name = "snow"
	icon_state = "snow_white1"

/turf/snow/snowwhite/rock1
	name = "snow"
	icon_state = "snow_white4"

/turf/snow/snowwhite/rock2
	name = "snow"
	icon_state = "snow_white5"

/turf/snow/snowwhite/rock3
	name = "snow"
	icon_state = "snow_white8"

/turf/snow/snowwhite/rock4
	name = "snow"
	icon_state = "snow_white9"

/turf/snow/snowwhite/rock5
	name = "snow"
	icon_state = "snow_white10"

/turf/snow/snowwhite/rock6
	name = "snow"
	icon_state = "snow_white11"

/turf/snow/snowwhite/rock7
	name = "snow"
	icon_state = "snow_white12"

/turf/snow/snowwhite/puffs
	name = "snow"
	icon_state = "snow_white2"

/turf/snow/snowwhite/puffs1
	name = "snow"
	icon_state = "snow_white3"

/turf/snow/snowwhite/puffs2
	name = "snow"
	icon_state = "snow_white6"

/turf/snow/snowwhite/prints
	name = "snow"
	icon_state = "snow_white7"

/turf/snow/permafrost
    name = "permafrost"
    icon_state = "permafrost"

/turf/snow/plating
	name = "snowy plating"
	icon_state = "snowyplating"

/turf/snow/drift
	name = "snowy plating"
	icon_state = "snowyplatingdrift"

/turf/snow/dusting
	name = "snowy plating"
	icon_state = "snowplating"

/turf/snow/ice
	name = "ice"
	icon_state = "ice"
