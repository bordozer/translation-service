package com.bordozer.translator.controllers;

import com.bordozer.commons.testing.endpoint.AbstractEndpointTest;
import com.bordozer.commons.utils.FileUtils;
import com.bordozer.commons.web.WebLogger;
import com.bordozer.translator.model.Language;
import com.bordozer.translator.service.TranslatorService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

import static com.bordozer.commons.testing.endpoint.EndpointTestBuilder.testEndpoint;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@WebMvcTest(TranslatorRestController.class)
class TranslatorRestControllerWithWebLoggingTest extends AbstractEndpointTest {

    private static final String URL = "/translate/";
    private static final String X_TRACE_ID = "x-trace-id";

    private static final String EXPECTED_RESPONSE = FileUtils.readSystemResource("tests/TranslatorRestControllerTest/translation-expected-response.json");

    @MockBean
    private TranslatorService translatorService;
    @MockBean
    private WebLogger webLogger;

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
                .hasHttpHeaderWithAnyValue(X_TRACE_ID)
                .hasBodyJson(EXPECTED_RESPONSE)
                .end()
        );
        verify(webLogger).logRequest(any(WebLogger.RequestLogData.class));
        verify(webLogger).logResponse(any(WebLogger.ResponseLogData.class));
    }

    @Test
    void shouldTranslateAndKeepProvidedRequestId() {
        // given
        when(translatorService.translate("Home page", Language.UA)).thenReturn("Головна сторiнка");

        // when
        getTo(testEndpoint(URL)
                .whenRequest()
                .withHttpHeader(X_TRACE_ID, "qwe-rty-uio-plm")
                .withHttpParameter("language", "UA")
                .withHttpParameter("translations[homePage]", "Home page")
                .thenResponse()
                .hasContentType(MediaType.APPLICATION_JSON)
                .hasOkHttpStatus()
                .hasHttpHeaderWithParticularValue(X_TRACE_ID, "qwe-rty-uio-plm")
                .hasBodyJson(EXPECTED_RESPONSE)
                .end()
        );
        verify(webLogger).logRequest(any(WebLogger.RequestLogData.class));
        verify(webLogger).logResponse(any(WebLogger.ResponseLogData.class));
    }

    @Test
    void shouldKeepTraceIdIfException() {
        // given
        when(translatorService.translate("Home page", Language.UA)).thenThrow(new RuntimeException("some exception message"));

        // when
        getTo(testEndpoint(URL)
                .whenRequest()
                .withHttpParameter("language", "UA")
                .withHttpParameter("translations[homePage]", "Home page")
                .thenResponse()
                .hasContentType(MediaType.APPLICATION_JSON)
                .hasHttpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                .hasHttpHeaderWithAnyValue(X_TRACE_ID)
                .hasBodyContains("some exception message")
                .end()
        );
        verify(webLogger).logRequest(any(WebLogger.RequestLogData.class));
        verify(webLogger).logResponse(any(WebLogger.ResponseLogData.class));
    }
}
