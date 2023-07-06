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

type AmplitudeInstance = {
  instanceName: string;
};

export interface AmplitudePlugin {
  initialize(
    options: AmplitudeInstance & {
      apiKey: string;
      libraryName?: string;
      libraryVersion?: string;
    },
  ): Promise<void>;
  logEvent(options: AmplitudeInstance & { eventType: string }): Promise<void>;
  logEventWithProperties(
    options: AmplitudeInstance & {
      eventType: string;
      eventProperties: PropertiesObject;
    },
  ): Promise<void>;
  enableCoppaControl(options: AmplitudeInstance): Promise<void>;
  disableCoppaControl(options: AmplitudeInstance): Promise<void>;
  regenerateDeviceId(options: AmplitudeInstance): Promise<void>;
  setDeviceId(
    options: AmplitudeInstance & {
      deviceId: string;
    },
  ): Promise<void>;
  getDeviceId(options: AmplitudeInstance): Promise<{ deviceId: string }>;
  useAdvertisingIdForDeviceId(options: AmplitudeInstance): Promise<void>;
  setOptOut(options: AmplitudeInstance & { optOut: boolean }): Promise<void>;
  trackingSessionEvents(
    options: AmplitudeInstance & {
      trackingSessionEvents: boolean;
    },
  ): Promise<void>;
  setUseDynamicConfig(
    options: AmplitudeInstance & {
      useDynamicConfig: boolean;
    },
  ): Promise<void>;
  setUserId(
    options: AmplitudeInstance & {
      userId: string | null;
    },
  ): Promise<void>;
  setServerUrl(
    options: AmplitudeInstance & {
      serverUrl: string;
    },
  ): Promise<void>;
  logRevenueV2(
    options: AmplitudeInstance & {
      userProperties: RevenueProperties;
    },
  ): Promise<void>;
  identify(
    options: AmplitudeInstance & {
      userProperties: PropertiesObject;
    },
  ): Promise<void>;
  setGroup(
    options: AmplitudeInstance & {
      groupType: string;
      groupName: string | string[];
    },
  ): Promise<void>;
  groupIdentify(
    options: AmplitudeInstance & {
      groupType: string;
      groupName: string | string[];
      userProperties: PropertiesObject;
    },
  ): Promise<void>;
  setUserProperties(
    options: AmplitudeInstance & {
      userProperties: PropertiesObject;
    },
  ): Promise<void>;
  clearUserProperties(options: AmplitudeInstance): Promise<void>;
  uploadEvents(options: AmplitudeInstance): Promise<void>;
  getSessionId(options: AmplitudeInstance): Promise<number>;
  setMinTimeBetweenSessionsMillis(
    options: AmplitudeInstance & {
      minTimeBetweenSessionsMillis: number;
    },
  ): Promise<void>;
  setServerZone(
    options: AmplitudeInstance & {
      serverZone: string;
      updateServerUrl: boolean;
    },
  ): Promise<void>;
  setEventUploadMaxBatchSize(
    options: AmplitudeInstance & {
      eventUploadMaxBatchSize: number;
    },
  ): Promise<void>;
  setEventUploadPeriodMillis(
    options: AmplitudeInstance & {
      eventUploadPeriodMillis: number;
    },
  ): Promise<void>;
  setEventUploadThreshold(
    options: AmplitudeInstance & {
      eventUploadThreshold: number;
    },
  ): Promise<void>;

  setPlan(options: AmplitudeInstance & { plan: Plan }): Promise<void>;

  setIngestionMetadata(
    options: AmplitudeInstance & { ingestionMetadata: IngestionMetadata },
  ): Promise<void>;
}

/**
 * Tracking plan
 */
export type Plan = {
  /** The tracking plan branch name e.g. "main" */
  branch?: string;
  /** The tracking plan source e.g. "web", "mobile" */
  source?: string;
  /** The tracking plan version e.g. "1", "15" */
  version?: string;
  /** The tracking plan version Id e.g. "9ec23ba0-275f-468f-80d1-66b88bff9529" */
  versionId?: string;
};

/**
 * Ingestion metadata
 */
export type IngestionMetadata = {
  /** The source name of ingestion metadata e.g. "ampli" */
  sourceName?: string;
  /** The source version of ingestion metadata e.g. "2.0.0" */
  sourceVersion?: string;
};
