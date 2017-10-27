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

package com.bordozer.guitarneckmaster.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bordozer.guitarneckmaster.dto.HealthStatusDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class GuitarNeckMasterController {

    @GetMapping(path = "/health-check")
    public HealthStatusDto healthCheck() {
        return HealthStatusDto.builder()
            .status("alive")
            .build();
    }
}
