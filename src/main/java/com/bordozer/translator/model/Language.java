package com.bordozer.translator.model;

import static com.google.common.collect.Lists.newArrayList;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Language {

    NERD(1, "nerd", "Language: Nerd", "nerd.png", StringUtils.EMPTY),
    RU(3, "ru", "Language: Russian", "ru.png", "ru"),
    UA(4, "ua", "Language: Ukrainian", "ua.png", "uk"),
    EN(2, "en", "Language: English", "en.png", "en");

    private final int id;
    private final String code;
    private final String name;
    private final String icon;
    private final String country;

    public static Language getById(final int id) {
        for (final Language language : values()) {
            if (language.getId() == id) {
                return language;
            }
        }

        throw new IllegalArgumentException(String.format("Illegal language id: %d", id));
    }

    public static Language getByCode(final String code) {
        for (final Language language : values()) {
            if (language.getCode().equalsIgnoreCase(code)) {
                return language;
            }
        }
        return null;
    }

    public static List<Language> getUILanguages() {
        final List<Language> languages = newArrayList();
        for (final Language language : values()) {
            if (language != NERD) {
                languages.add(language);
            }
        }
        return languages;
    }
}
