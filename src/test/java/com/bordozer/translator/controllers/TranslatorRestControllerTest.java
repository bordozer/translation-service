package com.bordozer.translator.controllers;

import com.bordozer.commons.testing.endpoint.AbstractEndpointTest;
import com.bordozer.commons.utils.FileUtils;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.service.TranslatorService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;

import static com.bordozer.commons.testing.endpoint.EndpointTestBuilder.testEndpoint;
import static org.mockito.Mockito.when;

@WebMvcTest(TranslatorRestController.class)
class TranslatorRestControllerTest extends AbstractEndpointTest {

    private static final String URL = "/translate/";

    private static final String EXPECTED_RESPONSE = FileUtils.readSystemResource("tests/TranslatorRestControllerTest/translation-expected-response.json");

    @MockBean
    private TranslatorService translatorService;

    @Test
    void shouldTranslateAndGenerateRequestId() {
        // given
        when(translatorService.translate("Home page", Language.UA)).thenReturn("Головна сторiнка");

        // when
        getTo(testEndpoint(URL)
                .whenRequest()
                .withHttpParameter("language", "UA")
                .withHttpParameter("translations[homePage]", "Home page")
                .thenResponse()
                .hasContentType(MediaType.APPLICATION_JSON)
                .hasOkHttpStatus()
                .hasHttpHeaderWithAnyValue("x-request-id")
                .hasBodyJson(EXPECTED_RESPONSE)
                .end()
        );
    }

    @Test
    void shouldTranslateAndKeepProvidedRequestId() {
        // given
        when(translatorService.translate("Home page", Language.UA)).thenReturn("Головна сторiнка");

        // when
        getTo(testEndpoint(URL)
                .whenRequest()
                .withHttpHeader("x-request-id", "qwe-rty-uio-plm")
                .withHttpParameter("language", "UA")
                .withHttpParameter("translations[homePage]", "Home page")
                .thenResponse()
                .hasContentType(MediaType.APPLICATION_JSON)
                .hasOkHttpStatus()
                .hasHttpHeaderWithParticularValue("x-request-id", "qwe-rty-uio-plm")
                .hasBodyJson(EXPECTED_RESPONSE)
                .end()
        );
    }
}
