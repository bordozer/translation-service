package com.bordozer.translator.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum TranslationEntryType {

    TRANSLATED("TranslationEntryType: Translated"),
    NERD_TRANSLATION("TranslationEntryType: Nerd"),
    MISSED_LANGUAGE("TranslationEntryType: Language tag is missed in translation.xml");

    private final String description;
}
