//These define the Z-level values of various levels
//Map Load Order seems to determine Z-level assignment order
//Any new multi-z levels will likely be above the ship? Add a buffer level of admin walls or space to prevent connections from ship to anything else.
//Most important note: A landmark of type /landmark/mapdata must be present on the top of the stack of Z-levels, and edit the height variable
//	to be the top z of this stack. I named it ZLevelLandmark and it is currently in the lower left of the top level of the ship. Please leave it
//	in the lower left of the maps if you move it!
#define Z_LEVEL_STARGAZER_FLOOR_1			1
#define Z_LEVEL_STARGAZER_FLOOR_2			2
#define Z_LEVEL_STARGAZER_FLOOR_3			3
#define Z_LEVEL_STARGAZER_FLOOR_4			4
#define Z_LEVEL_STARGAZER_FLOOR_5			5

/datum/map/stargazer //Need to actually edit most of this to be correct later.
	name = "Stargazer"
	full_name = "The Stargazer"
	path = "stargazer"

	lobby_icon = 'icons/misc/title_vr.dmi'
	lobby_screens = list("tether2_night")

	zlevel_datum_type = /datum/map_z_level/stargazer

	station_name  = "The Stargazer"
	station_short = "Stargazer"
	dock_name     = "Stargazer Flightdeck"
	boss_name     = "Central Command"
	boss_short    = "CentCom"
	company_name  = "NanoTrasen"
	company_short = "NT"
	starsys_name  = "Virgo-Erigone"

	shuttle_docked_message = "The scheduled Orange Line tram to the %dock_name% has arrived. It will depart in approximately %ETD%."
	shuttle_leaving_dock = "The Orange Line tram has left the station. Estimate %ETA% until the tram arrives at %dock_name%."
	shuttle_called_message = "A scheduled crew transfer to the %dock_name% is occuring. The tram will be arriving shortly. Those departing should proceed to the Orange Line tram station within %ETA%."
	shuttle_recall_message = "The scheduled crew transfer has been cancelled."
	emergency_shuttle_docked_message = "The evacuation tram has arrived at the tram station. You have approximately %ETD% to board the tram."
	emergency_shuttle_leaving_dock = "The emergency tram has left the station. Estimate %ETA% until the shuttle arrives at %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation has begun, and an off-schedule tram has been called. It will arrive at the tram station in approximately %ETA%."
	emergency_shuttle_recall_message = "The evacuation tram has been recalled."

/datum/map_z_level/stargazer/first //This defines the first deck z-level of the Stargazer
	z = Z_LEVEL_STARGAZER_FLOOR_1
	name = "1st Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 20
	base_turf = /turf/space

/datum/map_z_level/stargazer/second //This defines the second deck z-level of the Stargazer
	z = Z_LEVEL_STARGAZER_FLOOR_2
	name = "2nd Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 20
	base_turf = /turf/simulated/open

/datum/map_z_level/stargazer/third //This defines the third deck z-level of the Stargazer
	z = Z_LEVEL_STARGAZER_FLOOR_3
	name = "3rd Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 20
	base_turf = /turf/simulated/open

/datum/map_z_level/stargazer/fourth //This defines the fourth deck z-level of the Stargazer
	z = Z_LEVEL_STARGAZER_FLOOR_4
	name = "4th Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 20
	base_turf = /turf/simulated/open

/datum/map_z_level/stargazer/fifth //This defines the fifth deck z-level of the Stargazer
	z = Z_LEVEL_STARGAZER_FLOOR_5
	name = "5th Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 20
	base_turf = /turf/simulated/open