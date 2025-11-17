/*
 * RestInterfaceRoot.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.base.rest.serializer;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement;

/**
 * Json Serializer for the class <code>ResponseElement</code>. Only the map(element) is relevant for serialization not the complete class.
 *
 * @author Andreas Morgenstern
 */
public class ResponseElementSerializer extends JsonSerializer<ResponseElement> {

	/** {@inheritDoc} */
	@Override
	public void serialize(final ResponseElement value, final JsonGenerator jgen, final SerializerProvider provider) throws IOException {
		jgen.writeObject(value.getResponseElement());
	}

}
