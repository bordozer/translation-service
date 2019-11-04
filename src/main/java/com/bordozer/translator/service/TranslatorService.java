package com.bordozer.translator.service;

import java.util.Map;

import org.dom4j.DocumentException;

import com.bordozer.translator.model.Language;
import com.bordozer.translator.model.NerdKey;
import com.bordozer.translator.model.TranslationData;

public interface TranslatorService {

    String translate(final String nerd, final Language language, final String... params);

    Map<NerdKey, TranslationData> getTranslationsMap();

    Map<NerdKey, TranslationData> getUntranslatedMap();

    Map<NerdKey, TranslationData> getUnusedTranslationsMap();

    void reloadTranslations() throws DocumentException;

    Language getLanguage(final String code);

    Language getDefaultLanguage();
}
