import Amplitude
import Capacitor
import Foundation

var initialized = false

/// Please read the Capacitor iOS Plugin Development Guide
/// here: https://capacitorjs.com/docs/plugins/ios
@objc(AmplitudePlugin)
public class AmplitudePlugin: CAPPlugin {

  @objc
  func initialize(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let apiKey = call.getString("apiKey") else {
      return call.reject("Missing apiKey argument")
    }

    if initialized {
      return call.resolve()
    }

    Amplitude.instance(withName: instanceName).initCompletionBlock = {
      initialized = true
      call.resolve()
    }
    Amplitude.instance(withName: instanceName).initializeApiKey(apiKey)
  }

  @objc
  func enableCoppaControl(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }

    Amplitude.instance(withName: instanceName).enableCoppaControl()
    call.resolve()
  }

  @objc
  func disableCoppaControl(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }

    Amplitude.instance(withName: instanceName).disableCoppaControl()
    call.resolve()
  }

  @objc
  func regenerateDeviceId(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    Amplitude.instance(withName: instanceName).regenerateDeviceId()
    call.resolve()
  }

  @objc
  func setDeviceId(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let deviceId = call.getString("deviceId") else {
      return call.reject("Missing deviceId argument")
    }

    Amplitude.instance(withName: instanceName).setDeviceId(deviceId)
    call.resolve()
  }

  @objc
  func getDeviceId(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    let deviceId = Amplitude.instance(withName: instanceName).getDeviceId()
    call.resolve(["deviceId": deviceId])
  }

  @objc
  func setOptOut(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let optOut = call.getBool("optOut") else {
      return call.reject("Missing optOut argument")
    }
    Amplitude.instance(withName: instanceName).optOut = optOut
    call.resolve()
  }

  @objc
  func setLibraryName(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let libraryName = call.getString("libraryName") else {
      return call.reject("Missing libraryName argument")
    }
    Amplitude.instance(withName: instanceName).libraryName = libraryName
    call.resolve()
  }

  @objc
  func setLibraryVersion(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let libraryVersion = call.getString("libraryVersion") else {
      return call.reject("Missing libraryVersion argument")
    }

    Amplitude.instance(withName: instanceName).libraryVersion = libraryVersion
    call.resolve()
  }

  @objc
  func trackingSessionEvents(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let trackingSessionEvents = call.getBool("trackingSessionEvents") else {
      return call.reject("Missing trackingSessionEvents argument")
    }
    Amplitude.instance(withName: instanceName).trackingSessionEvents = trackingSessionEvents
    call.resolve()
  }

  @objc
  func setUseDynamicConfig(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let useDynamicConfig = call.getBool("useDynamicConfig") else {
      return call.reject("Missing useDynamicConfig argument")
    }
    Amplitude.instance(withName: instanceName).useDynamicConfig = useDynamicConfig
    call.resolve()
  }

  @objc
  func setUserId(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let userId = call.getString("userId") else {
      return call.reject("Missing userId argument")
    }
    Amplitude.instance(withName: instanceName).setUserId(userId)
    call.resolve()
  }

  @objc
  func setServerUrl(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let serverUrl = call.getString("serverUrl") else {
      return call.reject("Missing serverUrl argument")
    }
    Amplitude.instance(withName: instanceName).setServerUrl(serverUrl)
    call.resolve()
  }

  @objc
  func logEvent(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let eventType = call.getString("eventType") else {
      return call.reject("Missing eventType argument")
    }
    Amplitude.instance(withName: instanceName).logEvent(eventType)
    call.resolve()
  }

  @objc
  func logEventWithProperties(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let eventType = call.getString("eventType") else {
      return call.reject("Missing eventType argument")
    }
    guard let eventProperties = call.getObject("eventProperties") else {
      return call.reject("Missing eventProperties argument")
    }
    Amplitude.instance(withName: instanceName).logEvent(
      eventType, withEventProperties: eventProperties)
    call.resolve()
  }

  @objc
  func logRevenueV2(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let userProperties = call.getObject("userProperties") else {
      return call.reject("Missing userProperties argument")
    }
    let revenue = createRevenue(userProperties)
    Amplitude.instance(withName: instanceName).logRevenueV2(revenue)
    call.resolve()
  }

  @objc
  func identify(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let userProperties = call.getObject("userProperties") as? [String: [String: NSObject]]
    else {
      return call.reject("Missing userProperties argument")
    }
    let identify = createIdentify(userProperties)
    Amplitude.instance(withName: instanceName).identify(identify)
    call.resolve()
  }

  @objc
  func groupIdentify(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let groupType = call.getString("groupType") else {
      return call.reject("Missing groupType argument")
    }
    guard let groupName = call.getObject("groupName") as NSObject? else {
      return call.reject("Missing groupName argument")
    }
    guard let userProperties = call.getObject("userProperties") as? [String: [String: NSObject]]
    else {
      return call.reject("Missing userProperties argument")
    }
    let identify = createIdentify(userProperties)
    Amplitude.instance(withName: instanceName).groupIdentify(
      withGroupType: groupType,
      groupName: groupName,
      groupIdentify: identify)
    call.resolve()
  }

  @objc
  func setGroup(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let groupType = call.getString("groupType") else {
      return call.reject("Missing groupType argument")
    }
    guard let groupName = call.getObject("groupName") as NSObject? else {
      return call.reject("Missing groupName argument")
    }
    Amplitude.instance(withName: instanceName).setGroup(groupType, groupName: groupName)
    call.resolve()
  }

  @objc
  func setUserProperties(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let userProperties = call.getObject("userProperties") else {
      return call.reject("Missing userProperties argument")
    }
    Amplitude.instance(withName: instanceName).setUserProperties(userProperties)
    call.resolve()
  }

  @objc
  func clearUserProperties(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    Amplitude.instance(withName: instanceName).clearUserProperties()
    call.resolve()
  }

  @objc
  func uploadEvents(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    Amplitude.instance(withName: instanceName).uploadEvents()
    call.resolve()
  }

  @objc
  func getSessionId(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    let sessionId = Amplitude.instance(withName: instanceName).getSessionId()
    call.resolve(["sessionId": sessionId])
  }

  @objc
  func setMinTimeBetweenSessionsMillis(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let minTimeBetweenSessionsMillis = call.getInt("minTimeBetweenSessionsMillis") else {
      return call.reject("Missing minTimeBetweenSessionsMillis argument")
    }
    Amplitude.instance(withName: instanceName).minTimeBetweenSessionsMillis =
      minTimeBetweenSessionsMillis
    call.resolve()
  }

  @objc
  func setServerZone(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let serverZone = call.getString("serverZone") else {
      return call.reject("Missing serverZone argument")
    }
    guard let updateServerUrl = call.getBool("updateServerUrl") else {
      return call.reject("Missing updateServerUrl argument")
    }
    let ampServerZone = serverZone == "EU" ? AMPServerZone.EU : AMPServerZone.US
    Amplitude.instance(withName: instanceName).setServerZone(
      ampServerZone, updateServerUrl: updateServerUrl)
    call.resolve()
  }

  @objc
  func setEventUploadMaxBatchSize(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let eventUploadMaxBatchSize = call.options["eventUploadMaxBatchSize"] as? Int32 else {
      return call.reject("Missing eventUploadMaxBatchSize argument")
    }
    Amplitude.instance(withName: instanceName).updateEventUploadMaxBatchSize(
      eventUploadMaxBatchSize)
    call.resolve()
  }

  @objc
  func setEventUploadPeriodMillis(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let eventUploadPeriodMillis = call.options["eventUploadPeriodMillis"] as? Int32 else {
      return call.reject("Missing eventUploadPeriodMillis argument")
    }
    Amplitude.instance(withName: instanceName).eventUploadPeriodSeconds =
      eventUploadPeriodMillis / 1000
    call.resolve()
  }

  @objc
  func setEventUploadThreshold(_ call: CAPPluginCall) {
    guard let instanceName = call.getString("instanceName") else {
      return call.reject("Missing instanceName argument")
    }
    guard let eventUploadThreshold = call.options["eventUploadThreshold"] as? Int32 else {
      return call.reject("Missing eventUploadThreshold argument")
    }
    Amplitude.instance(withName: instanceName).eventUploadThreshold = eventUploadThreshold
    call.resolve()
  }

  private func createRevenue(_ userProperties: [String: Any]) -> AMPRevenue {
    let revenue = AMPRevenue()
    if userProperties["productId"] != nil {
      revenue.setProductIdentifier(userProperties["productId"] as! String)
    }
    if userProperties["price"] != nil {
      revenue.setPrice(userProperties["price"] as! NSNumber)
    }
    if userProperties["quantity"] != nil {
      revenue.setQuantity(userProperties["quantity"] as! Int)
    } else {
      revenue.setQuantity(1)
    }
    if userProperties["revenueType"] != nil {
      revenue.setRevenueType(userProperties["revenueType"] as! String)
    }
    if userProperties["receipt"] != nil {
      revenue.setReceipt((userProperties["receipt"] as! String).data(using: .utf8))
    }
    if userProperties["eventProperties"] != nil {
      revenue.setEventProperties(userProperties["eventProperties"] as! [String: Any])
    }
    return revenue
  }

  private func createIdentify(_ userProperties: [String: [String: NSObject]]) -> AMPIdentify {
    let identify = AMPIdentify()
    for (operation, properties) in userProperties {
      for (key, value) in properties {
        switch operation {
        case "$add":
          identify.add(key, value: value)
        case "$append":
          identify.append(key, value: value)
        case "$prepend":
          identify.prepend(key, value: value)
        case "$set":
          identify.set(key, value: value)
        case "$setOnce":
          identify.setOnce(key, value: value)
        case "$unset":
          identify.unset(key)  // value is default to `-`
        default:
          break
        }
      }
    }
    return identify
  }
}
