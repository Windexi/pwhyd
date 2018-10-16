	const_def 2 ; object constants
	const CHERRYGROVECITY_GRAMPS
	const CHERRYGROVECITY_SILVER
	const CHERRYGROVECITY_TEACHER
	const CHERRYGROVECITY_YOUNGSTER
	const CHERRYGROVECITY_FISHER

CherrygroveCity_MapScripts:
	db 2 ; scene scripts
	scene_script .DummyScene0 ; SCENE_CHERRYGROVECITY_NOTHING
	scene_script .DummyScene1 ; SCENE_CHERRYGROVECITY_MEET_RIVAL

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.DummyScene1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	return

.JumpstdReceiveItem:
	jumpstd receiveitem
	end

CherrygroveTeacherScript:
	faceplayer
	opentext
	writetext CherrygroveTeacherText
	waitbutton
	closetext
	end

CherrygroveYoungsterScript:
	faceplayer
	opentext
	writetext CherrygroveYoungsterText
	waitbutton
	closetext
	end

CherrygroveCitySign:
	jumptext CherrygroveCitySignText

CherrygroveCityPokecenterSign:
	jumpstd pokecentersign

CherrygroveCityMartSign:
	jumpstd martsign

CherrygroveTeacherText:
	text "Did you talk to"
	line "the old man by the"
	cont "#MON CENTER?"

	para "He'll put a MAP of"
	line "JOHTO on your"
	cont "#GEAR."
	done

CherrygroveYoungsterText:
	text "MR.#MON's house"
	line "is still farther"
	cont "up ahead."
	done

CherrygroveCitySignText:
	text "CHERRYGROVE CITY"

	para "Why is this a"
	line "city? It's so"
	cont "damn small..."
	done

CherrygroveCity_MapEvents:
	db 0, 0 ; filler

	db 5 ; warp events
	warp_event 21,  3, CHERRYGROVE_MART, 2
	warp_event 31, 11, CHERRYGROVE_POKECENTER_1F, 1
	warp_event 19,  9, CHERRYGROVE_GYM_SPEECH_HOUSE, 1
	warp_event 29,  5, GUIDE_GENTS_HOUSE, 1
	warp_event  7,  9, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, 1

	db 2 ; coord events
	coord_event 33,  6, SCENE_CHERRYGROVECITY_MEET_RIVAL, CherrygroveSilverSceneNorth
	coord_event 33,  7, SCENE_CHERRYGROVECITY_MEET_RIVAL, CherrygroveSilverSceneSouth

	db 3 ; bg events
	bg_event 26,  6, BGEVENT_READ, CherrygroveCitySign
	bg_event 22,  3, BGEVENT_READ, CherrygroveCityMartSign
	bg_event 32, 11, BGEVENT_READ, CherrygroveCityPokecenterSign

	db 2 ; object events
	object_event 27, 12, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CherrygroveTeacherScript, -1
	object_event 23,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveYoungsterScript, -1
