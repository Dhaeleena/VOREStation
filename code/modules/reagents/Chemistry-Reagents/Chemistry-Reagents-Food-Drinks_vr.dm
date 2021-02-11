/datum/reagent/nutriment
	nutriment_factor = 10

/datum/reagent/toxin/meatcolony
	name = "A colony of meat cells"
	id = "meatcolony"
	description = "Specialised cells designed to produce a large amount of meat once activated, whilst manufacturers have managed to stop these cells from taking over the body when ingested, it's still poisonous."
	taste_description = "a fibrous mess"
	reagent_state = LIQUID
	color = "#ff2424"
	strength = 10

/datum/reagent/toxin/plantcolony
	name = "A colony of plant cells"
	id = "plantcolony"
	description = "Specialised cells designed to produce a large amount of nutriment once activated, whilst manufacturers have managed to stop these cells from taking over the body when ingested, it's still poisonous."
	taste_description = "a fibrous mess"
	reagent_state = LIQUID
	color = "#7ce01f"
	strength = 10

/datum/reagent/nutriment/grubshake
	name = "Grub shake"
	id = "grubshake"
	description = "An odd fluid made from grub guts, supposedly filling."
	taste_description = "sparkles"
	taste_mult = 1.3
	nutriment_factor = 5
	color = "#fff200"

/datum/reagent/lipozine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjust_nutrition(-20 * removed)

/datum/reagent/ethanol/deathbell
	name = "Deathbell"
	id = "deathbell"
	description = "A successful experiment to make the most alcoholic thing possible."
	taste_description = "your brains smashed out by a smooth brick of hard, ice cold alcohol"
	color = "#9f6aff"
	taste_mult = 5
	strength = 10
	adj_temp = 10
	targ_temp = 330

	glass_name = "Deathbell"
	glass_desc = "The perfect blend of the most alcoholic things a bartender can get their hands on."

/datum/reagent/ethanol/deathbell/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()

	if(dose * strength >= strength) // Early warning
		M.make_dizzy(24) // Intentionally higher than normal to compensate for it's previous effects.
	if(dose * strength >= strength * 2.5) // Slurring takes longer. Again, intentional.
		M.slurring = max(M.slurring, 30)

/datum/reagent/ethanol/pink_moo
	name = "Pink Moo"
	id = "pinkmoo"
	description = "Like a White Russian but with 100% more pink!"
	taste_description = "strawberry icecream, with a coffee kick"
	color = "#d789bd"
	strength = 15

	glass_name = "Pink Moo"
	glass_desc = "A very familiar looking drink. ...moo?"

/datum/reagent/ethanol/originalsin
	name = "Original Sin"
	id = "originalsin"
	description = "Angel Ichor, entirely transformed by one drop of apple juice"
	taste_description = "the apple Eve gave to Adam"
	color = "#99CC35"
	strength = 17

	glass_name = "Original Sin"
	glass_desc = "A drink so fine, you may just risk eternal damnation!"

/datum/reagent/ethanol/newyorksour
	name = "New York Sour"
	id = "newyorksour"
	description = "Whiskey sour, with a layer of wine and egg white."
	taste_description = "refreshing lemoned whiskey, smoothed with wine"
	color = "#FFBF3C"
	strength = 17

	glass_name = "New York Sour"
	glass_desc = "A carefully poured three layered drink"

/datum/reagent/ethanol/windgarita
	name = "WND-Garita"
	id = "windgarita"
	description = "A highly questionable combination of margarita and Space Mountain Wind"
	taste_description = "like sin, and some tequilia"
	color = "#90D93D"
	strength = 15

	glass_name = "WND-Garita"
	glass_desc = "Who the hell comes up with these drinks?!"

/datum/reagent/ethanol/mudslide
	name = "Mudslide"
	id = "mudslide"
	description = "Vodka, Kahlua and Irish Cream together at last."
	taste_description = "a mocha milkshake, with a splash of vodka."
	color = "#8B6338"
	strength = 13

	glass_name = "Mudslide"
	glass_desc = "A richly coloured drink, comes with a chocolate garnish!"

/datum/reagent/nutriment/magicdust/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	playsound(M, 'sound/items/hooh.ogg', 50, 1, -1)
	if(prob(5))
		to_chat(M, "<span class='warning'>You feel like you've been gnomed...</span>")



/datum/reagent/ethanol/galacticpanic
	name = "Galactic Panic Attack"
	id = "galacticpanic"
	description = "The absolute worst thing you could ever put in your body."
	taste_description = "an entire galaxy collasping in on itself."
	strength = 10
	druggy = 50
	halluci = 30
	var/adj_dizzy = 10
	color = "#d3785d"

	glass_name = "Galactic Panic Attack"
	glass_desc = "Looking into this is like staring at the stars."

/datum/reagent/ethanol/galacticpanic/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	M.Stun(2)

/datum/reagent/ethanol/galacticpanic/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()

	if(dose * strength >= strength) // Early warning
		M.make_dizzy(24) // Intentionally higher than normal to compensate for it's previous effects.
	if(dose * strength >= strength * 2.5) // Slurring takes longer. Again, intentional.
		M.slurring = max(M.slurring, 30)

/datum/reagent/ethanol/bulldog
	name = "Space Bulldog"
	id = "bulldog"
	description = "An inventive kahlua recipe."
	taste_description = "fizzy, creamy, soda and coffee hell."
	strength = 30
	color = "#d3785d"

	glass_name = "Space Bulldog"
	glass_desc = "It looks like someone poured cola in a cup of coffee."


/datum/reagent/ethanol/sbagliato
	name = "Negroni Sbagliato"
	id = "sbagliato"
	description = "A drink invented because a bartender was too drunk."
	taste_description = "sweet bubbly wine and vermouth."
	strength = 30
	color = "#d3785d"

	glass_name = "Negroni Sbagliato"
	glass_desc = "Bubbles constantly pop up to the surface with a quiet fizz."


/datum/reagent/ethanol/italiancrisis
	name = "Italian Crisis"
	id = "italiancrisis"
	description = "This drink was concocted by a madwoman, causing the Italian Crisis of 2123."
	taste_description = "cola, fruit, fizz, coffee, and cream swirled together in an old boot."
	strength = 20
	druggy = 0
	halluci = 0
	var/adj_dizzy = 0
	color = "#d3785d"

	glass_name = "Italian Crisis"
	glass_desc = "This drink looks like it was a mistake."

/datum/reagent/ethanol/sugarrush
	name = "Sweet Rush"
	id = "sugarrush"
	description = "A favorite drink amongst poor bartenders living in Neo Detroit."
	taste_description = "sweet bubblegum vodka."
	strength = 30
	color = "#d3785d"

	glass_name = "Sweet Rush"
	glass_desc = "This looks like it might rot your teeth out."

/datum/reagent/ethanol/lotus
	name = "Lotus"
	id = "lotus"
	description = "The result of making one mistake after another and trying to cover it up with sugar."
	taste_description = "rich, sweet fruit and even more sugar."
	strength = 25
	color = "#d3785d"

	glass_name = "Lotus"
	glass_desc = "A promotional drink for a movie that only ever played in Neo Detroit theatres."

/datum/reagent/ethanol/shroomjuice
	name = "Dumb Shroom Juice"
	id = "shroomjuice"
	description = "The mushroom farmer didn't sort through their stock very well."
	taste_description = "sweet and sour citrus with a savory kick."
	strength = 100
	druggy = 30
	halluci = 30
	var/adj_dizzy = 30
	color = "#d3785d"

	glass_name = "Dumb Shroom Juice"
	glass_desc = "Touch fuzzy, get dizzy."

/datum/reagent/ethanol/russianroulette
	name = "Russian Roulette"
	id = "russianroulette"
	description = "The perfect drink for wagering your liver on a game of cards."
	taste_description = "coffee, vodka, cream, and a hot metal slug."
	strength = 30
	var/adj_dizzy = 30
	color = "#d3785d"

	glass_name = "Russian Roulette"
	glass_desc = "A favorite drink amongst the Pan-Slavic speaking community."

/datum/reagent/ethanol/russianroulette/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	M.Stun(2)

/datum/reagent/ethanol/lovemaker
	name = "The Love Maker"
	id = "lovemaker"
	description = "A drink said to help one find true love."
	taste_description = "sweet fruit and honey."
	strength = 30
	druggy = 0
	halluci = 0
	var/adj_dizzy = 30
	adj_temp = 10
	targ_temp = 360
	color = "#d3785d"

	glass_name = "The Love Maker"
	glass_desc = "A drink said to help one find the perfect fuck."

/datum/reagent/ethanol/honeyshot
	name = "Honey Shot"
	id = "honeyshot"
	description = "The perfect drink for bees."
	taste_description = "sweet tart grenadine flavored with honey."
	strength = 40
	var/adj_dizzy = 10
	color = "#d3785d"

	glass_name = "Honey shot"
	glass_desc = "A glass of golden liquid."

/datum/reagent/ethanol/appletini
	name = "Appletini"
	id = "appletini"
	description = "A classic cocktail using every grandma's favorite fruit."
	taste_description = "green sour apple with a hint of alcohol."
	strength = 45
	color = "#d3785d"

	glass_name = "Appletini"
	glass_desc = "The perfect fruit cocktail for a fancy night at the bar."

/datum/reagent/ethanol/glowingappletini
	name = "Glowing Appletini"
	id = "glowingappletini"
	description = "A new nuclear take on a pre-modern classic!"
	taste_description = "overwhelmingly sour apples powered by a nuclear fission reactor."
	strength = 30
	druggy = 20
	var/adj_dizzy = 20
	color = "#d3785d"

	glass_name = "Glowing Appletini"
	glass_desc = "The atomic option to fruity cocktails."

/datum/reagent/ethanol/scsatw
	name = "Slow Comfortable Screw Against the Wall"
	id = "scsatw"
	description = "The screwdriver's bigger cousin."
	taste_description = "smooth, savory booze and tangy orange juice."
	strength = 30
	druggy = 0
	halluci = 0
	var/adj_dizzy = 0
	color = "#d3785d"

	glass_name = "Slow Comfortable Screw Against the Wall"
	glass_desc = "The best accessory to daydrinking."

/datum/reagent/drink/choccymilk
	name = "Choccy Milk"
	id = "choccymilk"
	description = "Coco and milk, a timeless classic."
	taste_description = "sophisticated bittersweet chocolate mixed with silky, creamy, whole milk."
	color = "#d3785d"

	glass_name = "Choccy Milk"
	glass_desc = "The most iconic duo in the galaxy, chocolate, and milk."

/datum/reagent/ethanol/redspaceflush
	name = "Red Space Flush"
	id = "redspaceflush"
	description = "A drink made by imbueing the essence of redspace into the spirits."
	taste_description = "whiskey and rum strung out through a hellish dimensional rift."
	strength = 30
	druggy = 10
	var/adj_dizzy = 10
	color = "#d3785d"

	glass_name = "Redspace Flush"
	glass_desc = "A drink imbued with the very essence of Redspace."

/datum/reagent/drink/graveyard
	name = "Graveyard"
	id = "graveyard"
	description = "The result of taking a cup and filling it with all the drinks at the fountain."
	taste_description = "sugar and fizz."
	color = "#d3785d"

	glass_name = "Graveyard"
	glass_desc = "Hahaha softdrink machine go pshshhhhh..."

/datum/reagent/ethanol/bigbeer
	name = "Giant Beer"
	id = "bigbeer"
	description = "Bars in Neo Detroit started to sell this drink when the city put mandatory drink limits in 2289."
	taste_description = "beer, but bigger."
	strength = 40
	color = "#d3785d"

	glass_name = "Giant Beer"
	glass_desc = "The Neo Detroit beer and ale cocktail, perfect for your average drunk."

/datum/reagent/drink/sweettea
	name = "Sweet Tea"
	id = "sweettea"
	description = "Tea that is sweetened with some form of sweetener."
	taste_description = "tea that is sweet."
	color = "#d3785d"

	glass_name = "Sweet Tea"
	glass_desc = "A southern classic. Southern what? You know, southern."

/datum/reagent/ethanol/unsweettea
	name = "Unsweetened Tea"
	id = "unsweettea"
	description = "A sick experiment to take the sweetness out of tea after sugar has been added resulted in this."
	taste_description = "bland, slightly bitter, discount black tea."
	strength = 80
	druggy = 10
	color = "#d3785d"

	glass_name = "Unsweetened Tea"
	glass_desc = "A drink with all the calories of sweet tea, but with none of the satisfaction. Slightly psychoactive."
