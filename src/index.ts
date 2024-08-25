import { registerPlugin } from '@capacitor/core';

import type {
  AmplitudeConfiguration,
  AmplitudePlugin,
  PropertiesObject,
} from './definitions';
// import { Identify } from './identify';

const CapacitorAmplitude = registerPlugin<AmplitudePlugin>('Amplitude', {
  // web: () => import('./web').then(m => new m.AmplitudeWeb()),
});

export * from './definitions';
export * from './identify';

export class Amplitude {
  // private static _instances: Record<string, Amplitude>;
  private static _defaultInstanceName = '$default_instance';
  instanceName: string;

  constructor(instanceName: string = Amplitude._defaultInstanceName) {
    this.instanceName = instanceName;
  }

  initialize(
    apiKey: string,
    configuration: AmplitudeConfiguration = {},
  ): Promise<void> {
    return CapacitorAmplitude.initialize({
      instanceName: this.instanceName,
      apiKey,
      ...configuration,
    });
  }

  track(eventName: string, properties: PropertiesObject = {}): Promise<void> {
    return CapacitorAmplitude.track({
      instanceName: this.instanceName,
      eventName,
      properties,
    });
  }
  identifyUser(properties: PropertiesObject): Promise<void> {
    return CapacitorAmplitude.identifyUser({
      instanceName: this.instanceName,
      properties,
    });
  }
  setUserId(userId: string): Promise<void> {
    return CapacitorAmplitude.setUserId({
      instanceName: this.instanceName,
      userId,
    });
  }
  setDeviceId(deviceId: string): Promise<void> {
    return CapacitorAmplitude.setDeviceId({
      instanceName: this.instanceName,
      deviceId,
    });
  }
  reset(): Promise<void> {
    return CapacitorAmplitude.reset({ instanceName: this.instanceName });
  }
  setGroup(groupType: string, groupName: string): Promise<void> {
    return CapacitorAmplitude.setGroup({
      instanceName: this.instanceName,
      groupType,
      groupName,
    });
  }
  logRevenue(_: unknown): Promise<void> {
    return CapacitorAmplitude.logRevenue({
      instanceName: this.instanceName,
    });
  }

  getDeviceId(): Promise<{ deviceId: string }> {
    return CapacitorAmplitude.getDeviceId({
      instanceName: this.instanceName,
    }).then(({ deviceId }) => ({ deviceId }));
  }

  getUserId(): Promise<{ userId: string }> {
    return CapacitorAmplitude.getUserId({
      instanceName: this.instanceName,
    }).then(({ userId }) => ({ userId }));
  }
}
