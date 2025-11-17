package com.lsgskychefs.cbase.middleware.base.messaging;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AppExceptionMessage implements Serializable {

	private final String text;
	private final int priority;
	private final boolean secret;

	public AppExceptionMessage(@JsonProperty("text") final String text,
			@JsonProperty("priority") final int priority,
			@JsonProperty("secret") final boolean secret) {
		this.text = text;
		this.priority = priority;
		this.secret = secret;
	}

	public String getText() {
		return text;
	}

	public int getPriority() {
		return priority;
	}

	public boolean isSecret() {
		return secret;
	}
}
