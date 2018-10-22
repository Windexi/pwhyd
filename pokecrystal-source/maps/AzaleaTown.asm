	const_def 2 ; object constants
	const AZALEATOWN_GRAMPS
	const AZALEATOWN_TEACHER
	const AZALEATOWN_YOUNGSTER
	const AZALEATOWN_KURT_OUTSIDE

AzaleaTown_MapScripts:
	db 1 ; scene scripts
	scene_script .DummyScene0 ; SCENE_AZALEATOWN_NOTHING

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, .Flypoint

.DummyScene0:
	end

.Flypoint:
	setflag ENGINE_FLYPOINT_AZALEA
	return

AzaleaTownGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .ClearedWell
	writetext AzaleaTownGrampsTextBefore
	waitbutton
	closetext
	end

.ClearedWell:
	writetext AzaleaTownGrampsTextAfter
	waitbutton
	closetext
	end

AzaleaTownTeacherScript:
	jumptextfaceplayer AzaleaTownTeacherText

AzaleaTownYoungsterScript:
	jumptextfaceplayer AzaleaTownYoungsterText

UnusedWoosterScript:
; unused
	faceplayer
	opentext
	writetext WoosterText
	cry QUAGSIRE
	waitbutton
	closetext
	end

AzaleaTownSign:
	jumptext AzaleaTownSignText

AzaleaTownPokecenterSign:
	jumpstd pokecentersign

AzaleaTownMartSign:
	jumpstd martsign

AzaleaTownHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

AzaleaTownGrampsTextBefore:
	text "The SLOWPOKE have"
	line "disappeared from"
	cont "town…"

	para "I heard their"
	line "TAILS are being"
	cont "sold somewhere."
	done

AzaleaTownGrampsTextAfter:
	text "The SLOWPOKE have"
	line "returned."

	para "Knowing them, they"
	line "could've just been"

	para "goofing off some-"
	line "where."
	done

AzaleaTownTeacherText:
	text "Did you come to"
	line "get KURT to make"
	cont "some BALLS?"

	para "A lot of people do"
	line "just that."
	done

AzaleaTownYoungsterText:
	text "Cut through AZALEA"
	line "and you'll be in"
	cont "ILEX FOREST."

	para "But these skinny"
	line "trees make it"

	para "impossible to get"
	line "through."

	para "The CHARCOAL MAN's"
	line "#MON can CUT"
	cont "down trees."
	done

WoosterText:
	text "WOOSTER: Gugyoo…"
	done

AzaleaTownSignText:
	text "MEXICO"

	para "Hot... but"
	line "classy."
	done

AzaleaTown_MapEvents:
	db 0, 0 ; filler

	db 8 ; warp events
	warp_event 15,  9, AZALEA_POKECENTER_1F, 1
	warp_event 21, 13, CHARCOAL_KILN, 1
	warp_event 21,  5, AZALEA_MART, 2
	warp_event  9,  5, KURTS_HOUSE, 1
	warp_event 10, 15, AZALEA_GYM, 1
	warp_event 31,  7, SLOWPOKE_WELL_B1F, 1
	warp_event  2, 10, ILEX_FOREST_AZALEA_GATE, 3
	warp_event  2, 11, ILEX_FOREST_AZALEA_GATE, 4

	db 0 ; coord events

	db 4 ; bg events
	bg_event 20, 12, BGEVENT_READ, AzaleaTownSign
	bg_event 16,  9, BGEVENT_READ, AzaleaTownPokecenterSign
	bg_event 22,  5, BGEVENT_READ, AzaleaTownMartSign
	bg_event 31,  6, BGEVENT_ITEM, AzaleaTownHiddenFullHeal

	db 3 ; object events
	object_event 21,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	object_event 15, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, AzaleaTownTeacherScript, -1
	object_event  7,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaTownYoungsterScript, -1
	;object_event  6,  5, SPRITE_KURT_OUTSIDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
