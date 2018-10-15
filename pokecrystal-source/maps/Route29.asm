	const_def 2 ; object constants
	const ROUTE29_FRUIT_TREE
	const MR_LETS_BE_FRIENDS

Route29_MapScripts:
	db 1 ; scene scripts
	scene_script .DummyScene0 ; SCENE_ROUTE29_NOTHING

.DummyScene0:
	end

Route29Sign1:
	jumptext Route29Sign1Text

Route29Sign2:
	jumptext Route29Sign2Text

MrLetsBeFriends:
	faceplayer
	opentext
	writetext MrLetsBeFriendsText
	waitbutton
	closetext
	applymovement MR_LETS_BE_FRIENDS, MrLetsBeFriendsMovement
	disappear MR_LETS_BE_FRIENDS
	setevent EVENT_LETS_BE_FRIENDS
	end

MrLetsBeFriendsMovement:
	step RIGHT
	step RIGHT
	step UP
	step UP
	step_end

MrLetsBeFriendsText:
	text "Well hey there young"
	line "man."

	para "Are you lost?"

	para "Oh wait... you"
	line "must be a TRAINER!"

	para "Do you have any"
	line "#MON you don't want?"

	para "I sure am lonely..."

	para "Say! I have an idea!"

	para "Let's be friends!"

	para "Best friends..."

	para "I'd like that."

	para "Well, special"
	line "friend..."

	para "..."
	done

Route29FruitTree:
	jumptext FakeFruitTree

FakeFruitTree:
	text "I'm not a real fruit"
	line "tree!"

	para "I'm an imposter!"
	line "Muhuahahaha!"
	done

Route29Sign1Text:
	text "ROUTE 29"

	para "CHERRYGROVE CITY -"
	line "NEW BARK TOWN"
	done

Route29Sign2Text:
	text "ROUTE 29"

	para "CHERRYGROVE CITY -"
	line "NEW BARK TOWN"
	done

Route29_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_event 27,  1, ROUTE_29_ROUTE_46_GATE, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event 51,  7, BGEVENT_READ, Route29Sign1
	bg_event  3,  5, BGEVENT_READ, Route29Sign2

	db 2 ; object events
	object_event 12,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route29FruitTree, -1
	object_event 25,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MrLetsBeFriends, EVENT_LETS_BE_FRIENDS
