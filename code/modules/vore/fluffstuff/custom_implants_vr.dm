/*
//WickedTempest: Chakat Tempest
/obj/item/weapon/implant/reagent_generator/tempest
	generated_reagents = list("milk" = 2)
	reagent_name = "milk"
	usable_volume = 1000

	empty_message = list("Your breasts are almost completely drained!")
	full_message = list("Your teats feel heavy and swollen!")
	emote_descriptor = list("squeezes milk", "tugs on Tempest's breasts, milking them")
	self_emote_descriptor = list("squeeze")
	random_emote = list("moos quietly")
	verb_name = "Milk"
	verb_desc = "Grab Tempest's nipples and milk them into a container! May cause blushing and groaning."

/obj/item/weapon/implanter/reagent_generator/tempest
	implant_type = /obj/item/weapon/implant/reagent_generator/tempest

//SpoopyLizz: Roiz Lizden
//I made this! Woo!
//implant
//--------------------
/obj/item/weapon/implant/reagent_generator/roiz
	name = "egg laying implant"
	desc = "This is an implant that allows the user to lay eggs."
	generated_reagents = list("egg" = 2)
	usable_volume = 500
	transfer_amount = 50

	empty_message = list("Your lower belly feels smooth and empty. Sorry, we're out of eggs!", "The reduced pressure in your lower belly tells you there are no more eggs.")
	full_message = list("Your lower belly looks swollen with irregular bumps, and it feels heavy.", "Your lower abdomen feels really heavy, making it a bit hard to walk.")
	emote_descriptor = list("an egg right out of Roiz's lower belly!", "into Roiz' belly firmly, forcing him to lay an egg!", "Roiz really tight, who promptly lays an egg!")
	var/verb_descriptor = list("squeezes", "pushes", "hugs")
	var/self_verb_descriptor = list("squeeze", "push", "hug")
	var/short_emote_descriptor = list("lays", "forces out", "pushes out")
	self_emote_descriptor = list("lay", "force out", "push out")
	random_emote = list("hisses softly with a blush on his face", "yelps in embarrassment", "grunts a little")
	assigned_proc = /mob/living/carbon/human/proc/use_reagent_implant_roiz

/obj/item/weapon/implant/reagent_generator/roiz/post_implant(mob/living/carbon/source)
	START_PROCESSING(SSobj, src)
	to_chat(source, "<span class='notice'>You implant [source] with \the [src].</span>")
	source.verbs |= assigned_proc
	return 1

/obj/item/weapon/implanter/reagent_generator/roiz
	implant_type = /obj/item/weapon/implant/reagent_generator/roiz

/mob/living/carbon/human/proc/use_reagent_implant_roiz()
	set name = "Lay Egg"
	set desc = "Force Roiz to lay an egg by squeezing into his lower body! This makes the lizard extremely embarrassed, and it looks funny."
	set category = "Object"
	set src in view(1)

	//do_reagent_implant(usr)
	if(!isliving(usr) || !usr.checkClickCooldown())
		return

	if(usr.incapacitated() || usr.stat > CONSCIOUS)
		return

	var/obj/item/weapon/implant/reagent_generator/roiz/rimplant
	for(var/obj/item/organ/external/E in organs)
		for(var/obj/item/weapon/implant/I in E.implants)
			if(istype(I, /obj/item/weapon/implant/reagent_generator))
				rimplant = I
				break
	if (rimplant)
		if(rimplant.reagents.total_volume <= rimplant.transfer_amount)
			to_chat(src, "<span class='notice'>[pick(rimplant.empty_message)]</span>")
			return

		new /obj/item/weapon/reagent_containers/food/snacks/egg/roiz(get_turf(src))

		var/index = rand(0,3)

		if (usr != src)
			var/emote = rimplant.emote_descriptor[index]
			var/verb_desc = rimplant.verb_descriptor[index]
			var/self_verb_desc = rimplant.self_verb_descriptor[index]
			usr.visible_message("<span class='notice'>[usr] [verb_desc] [emote]</span>",
							"<span class='notice'>You [self_verb_desc] [emote]</span>")
		else
			visible_message("<span class='notice'>[src] [pick(rimplant.short_emote_descriptor)] an egg.</span>",
								"<span class='notice'>You [pick(rimplant.self_emote_descriptor)] an egg.</span>")
		if(prob(15))
			visible_message("<span class='notice'>[src] [pick(rimplant.random_emote)].</span>") // M-mlem.

		rimplant.reagents.remove_any(rimplant.transfer_amount)
*/

/obj/item/weapon/reagent_containers/food/snacks/egg/teshari
	name = "teshari egg"
	desc = "It's a large teshari egg."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "tesh_egg"
	filling_color = "#FDFFD1"
	volume = 12

/obj/item/weapon/reagent_containers/food/snacks/egg/teshari/New()
	..()
	reagents.add_reagent("egg", 10)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/egg/teshari/tesh2
	icon_state = "tesh_egg_2"

/*
/obj/item/weapon/implant/reagent_generator/pumila_nectar //Bugged. Two implants at once messes things up.
	generated_reagents = list("honey" = 2)
	reagent_name = "honey"
	usable_volume = 5000

	empty_message = list("You appear to be all out of nectar", "You feel as though you are lacking a majority of your nectar.")
	full_message = list("You appear to be full of nectar.", "You feel as though you are full of nectar!")
	emote_descriptor = list("squeezes nectar", "extracts nectar")
	self_emote_descriptor = list("squeeze", "extract")
	verb_name = "Extract Honey"
	verb_desc = "Obtain pumila's nectar and put it into a container!"

/obj/item/weapon/implanter/reagent_generator/pumila_nectar
	implant_type = /obj/item/weapon/implant/reagent_generator/pumila_nectar
*/
//Egg item
//-------------
/obj/item/weapon/reagent_containers/food/snacks/egg/roiz
	name = "lizard egg"
	desc = "It's a large lizard egg."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "egg_roiz"
	filling_color = "#FDFFD1"
	volume = 12

/obj/item/weapon/reagent_containers/food/snacks/egg/roiz/New()
	..()
	reagents.add_reagent("egg", 9)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/egg/roiz/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype( W, /obj/item/weapon/pen/crayon ))
		var/obj/item/weapon/pen/crayon/C = W
		var/clr = C.colourName

		if(!(clr in list("blue","green","mime","orange","purple","rainbow","red","yellow")))
			to_chat(user, "<span class='warning'>The egg refuses to take on this color!</span>")
			return

		to_chat(user, "<span class='notice'>You color \the [src] [clr]</span>")
		icon_state = "egg_roiz_[clr]"
		desc = "It's a large lizard egg. It has been colored [clr]!"
		if (clr == "rainbow")
			var/number = rand(1,4)
			icon_state = icon_state + num2text(number, 0)
	else
		..()

/obj/item/weapon/reagent_containers/food/snacks/friedegg/roiz
	name = "fried lizard egg"
	desc = "A large, fried lizard egg, with a touch of salt and pepper. It looks rather chewy."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "friedegg"
	volume = 12

/obj/item/weapon/reagent_containers/food/snacks/friedegg/roiz/New()
	..()
	reagents.add_reagent("protein", 9)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/boiledegg/roiz
	name = "boiled lizard egg"
	desc = "A hard boiled lizard egg. Be careful, a lizard detective may hatch!"
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "egg_roiz"
	volume = 12

/obj/item/weapon/reagent_containers/food/snacks/boiledegg/roiz/New()
	..()
	reagents.add_reagent("protein", 6)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/chocolateegg/roiz
	name = "chocolate lizard egg"
	desc = "Such huge, sweet, fattening food. You feel gluttonous just looking at it."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "chocolateegg_roiz"
	filling_color = "#7D5F46"
	nutriment_amt = 3
	nutriment_desc = list("chocolate" = 5)
	volume = 18

/obj/item/weapon/reagent_containers/food/snacks/chocolateegg/roiz/New()
	..()
	reagents.add_reagent("sugar", 6)
	reagents.add_reagent("coco", 6)
	reagents.add_reagent("milk", 2)
	bitesize = 2
