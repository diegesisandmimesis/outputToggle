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
//	Alternately, if you have a lot of things fiddling with the output
//	filter you can use:
//
//		// Same as gOutputOff, but with an explicit lock ID.
//		local id = gOutputLock;
//
//		// Remove the given lock.  If no locks remain after this
//		// done, this re-activates output.
//		gOutputUnlock(id);
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

	// Number of times to re-try a lock.  Retrying a lock should happen
	// VERY infrequently, so this should be a small number.
	_lockRetries = 3

	active = nil

	activate() {
		if(gTranscript) gTranscript.deactivate();
		active = true;
	}

	deactivate() {
		if(gTranscript) gTranscript.activate();
		active = nil;
	}

	set(v) {
		if(v == true) activate();
		else deactivate();
	}

	// Activate the filter, adding a lock.
	lock() {
		local i, v;

		v = nil;
		i = 0;

		// Create a random lock ID and add it to the list.
		while(v == nil) {
			v = rand(65536);

			// Make sure the lock number isn't already in use.
			if(_locks.indexOf(v) != nil)
				v = nil;

			// Make sure we're not stuck in a loop.  Lock
			// collisions have a probability of n in 65536,
			// where n is the number of locks.  So this is
			// probably overkill.  But eh.
			i += 1;
			if(i > _lockRetries)
				return(nil);
		}

		// Add the lock.
		_locks.append(v);

		// Activate the filter.
		activate();

		// Return the new lock ID.
		return(v);
	}

	unlock(v?) {
		if(v != nil) {
			// Remove the requested lock.
			if(_locks.indexOf(v) == nil)
				return(nil);
			_locks.removeElement(v);
		} else {
			// If the arg is nil remove the last lock.
			if(_locks.length == 0)
				return(nil);
			_locks.removeElementAt(_locks.length);
		}

		// If we still have locks, bail.
		if(_locks.length > 0)
			return(nil);

		// Deactivate the filter.
		deactivate();

		return(true);
	}
	filterText(str, val) { return(active ? '' : inherited(str, val)); }
	execute() { mainOutputStream.addOutputFilter(self); }
;
