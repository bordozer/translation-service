package com.bordozer.translator.dto;

import java.util.Map;

import org.immutables.value.Value;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

@JsonDeserialize(
    builder = ImmutableTranslationDTO.Builder.class
)
@JsonIgnoreProperties({ "initialized" })
@Value.Immutable
@Value.Modifiable
public interface TranslationDTO {

    Map<String, String> getTranslations();

    static ImmutableTranslationDTO.Builder builder() {
        return new ImmutableTranslationDTO.Builder();
    }
}
