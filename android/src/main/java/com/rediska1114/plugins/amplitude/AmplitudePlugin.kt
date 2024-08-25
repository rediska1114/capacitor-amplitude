package com.rediska1114.plugins.amplitude

import android.util.Log
import com.amplitude.android.Amplitude
import com.amplitude.android.AutocaptureOption
import com.amplitude.android.Configuration
import com.amplitude.core.ServerZone
import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "Amplitude")
class AmplitudePlugin : Plugin() {
  private lateinit var amplitude: Amplitude

  @PluginMethod
  fun initialize(call: PluginCall) {
    val apiKey = call.getString("apiKey") ?: return call.reject("API Key is required")

    val autocaptureSet = mutableSetOf<AutocaptureOption>(AutocaptureOption.SESSIONS)

    if (call.hasOption("autocapture")) {
      autocaptureSet.clear()
      val autocapture = call.getArray("autocapture")
      for (i in 0 until autocapture.length()) {
        val option = autocapture.getString(i)
        when (option.uppercase()) {
          "SESSIONS" -> autocaptureSet.add(AutocaptureOption.SESSIONS)
          "APP_LIFECYCLES" -> autocaptureSet.add(AutocaptureOption.APP_LIFECYCLES)
          "DEEP_LINKS" -> autocaptureSet.add(AutocaptureOption.DEEP_LINKS)
          "SCREEN_VIEWS" -> autocaptureSet.add(AutocaptureOption.SCREEN_VIEWS)
        }
      }
    }

    val config =
        Configuration(
                apiKey = apiKey,
                context = this.context.applicationContext,
                autocapture = autocaptureSet)
            // .apply {

              //          trackingOptions = call.getString("trackingOptions")?.let {
              // TrackingOptions.valueOf(it) }
            // }

    if (call.hasOption("deviceId")) {
      config.deviceId = call.getString("deviceId")
    }

    if (call.hasOption("partnerId")) {
      config.partnerId = call.getString("partnerId")
    }

    if (call.hasOption("flushIntervalMillis")) {
      config.flushIntervalMillis = call.getInt("flushIntervalMillis")!!
    }
    if (call.hasOption("flushQueueSize")) {
      config.flushQueueSize = call.getInt("flushQueueSize")!!
    }
    if (call.hasOption("flushMaxRetries")) {
      config.flushMaxRetries = call.getInt("flushMaxRetries")!!
    }
    if (call.hasOption("minIdLength")) {
      config.minIdLength = call.getInt("minIdLength")!!
    }
    if (call.hasOption("identifyBatchIntervalMillis")) {
      config.identifyBatchIntervalMillis = call.getLong("identifyBatchIntervalMillis")!!
    }
    if (call.hasOption("flushEventsOnClose")) {
      config.flushEventsOnClose = call.getBoolean("flushEventsOnClose")!!
    }
    if (call.hasOption("optOut")) {
      config.optOut = call.getBoolean("optOut")!!
    }
    if (call.hasOption("minTimeBetweenSessionsMillis")) {
      config.minTimeBetweenSessionsMillis = call.getLong("minTimeBetweenSessionsMillis")!!
    }
    if (call.hasOption("serverUrl")) {
      config.serverUrl = call.getString("serverUrl")!!
    }
    if (call.hasOption("serverZone")) {
      config.serverZone =
          when (call.getString("serverZone")) {
            "EU" -> ServerZone.EU
            else -> ServerZone.US
          }
    }
    if (call.hasOption("useBatch")) {
      config.useBatch = call.getBoolean("useBatch")!!
    }

    if (call.hasOption("useAdvertisingIdForDeviceId")) {
      config.useAdvertisingIdForDeviceId = call.getBoolean("useAdvertisingIdForDeviceId")!!
    }

    if (call.hasOption("useAppSetIdForDeviceId")) {
      config.useAppSetIdForDeviceId = call.getBoolean("useAppSetIdForDeviceId")!!
    }

    if (call.hasOption("enableCoppaControl")) {
      config.enableCoppaControl = call.getBoolean("enableCoppaControl")!!
    }
    if (call.hasOption("instanceName")) {
      config.instanceName = call.getString("instanceName")!!
    }
    if (call.hasOption("migrateLegacyData")) {
      config.migrateLegacyData = call.getBoolean("migrateLegacyData")!!
    }
    if (call.hasOption("offline")) {
      config.offline = call.getBoolean("offline")!!
    }
    if (call.hasOption("locationListening")) {
      config.locationListening = call.getBoolean("locationListening")!!
    }

    amplitude = Amplitude(config)
    call.resolve()
  }

  @PluginMethod
  fun track(call: PluginCall) {
    val eventName = call.getString("eventName")
    val properties = call.getObject("properties")?.toMap() ?: emptyMap()

    if (eventName == null) {
      call.reject("Event name is required")
      return
    }

    amplitude.track(eventName, properties)
    call.resolve()
  }

  @PluginMethod
  fun identifyUser(call: PluginCall) {
    val properties = call.getObject("properties")?.toMap() ?: emptyMap()

    amplitude.identify(properties)

    call.resolve()
  }

  @PluginMethod
  fun setUserId(call: PluginCall) {
    val userId = call.getString("userId")

    if (userId != null) {
      amplitude.setUserId(userId)
      call.resolve()
    } else {
      call.reject("User ID is required")
    }
  }

  @PluginMethod
  fun setDeviceId(call: PluginCall) {
    val deviceId = call.getString("deviceId")

    if (deviceId != null) {
      amplitude.setDeviceId(deviceId)
      call.resolve()
    } else {
      call.reject("Device ID is required")
    }
  }

  @PluginMethod
  fun reset(call: PluginCall) {
    amplitude.reset()
    call.resolve()
  }

  @PluginMethod
  fun setGroup(call: PluginCall) {
    val groupType = call.getString("groupType")
    val groupName = call.getString("groupName")

    if (groupType != null && groupName != null) {
      amplitude.setGroup(groupType, groupName)
      call.resolve()
    } else {
      call.reject("Group type and name are required")
    }
  }

  @PluginMethod
  fun logRevenue(call: PluginCall) {
    //    val productId = call.getString("productId")
    //    val price = call.getDouble("price") ?: 0.0
    //    val quantity = call.getInt("quantity") ?: 1
    //
    //    if (productId != null) {
    //      amplitude.logRevenue(productId, price, quantity)
    //      call.resolve()
    //    } else {
    //      call.reject("Product ID is required")
    //    }
    Log.w("AmplitudePlugin", "logRevenue not implemented")
  }

  private fun JSObject.toMap(): Map<String, Any> {
    val map = mutableMapOf<String, Any>()
    val keys = this.keys()
    while (keys.hasNext()) {
      val key = keys.next()
      map[key] = this.get(key)
    }
    return map
  }
}
