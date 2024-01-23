#charset "us-ascii"
//
// outputToggle.t
//
//	This is a very simple TADS3/adv3 module that provides an output
//	filter that will block all normal output.
//
//
// USAGE
//
//	Disable output with:
//
//		gOutputOff;
//
//	Re-enable output with:
//
//		gOutputOn;
//
//
#include <adv3.h>
#include <en_us.h>

// Module ID for the library
outputToggleModuleID: ModuleID {
        name = 'Output Toggle Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

outputToggleFilter: OutputFilter, PreinitObject
	_locks = perInstance(new Vector())

	active = nil

	activate() {
		local v;

		v = rand(65536);
		_locks.append(v);
		gTranscript.deactivate();
		active = true;
		return(v);
	}
	deactivate(v) {
		if(_locks.indexOf(v) == nil) return(nil);
		_locks.removeElement(v);
		if(_locks.length > 0) return(nil);
		active = nil;
		gTranscript.activate();
		return(true);
	}
/*
	activate() { if(gTranscript) gTranscript.deactivate(); active = true; }
	deactivate() { if(gTranscript) gTranscript.activate(); active = nil; }
	set(v) { if(v == true) activate(); else deactivate(); }
*/
	filterText(str, val) { return(active ? '' : inherited(str, val)); }
	execute() { mainOutputStream.addOutputFilter(self); }
;

// Command transcript for suppressing reports.
// The constructor sets the instance as the global transcript,
// restoreTranscript() sets it back to the way it was.
// Usage:
//
//	local tr = new OutputToggleTranscript();
//		// some stuff
//	tr.restoreTranscript();
//
// ...to suppress any reports generated in "some stuff".
OutputToggleTranscript: CommandTranscript
	_savedTranscript = nil

	addReport(report) {}
	filterText(str, txt) { return(nil); }
	reports_ = static []

	construct() { _savedTranscript = gTranscript; gTranscript = self; }
	restoreTranscript() { gTranscript = _savedTranscript; }
;
