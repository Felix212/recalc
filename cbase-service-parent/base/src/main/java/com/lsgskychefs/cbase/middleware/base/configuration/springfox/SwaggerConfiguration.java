/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.base.configuration.springfox;

import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import com.fasterxml.classmate.TypeResolver;
import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.schema.AlternateTypeRule;
import springfox.documentation.schema.AlternateTypeRules;
import springfox.documentation.schema.WildcardType;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

/**
 * Configuration class for Automated JSON API documentation for API's built with Spring.
 *
 * @author Alex Schaab
 */
@Configuration
@Profile("swagger")
public class SwaggerConfiguration {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(SwaggerConfiguration.class);

	/** CBASE-Middleware configuration property service */
	@Autowired
	protected CbaseMiddlewareConfigurationService configService;

	@Autowired
	private TypeResolver typeResolver;

	/** log info */
	public SwaggerConfiguration() {
		SwaggerConfiguration.LOGGER.info("SwaggerConfiguration is initialized.");
	}

	/**
	 * Swagger Api builder.
	 *
	 * @return the Swagger Api builder
	 */
	@Bean
	public Docket cbaseMiddlewareApi() {
		return new Docket(DocumentationType.SWAGGER_2)
				.groupName("cbase-middleware-api")
				.apiInfo(apiInfo())
				.alternateTypeRules(collectionRule())
				.select()
				.paths(PathSelectors.any())
				.build();

	}

	/**
	 * Get the CbaseMiddleware application Rest Api Info data.
	 *
	 * @return the CbaseMiddleware application Rest Api Info data.
	 */
	private ApiInfo apiInfo() {
		final Contact contact =
				new Contact("Lufthansa Industry Solutions BS GmbH", "http://lufthansa-industry-solutions.de",
						"klaus.foerster@lhind.dlh.de");
		return new ApiInfoBuilder()
				.title("CBASEmiddleware API")
				.description("This side provides an overview of all endpoints (API) " +
						"...")
				.termsOfServiceUrl("http://springfox.io")
				.contact(contact)
				.license("Apache License Version 2.0")
				.licenseUrl("https://cbasealm.ads.dlh.de")
				.version(configService.getVersion() + " - " + configService.getApplicationName())
				.build();
	}

	/**
	 * Create and return the collection rule.
	 *
	 * @return the collection rule.
	 */
	private AlternateTypeRule collectionRule() {
		final AlternateTypeRule collectionRule = AlternateTypeRules.newRule(
				// replace Collection<T> for any T
				typeResolver.resolve(Collection.class, WildcardType.class),
				// with List<T> for any T
				typeResolver.resolve(List.class, WildcardType.class));
		return collectionRule;
	}

}
