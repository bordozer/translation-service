package com.bordozer.translator.mappers;

import com.bordozer.commons.utils.IpUtils;
import com.bordozer.translator.dto.ModifiableHealthStatusDto;
import com.bordozer.translator.mappers.impl.MapstructImplPackage;
import com.bordozer.translator.model.Language;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.time.LocalDateTime;
import java.util.Map;

@Mapper(config = MapstructImplPackage.class)
public interface HealthCheckMapper {

    @Mapping(target = "appName", constant = "Translator Service")
    @Mapping(target = "time", expression = "java(now())")
    @Mapping(target = "statuses", source = "statuses")
    @Mapping(target = "ip", source = "ip.ip")
    @Mapping(target = "hostname", source = "ip.hostname")
    ModifiableHealthStatusDto map(Map<Language, String> statuses, IpUtils.Ip ip);

    default LocalDateTime now() {
        return LocalDateTime.now();
    }
}
