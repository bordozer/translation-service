package com.bordozer.translator.controllers;

import com.bordozer.commons.utils.LoggableJson;
import com.bordozer.translator.dto.ModifiableTranslationDTO;
import com.bordozer.translator.dto.TranslationDTO;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.service.TranslatorService;
import com.google.common.collect.Maps;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class TranslatorRestController {

    private final TranslatorService translatorService;

    @RequestMapping(method = RequestMethod.GET, value = "/translate/")
    public ResponseEntity<TranslationDTO> translateMultiple(final ModifiableTranslationDTO translations, final Language language) {
        assert language != null;
        log.info("Multiple translate request, language: {}, nerds map: {}", language, LoggableJson.of(translations));

        return new ResponseEntity<>(
                TranslationDTO.builder()
                        .translations(
                                Maps.transformValues(translations.getTranslations(), nerd -> translateSingle(nerd, language))
                        )
                        .build(), getHttpHeaders(), HttpStatus.OK);
    }

    @SneakyThrows
    @RequestMapping(method = RequestMethod.GET, value = "/reload")
    public ResponseEntity<String> reload() {
        log.info("Translation reloaded by request");
        translatorService.reloadTranslations();
        return new ResponseEntity<>("All translations have been reloaded", getHttpHeaders(), HttpStatus.OK);
    }

    private HttpHeaders getHttpHeaders() {
        final HttpHeaders headers = new HttpHeaders();
        headers.set("Access-Control-Allow-Origin", "*");
        headers.set("Access-Control-Allow-Headers", "X-Requested-With");
        headers.set("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE");
        return headers;
    }

    private String translateSingle(final String text, final Language language) {
        assert language != null;
        return translatorService.translate(text, language);
    }
}
