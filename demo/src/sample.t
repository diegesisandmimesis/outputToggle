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
		"This should be visible.\n ";
		gOutputOff;
		"This should not be visible.\n ";
		gOutputOn;
		"This should be visible again.\n ";
		runGame(true);
	}
;
