/obj/item/weapon/boneprops
	name = "bone"
	desc = "A bleached bone. It's very non-descript and its hard to tell what species or part of the body it came from."
	icon = 'icons/obj/bones_vr.dmi'
	icon_state = "generic"
	force = 0
	throwforce = 0
	item_state = "bone"
	w_class = ITEMSIZE_SMALL
	var/pred_ckey
	var/pred_name

/obj/item/weapon/boneprops/Initialize(var/mapload, var/mob/living/pred)
	. = ..()
	if(!mapload)
		pred_ckey = pred?.ckey
		pred_name = pred?.name

//TODO: Add the ability to crush any of the props, while on harm intent, into a pile of crushed styrofoam. Reuse the ashes sprite for this!
/obj/item/weapon/boneprops/attack_self(var/mob/user)
	if(user.a_intent == I_HURT)
		to_chat(user,"<span class='warning'>As you squeeze the [name], it crumbles into dust and falls apart into nothing!</span>")
		qdel(src)

/obj/item/weapon/boneprops/ribcage
	name = "ribcage"
	desc = "A bleached ribcage. You find it hard to tell what it belonged to... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "ribcage"

/obj/item/weapon/boneprops/skull
	name = "skull"
	desc = "A bleached skull. Seems like it belonged to a human... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull"

/obj/item/weapon/boneprops/skull/tajaran
	desc = "A bleached skull. Seems like it belonged to a tajara... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/unathi
	desc = "A bleached skull. Seems like it belonged to an unathi... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_unathi"

/obj/item/weapon/boneprops/skull/skrell
	desc = "A bleached skull. Seems like it belonged to a skrell... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull"

/obj/item/weapon/boneprops/skull/vasilissan
	desc = "A bleached skull. Seems like it belonged to a vasilissan... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull"

/obj/item/weapon/boneprops/skull/akula
	desc = "A bleached skull. Seems like it belonged to an akula... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_unathi"

/obj/item/weapon/boneprops/skull/rapala
	desc = "A bleached skull. Seems like it belonged to a rapala... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull"

/obj/item/weapon/boneprops/skull/vulpkanin
	desc = "A bleached skull. Seems like it belonged to a vulpkanin... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/sergal
	desc = "A bleached skull. Seems like it belonged to a sergal... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/zorren
	desc = "A bleached skull. Seems like it belonged to a zorren... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/nevrean
	desc = "A bleached skull. Seems like it belonged to a nevrean... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/teshari
	desc = "A bleached skull. Seems like it belonged to a teshari... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/vox
	desc = "A bleached skull. Seems like it belonged to a vox... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull_taj"

/obj/item/weapon/boneprops/skull/unknown
	desc = "A bleached skull. You can't quite tell what species it belonged to... On closer inspection, you realize this is actually made of styrofoam and plaster!"
	icon_state = "skull"

/obj/item/weapon/boneprops/skull/unknown/anthro
	icon_state = "skull_taj"
