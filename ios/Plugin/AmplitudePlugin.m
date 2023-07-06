#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(AmplitudePlugin, "Amplitude",
        CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(enableCoppaControl, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(disableCoppaControl, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(regenerateDeviceId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setDeviceId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(getDeviceId, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setOptOut, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(useAdvertisingIdForDeviceId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setPlan, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setIngestionMetadata, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(trackingSessionEvents, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setUseDynamicConfig, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setUserId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setServerUrl, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(logEvent, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(logEventWithProperties, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setUserProperties, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(logRevenueV2, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(identify, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(groupIdentify, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setGroup, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(clearUserProperties, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(uploadEvents, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(getSessionId, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setMinTimeBetweenSessionsMillis, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setServerZone, CAPPluginReturnPromise); 
        CAP_PLUGIN_METHOD(setEventUploadMaxBatchSize, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setEventUploadPeriodMillis, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(setEventUploadThreshold, CAPPluginReturnPromise); 
)
