	const_def 2 ; object constants
	const CHERRYGROVEMART_CLERK
	const CHERRYGROVEMART_JESSE
	const CHERRYGROVEMART_GRAMPS

CherrygroveMart_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

CherrygroveMartClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE_DEX
	closetext
	end

CherrygroveMartCooltrainerMScript:
	faceplayer
	opentext
	writetext CherrygroveMartCooltrainerMText
;	pokemart MARTTYPE_STANDARD, MART_DRUGDEALERCHERRYGROVE ; old integration
	yesorno
	iftrue SellDrugs
	jp SaidNo
	end

SaidNo:
	writetext WastingText
	waitbutton
	closetext
	end

NotEnoughMoney:
	writetext BrokeText
	waitbutton
	closetext
	end

CherrygroveMartYoungsterScript:
	jumptextfaceplayer CherrygroveMartYoungsterText

CherrygroveMartCooltrainerMText:
	text "What are you"
	line "looking at?"

	para "Oh... I get it."
	line "You need some?"
	
	para "My price is"
	line "2,500/oz."

	para "So, whaddaya say?"
	done

BrokeText:
	text "What?"
	line "You're broke?"

	para "We don't do"
	line "free samples."
	done

WastingText:
	text "Quit wasting my"
	line "time."
	done

SellDrugs:
	checkmoney YOUR_MONEY, 2500
	ifequal HAVE_LESS, NotEnoughMoney
	takemoney YOUR_MONEY, 2500
	giveitem STRANGEBLUEPOWDER
	playsound SFX_ITEM
	writetext GotDrugsText
	waitbutton
	closetext
	end

GotDrugsText:
	text "Recieved"
	line "BLUE POWDER!"
	done

CherrygroveMartYoungsterText:
	text "That strange man"
	line "over there keeps"
	cont "fidgeting..."

	para "Should we call an"
	line "ambulance?"
	done

CherrygroveMart_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, CHERRYGROVE_CITY, 1
	warp_event  3,  7, CHERRYGROVE_CITY, 1

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartClerkScript, -1
	object_event  2,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartYoungsterScript, -1
	object_event  7,  6, SPRITE_JESSE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveMartCooltrainerMScript, -1
	