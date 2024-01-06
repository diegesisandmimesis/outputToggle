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
	active = nil
	activate() { if(gTranscript) gTranscript.deactivate(); active = true; }
	deactivate() { if(gTranscript) gTranscript.activate(); active = nil; }
	filterText(str, val) { return(active ? '' : inherited(str, val)); }
	execute() { mainOutputStream.addOutputFilter(self); }
;
