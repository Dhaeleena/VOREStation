//These define the Z-level values of various levels
//Map Load Order seems to determine Z-level assignment order
#define Z_LEVEL_STARGAZER_FLOOR_1			1
#define Z_LEVEL_STARGAZER_FLOOR_2			2
#define Z_LEVEL_STARGAZER_FLOOR_3			3

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

/datum/map_z_level/stargazer/first
	z = Z_LEVEL_STARGAZER_FLOOR_1
	name = "First Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 33

/datum/map_z_level/stargazer/second
	z = Z_LEVEL_STARGAZER_FLOOR_2
	name = "Second Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 33
	base_turf = /turf/simulated/open

/datum/map_z_level/stargazer/third
	z = Z_LEVEL_STARGAZER_FLOOR_3
	name = "Third Floor"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER
	transit_chance = 33
	base_turf = /turf/simulated/open