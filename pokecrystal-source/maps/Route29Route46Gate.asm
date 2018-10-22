	const_def 2 ; object constants
	const ROUTE29ROUTE46GATE_OFFICER
	const ROUTE29ROUTE46GATE_YOUNGSTER

Route29Route46Gate_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

Route29Route46GateOfficerScript:
	checkevent EVENT_LETS_BE_FRIENDS
	iftrue DidYouSaySomething
	jumptextfaceplayer Route29Route46GateOfficerText
	end

Route29Route46GateYoungsterScript:
	jumptextfaceplayer Route29Route46GateYoungsterText

Route29Route46GateOfficerText:
	text "It sure is a nice"
	line "day out!"
	done

DidYouSaySomething:
	opentext
	writetext LetsBeFriendsText
	waitbutton
	closetext
	end

LetsBeFriendsText:
	text "A strange man just"
	line "ran right through"
	cont "here!"

	para "Did you say"
	line "something to him?"
	done

Route29Route46GateYoungsterText:
	text "I hate those"
	line "Republicans!"

	para "Why are they so"
	line "mean? They hurt"
	cont "my feelings!"
	done

Route29Route46Gate_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  4,  0, ROUTE_46, 1
	warp_event  5,  0, ROUTE_46, 2
	warp_event  4,  7, ROUTE_29, 1
	warp_event  5,  7, ROUTE_29, 1

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route29Route46GateOfficerScript, -1
	object_event  6,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route29Route46GateYoungsterScript, -1
