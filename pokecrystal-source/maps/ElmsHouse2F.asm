	const_def 0 ; object constants


ElmsHouse2F_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

RoomPC:
	jumptext RoomPCText

RoomPCText:
	text "It's a Mac!"

	para "...ew!"
	done

RoomTV:
	jumptext RoomTVText
	
RoomTVText:
	text "Anime channel!"

	para "..."

	para "traps are gay"
	done

RoomBookshelf:
	jumptext RoomBookshelfText

RoomBookshelfText:
	text "Ahhh..."

	para "Even the books"
	line "smell like her!"
	done

MrsPlant:
	jumptext MrsPlantText

MrsPlantText:
	text "It's Adrian's pet"
	line "plant!"

	para "Hopefully, someday"
	line "it can be"
	cont "MRS. PLANT!"
	done

AdrianBed:
	jumptext AdrianBedText

AdrianBedText:
	text "It's ADRIAN'S bed!"

	para "I would sleep in it"
	line "all day if I could!"
	done

ElmsHouse2F_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_event  7,  0, ELMS_HOUSE, 3

	db 0 ; coord events

	db 5 ; bg events
	bg_event  0,  1, BGEVENT_READ, RoomPC
	bg_event  2,  1, BGEVENT_READ, RoomTV
	bg_event  3,  1, BGEVENT_READ, RoomBookshelf
	bg_event  5,  4, BGEVENT_READ, MrsPlant
	bg_event  0,  6, BGEVENT_READ, AdrianBed

	db 0 ; object events
