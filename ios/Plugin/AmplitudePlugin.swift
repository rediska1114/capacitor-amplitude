import AmplitudeSwift
import Capacitor
import Foundation

/// Please read the Capacitor iOS Plugin Development Guide
/// here: https://capacitorjs.com/docs/plugins/ios
@objc(AmplitudePlugin)
public class AmplitudePlugin: CAPPlugin {
  private var amplitudeInstances: [String: Amplitude] = [:]
  private let defaultInstanceName = "default_instance"

  @objc
  func initialize(_ call: CAPPluginCall) {
    guard let apiKey = call.getString("apiKey") else {
      return call.reject("API Key is required")
    }

    let instanceName = call.getString("instanceName") ?? defaultInstanceName

    var autocaptureOptions: AutocaptureOptions = AutocaptureOptions.sessions

    if let autocapture = call.getArray("autocapture") as? [String] {
      autocaptureOptions = []
      for option in autocapture {
        switch option.uppercased() {
        case "SESSIONS":
          autocaptureOptions.insert(AutocaptureOptions.sessions)
        case "APP_LIFECYCLES":
          autocaptureOptions.insert(AutocaptureOptions.appLifecycles)
        case "ELEMENT_INTERACTIONS":
          autocaptureOptions.insert(AutocaptureOptions.elementInteractions)
        case "SCREEN_VIEWS":
          autocaptureOptions.insert(AutocaptureOptions.screenViews)
        default:
          break
        }
      }
    }

    var migrateLegacyData = true
    if let migrate = call.getBool("migrateLegacyData") {
      migrateLegacyData = migrate
    }

    let config = Configuration(
      apiKey: apiKey, autocapture: autocaptureOptions, migrateLegacyData: migrateLegacyData)

    if let partnerId = call.getString("partnerId") {
      config.partnerId = partnerId
    }
    if let flushIntervalMillis = call.getInt("flushIntervalMillis") {
      config.flushIntervalMillis = flushIntervalMillis
    }
    if let flushQueueSize = call.getInt("flushQueueSize") {
      config.flushQueueSize = flushQueueSize
    }
    if let flushMaxRetries = call.getInt("flushMaxRetries") {
      config.flushMaxRetries = flushMaxRetries
    }
    if let minIdLength = call.getInt("minIdLength") {
      config.minIdLength = minIdLength
    }
    if let identifyBatchIntervalMillis = call.getInt("identifyBatchIntervalMillis") {
      config.identifyBatchIntervalMillis = identifyBatchIntervalMillis
    }
    if let flushEventsOnClose = call.getBool("flushEventsOnClose") {
      config.flushEventsOnClose = flushEventsOnClose
    }
    if let optOut = call.getBool("optOut") {
      config.optOut = optOut
    }
    if let minTimeBetweenSessionsMillis = call.getInt("minTimeBetweenSessionsMillis") {
      config.minTimeBetweenSessionsMillis = minTimeBetweenSessionsMillis
    }
    if let serverUrl = call.getString("serverUrl") {
      config.serverUrl = serverUrl
    }
    if let serverZone = call.getString("serverZone") {
      config.serverZone = serverZone == "EU" ? .EU : .US
    }
    if let useBatch = call.getBool("useBatch") {
      config.useBatch = useBatch
    }

    if let enableCoppaControl = call.getBool("enableCoppaControl") {
      config.enableCoppaControl = enableCoppaControl
    }

    if let offline = call.getBool("offline") {
      config.offline = offline
    }

    let amplitude = Amplitude(configuration: config)
    amplitudeInstances[instanceName] = amplitude
    call.resolve()
  }

  @objc
  func track(_ call: CAPPluginCall) {
    guard let eventName = call.getString("eventName") else {
      return call.reject("Event name is required")
    }
    let instanceName = call.getString("instanceName") ?? defaultInstanceName
    let properties = call.getObject("properties") ?? [:]

    amplitudeInstances[instanceName]?.track(eventType: eventName, eventProperties: properties)
    call.resolve()
  }

  @objc
  func identify(_ call: CAPPluginCall) {
    let instanceName = call.getString("instanceName") ?? defaultInstanceName
    let properties = call.getObject("properties") ?? [:]

    amplitudeInstances[instanceName]?.identify(userProperties: properties)
    call.resolve()
  }

  @objc
  func setUserId(_ call: CAPPluginCall) {
    guard let userId = call.getString("userId") else {
      return call.reject("User ID is required")
    }
    let instanceName = call.getString("instanceName") ?? defaultInstanceName

    amplitudeInstances[instanceName]?.setUserId(userId: userId)
    call.resolve()
  }

  @objc
  func getDeviceId(_ call: CAPPluginCall) {
    let instanceName = call.getString("instanceName") ?? defaultInstanceName
    if let deviceId = amplitudeInstances[instanceName]?.getDeviceId() {
      call.resolve(["deviceId": deviceId])
    } else {
      call.reject("Instance not found")
    }
  }

  @objc
  func getUserId(_ call: CAPPluginCall) {
    let instanceName = call.getString("instanceName") ?? defaultInstanceName
    if let userId = amplitudeInstances[instanceName]?.getUserId() {
      call.resolve(["userId": userId])
    } else {
      call.reject("Instance not found")
    }
  }

  @objc
  func setDeviceId(_ call: CAPPluginCall) {
    guard let deviceId = call.getString("deviceId") else {
      return call.reject("Device ID is required")
    }
    let instanceName = call.getString("instanceName") ?? defaultInstanceName

    amplitudeInstances[instanceName]?.setDeviceId(deviceId: deviceId)
    call.resolve()
  }

  @objc
  func reset(_ call: CAPPluginCall) {
    let instanceName = call.getString("instanceName") ?? defaultInstanceName
    amplitudeInstances[instanceName]?.reset()
    call.resolve()
  }

  @objc
  func setGroup(_ call: CAPPluginCall) {
    guard let groupType = call.getString("groupType"),
      let groupName = call.getString("groupName")
    else {
      return call.reject("Group type and name are required")
    }
    let instanceName = call.getString("instanceName") ?? defaultInstanceName

    amplitudeInstances[instanceName]?.setGroup(groupType: groupType, groupName: groupName)
    call.resolve()
  }

  @objc
  func logRevenue(_ call: CAPPluginCall) {
    // Implement logRevenue method if needed
    call.reject("logRevenue not implemented")
  }
}
