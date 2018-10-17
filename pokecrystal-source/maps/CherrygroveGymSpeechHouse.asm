	const_def 2 ; object constants
	const CHERRYGROVEGYMSPEECHHOUSE_GUY1
	const CHERRYGROVEGYMSPEECHHOUSE_GUY2

CherrygroveGymSpeechHouse_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

Guy1:
	faceplayer
	opentext
	writetext WantInfoText
	yesorno
	iftrue Guy1History
	writetext WantInfoNoText
	waitbutton
	closetext
	end

Guy1History:
	writetext Guy1HistoryText
	waitbutton
	closetext
	end

Guy2:
	jumptextfaceplayer Guy2Text

CherrygroveGymSpeechHouseBookshelf:
	jumpstd picturebookshelf

WantInfoText:
	text "Well hey there!"
	line "You seem like a"
	cont "new TRAINER!"

	para "Wanna know some"
	line "history behind"
	cont "this old region"
	cont "here?"
	done

WantInfoNoText:
	text "Oh, well maybe"
	line "some other time!"
	done

Guy1HistoryText:
	text "A long time ago,"
	line "there used to be"
	cont "these things"
	cont "called GYM LEADERS!"

	para "TRAINERS would"
	line "battle them to"
	cont "get BADGES!"

	para "...but a while"
	line "ago the CHAMPION"
	cont "convinced the"
	cont "ELITE FOUR to"
	cont "remove the GYMs."

	para "Why, you ask?"
	para "Well, no one"
	line "really knows."

	para "Now, trainers"
	line "just battle each"
	cont "other for fun!"

	para "It's much better"
	line "this way, don't"
	cont "you think?"
	done

Guy2Text:
	text "Hmmm..."
	para "I don't like you!"
	cont "You're weird!"
	done

CherrygroveGymSpeechHouse_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, CHERRYGROVE_CITY, 3
	warp_event  3,  7, CHERRYGROVE_CITY, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event  0,  1, BGEVENT_READ, CherrygroveGymSpeechHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CherrygroveGymSpeechHouseBookshelf

	db 2 ; object events
	object_event  0,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Guy1, -1
	object_event  5,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Guy2, -1
