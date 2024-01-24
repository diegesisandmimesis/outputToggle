//
// outputToggle.h
//

// Uncomment to enable debugging options.
//#define __DEBUG_OUTPUT_TOGGLE

#define gOutputOn (outputToggleFilter.deactivate())
#define gOutputOff (outputToggleFilter.activate())
#define gOutputCheck (outputToggleFilter.active)
#define gOutputSet(v) (outputToggleFilter.set(v))

#define gOutputLock (outputToggleFilter.lock())
#define gOutputUnlock(v) (outputToggleFilter.unlock(v))

#define OUTPUT_TOGGLE_H
