package com.bordozer.translator.mappers;

import java.time.LocalDateTime;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.bordozer.translator.dto.ModifiableHealthStatusDto;
import com.bordozer.translator.mappers.impl.MapstructImplPackage;
import com.bordozer.translator.model.HealthStatus;
import com.bordozer.translator.utils.DateTimeUtils;

@Mapper(config = MapstructImplPackage.class)
public interface HealthCheckMapper {

    @Mapping(target = "appName", constant = "Translation Service")
    @Mapping(target = "time", expression = "java(now())")
    ModifiableHealthStatusDto map(HealthStatus healthStatus);

    default LocalDateTime now() {
        return DateTimeUtils.now();
    }
}
