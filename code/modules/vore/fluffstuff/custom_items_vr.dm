/* TUTORIAL
	"icon" is the file with the HUD/ground icon for the item
	"icon_state" is the iconstate in this file for the item
	"icon_override" is the file with the on-mob icons, can be the same file (Except for glasses, shoes, and masks.)
	"item_state" is the iconstate for the on-mob icons:
		item_state_s is used for worn uniforms on mobs
		item_state_r and item_state_l are for being held in each hand

	"item_state_slots" can replace "item_state", it is a list:
		item_state_slots["slotname1"] = "item state for that slot"
		item_state_slots["slotname2"] = "item state for that slot"
*/

/* TEMPLATE
//ckey:Character Name
/obj/item/weapon/fluff/charactername
	name = ""
	desc = ""

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "myicon"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "myicon"

*/

//For general use
/obj/item/device/modkit_conversion
	name = "modification kit"
	desc = "A kit containing all the needed tools and parts to modify a suit and helmet."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "modkit"
	var/parts = 3
	var/from_helmet = /obj/item/clothing/head/helmet/space/void
	var/from_suit = /obj/item/clothing/suit/space/void
	var/to_helmet = /obj/item/clothing/head/cardborg
	var/to_suit = /obj/item/clothing/suit/cardborg

	//conversion costs. refunds all parts by default, but can be tweaked per-kit
	var/from_helmet_cost = 1
	var/from_suit_cost = 2
	var/to_helmet_cost = -1
	var/to_suit_cost = -2

	var/owner_ckey = null		//ckey of the kit owner as a string
	var/skip_content_check = FALSE	//can we skip the contents check? we generally shouldn't, but this is necessary for rigs/coats with hoods/etc.
	var/transfer_contents = FALSE	//should we transfer the contents across before deleting? we generally shouldn't, esp. in the case of rigs/coats with hoods/etc. note this does nothing if skip is FALSE.
	var/can_repair = FALSE		//can we be used to repair damaged voidsuits when converting them?
	var/can_revert = TRUE		//can we revert items, or is it a one-way trip?
	var/delete_on_empty = FALSE	//do we self-delete when emptied?

	//Conversion proc
/obj/item/device/modkit_conversion/afterattack(obj/O, mob/user as mob)
	var/cost
	var/to_type
	var/keycheck

	if(isturf(O)) //silently fail if you click on a turf. shouldn't work anyway because turfs aren't objects but if I don't do this it spits runtimes.
		return
	if(istype(O,/obj/item/clothing/suit/space/void/) && !can_repair) //check if we're a voidsuit and if we're allowed to repair
		var/obj/item/clothing/suit/space/void/SS = O
		if(LAZYLEN(SS.breaches))
			to_chat(user, "<span class='warning'>You should probably repair that before you start tinkering with it.</span>")
			return
	if(O.blood_DNA || O.contaminated) //check if we're bloody or gooey or whatever, so modkits can't be used to hide crimes easily.
		to_chat(user, "<span class='warning'>You should probably clean that up before you start tinkering with it.</span>")
		return
	//we have to check that it's not the original type first, because otherwise it might convert wrong based on pathing; the subtype can still count as the basetype
	if(istype(O,to_helmet) && can_revert)
		cost = to_helmet_cost
		to_type = from_helmet
	else if(istype(O,to_suit) && can_revert)
		cost = to_suit_cost
		to_type = from_suit
	else if(!can_revert && (istype(O,to_helmet) || istype (O,to_suit)))
		to_chat(user, "<span class='warning'>This kit doesn't seem to have the tools necessary to revert changes to modified items.</span>")
		return
	else if(istype(O,from_helmet))
		cost = from_helmet_cost
		to_type = to_helmet
		keycheck = TRUE
	else if(istype(O,from_suit))
		cost = from_suit_cost
		to_type = to_suit
		keycheck = TRUE
	else
		return
	if(!isturf(O.loc))
		to_chat(user, "<span class='warning'>You need to put \the [O] on the ground, a table, or other worksurface before modifying it.</span>")
		return
	if(!skip_content_check && O.contents.len) //check if we're loaded/modified, in the event of gun/suit kits, to avoid purging stuff like ammo, badges, armbands, or suit helmets
		to_chat(user, "<span class='warning'>You should probably remove any attached items or loaded ammunition before trying to modify that!</span>")
		return
	if(cost > parts)
		to_chat(user, "<span class='warning'>The kit doesn't have enough parts left to modify that.</span>")
		if(can_revert && ((to_helmet_cost || to_suit_cost) < 0))
			to_chat(user, "<span class='notice'> You can recover parts by using the kit on an already-modified item.</span>")
		return
	if(keycheck && owner_ckey) //check if we're supposed to care
		if(user.ckey != owner_ckey) //ERROR: UNAUTHORIZED USER
			to_chat(user, "<span class='warning'>You probably shouldn't mess with all these strange tools and parts...</span>") //give them a slightly fluffy explanation as to why it didn't work
			return
	playsound(src, 'sound/items/Screwdriver.ogg', 100, 1)
	var/obj/N = new to_type(O.loc)
	user.visible_message("<span class='notice'>[user] opens \the [src] and modifies \the [O] into \the [N].</span>","<span class='notice'>You open \the [src] and modify \the [O] into \the [N].</span>")

	//crude, but transfer prints and fibers to avoid forensics abuse, same as the bloody/gooey check above
	N.fingerprints = O.fingerprints
	N.fingerprintshidden = O.fingerprintshidden
	N.fingerprintslast = O.fingerprintslast
	N.suit_fibers = O.suit_fibers

	//transfer logic could technically be made more thorough and handle stuff like helmet/boots/tank vars for suits, but in those cases you should be removing the items first anyway
	if(skip_content_check && transfer_contents)
		N.contents = O.contents
		if(istype(N,/obj/item/weapon/gun/projectile/))
			var/obj/item/weapon/gun/projectile/NN = N
			var/obj/item/weapon/gun/projectile/OO = O
			NN.magazine_type = OO.magazine_type
			NN.ammo_magazine = OO.ammo_magazine
		if(istype(N,/obj/item/weapon/gun/energy/))
			var/obj/item/weapon/gun/energy/NE = N
			var/obj/item/weapon/gun/energy/OE = O
			NE.cell_type = OE.cell_type
	else
		if(istype(N,/obj/item/weapon/gun/projectile/))
			var/obj/item/weapon/gun/projectile/NM = N
			NM.contents = list()
			NM.magazine_type = null
			NM.ammo_magazine = null
		if(istype(N,/obj/item/weapon/gun/energy/))
			var/obj/item/weapon/gun/energy/NO = N
			NO.contents = list()
			NO.cell_type = null

	qdel(O)
	parts -= cost
	if(!parts && delete_on_empty)
		qdel(src)

//DEBUG ITEM
/obj/item/device/modkit_conversion/fluff/debug_gunkit
	name = "Gun Transformation Kit"
	desc = "A kit containing all the needed tools and fabric to modify one sidearm to another."
	skip_content_check = FALSE
	transfer_contents = FALSE

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "harmony_kit"

	from_helmet = /obj/item/weapon/gun/energy/laser
	to_helmet = /obj/item/weapon/gun/energy/retro
//DEBUG ITEM ENDS

//General Use
/obj/item/weapon/flag
	name = "Nanotrasen Banner"
	desc = "I pledge allegiance to the flag of a megacorporation in space."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "Flag_Nanotrasen"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "Flag_Nanotrasen_mob"

/obj/item/weapon/flag/attack_self(mob/user as mob)
	if(isliving(user))
		user.visible_message("<span class='warning'>[user] waves their Banner around!</span>","<span class='warning'>You wave your Banner around.</span>")

/obj/item/weapon/flag/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message("<span class='warning'>[user] invades [M]'s personal space, thrusting [src] into their face insistently.</span>","<span class='warning'>You invade [M]'s personal space, thrusting [src] into their face insistently.</span>")


/obj/item/weapon/flag/federation
	name = "Federation Banner"
	desc = "Space, The Final Frontier. Sorta. Just go with it and say the damn oath."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "flag_federation"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "flag_federation_mob"

/obj/item/weapon/flag/xcom
	name = "Alien Combat Command Banner"
	desc = "A banner bearing the symbol of a task force fighting an unknown alien power."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "flag_xcom"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "flag_xcom_mob"

/obj/item/weapon/flag/advent
	name = "ALIEN Coalition Banner"
	desc = "A banner belonging to traitors who work for an unknown alien power."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "flag_advent"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "flag_advent_mob"

//Lots of people are using this now.
/obj/item/clothing/accessory/collar/khcrystal
	name = "life crystal"
	desc = "A small crystal with four little dots in it. It feels slightly warm to the touch. \
	Read manual before use! Can be worn, held, or attached to uniform. NOTE: Device contains antimatter."
	w_class = ITEMSIZE_SMALL

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_items_vr.dmi'

	icon_state = "khlife"
	item_state = "khlife_overlay"
	overlay_state = "khlife_overlay"

	slot_flags = SLOT_TIE

	var/mob/owner = null
	var/client/owner_c = null //They'll be dead when we message them probably.
	var/state = 0 //0 - New, 1 - Paired, 2 - Breaking, 3 - Broken (same as iconstates)

/obj/item/clothing/accessory/collar/khcrystal/New()
	..()
	update_state(0)

/obj/item/clothing/accessory/collar/khcrystal/Destroy() //Waitwaitwait
	if(state == 1)
		process() //Nownownow
	return ..() //Okfine

/obj/item/clothing/accessory/collar/khcrystal/process()
	check_owner()
	if((state > 1) || !owner)
		STOP_PROCESSING(SSobj, src)

/obj/item/clothing/accessory/collar/khcrystal/attack_self(mob/user as mob)
	if(state > 0) //Can't re-pair, one time only, for security reasons.
		to_chat(user, "<span class='notice'>The [name] doesn't do anything.</span>")
		return 0

	owner = user	//We're paired to this guy
	owner_c = user.client	//This is his client
	update_state(1)
	to_chat(user, "<span class='notice'>The [name] glows pleasantly blue.</span>")
	START_PROCESSING(SSobj, src)

/obj/item/clothing/accessory/collar/khcrystal/proc/check_owner()
	//He's dead, jim
	if((state == 1) && owner && (owner.stat == DEAD))
		update_state(2)
		audible_message("<span class='warning'>The [name] begins flashing red.</span>")
		sleep(30)
		visible_message("<span class='warning'>The [name] shatters into dust!</span>")
		if(owner_c)
			to_chat(owner_c, "<span class='notice'>The HAVENS system is notified of your demise via \the [name].</span>")
		update_state(3)
		name = "broken [initial(name)]"
		desc = "This seems like a necklace, but the actual pendant is missing."

/obj/item/clothing/accessory/collar/khcrystal/proc/update_state(var/tostate)
	state = tostate
	icon_state = "[initial(icon_state)][tostate]"
	update_icon()

/obj/item/weapon/paper/khcrystal_manual
	name = "KH-LC91-1 manual"
	info = {"<h4>KH-LC91-1 Life Crystal</h4>
	<h5>Usage</h5>
	<ol>
		<li>Hold new crystal in hand.</li>
		<li>Make fist with that hand.</li>
		<li>Wait 1 second.</li>
	</ol>
	<br />
	<h5>Purpose</h5>
	<p>The Kitsuhana Life Crystal is a small device typically worn around the neck for the purpose of reporting your status to the HAVENS (Kitsuhana's High-AVailability ENgram Storage) system, so that appropriate measures can be taken in the case of your body's demise. The whole device is housed inside a pleasing-to-the-eye elongated diamond.</p>
	<p>Upon your body's desmise, the crystal will send a transmission to HAVENS. Depending on your membership level, the appropriate actions can be taken to ensure that you are back up and enjoying existence as soon as possible.</p>

	<p>Nanotrasen has negotiated a <i>FREE</i> Star membership for you in the HAVENS system, though an upgrade can be obtained depending on your citizenship and reputation level.</p>

	As a reminder, the membership levels in HAVENS are:
	<ul>
		<li><b>HAVENS Star:</b> Upon reciving a signal from a transmitter indicating body demise, HAVENS will attempt to contact the owner for 48 hours, before starting the process of resleeving the owner into a new body they selected when registering their HAVENS membership.</li>
		<li><b>HAVENS Nebula:</b> After the contact period from the Star service has expired, an agent will be alotted a HAVENS spacecraft, and will attempt to locate your remains, and any belongings you had, for up to one week. If possible, any more recent memory recordings or mindstates will be recovered before your resleeving. (Great for explorers! Don't miss out on anything you discovered!)</li>
		<li><b>HAVENS Galaxy:</b> Upon reciving the signal from the Star service, a HAVENS High-Threat Response Team will be alotted a HAVENS FTL-capable Interdictor-class spacecraft and dispatched to your last known position to locate and recover your remains, plus any belongings. You will be resleeved on-site to continue where you left off.</li>
	</ul>
	<br />
	<h5>Technical</h5>
	<p>The Life Crystal is a small 5cm long diamond containing four main components which are visible inside the translucent gem.</p>

	From tip to top, they are:
	<ol>
		<li><b>Qubit Bucket:</b> This small cube contains 200 bits worth of quantum-entangled bits for transmitting to HAVENS. QE transmission technologies cannot be jammed or interfered with, and are effectively instant over any distance.
		<li><b>Antimatter Bottle:</b> This tiny antimatter vessel is required to power the transmitter for the time it takes to transmit the signal to HAVENS. The inside of the crystal is thick enough to block any alpha or beta particles emitted when this antimatter contacts matter, however the crystal will be destroyed when activated.
		<li><b>Decay Reactor:</b> This long-term microreactor will last for around one month and provide sufficient power to power all but the transmitter. This power is required for containing the antimatter bottle.
		<li><b>Sensor Suite:</b> The sensor that tracks the owner's life-state, such that it can be transmitted back to HAVENS when necessary.
	</ol>
	<p>The diamond itself is coated in a layer of graphene, to give it a pleasant rainbow finish. This also serves as a conductor that, if broken, will discharge the antimatter bottle immediately as it is unsafe to do so any point after the crystal is broken via physical means.</p>
	<br />
	<h5>Special Notes</h5>
	<i>\[AM WARNING\]</i>
	<p>This device contains antimatter. Please consult all local regulations when travelling to ensure compliance with local laws.</p>"}

/obj/item/weapon/storage/box/khcrystal
	name = "life crystal case"
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "khlifebox"
	desc = "This case can only hold the KH-LC91-1 and a manual."
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	storage_slots = 2
	can_hold = list(/obj/item/weapon/paper/khcrystal_manual, /obj/item/clothing/accessory/collar/khcrystal)
	max_storage_space = ITEMSIZE_COST_SMALL * 2
	w_class = ITEMSIZE_SMALL

/obj/item/weapon/storage/box/khcrystal/New()
	..()
	new /obj/item/weapon/paper/khcrystal_manual(src)
	new /obj/item/clothing/accessory/collar/khcrystal(src)

/obj/item/weapon/cane/fluff
	name = "cane"
	desc = "A cane used by a true gentlemen. Or a clown."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "browncane"
	item_icons = list (slot_r_hand_str = 'icons/vore/custom_items_vr.dmi', slot_l_hand_str = 'icons/vore/custom_items_vr.dmi')
	item_state_slots = list(slot_r_hand_str = "browncanemob_r", slot_l_hand_str = "browncanemob_l")
	force = 5.0
	throwforce = 7.0
	w_class = ITEMSIZE_SMALL
	matter = list(DEFAULT_WALL_MATERIAL = 50)
	attack_verb = list("bludgeoned", "whacked", "disciplined", "thrashed")

//General use, Verk felt like sharing.
/obj/item/clothing/glasses/fluff/science_proper
	name = "Aesthetic Science Goggles"
	desc = "The goggles really do nothing this time!"
	icon_state = "purple"
	item_state_slots = list(slot_r_hand_str = "glasses", slot_l_hand_str = "glasses")
	item_flags = AIRTIGHT

//General use, Verk felt like sharing.
/obj/item/clothing/glasses/fluff/spiffygogs
	name = "Orange Goggles"
	desc = "You can almost feel the raw power radiating off these strange specs."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "spiffygogs"
	slot_flags = SLOT_EYES | SLOT_EARS
	item_state_slots = list(slot_r_hand_str = "glasses", slot_l_hand_str = "glasses")
	toggleable = 1
	off_state = "spiffygogsup"

//General use
/obj/item/clothing/accessory/tronket
	name = "metal necklace"
	desc = "A shiny steel chain with a vague metallic object dangling off it."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "tronket"
	item_state = "tronket"
	overlay_state = "tronket"
	slot_flags = SLOT_TIE
	slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/flops
	name = "drop straps"
	desc = "Wearing suspenders over shoulders? That's been so out for centuries and you know better."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "flops"
	item_state = "flops"
	overlay_state = "flops"
	slot_flags = SLOT_TIE
	slot = ACCESSORY_SLOT_DECOR

/obj/item/weapon/fluff/injector //Injectors. Custom item used to explain wild changes in a mob's body or chemistry.
	name = "Injector"
	desc = "Some type of injector."
	icon = 'icons/obj/items.dmi'
	icon_state = "dnainjector"

/obj/item/weapon/fluff/injector/monkey
	name = "Lesser Form Injector"
	desc = "Turn the user into their lesser, more primal form."

/obj/item/weapon/fluff/injector/monkey/attack(mob/living/M, mob/living/user)

	if(usr == M) //Is the person using it on theirself?
		if(ishuman(M)) //If so, monkify them.
			var/mob/living/carbon/human/H = user
			H.monkeyize()
			qdel(src) //One time use.
	else //If not, do nothing.
		to_chat(user, "<span class='warning'>You are unable to inject other people.</span>")

/obj/item/weapon/fluff/injector/numb_bite
	name = "Numbing Venom Injector"
	desc = "Injects the user with a high dose of some type of chemical, causing any chemical glands they have to kick into overdrive and create the production of a numbing enzyme that is injected via bites.."

/obj/item/weapon/fluff/injector/numb_bite/attack(mob/living/M, mob/living/user)

	if(usr == M) //Is the person using it on theirself?
		if(ishuman(M)) //Give them numbing bites.
			var/mob/living/carbon/human/H = user
			H.species.give_numbing_bite() //This was annoying, but this is the easiest way of performing it.
			qdel(src) //One time use.
	else //If not, do nothing.
		to_chat(user, "<span class='warning'>You are unable to inject other people.</span>")

//For 2 handed fluff weapons.
/obj/item/weapon/material/twohanded/fluff //Twohanded fluff items.
	name = "fluff."
	desc = "This object is so fluffy. Just from the sight of it, you know that either something went wrong or someone spawned the incorrect item."
	icon = 'icons/vore/custom_items_vr.dmi'
	item_icons = list(
				slot_l_hand_str = 'icons/vore/custom_items_left_hand_vr.dmi',
				slot_r_hand_str = 'icons/vore/custom_items_right_hand_vr.dmi',
				)

/obj/item/weapon/material/twohanded/fluff/New(var/newloc)
	..(newloc," ") //See materials_vr_dmi for more information as to why this is a blank space.

//General use.
/obj/item/weapon/material/twohanded/fluff/riding_crop
	name = "riding crop"
	desc = "A steel rod, a little over a foot long with a widened grip and a thick, leather patch at the end. Made to smack naughty submissives."
	//force_wielded = 0.05 //Stings, but does jack shit for damage, provided you don't hit someone 100 times. 1 damage with hardness of 60.
	force_divisor = 0.05 //Required in order for the X attacks Y message to pop up.
	unwielded_force_divisor = 1 // One here, too.
	applies_material_colour = 0
	unbreakable = 1
	base_icon = "riding_crop"
	icon_state = "riding_crop0"
	attack_verb = list("cropped","spanked","swatted","smacked","peppered")
