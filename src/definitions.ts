export type PropertiesObject = Record<string, any>;

// type RevenueProperties = {
//   price: number;
//   productId?: string;
//   quantity?: number;
//   revenueType?: string;
//   receipt?: string;
//   receiptSignature?: string;
//   eventProperties?: PropertiesObject;
// };

export interface AmplitudePlugin {
  initialize(
    options: { apiKey: string } & AmplitudeConfiguration,
  ): Promise<void>;

  track(
    options: InstanceNameOptions & {
      eventName: string;
      properties: PropertiesObject;
    },
  ): Promise<void>;
  identify(
    options: InstanceNameOptions & { properties: PropertiesObject },
  ): Promise<void>;
  setUserId(options: InstanceNameOptions & { userId: string }): Promise<void>;
  setDeviceId(
    options: InstanceNameOptions & { deviceId: string },
  ): Promise<void>;
  reset(options: InstanceNameOptions): Promise<void>;
  setGroup(
    options: InstanceNameOptions & { groupType: string; groupName: string },
  ): Promise<void>;
  logRevenue(options: InstanceNameOptions & unknown): Promise<void>;
  getDeviceId(options: InstanceNameOptions): Promise<{ deviceId: string }>;
  getUserId(options: InstanceNameOptions): Promise<{ userId: string }>;
}

export interface AmplitudeConfiguration {
  autocapture?: Array<
    'SESSIONS' | 'APP_LIFECYCLES' | 'DEEP_LINKS' | 'SCREEN_VIEWS'
  >;

  deviceId?: string;
  partnerId?: string;
  flushIntervalMillis?: number;
  flushQueueSize?: number;
  flushMaxRetries?: number;
  minIdLength?: number;
  identifyBatchIntervalMillis?: number;
  flushEventsOnClose?: boolean;
  optOut?: boolean;
  minTimeBetweenSessionsMillis?: number;
  serverUrl?: string;
  serverZone?: 'EU' | 'US';
  useBatch?: boolean;
  useAdvertisingIdForDeviceId?: boolean;
  useAppSetIdForDeviceId?: boolean;
  enableCoppaControl?: boolean;
  instanceName?: string;
  migrateLegacyData?: boolean;
  offline?: boolean;
  locationListening?: boolean;
}

export interface InstanceNameOptions {
  instanceName: string;
}
