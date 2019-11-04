package com.bordozer.translator.service.impl;

import com.bordozer.commons.utils.LoggableJson;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.model.NerdKey;
import com.bordozer.translator.model.TranslationData;
import com.bordozer.translator.model.TranslationEntry;
import com.bordozer.translator.model.TranslationEntryMissed;
import com.bordozer.translator.service.TranslatorService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.dom4j.DocumentException;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static com.google.common.collect.Maps.newHashMap;

@Slf4j
@Service
public class TranslatorServiceImpl implements TranslatorService {

    private static final String TRANSLATIONS_PATH = "src/main/resources/translations/";
    private static final Language DEFAULT_LANGUAGE = Language.EN;

    private Translator translator;

    @Override
    public String translate(final String nerd, final Language language, final String... params) {
        if (StringUtils.isBlank(nerd)) {
            log.info("Nerd '{}' is blank - no translation needed", LoggableJson.of(nerd));
            return nerd;
        }

        if (language == Language.NERD) {
            log.info("Translation language is nerd - no translation needed. Nerd: '{}'", nerd);
            return nerd;
        }

        log.info("About to get translation for nerd '{}', language: '{}'", nerd, language);
        final TranslationEntry translationEntry = translator.getTranslation(nerd, language);
        log.info("Translation entry: {}, language: '{}'", nerd, language);

        if (translationEntry instanceof TranslationEntryMissed) {
            log.warn("Missed translation: {}, language: '{}'", nerd, language);
            translator.registerNotTranslationEntry(translationEntry);
        }

        String result = translationEntry.getValue();

        int i = 1;
        for (String param : params) {
            result = result.replace(String.format("$%d", i++), param);
        }

        return result;
    }

    @Override
    public Map<NerdKey, TranslationData> getTranslationsMap() {
        return translator.getTranslationsMap();
    }

    @Override
    public Map<NerdKey, TranslationData> getUntranslatedMap() {
        return translator.getUntranslatedMap();
    }

    @Override
    public Map<NerdKey, TranslationData> getUnusedTranslationsMap() {
        return translator.getUnusedTranslationsMap();
    }

    public void init() {
        log.info("Init translations...");
        final Map<NerdKey, TranslationData> translationsMap = newHashMap();
        translator = new Translator(translationsMap);

        translator.addTranslationMap(getTranslationMap(new File(TRANSLATIONS_PATH)));
    }

    private Map<NerdKey, TranslationData> getTranslationMap(final File dir) {

        final File[] farr = dir.listFiles();
        if (farr == null) {
            log.error("No translation files found in dir '{}'", dir.getAbsolutePath());
            return newHashMap();
        }
        log.info("Translation files found in dir '{}': {}", dir.getAbsolutePath(), LoggableJson.of(farr));

        final List<File> files = Arrays.asList(farr);

        final Map<NerdKey, TranslationData> result = newHashMap();
        for (final File file : files) {
            if (file.isDirectory()) {
                result.putAll(getTranslationMap(file));
                continue;
            }

            try {
                result.putAll(TranslationsReader.getTranslationMap(file));
            } catch (final DocumentException e) {
                log.error(String.format("Can not load translation from file '%s'", file.getAbsolutePath()), e);
            }
        }

        return result;
    }

    @Override
    public void reloadTranslations() {
        translator.clearUntranslatedMap();
        init();
    }

    @Override
    public Language getLanguage(final String code) {

        final Language language = Language.getByCode(code);

        if (language != null) {
            return language;
        }

        return getDefaultLanguage();
    }

    @Override
    public Language getDefaultLanguage() {
        return DEFAULT_LANGUAGE;
    }

    public void setTranslator(final Translator translator) {
        this.translator = translator;
    }
}
