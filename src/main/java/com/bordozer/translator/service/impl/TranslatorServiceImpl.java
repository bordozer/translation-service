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
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UncheckedIOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.google.common.base.Charsets.UTF_8;
import static com.google.common.collect.Maps.newHashMap;

@Slf4j
@Service
public class TranslatorServiceImpl implements TranslatorService {

    private static final String TRANSLATIONS_PATH = "translations";
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

        final List<String> xmlContexts = getTranslationResourceContexts();
        log.info("Translation resources root files: {}", LoggableJson.of(xmlContexts));
        xmlContexts.forEach(xmlContext -> translator.addTranslationMap(getTranslationMap(xmlContext)));
    }

    private Map<NerdKey, TranslationData> getTranslationMap(final String context) {
        final Map<NerdKey, TranslationData> result = newHashMap();
        result.putAll(TranslationsReader.getTranslationMap(context));
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

    private static List<String> getTranslationResourceContexts() {
        final PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        try {
            final Resource[] messageResources = resolver.getResources("classpath*:/translations/*.xml");
            return Arrays.stream(messageResources)
                    .map(getResourceContext())
                    .collect(Collectors.toList());
        } catch (final IOException e) {
            log.error("Resources list error: '{}'", e.getMessage());
            throw new IllegalStateException("Cannot get translation resources list");
        }

        /*final ClassLoader loader = Thread.currentThread().getContextClassLoader();

        final URL url = loader.getResource(TRANSLATIONS_PATH);
        Objects.requireNonNull(url, String.format("%s URL cannot be got", TRANSLATIONS_PATH));

        final String resourcesRootPath = url.getPath();
        Objects.requireNonNull(resourcesRootPath, String.format("%s  path is null", LoggableJson.of(url)));

        log.info("Resources Root Path: '{}'", resourcesRootPath);
        final File[] files = new File(resourcesRootPath).listFiles();
        Objects.requireNonNull(files, "Translation resource root is empty! No translations files found");
        return files;*/
    }

    private static Function<Resource, String> getResourceContext() {
        return resource -> {
            log.info("Found resource: {}", resource);
            return resourceAsString(resource);
        };
    }

    private static String resourceAsString(final Resource resource) {
        try (final Reader reader = new InputStreamReader(resource.getInputStream(), UTF_8)) {
            return FileCopyUtils.copyToString(reader);
        } catch (final IOException ex) {
            throw new UncheckedIOException(ex);
        }
    }
}
