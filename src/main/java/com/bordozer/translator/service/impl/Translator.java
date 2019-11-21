package com.bordozer.translator.service.impl;

import com.bordozer.commons.utils.LoggableJson;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.model.NerdKey;
import com.bordozer.translator.model.TranslationData;
import com.bordozer.translator.model.TranslationEntry;
import com.bordozer.translator.model.TranslationEntryMissed;
import com.bordozer.translator.model.TranslationEntryNerd;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.google.common.collect.Lists.newArrayList;
import static com.google.common.collect.Maps.newHashMap;
import static com.google.common.collect.Maps.newLinkedHashMap;

@Slf4j
class Translator {

    private final Map<NerdKey, TranslationData> translationsMap;
    private final Map<NerdKey, TranslationData> untranslatedMap = newHashMap();

    Translator(final Map<NerdKey, TranslationData> translationsMap) {
        this.translationsMap = translationsMap;
    }

    TranslationEntry getTranslation(final String nerd, final Language language) {

        final NerdKey key = new NerdKey(nerd);

        if (!translationsMap.containsKey(key)) {
            return new TranslationEntryMissed(nerd, language);
        }

        final TranslationData translationData = translationsMap.get(key);
        translationData.increaseUseIndex();

        if (untranslatedMap.containsKey(key)) {
            untranslatedMap.get(key).increaseUseIndex();
        }

        return translationData.getTranslationEntry(language);
    }

    private void registerTranslationEntry(final TranslationEntry translationEntry) {
        final NerdKey nerdKey = new NerdKey(translationEntry.getNerd());
        if (!translationsMap.containsKey(nerdKey)) {
            synchronized (translationsMap) {
                if (!translationsMap.containsKey(nerdKey)) {
                    addTranslationEntryToMap(translationsMap, translationEntry);
                }
            }
        }
    }

    void registerNotTranslationEntry(final TranslationEntry translationEntry) {

        registerTranslationEntry(translationEntry);

        final NerdKey nerdKey = new NerdKey(translationEntry.getNerd());
        if (!untranslatedMap.containsKey(nerdKey)) {
            synchronized (untranslatedMap) {
                if (!untranslatedMap.containsKey(nerdKey)) {
//                    log.info("Register new untranslated entry. Nerd: '{}'", LoggableJson.of(nerdKey));
                    addTranslationEntryToMap(untranslatedMap, translationEntry);
                }
            }
        }
    }

    void addTranslationMap(final Map<NerdKey, TranslationData> translationsMap) {
        this.translationsMap.putAll(translationsMap);
    }

    Map<NerdKey, TranslationData> getTranslationsMap() {
        return translationsMap;
    }

    Map<NerdKey, TranslationData> getUntranslatedMap() {
        return untranslatedMap;
    }

    Map<NerdKey, TranslationData> getUnusedTranslationsMap() {
        final Map<NerdKey, TranslationData> translationsMap = getTranslationsMap();
        final HashMap<NerdKey, TranslationData> map = newLinkedHashMap();

        for (final NerdKey nerdKey : translationsMap.keySet()) {

            final TranslationData translationData = translationsMap.get(nerdKey);
            final List<TranslationEntry> translations = newArrayList(new TranslationEntryNerd(nerdKey.getNerd())); // translationData.getTranslations()

            if (translationData.getUsageIndex() == 0) {
                map.put(nerdKey, new TranslationData(nerdKey.getNerd(), translations, translationData.getUsageIndex()));
            }
        }

        return map;
    }

    void clearUntranslatedMap() {
        log.info("Translated map is cleared");
        untranslatedMap.clear();
    }

    private void addTranslationEntryToMap(final Map<NerdKey, TranslationData> map, final TranslationEntry translationEntry) {
        final String nerd = translationEntry.getNerd();
        final NerdKey nerdKey = new NerdKey(nerd);
        final TranslationData translationData = map.get(nerdKey);

        if (translationData == null) {
            map.put(nerdKey, new TranslationData(nerd, newArrayList(translationEntry)));
        } else {
            if (!hasTranslationEntryForLanguage(translationData, translationEntry.getLanguage())) {
                final List<TranslationEntry> translations = translationData.getTranslations();
                translations.add(new TranslationEntryMissed(nerd, translationEntry.getLanguage()));
                map.put(nerdKey, new TranslationData(nerd, translations));
            }
        }
    }

    private boolean hasTranslationEntryForLanguage(final TranslationData translationData, final Language language) {
        final List<TranslationEntry> translationEntries = translationData.getTranslations();

        for (final TranslationEntry translationEntry : translationEntries) {
            if (translationEntry.getLanguage() == language) {
                return true;
            }
        }

        return false;
    }
}
