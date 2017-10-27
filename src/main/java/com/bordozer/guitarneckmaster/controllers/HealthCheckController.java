package com.bordozer.guitarneckmaster.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bordozer.guitarneckmaster.dto.HealthStatusDto;
import com.bordozer.guitarneckmaster.service.HealthCheckService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class HealthCheckController {

    private final HealthCheckService healthCheckService;

    @GetMapping(path = "/health-check")
    public HealthStatusDto healthCheck() {
        return healthCheckService.getStatus();
    }
}
