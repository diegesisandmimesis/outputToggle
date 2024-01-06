#charset "us-ascii"
//
// outputToggle.t
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
	isActive = nil
	activate() { gTranscript.deactivate(); isActive = true; }
	deactivate() { gTranscript.activate(); isActive = nil; }
	filterText(str, val) { return(isActive ? '' : inherited(str, val)); }
	execute() {
		mainOutputStream.addOutputFilter(self);
	}
;
