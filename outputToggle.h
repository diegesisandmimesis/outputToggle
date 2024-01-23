//
// outputToggle.h
//

// Uncomment to enable debugging options.
//#define __DEBUG_OUTPUT_TOGGLE

#define gOutputOn (outputToggleFilter.deactivate())
#define gOutputOff (outputToggleFilter.activate())
#define gOutputCheck (outputToggleFilter.active)

#define gOutputLock (outputToggleFilter.activate())
#define gOutputUnlock(v) (outputToggleFilter.deactivate(v))

#define OUTPUT_TOGGLE_H
