/*
 * Copyright (c) 2017 CoreLogic, Inc. All Rights Reserved.
 *
 * This software is the confidential and proprietary information of CoreLogic, Inc.
 * It is furnished under license and may only be used or copied in accordance
 * with the terms of such license.
 * This software is subject to change without notice and no information
 * contained in it should be construed as commitment by CoreLogic, Inc.
 * CoreLogic, Inc. cannot accept any responsibility, financial or otherwise, for any
 * consequences arising from the use of this software except as otherwise stated in
 * the terms of the license.
 */

package com.bordozer.guitarneckmaster.mappers.impl;

import org.mapstruct.MapperConfig;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
@MapperConfig(implementationPackage = MapstructImplPackage.NAME, componentModel = "spring")
public final class MapstructImplPackage {

    public static final String NAME = "com.bordozer.guitarneckmaster.mappers.impl";
}
