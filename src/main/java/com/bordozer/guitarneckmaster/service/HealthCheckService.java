package com.bordozer.guitarneckmaster.service;

import org.springframework.stereotype.Service;

import com.bordozer.guitarneckmaster.dto.HealthStatusDto;

import reactor.core.publisher.Mono;

@Service
public interface HealthCheckService {

    Mono<HealthStatusDto> getStatus();
}
