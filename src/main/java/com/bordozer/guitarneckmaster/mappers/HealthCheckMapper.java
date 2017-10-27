package com.bordozer.guitarneckmaster.mappers;

import org.mapstruct.Mapper;

import com.bordozer.guitarneckmaster.dto.ModifiableHealthStatusDto;
import com.bordozer.guitarneckmaster.mappers.impl.MapstructImplPackage;
import com.bordozer.guitarneckmaster.model.HealthStatus;

@Mapper(config = MapstructImplPackage.class)
public interface HealthCheckMapper {

    ModifiableHealthStatusDto map(HealthStatus healthStatus);
}
