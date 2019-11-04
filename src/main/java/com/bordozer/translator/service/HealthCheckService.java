package com.bordozer.translator.service;

import org.springframework.stereotype.Service;

import com.bordozer.translator.dto.HealthStatusDto;

import reactor.core.publisher.Mono;

@Service
public interface HealthCheckService {

    Mono<HealthStatusDto> getStatus();
}
