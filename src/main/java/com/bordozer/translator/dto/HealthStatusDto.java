package com.bordozer.translator.dto;

import com.bordozer.translator.dto.ImmutableHealthStatusDto.Builder;
import com.bordozer.translator.model.Language;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import org.immutables.value.Value;

import java.time.LocalDateTime;
import java.util.Map;

@JsonDeserialize(
        builder = Builder.class
)
@JsonIgnoreProperties({"initialized"})
@Value.Immutable
@Value.Modifiable
public interface HealthStatusDto {

    String getAppName();

    Map<Language, String> getStatuses();

    LocalDateTime getTime();

    String getIp();

    String getHostname();
}
