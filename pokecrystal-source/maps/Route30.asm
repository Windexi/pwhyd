	const_def 2 ; object constants
	const ROUTE30_YOUNGSTER1
	const ROUTE30_YOUNGSTER2
	const ROUTE30_YOUNGSTER3
	const ROUTE30_BUG_CATCHER
	const ROUTE30_COOLTRAINER_F
	const ROUTE30_POKE_BALL
	const ROUTE30_ADRIAN

Route30_MapScripts:
	db 2 ; scene scripts
	scene_script .DummyScene0 ; SCENE_ROUTE30_NOTHING
	scene_script .DummyScene1 ; SCENE_MEET_ADRIAN

	db 0 ; callbacks

.DummyScene0:
	end

.DummyScene1:
	end	

Route30MeetAdrianLeft:
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, DOWN
	special FadeOutMusic
	appear ROUTE30_ADRIAN
	applymovement ROUTE30_ADRIAN, AdrianLeftMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	jp MeetAdrian
Route30MeetAdrianRight:
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, DOWN
	special FadeOutMusic
	appear ROUTE30_ADRIAN
	applymovement ROUTE30_ADRIAN, AdrianRightMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	jp MeetAdrian
MeetAdrian:
	opentext
	writetext MeetAdrianText
	waitbutton
	closetext
	loadtrainer RIVAL1, RIVAL1_1_LICKITUNG
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	iftrue YouBeatAdrian
	jp AdrianWon

YouBeatAdrian:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext YouBeatAdrianText
	waitbutton
	closetext
	jp AdrianLeaves

AdrianWon:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext AdrianWonText
	waitbutton
	closetext
AdrianLeaves:
	applymovement ROUTE30_ADRIAN, AdrianLeavesMovement
	disappear ROUTE30_ADRIAN
	setscene SCENE_ROUTE30_NOTHING
	special HealParty
	playmapmusic
	end

MeetAdrianText:
	text "Oh, hello!"
	line "don't I know you"
	cont "from somewhere?"

	para "<……> <……> <……>"

	para "Oh yes! You're"
	line "that quiet kid"
	cont "from town!"

	para "Well, allow me"
	line "to introduce"
	cont "myself!"

	para "the name's"
	line "ADRIAN!"

	para "I live in that"
	line "big 'ol house"
	cont "smack dab"
	cont "in the middle."

	para "<……> <……> <……>"

	para ":D"

	para "<……> <……> <……>"

	para "Say! How about"
	line "we have a quick"
	cont "battle? Just"
	cont "the two of us!"

	para "It'll be fun!"
	done

AdrianWonText:
	para "Wow..."
	line "I won! :DDD"

	para "I didn't think"
	line "I was THAT good!"

	para "Well, you did"
	line "good too! Don't"
	cont "be too hard"
	cont "on yourself!"

	para "Hey, I'm going"
	line "to go ahead..."
	
	para "...but I'll see"
	line "you again, I"
	cont "hope!! ;;)"

	para "Seeyaaaa!"
	done

YouBeatAdrianText:
	para "Awwwwww :("
	line "I lost!"

	para "My poor"
	line "LICKITUNG!"

	para "Oh well, that"
	line "was a GREAT"
	cont "battle!"

	para "You're really"
	line "good!!!! :DD"

	para "Hey, I'm going"
	line "to go ahead..."
	
	para "...but I'll see"
	line "you again, I"
	cont "hope!! ;;)"

	para "Seeyaaaa!"
	done

.Script:
	writecode VAR_CALLERID, PHONE_YOUNGSTER_JOEY
	endifjustbattled
	opentext
	checkflag ENGINE_JOEY
	iftrue .Rematch
	checkcellnum PHONE_YOUNGSTER_JOEY
	iftrue .NumberAccepted
	checkevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext YoungsterJoey1AfterText
	buttonsound
	setevent EVENT_JOEY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	jump .RequestNumber

.AskAgain:
	scall .AskNumber2
.RequestNumber:
	askforphonenumber PHONE_YOUNGSTER_JOEY
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	trainertotext YOUNGSTER, JOEY1, MEM_BUFFER_0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext YoungsterJoey1BeatenText, 0
	copybytetovar wJoeyFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer YOUNGSTER, JOEY1
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 1
	clearflag ENGINE_JOEY
	end

.LoadFight1:
	loadtrainer YOUNGSTER, JOEY2
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 2
	clearflag ENGINE_JOEY
	end

.LoadFight2:
	loadtrainer YOUNGSTER, JOEY3
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 3
	clearflag ENGINE_JOEY
	end

.LoadFight3:
	loadtrainer YOUNGSTER, JOEY4
	startbattle
	reloadmapafterbattle
	loadvar wJoeyFightCount, 4
	clearflag ENGINE_JOEY
	end

.LoadFight4:
	loadtrainer YOUNGSTER, JOEY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JOEY
	checkevent EVENT_JOEY_HP_UP
	iftrue .GiveHPUp
	checkevent EVENT_GOT_HP_UP_FROM_JOEY
	iftrue .done
	scall .RematchGift
	verbosegiveitem HP_UP
	iffalse .PackFull
	setevent EVENT_GOT_HP_UP_FROM_JOEY
	jump .NumberAccepted

.done
	end

.GiveHPUp:
	opentext
	writetext YoungsterJoeyText_GiveHPUpAfterBattle
	waitbutton
	verbosegiveitem HP_UP
	iffalse .PackFull
	clearevent EVENT_JOEY_HP_UP
	setevent EVENT_GOT_HP_UP_FROM_JOEY
	jump .NumberAccepted

.AskNumber1:
	jumpstd asknumber1m
	end

.AskNumber2:
	jumpstd asknumber2m
	end

.RegisteredNumber:
	jumpstd registerednumberm
	end

.NumberAccepted:
	jumpstd numberacceptedm
	end

.NumberDeclined:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.RematchStd:
	jumpstd rematchm
	end

.PackFull:
	setevent EVENT_JOEY_HP_UP
	jumpstd packfullm
	end

.RematchGift:
	jumpstd rematchgiftm
	end

TrainerYoungsterMikey:
	trainer YOUNGSTER, MIKEY, EVENT_BEAT_YOUNGSTER_MIKEY, YoungsterMikeySeenText, YoungsterMikeyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterMikeyAfterText
	waitbutton
	closetext
	end

TrainerBugCatcherDon:
	trainer BUG_CATCHER, DON, EVENT_BEAT_BUG_CATCHER_DON, BugCatcherDonSeenText, BugCatcherDonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BugCatcherDonAfterText
	waitbutton
	closetext
	end

;Route30YoungsterScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .CompletedEggQuest
	writetext Route30YoungsterText_DirectionsToMrPokemonsHouse
	waitbutton
	closetext
	end

.CompletedEggQuest:
	writetext Route30YoungsterText_EveryoneIsBattling
	waitbutton
	closetext
	end

Route30CooltrainerFScript:
	jumptextfaceplayer Route30CooltrainerFText

Route30Sign:
	jumptext Route30SignText

HiddenSign:
	jumptext HiddenSignText

VaccineHouseSign:
	jumptext VaccineHouseSignText

Route30PPUp:
	itemball PP_UP

Route30HiddenPotion:
	hiddenitem SUPER_POTION, EVENT_ROUTE_30_HIDDEN_SUPER_POTION

Route30_JoeysRattataAttacksMovement:
	fix_facing
	big_step UP
	big_step DOWN
	step_end

Route30_MikeysRattataAttacksMovement:
	fix_facing
	big_step DOWN
	big_step UP
	step_end

Text_UseTackle:
	text "Go, RATTATA!"

	para "TACKLE!"
	done

Text_ThisIsABigBattle:
	text "What? This is a"
	line "big battle!"
	cont "Leave me alone!"
	done

YoungsterJoey1SeenText:
	text "I just lost, so"
	line "I'm trying to find"
	cont "more #MON."

	para "Wait! You look"
	line "weak! Come on,"
	cont "let's battle!"
	done

YoungsterJoey1BeatenText:
	text "Ack! I lost again!"
	line "Doggone it!"
	done

YoungsterJoey1AfterText:
	text "Do I have to have"
	line "more #MON in"

	para "order to battle"
	line "better?"

	para "No! I'm sticking"
	line "with this one no"
	cont "matter what!"
	done

YoungsterMikeySeenText:
	text "You're a #MON"
	line "trainer, right?"

	para "Then you have to"
	line "battle!"
	done

YoungsterMikeyBeatenText:
	text "That's strange."
	line "I won before."
	done

YoungsterMikeyAfterText:
	text "Becoming a good"
	line "trainer is really"
	cont "tough."

	para "I'm going to bat-"
	line "tle other people"
	cont "to get better."
	done

BugCatcherDonSeenText:
	text "Instead of a bug"
	line "#MON, I found"
	cont "a trainer!"
	done

BugCatcherDonBeatenText:
	text "Argh! You're too"
	line "strong!"
	done

BugCatcherDonAfterText:
	text "I ran out of #"
	line "BALLS while I was"
	cont "catching #MON."

	para "I should've bought"
	line "some more…"
	done

Route30YoungsterText_DirectionsToMrPokemonsHouse:
	text "MR.#MON's"
	line "house? It's a bit"
	cont "farther ahead."
	done

Route30YoungsterText_EveryoneIsBattling:
	text "Everyone's having"
	line "fun battling!"
	cont "You should too!"
	done

Route30CooltrainerFText:
	text "I'm not a trainer."

	para "But if you look"
	line "one in the eyes,"
	cont "prepare to battle."
	done

Route30SignText:
	text "ROUTE 30"

	para "FONTAN CITY -"
	line "DUPI CITY  "
	done

HiddenSignText:
	text "OAK'S NOTES"
	para "CTRL-C is copy!"
	line "CTRL-V is paste!"
	done

VaccineHouseSignText:
	text "MR.#MON'S HOUSE"
	done

YoungsterJoeyText_GiveHPUpAfterBattle:
	text "I lost again…"
	line "Gee, you're tough!"

	para "Oh yeah, I almost"
	line "forgot that I had"
	cont "to give you this."

	para "Use it to get even"
	line "tougher, OK?"

	para "I'm going to get"
	line "tougher too."
	done

AdrianLeftMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_down
	step_down
	step_down
	step_end

AdrianRightMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_down
	step_down
	step_down
	step_end

AdrianLeavesMovement:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_left
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

Route30_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  8, 39, ROUTE_30_BERRY_HOUSE, 1 ; TODO: turn into cave
	warp_event  3, 25, MR_POKEMONS_HOUSE, 1 ; TODO: turn into TM House

	db 2 ; coord events
	coord_event  6, 52, SCENE_MEET_ADRIAN, Route30MeetAdrianLeft
	coord_event  7, 52, SCENE_MEET_ADRIAN, Route30MeetAdrianRight

	db 4 ; bg events
	bg_event  5, 47, BGEVENT_READ, Route30Sign
	bg_event 17, 41, BGEVENT_READ, HiddenSign
	bg_event 15, 13, BGEVENT_READ, VaccineHouseSign
	bg_event 10, 51, BGEVENT_ITEM, Route30HiddenPotion

	db 6 ; object events
	object_event  4, 47, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_BATTLE
	object_event  8, 43, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, ObjectEvent, EVENT_ROUTE_30_YOUNGSTER_JOEY
	object_event 10, 31, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerYoungsterMikey, -1
	object_event 16, 19, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherDon, -1
	object_event  4, 10, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route30CooltrainerFScript, -1
	object_event 17, 38, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route30PPUp, EVENT_ROUTE_30_PP_UP
	object_event  3, 43, SPRITE_ADRIAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MEET_ADRIAN
