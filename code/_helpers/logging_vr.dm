/proc/log_subtle(text, mob/speaker)
	if (config.log_emote)
		WRITE_LOG(diary, "SUBTLE: [speaker.simple_info_line()]: [html_decode(text)]")
