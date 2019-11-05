package com.bordozer.translator.service.impl;

import com.bordozer.translator.model.Language;
import com.bordozer.translator.model.NerdKey;
import com.bordozer.translator.model.TranslationData;
import com.bordozer.translator.model.TranslationEntry;
import com.bordozer.translator.model.TranslationEntryMissed;
import com.bordozer.translator.model.TranslationEntryNerd;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import static com.google.common.collect.Lists.newArrayList;
import static com.google.common.collect.Maps.newHashMap;

@Slf4j
class TranslationsReader {

    private static final String TRANSLATION = "translation";

    static Map<NerdKey, TranslationData> getTranslationMap(final String translationXmlContext) {
        try {
            final Document document = DocumentHelper.parseText(translationXmlContext);
            final Iterator photosIterator = document.getRootElement().elementIterator(TRANSLATION);

            final Map<NerdKey, TranslationData> translationsMap = newHashMap();

            while (photosIterator.hasNext()) {

                final Element nerdElement = (Element) photosIterator.next();
                final String nerd = nerdElement.element(Language.NERD.getCode()).getText();
                log.info("Found NERD: {}", nerd);

                final List<TranslationEntry> translations = newArrayList();
                translations.add(new TranslationEntryNerd(nerd));

                for (final Language language : Language.values()) {

                    if (language == Language.NERD) {
                        continue;
                    }

                    final Element element = nerdElement.element(language.getCode());
                    if (element == null) {
                        translations.add(new TranslationEntryMissed(nerd, language));
                        continue;
                    }

                    final String translation = element.getText();
                    translations.add(new TranslationEntry(nerd, language, translation));
                }

                translationsMap.put(new NerdKey(nerd), new TranslationData(nerd, translations));
            }

            return translationsMap;
        } catch (final DocumentException ex) {
            log.error("Error parsing translation XML context: {}", ex.getMessage());
            throw new IllegalStateException("Cannot parse translation XML context");
        }
    }
}
