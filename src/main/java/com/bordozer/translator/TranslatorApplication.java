package com.bordozer.translator;

import com.bordozer.commons.web.CommonsWebConfig;
import com.bordozer.translator.configuration.ApplicationConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;

@SpringBootApplication
@Import({ApplicationConfiguration.class, CommonsWebConfig.class})
public class TranslatorApplication {

    public static void main(String[] args) {
        SpringApplication.run(TranslatorApplication.class, args);
    }
}
