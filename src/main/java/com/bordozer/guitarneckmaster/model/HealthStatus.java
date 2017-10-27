package com.bordozer.guitarneckmaster.model;

import org.immutables.value.Value;

@Value.Immutable
@Value.Modifiable
public interface HealthStatus {

    String getStatus();
}
