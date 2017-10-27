package com.bordozer.guitarneckmaster.service.impl;

import org.springframework.stereotype.Service;

import com.bordozer.guitarneckmaster.dto.HealthStatusDto;
import com.bordozer.guitarneckmaster.mappers.HealthCheckMapper;
import com.bordozer.guitarneckmaster.model.HealthStatus;
import com.bordozer.guitarneckmaster.model.ImmutableHealthStatus;
import com.bordozer.guitarneckmaster.service.HealthCheckService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@Slf4j
@Service
@RequiredArgsConstructor
public class HealthCheckServiceImpl implements HealthCheckService {

    private final HealthCheckMapper healthCheckMapper;

    @Override
    public Mono<HealthStatusDto> getStatus() {
        final HealthStatus healthStatus = new ImmutableHealthStatus.Builder()
            .status("active")
            .build();

        return Mono.just(healthCheckMapper.map(healthStatus));
    }
}
