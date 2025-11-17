
package com.lsgskychefs.cbase.middleware.base.configuration.security.oauth2;

import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistration.Builder;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.oauth2.core.oidc.IdTokenClaimNames;

public enum CbaseOAuth2Provider {

	RIM {

		@Override
		public Builder getBuilder(String registrationId) {
			ClientRegistration.Builder builder = getBuilder(registrationId,
					ClientAuthenticationMethod.POST, DEFAULT_LOGIN_REDIRECT_URL);
			//builder.scope("openid", "profile", "email");
			//builder.authorizationUri("https://accounts.google.com/o/oauth2/v2/auth");
			builder.tokenUri("https://asa-uat.svc.flight-retail.com/identity/connect/token");
			builder.authorizationGrantType(AuthorizationGrantType.PASSWORD);
			//builder.jwkSetUri("https://www.googleapis.com/oauth2/v3/certs");
			//builder.userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo");
			//builder.userNameAttributeName(IdTokenClaimNames.SUB);
			//builder.clientName("Google");
			return builder;
		}
	};

	private static final String DEFAULT_LOGIN_REDIRECT_URL = "{baseUrl}/login/oauth2/code/{registrationId}";

	protected final ClientRegistration.Builder getBuilder(String registrationId,
															ClientAuthenticationMethod method, String redirectUri) {
		ClientRegistration.Builder builder = ClientRegistration.withRegistrationId(registrationId);
		builder.clientAuthenticationMethod(method);
		builder.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE);
		builder.redirectUriTemplate(redirectUri);
		return builder;
	}

	/**
	 * Create a new
	 * {@link org.springframework.security.oauth2.client.registration.ClientRegistration.Builder
	 * ClientRegistration.Builder} pre-configured with provider defaults.
	 * @param registrationId the registration-id used with the new builder
	 * @return a builder instance
	 */
	public abstract ClientRegistration.Builder getBuilder(String registrationId);

}