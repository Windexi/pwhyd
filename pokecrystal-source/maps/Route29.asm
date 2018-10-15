	const_def 2 ; object constants
	const ROUTE29_FRUIT_TREE
	const MR_LETS_BE_FRIENDS
;	const ROUTE29_HIDDEN

Route29_MapScripts:
	db 1 ; scene scripts
	scene_script .DummyScene0 ; SCENE_ROUTE29_NOTHING
	scene_script .DummyScene1

.DummyScene0:
	end

.DummyScene1:
	end

Route29Sign1:
	jumptext Route29Sign1Text

Route29Sign2:
	jumptext Route29Sign2Text

Route29HiddenItem:
	hiddenitem RARE_CANDY, EVENT_ROUTE29_HIDDEN_ITEM

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

Bouncer:
	faceplayer
	opentext
	writetext BouncerText
	waitbutton
	closetext
	end

BouncerFriend1:
	; in future event
	end

BouncerFriend2:
	; in future event
	end

BouncerText:
	text "Hey kid!"

	para "This place is"
	line "for me and my"
	cont "OGs only!"

	para "Now scram!"
	done

MrLetsBeFriendsText:
	text "Well hey there"
	line "young man..."

	para "Are you lost?"

	para "Oh wait... you"
	line "must be a TRAINER!"

	para "Do you have any"
	line "extra #MON?"

	para "I sure am lonely..."

	para "Say! I have a" 
	line "good idea!"

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
	text "I'm not a real"
	line "fruit tree!"

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

	db 3 ; bg events
	bg_event 51,  7, BGEVENT_READ, Route29Sign1
	bg_event  3,  5, BGEVENT_READ, Route29Sign2
	bg_event 53,  2, BGEVENT_ITEM, Route29HiddenItem

	db 5 ; object events
	object_event 12,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route29FruitTree, -1
	object_event 25,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MrLetsBeFriends, EVENT_LETS_BE_FRIENDS
	object_event 53,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Bouncer, -1
	object_event 57,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BouncerFriend1, -1
	object_event 55,  2, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BouncerFriend2, -1
