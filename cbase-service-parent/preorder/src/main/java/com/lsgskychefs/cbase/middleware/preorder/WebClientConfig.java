package com.lsgskychefs.cbase.middleware.preorder;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnNotWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;
import org.springframework.security.oauth2.client.AuthorizedClientServiceOAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizationContext;
import org.springframework.security.oauth2.client.OAuth2AuthorizeRequest;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientProvider;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientProviderBuilder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.reactive.function.client.ServletOAuth2AuthorizedClientExchangeFilterFunction;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.util.StringUtils;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;

import io.netty.channel.ChannelOption;
import io.netty.handler.timeout.ReadTimeoutHandler;
import io.netty.handler.timeout.WriteTimeoutHandler;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.HttpClient;
import reactor.netty.tcp.ProxyProvider;
import reactor.netty.tcp.TcpClient;

@Configuration
public class WebClientConfig {

	@Value("${cbase.service.interface.baseurl}")
	private String interfaceBaseUrl;

	@Value("${cbase.service.interface.proxy.host}")
	private String interfaceProxyHost;

	@Value("${cbase.service.interface.proxy.port}")
	private Integer interfaceProxyPort;

	@Value("${cbase.service.interface.proxy.username}")
	private String interfaceProxyUsername;

	@Value("${cbase.service.interface.proxy.password}")
	private String interfaceProxyPassword;

	@Value("${cbase.service.interface.proxy.bypass:127.0.0.1}")
	private String interfaceProxyBypass;

	@Value("${cbase.service.interface.oauth2.username}")
	private String oauth2Username;

	@Value("${cbase.service.interface.oauth2.password}")
	private String oauth2Password;

	private static String CLIENT_PROPERTY_KEY = "spring.security.oauth2.client.registration.";
	private static String CLIENT_TOKEN_URI = "spring.security.oauth2.client.provider.";
	private static List<String> clients = Arrays.asList("rim");

	@Autowired
	private Environment env;

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(WebClientConfig.class);

	@Bean
	WebClient webClient(final OAuth2AuthorizedClientManager authorizedClientManager) {
		TcpClient tcpClient = TcpClient.newConnection().option(ChannelOption.CONNECT_TIMEOUT_MILLIS, 5000)
				.doOnConnected(connection -> connection.addHandlerLast(new ReadTimeoutHandler(10))
						.addHandlerLast(new WriteTimeoutHandler(10)));

		if (interfaceProxyHost != null) {
			final Function<String, String> pwd = username -> interfaceProxyPassword;
			tcpClient = tcpClient.proxy(
					proxy -> proxy.type(ProxyProvider.Proxy.HTTP).host(interfaceProxyHost).port(interfaceProxyPort)
							.username(interfaceProxyUsername).password(pwd).nonProxyHosts(interfaceProxyBypass));
		}

		final ServletOAuth2AuthorizedClientExchangeFilterFunction oauth2 = new ServletOAuth2AuthorizedClientExchangeFilterFunction(
				authorizedClientManager);
		oauth2.setDefaultClientRegistrationId("rim");

		return WebClient.builder().baseUrl(interfaceBaseUrl)
				.codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(16 * 1024 * 1024))
				.clientConnector(new ReactorClientHttpConnector(HttpClient.from(tcpClient).wiretap(true)))
				.apply(oauth2.oauth2Configuration()).build();
	}

	@Bean
	@ConditionalOnNotWebApplication
	public ClientRegistrationRepository clientRegistrationRepository2() {
		return new InMemoryClientRegistrationRepository(this.getClientRegistration("rim"));
	}

	private ClientRegistration getClientRegistration(final String client) {
		final String clientId = env.getProperty(CLIENT_PROPERTY_KEY + client + ".client-id");
		final String clientSecret = env.getProperty(CLIENT_PROPERTY_KEY + client + ".client-secret");
		final String tokenUri = env.getProperty(CLIENT_TOKEN_URI + client + ".token-uri");

		return ClientRegistration.withRegistrationId("rim").clientId(clientId).clientSecret(clientSecret)
				.clientAuthenticationMethod(ClientAuthenticationMethod.BASIC)
				.authorizationGrantType(AuthorizationGrantType.PASSWORD).tokenUri(tokenUri).clientName("rim").build();
	}

	private ClientRegistration getRegistration(final String client) {
		final String clientId = env.getProperty(CLIENT_PROPERTY_KEY + client + ".client-id");

		if (clientId == null) {
			return null;
		}

		final String clientSecret = env.getProperty(CLIENT_PROPERTY_KEY + client + ".client-secret");

		if (client.equals("google")) {
			return CommonOAuth2Provider.GOOGLE.getBuilder(client).clientId(clientId).clientSecret(clientSecret).build();
		}
		if (client.equals("facebook")) {
			return CommonOAuth2Provider.FACEBOOK.getBuilder(client).clientId(clientId).clientSecret(clientSecret)
					.build();
		}
		return null;
	}

	// private ClientRegistration rimClientRegistration() {
	// return
	// CommonOAuth2Provider.GOOGLE.getBuilder("google").clientId("google-client-id")
	// .clientSecret("google-client-secret").build();
	// }

//
//	@Bean
//	@ConditionalOnMissingBean
//	public OAuth2AuthorizedClientService authorizedClientService2() {
//		return new InMemoryOAuth2AuthorizedClientService(this.clientRegistrationRepository2());
//	}
//

	@Bean
	OAuth2AuthorizedClientManager authorizedClientManager(final ClientRegistrationRepository clients) {
		final OAuth2AuthorizedClientService service = new InMemoryOAuth2AuthorizedClientService(clients);
		final AuthorizedClientServiceOAuth2AuthorizedClientManager manager = new AuthorizedClientServiceOAuth2AuthorizedClientManager(
				clients, service);
		final OAuth2AuthorizedClientProvider authorizedClientProvider = OAuth2AuthorizedClientProviderBuilder.builder()
				.password().build();
		manager.setAuthorizedClientProvider(authorizedClientProvider);
		manager.setContextAttributesMapper(contextAttributesMapper());
		return manager;
	}

	private Function<OAuth2AuthorizeRequest, Map<String, Object>> contextAttributesMapper() {
		return authorizeRequest -> {
			Map<String, Object> contextAttributes = Collections.emptyMap();

			final String username = oauth2Username;
			final String password = oauth2Password;
			if (StringUtils.hasText(username) && StringUtils.hasText(password)) {
				contextAttributes = new HashMap<>();
				// `PasswordOAuth2AuthorizedClientProvider` requires both attributes
				contextAttributes.put(OAuth2AuthorizationContext.USERNAME_ATTRIBUTE_NAME, username);
				contextAttributes.put(OAuth2AuthorizationContext.PASSWORD_ATTRIBUTE_NAME, password);
			}
			return contextAttributes;
		};
	}

//	@Bean
//	public WebClient defaultWebClient() {
//		final ConnectionProvider provider = ConnectionProvider.builder("fixed").maxConnections(100)
//				.pendingAcquireTimeout(Duration.ofMillis(30000)).maxIdleTime(Duration.ofMillis(60)).build();
//
//		// TcpClient tcpClient =
//		// TcpClient.create(provider).option(ChannelOption.CONNECT_TIMEOUT_MILLIS, 2000)
//		// .doOnConnected(connection -> connection.addHandlerLast(new
//		// ReadTimeoutHandler(10))
//		// .addHandlerLast(new WriteTimeoutHandler(10)));
//
//		TcpClient tcpClient = TcpClient.newConnection().option(ChannelOption.CONNECT_TIMEOUT_MILLIS, 1000)
//				.doOnConnected(connection -> connection.addHandlerLast(new ReadTimeoutHandler(10))
//						.addHandlerLast(new WriteTimeoutHandler(10)));
//
//		if (interfaceProxyHost != null) {
//			final Function<String, String> pwd = username -> interfaceProxyPassword;
//			tcpClient = tcpClient.proxy(
//					proxy -> proxy.type(ProxyProvider.Proxy.HTTP).host(interfaceProxyHost).port(interfaceProxyPort)
//							.username(interfaceProxyUsername).password(pwd).nonProxyHosts(interfaceProxyBypass));
//		}
//
//		// .filter(filterFunction(clientRegistrations))
//
//		return WebClient.builder().baseUrl(interfaceBaseUrl)
//				.codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(16 * 1024 * 1024))
//				.clientConnector(new ReactorClientHttpConnector(HttpClient.from(tcpClient).wiretap(true)))
//				.filter(logRequest()).filter(logResponse()).build();
//	}

	private ExchangeFilterFunction logRequest() {
		return (clientRequest, next) -> {
			LOGGER.debug("Request: {} {}", clientRequest.method(), clientRequest.url());
			LOGGER.debug("--- Http Headers: ---");
			clientRequest.headers().forEach(this::logHeader);
			LOGGER.debug("--- Http Cookies: ---");
			clientRequest.cookies().forEach(this::logHeader);
			return next.exchange(clientRequest);
		};
	}

	private ExchangeFilterFunction logResponse() {
		return ExchangeFilterFunction.ofResponseProcessor(clientResponse -> {
			LOGGER.debug("Response: {}", clientResponse.statusCode());
			clientResponse.headers().asHttpHeaders()
					.forEach((name, values) -> values.forEach(value -> LOGGER.debug("{}={}", name, value)));
			return Mono.just(clientResponse);
		});
	}

	private void logHeader(final String name, final List<String> values) {
		values.forEach(value -> LOGGER.debug("{}={}", name, value));
	}

//	private ServerOAuth2AuthorizedClientExchangeFilterFunction filterFunction(
//			final ReactiveClientRegistrationRepository clientRegistrations) {
//		final ServerOAuth2AuthorizedClientExchangeFilterFunction filterFunction = new ServerOAuth2AuthorizedClientExchangeFilterFunction(
//				clientRegistrations, new UnAuthenticatedServerOAuth2AuthorizedClientRepository());
//		filterFunction.setDefaultClientRegistrationId("myKey");
//		return filterFunction;
//	}

//	@Bean
//	public OAuth2AuthorizedClientManager authorizedClientManager(
//			final ClientRegistrationRepository clientRegistrationRepository,
//			final OAuth2AuthorizedClientService clientService) {
//
//		final OAuth2AuthorizedClientProvider authorizedClientProvider = OAuth2AuthorizedClientProviderBuilder.builder()
//				.clientCredentials().build();
//
//		final AuthorizedClientServiceOAuth2AuthorizedClientManager authorizedClientManager = new AuthorizedClientServiceOAuth2AuthorizedClientManager(
//				clientRegistrationRepository, clientService);
//		authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);
//
//		return authorizedClientManager;
//	}

//	@Bean
//	public OAuth2AuthorizedClientManager authorizedClientManager(
//			final ClientRegistrationRepository clientRegistrationRepository,
//			final OAuth2AuthorizedClientRepository authorizedClientRepository2) {
//
//		final OAuth2AuthorizedClientProvider authorizedClientProvider = OAuth2AuthorizedClientProviderBuilder.builder()
//				.password().refreshToken().build();
//
//		final DefaultOAuth2AuthorizedClientManager authorizedClientManager = new DefaultOAuth2AuthorizedClientManager(
//				clientRegistrationRepository, authorizedClientRepository2);
//		authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);
//
//		// Assuming the `username` and `password` are supplied as `HttpServletRequest`
//		// parameters,
//		// map the `HttpServletRequest` parameters to
//		// `OAuth2AuthorizationContext.getAttributes()`
//		authorizedClientManager.setContextAttributesMapper(contextAttributesMapper());
//
//		return authorizedClientManager;
//	}
//

//	@Bean
//	public ClientRegistrationRepository clientRegistrations() {
//
//		final ClientRegistration clientRegistration = ClientRegistration.withRegistrationId("myKey")
//				.clientId("asa-uat-preorder.lsg.client").clientSecret("KHFP9dN4XYPydgs4EbLt").scope("read,write")
//				.authorizationGrantType(AuthorizationGrantType.PASSWORD)
//				.tokenUri("https://asa-uat.svc.flight-retail.com/identity/connect/token").build();
//
//		return new InMemoryClientRegistrationRepository(clientRegistration);
//	}
//
//	@Bean
//	OAuth2AuthorizedClientRepository authorizedClientRepository2() {
//		return new HttpSessionOAuth2AuthorizedClientRepository();
//	}

	/*
	 * // trying to set up spring 5 oauth2, but grant type password seems not to
	 * work
	 * 
	 * @Bean WebClient webClient(@Qualifier("cr")
	 * ReactiveClientRegistrationRepository clientRegistrations) {
	 * ServerOAuth2AuthorizedClientExchangeFilterFunction oauth = new
	 * ServerOAuth2AuthorizedClientExchangeFilterFunction( clientRegistrations, new
	 * UnAuthenticatedServerOAuth2AuthorizedClientRepository());
	 * oauth.setDefaultClientRegistrationId("rim"); return
	 * WebClient.builder().filter(oauth).build(); }
	 * 
	 * @Bean("cr") ReactiveClientRegistrationRepository getRegistration(
	 * 
	 * @Value("${spring.security.oauth2.client.provider.rim.token-uri}") String
	 * tokenUri,
	 * 
	 * @Value("${spring.security.oauth2.client.registration.rim.client-id}") String
	 * clientId,
	 * 
	 * @Value("${spring.security.oauth2.client.registration.rim.client-secret}")
	 * String clientSecret) { ClientRegistration registration =
	 * ClientRegistration.withRegistrationId("rim").tokenUri(tokenUri)
	 * .clientId(clientId).clientSecret(clientSecret).authorizationGrantType(
	 * AuthorizationGrantType.PASSWORD) .build(); return new
	 * InMemoryReactiveClientRegistrationRepository(registration); }
	 * 
	 * @Bean public ServletOAuth2AuthorizedClientExchangeFilterFunction
	 * servletOAuth2AuthorizedClientExchangeFilterFunction(
	 * ClientRegistrationRepository clientRegistrations,
	 * OAuth2AuthorizedClientRepository authorizedClients) {
	 * 
	 * ServletOAuth2AuthorizedClientExchangeFilterFunction oauth = new
	 * ServletOAuth2AuthorizedClientExchangeFilterFunction( clientRegistrations,
	 * authorizedClients);
	 * 
	 * oauth.setDefaultOAuth2AuthorizedClient(true);
	 * oauth.setDefaultClientRegistrationId("rim");
	 * 
	 * return oauth; }
	 * 
	 * @Bean public ClientRegistrationRepository clientRegistrations() {
	 * 
	 * ClientRegistration clientRegistration =
	 * ClientRegistration.withRegistrationId("rim")
	 * .clientId("asa-uat-preorder.lsg.client").clientSecret("KHFP9dN4XYPydgs4EbLt")
	 * .scope("read,write") .authorizationGrantType(AuthorizationGrantType.PASSWORD)
	 * .tokenUri("https://asa-uat.svc.flight-retail.com/identity/connect/token").
	 * build();
	 * 
	 * return new InMemoryClientRegistrationRepository(clientRegistration); }
	 * 
	 * @Bean public ClientHttpConnector clientHttpConnector() {
	 * 
	 * TcpClient tcpClient =
	 * TcpClient.create().option(ChannelOption.CONNECT_TIMEOUT_MILLIS, 2000)
	 * .doOnConnected(connection -> connection.addHandlerLast(new
	 * ReadTimeoutHandler(1)) .addHandlerLast(new WriteTimeoutHandler(1)));
	 * 
	 * return new ReactorClientHttpConnector(HttpClient.from(tcpClient)); }
	 * 
	 * @Bean public WebClient webClient(
	 * ServletOAuth2AuthorizedClientExchangeFilterFunction
	 * servletOAuth2AuthorizedClientExchangeFilterFunction, ClientHttpConnector
	 * clientHttpConnector) {
	 * 
	 * return WebClient.builder() // .baseUrl(MESSAGE_BASE_URL)
	 * .clientConnector(clientHttpConnector).filter(
	 * servletOAuth2AuthorizedClientExchangeFilterFunction) //
	 * .apply(servletOAuth2AuthorizedClientExchangeFilterFunction.
	 * oauth2Configuration()) .build(); }
	 */
}