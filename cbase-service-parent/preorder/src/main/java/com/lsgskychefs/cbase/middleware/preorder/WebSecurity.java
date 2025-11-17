package com.lsgskychefs.cbase.middleware.preorder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

//@Configuration
public class WebSecurity extends WebSecurityConfigurerAdapter {

	@Autowired
	public void configureGlobal(final AuthenticationManagerBuilder auth) throws Exception {
		auth.inMemoryAuthentication().withUser("user").password(passwordEncoder().encode("pass"))
				.authorities("ROLE_USER");
	}

	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("*").permitAll().anyRequest().anonymous().and().oauth2Client();

	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
