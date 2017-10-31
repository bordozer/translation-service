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
@RequestMapping("/translate")
@RequiredArgsConstructor
public class TranslatorRestController {

    private final TranslatorService translatorService;

    @RequestMapping(method = RequestMethod.GET, value = "/")
    public TranslationDTO translateMultiple(final ModifiableTranslationDTO translations, final Language language) {
        assert language != null;
        log.info("Translate multiple, language: {}, nerds map: {}", language, translations);
        return new ImmutableTranslationDTO.Builder()
            .translations(Maps.transformValues(translations.getTranslations(), nerd -> translateSingle(nerd, language)))
            .build();
    }

    private String translateSingle(final String text, final Language language) {
        assert language != null;
//        log.info("Translate single value: {}", text);
        return translatorService.translate(text, language);
    }
}
