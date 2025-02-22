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
  private val amplitudeInstances: MutableMap<String, Amplitude> = mutableMapOf()
  private val defaultInstanceName = "\$default_instance"

  @OptIn(ExperimentalAmplitudeFeature::class)
  @PluginMethod
  fun initialize(call: PluginCall) {
    val apiKey = call.getString("apiKey") ?: return call.reject("API Key is required")
    val instanceName = call.getString("instanceName") ?: defaultInstanceName

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
          "ELEMENT_INTERACTIONS" -> autocaptureSet.add(AutocaptureOption.ELEMENT_INTERACTIONS)
        }
      }
    }

    val config =
        Configuration(
            apiKey = apiKey,
            context = this.context.applicationContext,
            instanceName = instanceName,
            autocapture = autocaptureSet)

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
    if (call.hasOption("migrateLegacyData")) {
      config.migrateLegacyData = call.getBoolean("migrateLegacyData")!!
    }
    if (call.hasOption("offline")) {
      config.offline = call.getBoolean("offline")!!
    }
    if (call.hasOption("locationListening")) {
      config.locationListening = call.getBoolean("locationListening")!!
    }

    val amplitude = Amplitude(config)
    amplitudeInstances[instanceName] = amplitude
    call.resolve()
  }

  @PluginMethod
  fun track(call: PluginCall) {
    val eventName = call.getString("eventName")
    val instanceName = call.getString("instanceName") ?: defaultInstanceName
    val properties = call.getObject("properties")?.toMap() ?: emptyMap()

    if (eventName == null) {
      call.reject("Event name is required")
      return
    }

    amplitudeInstances[instanceName]?.track(eventName, properties)
    call.resolve()
  }

  @PluginMethod
  fun identify(call: PluginCall) {
    val instanceName = call.getString("instanceName") ?: defaultInstanceName
    val properties = call.getObject("properties")?.toMap() ?: emptyMap()

    amplitudeInstances[instanceName]?.identify(properties)
    call.resolve()
  }

  @PluginMethod
  fun setUserId(call: PluginCall) {
    val userId = call.getString("userId")
    val instanceName = call.getString("instanceName") ?: defaultInstanceName

    if (userId != null) {
      amplitudeInstances[instanceName]?.setUserId(userId)
      call.resolve()
    } else {
      call.reject("User ID is required")
    }
  }

  @PluginMethod
  fun getDeviceId(call: PluginCall) {
    val instanceName = call.getString("instanceName") ?: defaultInstanceName
    val deviceId = amplitudeInstances[instanceName]?.getDeviceId()
    val data = JSObject().apply { put("deviceId", deviceId) }
    call.resolve(data)
  }

  @PluginMethod
  fun getUserId(call: PluginCall) {
    val instanceName = call.getString("instanceName") ?: defaultInstanceName
    val userId = amplitudeInstances[instanceName]?.getUserId()
    val data = JSObject().apply { put("userId", userId) }
    call.resolve(data)
  }

  @PluginMethod
  fun setDeviceId(call: PluginCall) {
    val deviceId = call.getString("deviceId")
    val instanceName = call.getString("instanceName") ?: defaultInstanceName

    if (deviceId != null) {
      amplitudeInstances[instanceName]?.setDeviceId(deviceId)
      call.resolve()
    } else {
      call.reject("Device ID is required")
    }
  }

  @PluginMethod
  fun reset(call: PluginCall) {
    val instanceName = call.getString("instanceName") ?: defaultInstanceName
    amplitudeInstances[instanceName]?.reset()
    call.resolve()
  }

  @PluginMethod
  fun setGroup(call: PluginCall) {
    val groupType = call.getString("groupType")
    val groupName = call.getString("groupName")
    val instanceName = call.getString("instanceName") ?: defaultInstanceName

    if (groupType != null && groupName != null) {
      amplitudeInstances[instanceName]?.setGroup(groupType, groupName)
      call.resolve()
    } else {
      call.reject("Group type and name are required")
    }
  }

  @PluginMethod
  fun logRevenue(call: PluginCall) {
    // Implement logRevenue method if needed
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
