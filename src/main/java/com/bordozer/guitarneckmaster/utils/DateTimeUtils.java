package com.bordozer.guitarneckmaster.utils;

import java.time.LocalDateTime;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class DateTimeUtils {

    public static LocalDateTime now() {
        return LocalDateTime.now();
    }
}
