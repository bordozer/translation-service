package com.bordozer.guitarneckmaster.mappers;

import java.time.LocalDateTime;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.bordozer.guitarneckmaster.dto.ModifiableHealthStatusDto;
import com.bordozer.guitarneckmaster.mappers.impl.MapstructImplPackage;
import com.bordozer.guitarneckmaster.model.HealthStatus;
import com.bordozer.guitarneckmaster.utils.DateTimeUtils;

@Mapper(config = MapstructImplPackage.class)
public interface HealthCheckMapper {

    @Mapping(target = "appName", constant = "Translation Service")
    @Mapping(target = "time", expression = "java(now())")
    ModifiableHealthStatusDto map(HealthStatus healthStatus);

    default LocalDateTime now() {
        return DateTimeUtils.now();
    }
}
