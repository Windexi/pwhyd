	const_def 2 ; object constants
	const GUIDEGENTSHOUSE_GRAMPS

GuideGentsHouse_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

GuideGent:
	faceplayer
	opentext
	writetext GuideGentText
	waitbutton
	closetext
	warp CHERRYGROVE_CITY, 29, 6
	end

Bookshelf:
	faceplayer
	opentext
	writetext BookshelfText
	waitbutton
	closetext
	end

BookshelfText:
	text "It's a dingy old"
	line "bookshelf..."

	para "Everything is"
	line "coated in dust!"
	done

StrangeBookshelf:
	faceplayer
	opentext
	writetext StrangeBookshelfText
	waitbutton
	closetext
	end

StairsScript:
	opentext
	writetext StairsText
	waitbutton
	closetext
	applymovement PLAYER, StairsMovement
	end

Plant:
	opentext
	writetext PlantText
	waitbutton
	closetext
	end

PlantText:
	text "This house has"
	line "many plants!"
	done

ShoppingList:
	opentext
	writetext ShoppingListText
	waitbutton
	closetext
	end

ShoppingListText:
	text "A... shopping"
	line "list?"

	para "Those are some"
	line "long words!"
	done

StairsText:
	text "Ew! Something"
	line "down there"
	cont "really smells!"
	done

StairsMovement:
	step DOWN 
	step_end

StrangeBookshelfText:
	text "This shelf is"
	line "littered with"
	cont "chemistry books!"
	done

GuideGentText:
	text "..."
	done

GuideGentsHouse_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, CHERRYGROVE_CITY, 4
	warp_event  3,  7, CHERRYGROVE_CITY, 4

	db 1 ; coord events
	coord_event 6,  2, -1, StairsScript

	db 10 ; bg events
	bg_event  0,  1, BGEVENT_READ, Bookshelf
	bg_event  1,  1, BGEVENT_READ, Bookshelf
	bg_event  2,  1, BGEVENT_READ, Bookshelf
	bg_event  3,  1, BGEVENT_READ, StrangeBookshelf
	bg_event  4,  1, BGEVENT_READ, Bookshelf	
	bg_event  5,  1, BGEVENT_READ, Bookshelf
	bg_event  7,  5, BGEVENT_READ, Plant
	bg_event  7,  7, BGEVENT_READ, Plant	
	bg_event  0,  7, BGEVENT_READ, Plant
	bg_event  1,  4, BGEVENT_READ, ShoppingList

	db 1 ; object events
	object_event  5,  5, SPRITE_WALTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GuideGent, -1
