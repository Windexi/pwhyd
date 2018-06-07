	const_def 2 ; object constants
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_FISHER

NewBarkTown_MapScripts:
	db 1 ; scene scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	return

NewBarkTownTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_NEW_BARK_INTRO_FINISHED
	iftrue MuchMoney
	writetext Text_GearIsImpressive
	waitbutton
	playsound SFX_TRANSACTION
	closetext
	end

MuchMoney:
	writetext Text_TellMomIfLeaving
	waitbutton
	playsound SFX_TRANSACTION
	closetext
	end

.MonIsAdorable:
	writetext Text_YourMonIsAdorable
	waitbutton
	closetext
	end

.TellMomYoureLeaving:
	writetext Text_TellMomIfLeaving
	waitbutton
	playsound SFX_TRANSACTION
	closetext
	end

NewBarkTownFisherScript:
	jumptextfaceplayer Text_ElmDiscoveredNewMon

NewBarkTownSign:
	jumptext NewBarkTownSignText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText

NewBarkTownStinkyCave:
	jumptext NewBarkTownStinkyCaveText

NewBarkTownResearchSign:
	jumptext NewBarkTownResearchSignText

Text_GearIsImpressive:
	text "heheh..."

	para "HELP, SOMEONE!"
	line "HE RAPE ME!"
	done

Text_YourMonIsAdorable:
	text "Oh! Your #MON"
	line "is adorable!"
	cont "I wish I had one!"
	done

Text_TellMomIfLeaving:
	text "I get big"
	line "money if I say"
	cont "someone rape me!"

	para "HELP! ASH RAPE"
	line "ME!"
	done

Text_ElmDiscoveredNewMon:
	text "Go to hell!"
	done

NewBarkTownSignText:
	text "NEW BARK TOWN"
	para "Unfortunately,"
	line "existing."
	done

NewBarkTownPlayersHouseSignText:
	text "<PLAYER>'s House"
	done

NewBarkTownElmsLabSignText:
	text "ELM #MON LAB"
	done

NewBarkTownElmsHouseSignText:
	text "ADRIAN'S HOUSE!"
	para "How cute! She can"
	line "afford a mailbox!"
	done

NewBarkTownStinkyCaveText:
	text "STINKY CAVE"
	para "Only the GAYS"
	line "venture inside!"
	done

NewBarkTownResearchSignText:
	text "OAK'S 'RESEARCH'"
	line "LAB"
	done

NotYet:
	checkevent EVENT_OAK_PERSIST
	iftrue NotYetTurnBack
	end

NotYetTurnBack:
	opentext
	writetext NotYetText
	waitbutton
	closetext
	applymovement PLAYER, NotYetMovement
	end

NotYetText:
	text "If I go out"
	line "there..."

	para "I'll get bullied"
	line "by the #MON"
	cont "too!"
	done

NotYetMovement:
	turn_head RIGHT
	step RIGHT
	step_end

NewBarkTown_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event  5,  3, ELMS_LAB, 2
	warp_event 14,  5, PLAYERS_HOUSE_1F, 1
	warp_event 11, 13, ELMS_HOUSE, 1

	db 2 ; coord events
	coord_event  1,  8, SCENE_DEFAULT, NotYet
	coord_event  1,  9, SCENE_DEFAULT, NotYet

	db 5 ; bg events
	bg_event  4, 10, BGEVENT_READ, NewBarkTownSign
	bg_event  3,  3, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_READ, NewBarkTownElmsHouseSign
	bg_event 12,  6, BGEVENT_READ, NewBarkTownStinkyCave
	bg_event  6,  4, BGEVENT_READ, NewBarkTownResearchSign

	db 2 ; object events
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 15, 13, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownFisherScript, -1
