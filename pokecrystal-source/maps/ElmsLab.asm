	const_def 2 ; object constants
	const ELMSLAB_ELM
	const ELMSLAB_LYING_OAK
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_ELMS_AIDE

ElmsLab_MapScripts:
	db 5 ; scene scripts
	scene_script .DummyScene1 ; SCENE_ELMSLAB_CANT_LEAVE
	scene_script .DummyScene2 ; SCENE_ELMSLAB_NOTHING
	scene_script .DummyScene3 ; SCENE_ELMSLAB_MEET_OFFICER
	scene_script .DummyScene4 ; SCENE_ELMSLAB_UNUSED
	scene_script .DummyScene5 ; SCENE_ELMSLAB_AIDE_GIVES_POTION

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, .MoveElmCallback

.DummyScene1:
	end

.DummyScene2:
	end

.DummyScene3:
	end

.DummyScene4:
	end

.DummyScene5:
	end

.MoveElmCallback:
	checkscene
	iftrue .Skip ; not SCENE_DEFAULT
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	return

InitiateIntro:
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	opentext
	writetext ElmText_Intro
.MustSayYes:
	yesorno
	iftrue ElmSaidYes
	writetext ElmText_Refused
	waitbutton
	warp NEW_BARK_TOWN, 5, 4
	end

ElmSaidYes:
	writetext ElmText_Accepted
	buttonsound
	writetext KnockOut
	yesorno
	iftrue StealAPokemon
	writetext ElmText_Refused
	waitbutton
	warp NEW_BARK_TOWN, 5, 4
	end

StealAPokemon
	setscene SCENE_ELMSLAB_CANT_LEAVE
	setevent EVENT_OAK_KNOCKED_OUT
	clearevent EVENT_KNOCKED_OAK_IN_LAB
	setevent EVENT_DEFAULT_OAK_IN_LAB
	setevent EVENT_NEW_BARK_INTRO_FINISHED
	disappear ELMSLAB_ELM
	appear ELMSLAB_LYING_OAK
	refreshscreen
	clearevent EVENT_OAK_PERSIST
	writetext Ouchie
	waitbutton
	closetext
	end

KnockOut:
	text "Knock out"
	line "PROF.OAK?"
	done

Ouchie:
	text "Bonk!"
	para "Ouchie!"

	para "Mean 'ol"
	line "PROF.OAK"
	cont "crumpled to the"
	cont "floor!"

	para "Time to choose"
	line "your very first"
	cont "#MON!"
	done

ProfElmScript:
	faceplayer
	checkevent EVENT_OAK_KNOCKED_OUT
	iftrue HesOutCold
	checkevent EVENT_OAK_PERSIST
	iftrue InitiateIntro
	closetext
	end

HesOutCold:
	opentext
	writetext HesOutColdText
	waitbutton
	closetext
	end

HesOutColdText:
	text "The old timer is"
	line "out cold!"

	para "Gee... I hope he's"
	line "breathing..."
	done

LabTryToLeaveScript:
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
	applymovement PLAYER, ElmsLab_CantLeaveMovement
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	refreshscreen
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	buttonsound
	waitsfx
	pokenamemem CYNDAQUIL, MEM_BUFFER_0
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke CYNDAQUIL, 5, BERRY
	closetext
	jump ElmDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	buttonsound
	waitsfx
	pokenamemem TOTODILE, MEM_BUFFER_0
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke TOTODILE, 5, BERRY
	closetext
	jump ElmDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterChikoritaText
	buttonsound
	waitsfx
	pokenamemem CHIKORITA, MEM_BUFFER_0
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke CHIKORITA, 5, BERRY
	closetext
	jump ElmDirectionsScript

ElmDirectionsScript:
	setscene SCENE_ELMSLAB_NOTHING
	setmapscene NEW_BARK_TOWN, SCENE_FINISHED
	end

LookAtElmPokeBallScript:
	opentext
	writetext ElmPokeBallText
	waitbutton
	closetext
	end

DidntChooseStarterScript:
	writetext DidntChooseStarterText
	waitbutton
	closetext
	end

ElmPokeBallText:
	text "This #MON"
	line "looks weak!"
	done

ElmsAideScript:
	faceplayer
	opentext
	checkevent EVENT_OAK_KNOCKED_OUT
	iftrue AideScript_TimeToLeave
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	end

AideScript_TimeToLeave:
	writetext AideTextLeaving
	waitbutton
	closetext
	checkcode VAR_FACING
	ifequal RIGHT, MoveWay
	applymovement ELMSLAB_ELMS_AIDE, AideKnockOutMovement
	disappear ELMSLAB_ELMS_AIDE
	setscene SCENE_ELMSLAB_NOTHING
	setevent EVENT_ELMS_AIDE_IN_LAB
	end

MoveWay
	applymovement PLAYER, MoveWay_Movement
	applymovement ELMSLAB_ELMS_AIDE, AideKnockOutMovement
	disappear ELMSLAB_ELMS_AIDE
	setscene SCENE_ELMSLAB_NOTHING
	setevent EVENT_ELMS_AIDE_IN_LAB
	end

MoveWay_Movement
	turn_head UP
	step UP
	turn_head DOWN
	step_end

OakNotes1:
	jumptext OakNotes1Text

OakNotes2:
	jumptext OakNotes2Text

OakNotes3:
	jumptext OakNotes3Text

OakNotes4:
	jumptext OakNotes4Text

OakNotes5:
	jumptext OakNotes5Text

OakNotes6
	jumptext OakNotes6Text

OakNotes1Text:
	text "OAK'S NOTES"
	
	para "TAKE PILLS!"
	done

OakNotes2Text:
	text "OAK'S NOTES"

	para "READ NOTES!"
	done

OakNotes3Text:
	text "OAK'S NOTES"

	para "Hello there!"
	para "Welcome to the"
	line "world of #MON!"
	para "My name is OAK!"
	para "People call me"
	line "the #MON PROF!"
	para "..."
	para "...This goes on"
	line "for quite some"
	cont "time."
	done

OakNotes4Text:
	text "OAK'S NOTES"

	para "FGDFSDAFFCC"

	para "..."
	para "...What?!"
	done

OakNotes5Text:
	text "OAK's fdfcz"
	
	para "This note is"
	line "barely"
	cont "ledgible."
	done

OakNotes6Text:
	text "OAK'S NOTES!"

	para "Don't talk to"
	line "the TEACHER!!!"
	done

ElmsLabTrashcan:
	jumptext ElmsLabTrashcanText

ElmsLabPC:
	jumptext ElmsLabPCText

ElmsLabTrashcan2:
; unused
	jumpstd trashcan

UhOhBookshelf:
	jumptext UhOhBookshelfText

ElmsLabBookshelf:
	jumptext ElmsLabBookshelfText

ElmsLabBookshelfText:
	text "It's full of old"
	line "#MON books!"

	para "A lot of these"
	line "haven't been"
	cont "opened in"
	cont "years..."
	done

UhOhBookshelfText:
	text "..."

	para "What the"
	line "hell?!"

	para "It's full of"
	line "hentai and"
	cont "erotica!"

	para "Naughty"
	line "PROF.OAK!"
	done

ElmsLab_CantLeaveMovement:
	step UP
	step_end

AideKnockOutMovement:
	turn_head LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step DOWN
	step DOWN
	step_end

ElmText_Intro:
	text "WHO YOU?"
	line "How you in here?"
	
	para "I know you?"

	para "BBBRRRNNNBBLL!"

	para "Ah, you come"
	line "for #MON?"
	done

ElmText_Accepted:
	text "WELL, NO FOR"
	line "YOU!"

	para "MY #MON!"
	line "you GO NOW!"
	done

ElmText_Refused:
	text "OK!!!!!!!"
	done

LabWhereGoingText:
	text "Aww c'mon!"
	para "Let's steal"
	line "a #MON!"
	done

TakeCyndaquilText:
	text "This #MON is"
	line "very HOT!"

	para "maybe it can"
	line "burn my foes!"
	done

TakeTotodileText:
	text "This one looks"
	line "crazy!"

	para "Those teeth..."
	para "It looks"
	line "strong!"
	done

TakeChikoritaText:
	text "This one has"
	line "sharp leaves!"

	para "Wait..."

	para "Sharp leaves?!"

	para "Leaves aren't"
	line "sharp!"

	para "What the hell"
	line "Gamefreak?!"
	done

DidntChooseStarterText:
	text "Eh, it looks"
	line "took weak."

	para "I don't want"
	line "a weak #MON!"
	done

ChoseStarterText:
	text "Yeah! This one"
	line "must be the"
	cont "strongest!"
	done

ChoseStarterChikoritaText:
	text "Whatever."
	para "Sharp leaves"
	line "or not..."

	para "Chikorita is"
	line "badass!"
	done

ReceivedStarterText:
	text "<PLAYER> stole"
	line "@"
	text_from_ram wStringBuffer3
	text "!"
	done

ElmsLabTrashcanText:
	text "Full of empty"
	line "pill containers!"
	done

ElmsLabPCText:
	text "It looks like"
	line "PROF.OAK opened"
	para "a blank Word"
	line "document and"
	cont "started mashing"
	cont "on the keys!"
	done

AideTextLeaving:
	text "Not gonna lie..."

	para "I've been wanting"
	line "to do that myself"
	cont "for a long time."

	para "Thanks a million."

	para "Maybe I'll see"
	line "you around..."
	done

AideText_AlwaysBusy:
	text "I'm worried about"
	line "PROF.OAK."

	para "His health hasn't"
	line "been the best"
	cont "lately."

	para "Not to mention..."
	line "his speech has"
	cont "gotten much worse."

	para "We moved him down"
	line "to JOHTO so he"
	cont "can get better"
	cont "care."
	done

ElmsLab_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  0, 11, NEW_BARK_TOWN, 1
	warp_event  1, 11, NEW_BARK_TOWN, 1

	db 2 ; coord events
	coord_event  2,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  3,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript

	db 15 ; bg events
	bg_event  4,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  5,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  6,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  7,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  8,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  7, BGEVENT_READ, UhOhBookshelf
	bg_event  4, 11, BGEVENT_READ, ElmsLabBookshelf
	bg_event  4,  0, BGEVENT_READ, OakNotes1
	bg_event  5,  0, BGEVENT_READ, OakNotes2
	bg_event  6,  0, BGEVENT_READ, OakNotes3
	bg_event  7,  0, BGEVENT_READ, OakNotes4
	bg_event  8,  0, BGEVENT_READ, OakNotes5
	bg_event  9,  0, BGEVENT_READ, OakNotes6
	bg_event  9,  3, BGEVENT_READ, ElmsLabTrashcan
	bg_event  1,  5, BGEVENT_DOWN, ElmsLabPC

	db 6 ; object events
	object_event  3,  3, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, EVENT_DEFAULT_OAK_IN_LAB
	object_event  3,  4, SPRITE_LYING_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, EVENT_KNOCKED_OAK_IN_LAB
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  6,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
