package com.bordozer.translator.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bordozer.translator.dto.ImmutableTranslationDTO;
import com.bordozer.translator.dto.ModifiableTranslationDTO;
import com.bordozer.translator.dto.TranslationDTO;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.service.TranslatorService;
import com.google.common.collect.Maps;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/translator")
@RequiredArgsConstructor
public class TranslatorRestController {

    private final TranslatorService translatorService;

    @RequestMapping(method = RequestMethod.GET, value = "/")
    public TranslationDTO translateMultiple(final ModifiableTranslationDTO dto, final Language language) {
        log.info("Translate multiple: {}", dto);
        return new ImmutableTranslationDTO.Builder()
            .translations(Maps.transformValues(dto.getTranslations(), nerd -> translateSingle(nerd, language)))
            .build();
    }

    private String translateSingle(final String text, final Language language) {
        log.info("Translate single value: {}", text);
        return translatorService.translate(text, language);
    }
}
