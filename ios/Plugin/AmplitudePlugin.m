#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(AmplitudePlugin, "Amplitude",
        CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(track, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(identify, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setUserId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(getDeviceId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(getUserId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setDeviceId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(reset, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setGroup, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(logRevenue, CAPPluginReturnPromise);
)
