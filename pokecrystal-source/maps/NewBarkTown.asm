	const_def 2 ; object constants
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_FISHER
	const NEWBARKTOWN_SILVER

NewBarkTown_MapScripts:
	db 2 ; scene scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.DummyScene1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	return

NewBarkTown_TeacherStopsYouScene1
	faceplayer
	end
	
NewBarkTown_TeacherStopsYouScene2
	faceplayer
	end
	
NewBarkTownTeacherScript:
	faceplayer
	end

NewBarkTownFisherScript:
	jumptext Text_ElmDiscoveredNewMon

NewBarkTownSign:
	jumptext NewBarkTownSignText

RoadClosedHaha:
	jumptext RoadClosedHahaText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText

Text_ElmDiscoveredNewMon:
	text "Go to hell!"
	done

NewBarkTownSignText:
	text "NEW BARK TOWN"

	para "Unfortunately,"
	line "still existing."
	done

NewBarkTownPlayersHouseSignText:
	text "<PLAYER>'s House"
	done

NewBarkTownElmsLabSignText:
	text "ELM #MON LAB"
	done

NewBarkTownElmsHouseSignText:
	text "ADRIAN'S HOUSE!"
	done

RoadClosedHahaText:
	text "Go away!"
	para "Road's closed,"
	para "because I"
	line "said so!"
	para "Muhuahaha!"
	done
	
NewBarkTown_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  6,  3, ELMS_LAB, 1
	warp_event 13,  5, PLAYERS_HOUSE_1F, 1
	warp_event  3, 11, PLAYERS_NEIGHBORS_HOUSE, 1
	warp_event 11, 13, ELMS_HOUSE, 1
	
	db 2 ; coord events
	coord_event  0,  0, SCENE_DEFAULT, NewBarkTown_TeacherStopsYouScene1
	coord_event  0,  0, SCENE_DEFAULT, NewBarkTown_TeacherStopsYouScene2

	db 4 ; bg events
	bg_event  4,  10, BGEVENT_READ, NewBarkTownSign
	bg_event 17,  11, BGEVENT_READ, RoadClosedHaha
	bg_event 11,  5, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event  3,  3, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_READ, NewBarkTownElmsHouseSign

	db 3 ; object events
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event  5, 13, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownFisherScript, -1
