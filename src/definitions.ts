type PropertiesObject = Record<string, any>;

type RevenueProperties = {
  price: number;
  productId?: string;
  quantity?: number;
  revenueType?: string;
  receipt?: string;
  receiptSignature?: string;
  eventProperties?: PropertiesObject;
};

export interface AmplitudePlugin {
  initialize(options: { instanceName: string; apiKey: string }): Promise<void>;
  logEvent(options: { instanceName: string; eventType: string }): Promise<void>;
  logEventWithProperties(options: {
    instanceName: string;
    eventType: string;
    eventProperties: PropertiesObject;
  }): Promise<void>;
  enableCoppaControl(options: { instanceName: string }): Promise<void>;
  disableCoppaControl(options: { instanceName: string }): Promise<void>;
  regenerateDeviceId(options: { instanceName: string }): Promise<void>;
  setDeviceId(options: {
    instanceName: string;
    deviceId: string;
  }): Promise<void>;
  getDeviceId(options: { instanceName: string }): Promise<{ deviceId: string }>;
  setOptOut(options: { instanceName: string; optOut: boolean }): Promise<void>;
  setLibraryName(options: {
    instanceName: string;
    libraryName: string;
  }): Promise<void>;
  setLibraryVersion(options: {
    instanceName: string;
    libraryVersion: string;
  }): Promise<void>;
  trackingSessionEvents(options: {
    instanceName: string;
    trackingSessionEvents: boolean;
  }): Promise<void>;
  setUseDynamicConfig(options: {
    instanceName: string;
    useDynamicConfig: boolean;
  }): Promise<void>;
  setUserId(options: {
    instanceName: string;
    userId: string | null;
  }): Promise<void>;
  setServerUrl(options: {
    instanceName: string;
    serverUrl: string;
  }): Promise<void>;
  logRevenueV2(options: {
    instanceName: string;
    userProperties: RevenueProperties;
  }): Promise<void>;
  identify(options: {
    instanceName: string;
    userProperties: PropertiesObject;
  }): Promise<void>;
  setGroup(options: {
    instanceName: string;
    groupType: string;
    groupName: string | string[];
  }): Promise<void>;
  groupIdentify(options: {
    instanceName: string;
    groupType: string;
    groupName: string | string[];
    userProperties: PropertiesObject;
  }): Promise<void>;
  setUserProperties(options: {
    instanceName: string;
    userProperties: PropertiesObject;
  }): Promise<void>;
  clearUserProperties(options: { instanceName: string }): Promise<void>;
  uploadEvents(options: { instanceName: string }): Promise<void>;
  getSessionId(options: {
    instanceName: string;
  }): Promise<{ sessionId: number }>;
  setMinTimeBetweenSessionsMillis(options: {
    instanceName: string;
    minTimeBetweenSessionsMillis: number;
  }): Promise<void>;
  setServerZone(options: {
    instanceName: string;
    serverZone: string;
    updateServerUrl: boolean;
  }): Promise<void>;
  setEventUploadMaxBatchSize(options: {
    instanceName: string;
    eventUploadMaxBatchSize: number;
  }): Promise<void>;
  setEventUploadPeriodMillis(options: {
    instanceName: string;
    eventUploadPeriodMillis: number;
  }): Promise<void>;
  setEventUploadThreshold(options: {
    instanceName: string;
    eventUploadThreshold: number;
  }): Promise<void>;
}
