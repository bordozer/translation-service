package com.bordozer.translator.controllers;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bordozer.translator.dto.HealthStatusDto;
import com.bordozer.translator.service.HealthCheckService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class HealthCheckRestController {

    private final HealthCheckService healthCheckService;

    @GetMapping(path = "/health-check", produces = MediaType.APPLICATION_JSON_VALUE)
    public HealthStatusDto healthCheck() {
        log.info("health-check is called");
        return healthCheckService.getStatus().block();
    }
}
