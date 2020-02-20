package com.bordozer.translator.service.impl;

import com.bordozer.commons.utils.IpUtils;
import com.bordozer.translator.dto.HealthStatusDto;
import com.bordozer.translator.mappers.HealthCheckMapper;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.service.HealthCheckService;
import com.bordozer.translator.service.TranslatorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class HealthCheckServiceImpl implements HealthCheckService {

    public static final String I_M_WORKING_NERD = "I'm working";

    private final TranslatorService translatorService;
    private final HealthCheckMapper healthCheckMapper;

    @Override
    public Mono<HealthStatusDto> getStatus() {

        Map<Language, String> statuses = Arrays.stream(Language.values())
                .filter(language -> !StringUtils.EMPTY.equals(language.getCountry()))
                .collect(Collectors.toMap(language -> language, language -> translatorService.translate(I_M_WORKING_NERD, language)));

        return Mono.just(healthCheckMapper.map(statuses, IpUtils.getIp()));
    }
}
