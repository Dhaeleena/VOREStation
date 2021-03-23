#if !defined(USING_MAP_DATUM)

	#include "stargazer-floor-1.dmm"
	#include "stargazer-floor-2.dmm"
	#include "stargazer-floor-3.dmm"

	#include "stargazer-floor-1-old.dmm"
	#include "stargazer-floor-2-old.dmm"
	#include "stargazer-floor-3-old.dmm"

	#include "stargazer_areas.dm"
	#include "stargazer_defines.dm"

	#define USING_MAP_DATUM /datum/map/stargazer

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Stargazer

#endif