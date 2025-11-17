/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration;

import java.math.BigDecimal;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.Proxy.Type;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.format.FormatterRegistry;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.validation.beanvalidation.MethodValidationInterceptor;
import org.springframework.validation.beanvalidation.MethodValidationPostProcessor;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.lsgskychefs.cbase.middleware.base.converter.StringToBigDecimalConverter;
import com.lsgskychefs.cbase.middleware.base.converter.StringToDateConverter;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareCaseInsensitiveRequestFilter;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareHttpBodyRequestFilter;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;
import com.lsgskychefs.cbase.middleware.base.rest.RestInterfaceRoot;
import com.lsgskychefs.cbase.middleware.base.rest.deserializer.CbaseMiddlewareBigDecimalDeserializer;
import com.lsgskychefs.cbase.middleware.base.rest.deserializer.CbaseMiddlewareDateDeserializer;
import com.lsgskychefs.cbase.middleware.base.rest.serializer.CbaseMiddlewareBigDecimalSerializer;
import com.lsgskychefs.cbase.middleware.base.rest.serializer.CbaseMiddlewareDateSerializer;

/**
 * REST specific configuration.
 *
 * @author Ingo Rietzschel - U125742
 */
@Configuration
@ConditionalOnWebApplication
public class CbaseMiddlewareWebConfigurationAdapter extends WebMvcConfigurerAdapter {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareWebConfigurationAdapter.class);

	/**
	 * Helper class to get default parameter value from current request or default
	 * value.
	 */
	private final CbaseMiddlewareRestHelper cbaseRestHelper = new CbaseMiddlewareRestHelper();

	/** Configuration property for JSON response formatting */
	@Value("${cbase-middleware.pretty-print-JSON-responses:false}")
	private boolean prettyPrintJSONResponses;

	/**
	 * If specified it will be used for Rest Calls from Spring using
	 * {@link RestTemplate}
	 */
	@Value("${cbase.middleware.proxy.host}")
	private String proxyHost;

	/**
	 * If specified it will be used for Rest Calls from Spring using
	 * {@link RestTemplate}
	 */
	@Value("${cbase.middleware.proxy.port}")
	private Integer proxyPort;

	/** The {@link String} to {@link Date} converter. */
	@Autowired
	private StringToDateConverter stringDateConverter;

	/** The {@link String} to {@link BigDecimal} converter. */
	@Autowired
	private StringToBigDecimalConverter stringBigDecimalConverter;

	/** log info */
	public CbaseMiddlewareWebConfigurationAdapter() {
		super();
		LOGGER.info("CbaseMiddlewareWebConfigurationAdapter is initalized.");
	}

	@Override
	public void addFormatters(final FormatterRegistry registry) {
		LOGGER.info("adding formatters");
		registry.addConverter(stringBigDecimalConverter);
		registry.addConverter(stringDateConverter);
	}

	/**
	 * Simple approach where you want all requests to use the same proxy while using
	 * {@link RestTemplate}
	 * 
	 * @return the RestTemplate with Proxy
	 */
	@Bean
	public RestTemplate restTemplate() {
		final SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();
		if (proxyHost != null && proxyPort != null) {
			final Proxy proxy = new Proxy(Type.HTTP, new InetSocketAddress(proxyHost, proxyPort));
			requestFactory.setProxy(proxy);
		}
		return new RestTemplate(requestFactory);
	}

	/**
	 * Register a the {@link MethodValidationPostProcessor} that delegate to a
	 * {@link MethodValidationInterceptor}.<br>
	 * This Interceptor and the @Validated annotation allow the use of
	 * 'javax.validation.constraints' annotations on @RequestParam and @PathVariable
	 *
	 * @return the Interceptor
	 */
	@Bean
	public MethodValidationPostProcessor methodValidationPostProcessor() {
		return new MethodValidationPostProcessor();
	}

	/**
	 * Register the {@link CbaseMiddlewareCaseInsensitiveRequestFilter}
	 *
	 * @return the {@link CbaseMiddlewareCaseInsensitiveRequestFilter}
	 */
	@Bean
	public FilterRegistrationBean caseInsensitiveRequestFilter() {
		final FilterRegistrationBean filterRegBean = new FilterRegistrationBean();
		filterRegBean.setFilter(new CbaseMiddlewareCaseInsensitiveRequestFilter());
		final List<String> urlPatterns = new ArrayList<>();
		urlPatterns.add(RestInterfaceRoot.REST_API_ROOT + "/*");
		filterRegBean.setUrlPatterns(urlPatterns);
		return filterRegBean;
	}

	/**
	 * Register the {@link CbaseMiddlewareHttpBodyRequestFilter}
	 *
	 * @return the {@link CbaseMiddlewareHttpBodyRequestFilter}
	 */
	@Bean
	public FilterRegistrationBean httpRequestBodyFilter() {
		final FilterRegistrationBean filterRegBean = new FilterRegistrationBean();
		filterRegBean.setFilter(new CbaseMiddlewareHttpBodyRequestFilter());
		final List<String> urlPatterns = new ArrayList<>();
		urlPatterns.add(RestInterfaceRoot.REST_API_ROOT + "/*");
		filterRegBean.setUrlPatterns(urlPatterns);
		return filterRegBean;
	}

	/**
	 * Configure an {@link ObjectMapper}
	 *
	 * @return the configured object mapper
	 */
	@Primary
	@Bean
	public ObjectMapper objectMapper() {
		final ObjectMapper objectMapper = new ObjectMapper();
		// Pretty-print JSON responses
		if (prettyPrintJSONResponses) {
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
		}
		// Disable Fail On Empty Beans serzialization exceptions
		objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);

		configureSerializer(objectMapper);
		configureDeserializer(objectMapper);

		return objectMapper;
	}

	/**
	 * Configure and add the serializer for Date and BigDecimal.
	 *
	 * @param mapper to cofigured object mapper
	 */
	private void configureSerializer(final ObjectMapper mapper) {

		final CbaseMiddlewareDateSerializer dateSerializer = new CbaseMiddlewareDateSerializer(cbaseRestHelper);
		final CbaseMiddlewareBigDecimalSerializer bigDecimalSerializer = new CbaseMiddlewareBigDecimalSerializer(
				cbaseRestHelper);
		final SimpleModule module = new SimpleModule("CbaseMiddlewareModule-Serializer",
				new Version(0, 1, 0, "", "cbase-middleware", "simple-module"));
		module.addSerializer(Date.class, dateSerializer);
		module.addSerializer(Time.class, dateSerializer);
		module.addSerializer(BigDecimal.class, bigDecimalSerializer);
		mapper.registerModule(module);

	}

	/**
	 * Configure and add the deserializer for Date and BigDecimal.
	 *
	 * @param mapper to cofigured object mapper
	 */
	private void configureDeserializer(final ObjectMapper mapper) {
		final CbaseMiddlewareDateDeserializer dateDeserializer = new CbaseMiddlewareDateDeserializer(cbaseRestHelper);
		final CbaseMiddlewareBigDecimalDeserializer bigDecimalDeserializer = new CbaseMiddlewareBigDecimalDeserializer(
				cbaseRestHelper);

		final SimpleModule module = new SimpleModule("CbaseMiddlewareModule-Deserializer",
				new Version(0, 1, 0, "", "cbase-middleware", "simple-module"));
		module.addDeserializer(Date.class, dateDeserializer);
		module.addDeserializer(BigDecimal.class, bigDecimalDeserializer);
		mapper.registerModule(module);

	}

}
