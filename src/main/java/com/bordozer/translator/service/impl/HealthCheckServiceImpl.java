package com.bordozer.translator.service.impl;

import com.bordozer.translator.utils.IpUtils;
import org.springframework.stereotype.Service;

import com.bordozer.translator.dto.HealthStatusDto;
import com.bordozer.translator.mappers.HealthCheckMapper;
import com.bordozer.translator.model.HealthStatus;
import com.bordozer.translator.model.ImmutableHealthStatus;
import com.bordozer.translator.service.HealthCheckService;

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


        return Mono.just(healthCheckMapper.map(healthStatus, IpUtils.getIp()));
    }
}
