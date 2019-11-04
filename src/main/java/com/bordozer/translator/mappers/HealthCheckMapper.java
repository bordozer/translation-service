package com.bordozer.translator.mappers;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.bordozer.translator.dto.ModifiableHealthStatusDto;
import com.bordozer.translator.mappers.impl.MapstructImplPackage;
import com.bordozer.translator.model.HealthStatus;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.utils.DateTimeUtils;

@Mapper(config = MapstructImplPackage.class)
public interface HealthCheckMapper {

    @Mapping(target = "appName", constant = "Translation Service")
    @Mapping(target = "time", expression = "java(now())")
    @Mapping(target = "supportedLanguages", expression = "java(supportedLanguages())")
    ModifiableHealthStatusDto map(HealthStatus healthStatus);

    default LocalDateTime now() {
        return DateTimeUtils.now();
    }

    default List<Language> supportedLanguages() {
        return Arrays.stream(Language.values())
            .filter(val -> !StringUtils.EMPTY.equals(val.getCountry()))
            .sorted(Comparator.comparing(Language::getCode))
            .collect(Collectors.toList());
    }
}
