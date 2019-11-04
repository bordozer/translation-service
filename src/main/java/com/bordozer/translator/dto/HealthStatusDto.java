package com.bordozer.translator.dto;

import java.time.LocalDateTime;
import java.util.List;

import org.immutables.value.Value;

import com.bordozer.translator.dto.ImmutableHealthStatusDto.Builder;
import com.bordozer.translator.model.Language;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

@JsonDeserialize(
    builder = Builder.class
)
@JsonIgnoreProperties({ "initialized" })
@Value.Immutable
@Value.Modifiable
public interface HealthStatusDto {

    String getAppName();

    String getStatus();

    List<Language> getSupportedLanguages();

    LocalDateTime getTime();
}
