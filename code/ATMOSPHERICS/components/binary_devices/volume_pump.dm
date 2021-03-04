/obj/machinery/atmospherics/binary/pump/volume
	icon = 'icons/atmos/volume_pump.dmi'
	icon_state = "map_off"
	construction_type = /obj/item/pipe/directional
	pipe_state = "volumepump"
	level = 1

	name = "volumetric gas pump"
	desc = "A pump that moves gas by volume."

	/var/max_flow_rate = 200
	/var/set_flow_rate = 200

/obj/machinery/atmospherics/binary/pump/volume/process()
	last_power_draw = 0
	last_flow_rate = 0

	if((stat & (NOPOWER|BROKEN)) || !use_power)
		return

	var/power_draw = -1
	var/transfer_moles = (set_flow_rate/air1.volume)*air1.total_moles
	power_draw = pump_gas(src, air1, air2, transfer_moles, power_rating)

	if (power_draw >= 0)
		last_power_draw = power_draw
		use_power(power_draw)

		if(network1)
			network1.update = 1

		if(network2)
			network2.update = 1

	return 1

/obj/machinery/atmospherics/binary/pump/volume/update_icon()
	if(!powered())
		icon_state = "off"
	else
		icon_state = "[use_power ? "on" : "off"]"

/obj/machinery/atmospherics/binary/pump/volume/broadcast_status()
	if(!radio_connection)
		return 0

	var/datum/signal/signal = new
	signal.transmission_method = TRANSMISSION_RADIO //radio signal
	signal.source = src

	signal.data = list(
		"tag" = id,
		"device" = "AGP",
		"power" = use_power,
		"flow_rate" = set_flow_rate,
		"sigtype" = "status"
	)

	radio_connection.post_signal(src, signal, filter = RADIO_ATMOSIA)

	return 1

/obj/machinery/atmospherics/binary/pump/volume/receive_signal(datum/signal/signal)
	if(!signal.data["tag"] || (signal.data["tag"] != id) || (signal.data["sigtype"]!="command"))
		return 0

	if(signal.data["power"])
		if(text2num(signal.data["power"]))
			update_use_power(USE_POWER_IDLE)
		else
			update_use_power(USE_POWER_OFF)

	if("power_toggle" in signal.data)
		update_use_power(!use_power)

	if(signal.data["set_flow_rate"])
		set_flow_rate = between(
			0,
			text2num(signal.data["set_flow_rate"]),
			max_flow_rate
		)

	if(signal.data["status"])
		spawn(2)
			broadcast_status()
		return //do not update_icon

	spawn(2)
		broadcast_status()
	update_icon()
	return

/obj/machinery/atmospherics/binary/pump/volume/tgui_data(mob/user)
	// this is the data which will be sent to the ui
	var/data[0]

	data = list(
		"on" = use_power,
		"flow_set" = round(set_flow_rate*10),
		"max_flow" = max_flow_rate,
		"last_flow_rate" = round(last_flow_rate*10),
		"last_power_draw" = round(last_power_draw),
		"max_power_draw" = power_rating,
	)

	return data

/obj/machinery/atmospherics/binary/pump/volume/tgui_interact(mob/user, datum/tgui/ui)
	if(stat & (BROKEN|NOPOWER))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VolumeGasPump", name)
		ui.open()

/obj/machinery/atmospherics/binary/pump/volume/tgui_act(action, params)
	switch(action)
		if("power")
			update_use_power(!use_power)
			. = TRUE
		if("set_flow")
			var/flow = params["flow"]
			switch(flow)
				if("min")
					set_flow_rate = 0
				if("max")
					set_flow_rate = max_flow_rate
				if("set")
					var/new_flow = input(usr,"Enter new output flow rate (0-[max_flow_rate]L/s)","Flow rate control",set_flow_rate) as num
					set_flow_rate = between(0, new_flow, max_flow_rate)
			. = TRUE

	add_fingerprint(usr)
	update_icon()