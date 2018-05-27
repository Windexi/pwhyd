	const_def 2 ; object constants
	const PLAYERSHOUSE1F_MOM1
	const PLAYERSHOUSE1F_MOM2
	const PLAYERSHOUSE1F_MOM3
	const PLAYERSHOUSE1F_MOM4
	const PLAYERSHOUSE1F_POKEFAN_F

PlayersHouse1F_MapScripts:
	db 2 ; scene scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	db 0 ; callbacks

.DummyScene0:
	end

.DummyScene1:
	end

MeetMomLeftScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

MeetMomRightScript:
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYER, LEFT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .OnRight
	applymovement PLAYERSHOUSE1F_MOM1, MovementData_0x7a5fc
	jump MeetMomScript

.OnRight:
	applymovement PLAYERSHOUSE1F_MOM1, MovementData_0x7a5fe
MeetMomScript:
	opentext
	writetext UnknownText_0x7a604
	buttonsound
	stringtotext GearName, MEM_BUFFER_1
	scall PlayersHouse1FReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene SCENE_FINISHED
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext UnknownText_0x7a6bd
	buttonsound
	special SetDayOfWeek
.SetDayOfWeek:
	writetext UnknownText_0x7a742
	yesorno
	iffalse .WrongDay
	special InitialSetDSTFlag
	yesorno
	iffalse .SetDayOfWeek
	jump .DayOfWeekDone

.WrongDay:
	special InitialClearDSTFlag
	yesorno
	iffalse .SetDayOfWeek
.DayOfWeekDone:
	writetext UnknownText_0x7a763
	yesorno
	iffalse .ExplainPhone
	jump .KnowPhone

.KnowPhone:
	writetext UnknownText_0x7a7cb
	buttonsound
	jump .FinishPhone

.ExplainPhone:
	writetext UnknownText_0x7a807
	buttonsound
	jump .FinishPhone

.FinishPhone:
	writetext UnknownText_0x7a850
	waitbutton
	closetext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .FromRight
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iffalse .FromLeft
	jump .Finish

.FromRight:
	applymovement PLAYERSHOUSE1F_MOM1, MovementData_0x7a600
	jump .Finish

.FromLeft:
	applymovement PLAYERSHOUSE1F_MOM1, MovementData_0x7a602
	jump .Finish

.Finish:
	special RestartMapMusic
	turnobject PLAYERSHOUSE1F_MOM1, LEFT
	end

MeetMomTalkedScript:
	jump MeetMomScript

GearName:
	db "#GEAR@"

PlayersHouse1FReceiveItemStd:
	jumpstd receiveitem
	end

MomScript:
	faceplayer
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkscene
	iffalse MeetMomTalkedScript ; SCENE_DEFAULT
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .FirstTimeBanking
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .GaveMysteryEgg
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .GotAPokemon
	writetext UnknownText_0x7a8b5
	waitbutton
	closetext
	end

.GotAPokemon:
	writetext UnknownText_0x7a8e5
	waitbutton
	closetext
	end

.FirstTimeBanking:
	writetext UnknownText_0x7a957
	waitbutton
	closetext
	end

.GaveMysteryEgg:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special BankOfMom
	waitbutton
	closetext
	end

.Main:
	writetext NeighborText
	waitbutton
	closetext
	turnobject PLAYERSHOUSE1F_POKEFAN_F, RIGHT
	end

MovementData_0x7a5fc:
	turn_head RIGHT
	step_end

MovementData_0x7a5fe:
	slow_step RIGHT
	step_end

MovementData_0x7a600:
	turn_head LEFT
	step_end

MovementData_0x7a602:
	slow_step LEFT
	step_end

UnknownText_0x7a604:
	text "shoutouts to simpleflips"

UnknownText_0x7a6bd:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a742:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a763:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a7cb:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a807:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a850:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a8b5:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a8e5:
	text "shoutouts to simpleflips"
	done

UnknownText_0x7a957:
	text "shoutouts to simpleflips"
	done

NeighborText:
	text "shoutouts to simpleflips"
	done

PlayersHouse1F_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  5,  7, NEW_BARK_TOWN, 2
	warp_event  7,  1, PLAYERS_HOUSE_2F, 1

	db 1 ; coord events
	coord_event  5,  4, SCENE_DEFAULT, MeetMomLeftScript

	db 0 ; bg events

	db 1 ; object events
	object_event  1,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1