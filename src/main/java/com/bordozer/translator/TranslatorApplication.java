package com.bordozer.translator;

import com.bordozer.commons.web.RequestIdFilter;
import com.bordozer.commons.web.RequestLogFilter;
import com.bordozer.commons.web.WebLogger;
import com.bordozer.translator.configuration.ApplicationConfiguration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.core.annotation.Order;

import java.util.List;

@SpringBootApplication
@Import(ApplicationConfiguration.class)
public class TranslatorApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(TranslatorApplication.class, args);
    }

    @Bean
    public WebLogger webLogger() {
        return new WebLogger();
    }

    @Bean
    @Order(1)
    public FilterRegistrationBean<RequestIdFilter> requestIdFilter() {
        FilterRegistrationBean<RequestIdFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new RequestIdFilter());
        return registrationBean;
    }

    @Bean
    @Order(2)
    public FilterRegistrationBean<RequestLogFilter> requestLogFilter(
            final WebLogger webLogger,
            @Value("${application.properties.logging.logRequestForUrls:}") List<String> requestLogUrls,
            @Value("${application.properties.logging.logRequest:true}") boolean logRequest,
            @Value("${application.properties.logging.logResponse:true}") boolean logResponse) {

        FilterRegistrationBean<RequestLogFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new RequestLogFilter(logRequest, logResponse, webLogger));
        registrationBean.setUrlPatterns(requestLogUrls);
        return registrationBean;
    }
}
