	const_def 2 ; object constants
	const PLAYERSHOUSE2F_CONSOLE
	const PLAYERSHOUSE2F_DOLL_1
	const PLAYERSHOUSE2F_DOLL_2
	const PLAYERSHOUSE2F_BIG_DOLL

PlayersHouse2F_MapScripts:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, .InitializeRoom
	callback MAPCALLBACK_TILES, .SetSpawn

; unused
.Null:
	end

.InitializeRoom:
	special ToggleDecorationsVisibility
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	checkevent EVENT_INITIALIZED_EVENTS
	iftrue .SkipInitialization
	jumpstd initializeevents
	return

.SkipInitialization:
	return

.SetSpawn:
	special ToggleMaptileDecorations
	return

	db 0, 0, 0 ; filler

.Warp:
	warp NONE, 0, 0
	end

PlayersHouseMrPlant:
	jumptext MrPlantText
	end

MrPlantText:
	text "Ah, Mr. Plant!"
	para "My only friend!"
	done

DebugBall:
	opentext
	writetext DebugBallText
	yesorno
	iftrue Debug
	closetext
	end

DebugBallText:
	text "Hello! I'm the"
	line "DEBUG BALL!"

	para "Debug?"
	done

Debug:
	; All credit goes to Mateo and Rangi42. Source taken from RedPlusPlus with permission.
	opentext
	; gear
	setflag ENGINE_POKEDEX
	setflag ENGINE_VS_SEEKER
	; all hms (givetmhm unsupported in pwhyd so far)
	; givetmhm HM_CUT
	; givetmhm HM_FLY
	; givetmhm HM_SURF
	; givetmhm HM_STRENGTH
	; givetmhm HM_WATERFALL
	; givetmhm HM_DIV
	; max money
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 999999
	giveitem COIN_CASE
	givecoins 50000
	; all badges
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_FOGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	setflag ENGINE_BOULDERBADGE
	setflag ENGINE_CASCADEBADGE
	setflag ENGINE_THUNDERBADGE
	setflag ENGINE_RAINBOWBADGE
	setflag ENGINE_MARSHBADGE
	setflag ENGINE_SOULBADGE
	setflag ENGINE_VOLCANOBADGE
	setflag ENGINE_EARTHBADGE
	setevent EVENT_BEAT_ELITE_FOUR
	; setevent EVENT_BEAT_LEAF
	; fly anywhere
	setflag ENGINE_FLYPOINT_NEW_BARK
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	setflag ENGINE_FLYPOINT_VIOLET
	; setflag ENGINE_FLYPOINT_UNION_CAVE
	setflag ENGINE_FLYPOINT_AZALEA
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_FLYPOINT_ECRUTEAK
	setflag ENGINE_FLYPOINT_OLIVINE
	setflag ENGINE_FLYPOINT_CIANWOOD
	setflag ENGINE_FLYPOINT_MAHOGANY
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	setflag ENGINE_FLYPOINT_BLACKTHORN
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	setflag ENGINE_FLYPOINT_PALLET
	setflag ENGINE_FLYPOINT_VIRIDIAN
	setflag ENGINE_FLYPOINT_PEWTER
	; setflag ENGINE_FLYPOINT_MT_MOON
	setflag ENGINE_FLYPOINT_CERULEAN
	setflag ENGINE_FLYPOINT_VERMILION
	setflag ENGINE_FLYPOINT_CELADON
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	setflag ENGINE_FLYPOINT_LAVENDER
	setflag ENGINE_FLYPOINT_FUCHSIA
	setflag ENGINE_FLYPOINT_SAFFRON
	setflag ENGINE_FLYPOINT_CINNABAR
	; useful items
	giveitem BICYCLE
	giveitem TOWN_MAP
	giveitem POKE_FLUTE
	; giveitem VS_SEEKER
	giveitem MAX_REPEL, 99
	giveitem ESCAPE_ROPE, 99
	; shiny dex / incompatible atm
	; setflag ENGINE_CREDITS_SKIP
	; giveitem SHINY_CHARM
	; setflag ENGINE_HAVE_SHINY_CHARM
	; hm slaves
	givepoke MEW, 100, LEFTOVERS
	givepoke MEW, 100, LEFTOVERS
	loadvar wPartyMon1Moves+0, FLY
	loadvar wPartyMon1Moves+1, SURF
	loadvar wPartyMon1Moves+2, STRENGTH
	loadvar wPartyMon1Moves+3, CUT
	loadvar wPartyMon1PP+0, 15
	loadvar wPartyMon1PP+1, 15
	loadvar wPartyMon1PP+2, 15
	loadvar wPartyMon1PP+3, 30
	loadvar wPartyMon2Moves+0, FLASH
	loadvar wPartyMon2Moves+1, ROCK_SMASH
	loadvar wPartyMon2Moves+2, WATERFALL
	; no dive in pwhyd
	; loadvar wPartyMon2Moves+3, DIVE
	loadvar wPartyMon2PP+0, 20
	loadvar wPartyMon2PP+1, 15
	loadvar wPartyMon2PP+2, 15
	loadvar wPartyMon2PP+3, 10
	; pokedex
	callasm FillPokedex
	; phone
	addcellnum PHONE_MOM
	addcellnum PHONE_OAK
	addcellnum PHONE_BILL
	; you can leave New Bark Town
	setevent EVENT_OAK_KNOCKED_OUT
	clearevent EVENT_KNOCKED_OAK_IN_LAB
	setevent EVENT_DEFAULT_OAK_IN_LAB
	setevent EVENT_NEW_BARK_INTRO_FINISHED
	closetext
	end

FillPokedex:
	ld a, 1
	ld [wFirstMagikarpSeen], a
	ld hl, wPokedexSeen
	call .Fill
	ld hl, wPokedexCaught
.Fill:
	ld a, %11111111
	ld bc, 31 ; 001-248
	call ByteFill
	ld a, %00011111
	ld [hl], a ; 249-253
	ret

PlayersHouse2F_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_event  7,  0, PLAYERS_HOUSE_1F, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event  3,  2, BGEVENT_READ, PlayersHouseMrPlant
	; bg_event  7,  5, BGEVENT_READ, DebugBall  << I forgot why I put this here. Ignore.

	db 1 ; object events
	object_event  7,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DebugBall, EVENT_DEBUG_BALL
