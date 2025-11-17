/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.deserializer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.Spy;
import org.mockito.runners.MockitoJUnitRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;

/**
 * @author Ingo Rietzschel - U125742
 */
@RunWith(MockitoJUnitRunner.class)
public class BigDecimalDeserializerTest {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(BigDecimalDeserializerTest.class);

	/** CBASE_REST_HELPER */
	@Spy
	private CbaseMiddlewareRestHelper cbaseRestHelper;

	@Mock
	private JsonParser jsonParser;

	@Test
	public void testDeserialize() throws Exception {
		final String strNumber = "100.123";
		when(jsonParser.getText()).thenReturn(strNumber);

		final CbaseMiddlewareBigDecimalDeserializer deserializer = new CbaseMiddlewareBigDecimalDeserializer(cbaseRestHelper);

		final BigDecimal bigDecimal = deserializer.deserialize(jsonParser, null);
		assertEquals(new BigDecimal(strNumber), bigDecimal);
	}

	@Test
	public void testDeserializeComma() throws Exception {
		Mockito.doReturn(false).when(cbaseRestHelper).isDecimalPoint();
		final String strNumber = "100,123";
		when(jsonParser.getText()).thenReturn(strNumber);

		final CbaseMiddlewareBigDecimalDeserializer deserializer = new CbaseMiddlewareBigDecimalDeserializer(cbaseRestHelper);

		final BigDecimal bigDecimal = deserializer.deserialize(jsonParser, null);
		assertEquals(new BigDecimal("100.123"), bigDecimal);
	}

	@Test
	public void testDeserializeFail() throws Exception {
		final String strNumber = "100,123";
		when(jsonParser.getText()).thenReturn(strNumber);

		final CbaseMiddlewareBigDecimalDeserializer deserializer = new CbaseMiddlewareBigDecimalDeserializer(cbaseRestHelper);

		final BigDecimal bigDecimal = deserializer.deserialize(jsonParser, null);
		assertNotEquals(new BigDecimal("100.123"), bigDecimal);
	}

	@Test
	public void testDeserializeParseException() throws Exception {
		final String strNumber = "sdf";
		when(jsonParser.getText()).thenReturn(strNumber);

		final CbaseMiddlewareBigDecimalDeserializer deserializer = new CbaseMiddlewareBigDecimalDeserializer(cbaseRestHelper);

		final BigDecimal bigDecimal = deserializer.deserialize(jsonParser, null);
		assertEquals(null, bigDecimal);
	}
}
