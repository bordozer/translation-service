package com.bordozer.guitarneckmaster.dto;

import java.time.LocalDateTime;

import org.immutables.value.Value;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

@JsonDeserialize(
    builder = ImmutableHealthStatusDto.Builder.class
)
@JsonIgnoreProperties({ "initialized" })
@Value.Immutable
@Value.Modifiable
public interface HealthStatusDto {

    String getAppName();

    String getStatus();

    LocalDateTime getTime();
}
