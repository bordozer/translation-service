package com.bordozer.guitarneckmaster.service;

import org.springframework.stereotype.Service;

import com.bordozer.guitarneckmaster.dto.HealthStatusDto;

@Service
public interface HealthCheckService {

    HealthStatusDto getStatus();
}
