package com.lsgskychefs.cbase.middleware.preorder;

import java.util.Collection;
import java.util.function.Supplier;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.util.Assert;

public final class UnauthenticatedPrincipalOAuth2AuthorizedClientRepository
		implements OAuth2AuthorizedClientRepository {
	private final AuthenticationTrustResolver authenticationTrustResolver = new AuthenticationTrustResolverImpl();

	private final OAuth2AuthorizedClientService authorizedClientService;

	private Supplier<Authentication> unauthenticatedPrincipalSupplier = () -> new UnauthenticatedPrincipalAuthentication(
			"unauthenticatedPrincipal");

	public UnauthenticatedPrincipalOAuth2AuthorizedClientRepository(
			final OAuth2AuthorizedClientService authorizedClientService) {
		Assert.notNull(authorizedClientService, "authorizedClientService cannot be null");
		this.authorizedClientService = authorizedClientService;
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T extends OAuth2AuthorizedClient> T loadAuthorizedClient(final String clientRegistrationId,
			final Authentication principal, final HttpServletRequest request) {
		Assert.hasText(clientRegistrationId, "clientRegistrationId cannot be empty");
		Assert.isTrue(isUnauthenticated(principal), "The user " + principal + " should not be authenticated");
		final String unauthenticatedPrincipalName = principal != null ? principal.getName()
				: this.unauthenticatedPrincipalSupplier.get().getName();
		return (T) this.authorizedClientService.loadAuthorizedClient(clientRegistrationId,
				unauthenticatedPrincipalName);
	}

	@Override
	public void saveAuthorizedClient(final OAuth2AuthorizedClient authorizedClient, final Authentication principal,
			final HttpServletRequest request, final HttpServletResponse response) {
		Assert.notNull(authorizedClient, "authorizedClient cannot be null");
		Assert.isTrue(isUnauthenticated(principal), "The user " + principal + " should not be authenticated");
		final Authentication unauthenticatedPrincipal = principal != null ? principal
				: this.unauthenticatedPrincipalSupplier.get();
		this.authorizedClientService.saveAuthorizedClient(authorizedClient, unauthenticatedPrincipal);
	}

	@Override
	public void removeAuthorizedClient(final String clientRegistrationId, final Authentication principal,
			final HttpServletRequest request, final HttpServletResponse response) {
		Assert.hasText(clientRegistrationId, "clientRegistrationId cannot be empty");
		Assert.isTrue(isUnauthenticated(principal), "The user " + principal + " should not be authenticated");
		final String unauthenticatedPrincipalName = principal != null ? principal.getName()
				: this.unauthenticatedPrincipalSupplier.get().getName();
		this.authorizedClientService.removeAuthorizedClient(clientRegistrationId, unauthenticatedPrincipalName);
	}

	public final void setUnauthenticatedPrincipalSupplier(
			final Supplier<Authentication> unauthenticatedPrincipalSupplier) {
		Assert.notNull(unauthenticatedPrincipalSupplier, "unauthenticatedPrincipalSupplier cannot be null");
		this.unauthenticatedPrincipalSupplier = unauthenticatedPrincipalSupplier;
	}

	private boolean isUnauthenticated(final Authentication authentication) {
		return authentication == null || this.authenticationTrustResolver.isAnonymous(authentication);
	}

	private static class UnauthenticatedPrincipalAuthentication implements Authentication {
		private final String name;

		private UnauthenticatedPrincipalAuthentication(final String name) {
			this.name = name;
		}

		@Override
		public Collection<? extends GrantedAuthority> getAuthorities() {
			throw unsupported();
		}

		@Override
		public Object getCredentials() {
			throw unsupported();
		}

		@Override
		public Object getDetails() {
			throw unsupported();
		}

		@Override
		public Object getPrincipal() {
			throw unsupported();
		}

		@Override
		public boolean isAuthenticated() {
			return false;
		}

		@Override
		public void setAuthenticated(final boolean isAuthenticated) throws IllegalArgumentException {
			throw unsupported();
		}

		@Override
		public String getName() {
			return this.name;
		}

		private UnsupportedOperationException unsupported() {
			return new UnsupportedOperationException("Not Supported");
		}
	}
}
