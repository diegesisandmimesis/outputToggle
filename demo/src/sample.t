#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the outputToggle library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

#include "outputToggle.h"

versionInfo: GameID;

startRoom: Room 'Void' "This is a featureless void.";
+me: Person;

gameMain: GameMainDef
	initialPlayerChar = me
	newGame() {
		showIntro();
		outputTest();
		showHelp();
		runGame(true);
	}
	showIntro() {
		"This is a demo for the outputToggle filter.  Immediately
		below is a simple output test: ";
		"<.p> ";
	}
	showHelp() {
		"Use the <b>&gt;SYSTEMACTIONTEST</b> to repeat the test
		inside of a system action and <b>&gt;IACTIONTEST</b> to
		repeat the test inside of a <q>normal</q> action. ";
		"<.p> ";
	}
	outputTest() {
		"Three output lines follow.  The lines numbered
		01 and 03 should be visible, the line numbered 02
		should not.\n ";
		"<.p> ";
		"01:  This should be visible.\n ";
		gOutputOff;
		"02:  This should not be visible.\n ";
		gOutputOn;
		"03:  This should be visible again.\n ";
		"<.p> ";
	}
;

DefineSystemAction(SystemActionTest)
	execSystemAction() { gameMain.outputTest(); }
;
VerbRule(SystemActionTest) 'systemactiontest': SystemActionTestAction
	verbPhrase = 'test/testing';

DefineIAction(IActionTest)
	execAction() { gameMain.outputTest(); }
;
VerbRule(IActionTest) 'iactiontest': IActionTestAction
	verbPhrase = 'test/testing';
