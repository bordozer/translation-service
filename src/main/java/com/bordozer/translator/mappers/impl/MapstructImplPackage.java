package com.bordozer.translator.mappers.impl;

import org.mapstruct.MapperConfig;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
@MapperConfig(implementationPackage = MapstructImplPackage.NAME, componentModel = "spring")
public final class MapstructImplPackage {

    public static final String NAME = "com.bordozer.translator.mappers.impl";
}
