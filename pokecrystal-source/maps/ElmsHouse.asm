	const_def 2 ; object constants
	const ELMSHOUSE_ELMS_WIFE
	const ELMSHOUSE_ELMS_SON

ElmsHouse_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

ElmsWife:
	faceplayer
	opentext
	writetext ElmsWifeText
	waitbutton
	closetext
	warp NEW_BARK_TOWN, 11, 14 
	end

ElmsSon:
	jumptextfaceplayer ElmsSonText

ElmsHousePC:
	jumptext ElmsHousePCText

ElmsHouseMac:
	jumptext ElmsHouseMacText

ElmsWifeText:
	text "We're rich so we"
	line "have many radios!"

	para "How many radios do"
	line "you have?"

	para "..."

	para "None?!"

	para "Get out!"
	done

ElmsSonText:
	text "My sister is super"
	line "attractive."

	para "You're ugly!"

	para "You have" 
	line "no chance!"
	done

ElmsHousePCText:
	text "It's a Mac!"

	para "...ew!"
	done

ElmsHouseMacText:
	text "It's a Mac!"

	para "Someone has been"
	line "playing ROBLOX!"
	done

ElmsHouse_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event  2,  7, NEW_BARK_TOWN, 3
	warp_event  3,  7, NEW_BARK_TOWN, 3
	warp_event  6,  0, ELMS_HOUSE_2F, 1

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  1, BGEVENT_READ, ElmsHousePC
	bg_event  2,  1, BGEVENT_READ, ElmsHousePC
	bg_event  4,  1, BGEVENT_READ, ElmsHouseMac

	db 2 ; object events
	object_event  1,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ElmsWife, -1
	object_event  5,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsSon, -1
