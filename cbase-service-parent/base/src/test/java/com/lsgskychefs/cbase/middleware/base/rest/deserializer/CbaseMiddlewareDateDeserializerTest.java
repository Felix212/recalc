/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.deserializer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.when;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.runners.MockitoJUnitRunner;

import com.fasterxml.jackson.core.JsonParser;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;
import com.lsgskychefs.cbase.middleware.base.util.CbaseMiddlewareDateFormatter;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * @author Ingo Rietzschel - U125742
 */
@RunWith(MockitoJUnitRunner.class)
public class CbaseMiddlewareDateDeserializerTest {

	/** CBASE_REST_HELPER */
	@Spy
	private CbaseMiddlewareRestHelper cbaseRestHelper;

	@Mock
	private JsonParser jsonParser;
	private CbaseMiddlewareDateDeserializer deserializer;

	@Before
	public void setUp() {
		deserializer = new CbaseMiddlewareDateDeserializer(cbaseRestHelper);

	}

	@Test
	public void testDeserialize() throws Exception {
		final SimpleDateFormat dateFormat = new SimpleDateFormat(FormatConstants.DATE_PATTERN);
		final String strDate = "04.02.2016 13:57";
		when(jsonParser.getText()).thenReturn(strDate);

		final Date date = deserializer.deserialize(jsonParser, null);
		assertEquals(dateFormat.parse(strDate), date);
	}

	@Test
	public void testDeserializeFail() throws Exception {
		final SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
		final String strDate = "04.02.2016 13:57:12";
		when(jsonParser.getText()).thenReturn(strDate);

		final Date date = deserializer.deserialize(jsonParser, null);
		assertNotEquals(dateFormat.parse(strDate), date);
	}

	@Test
	public void testUseParameter() throws Exception {
		final CbaseMiddlewareDateFormatter dateFormat = new CbaseMiddlewareDateFormatter("dd.MM.yyyy HH:mm:ss");
		doReturn(dateFormat).when(cbaseRestHelper).getDateTimeFormat();
		final String strDate = "04.02.2016 13:57:12";
		when(jsonParser.getText()).thenReturn(strDate);

		final Date date = deserializer.deserialize(jsonParser, null);
		assertEquals(dateFormat.parse(strDate), date);
	}

	@Test(expected = IOException.class)
	public void testWrongDate() throws Exception {
		final CbaseMiddlewareDateFormatter dateFormat = new CbaseMiddlewareDateFormatter("dd.MM.yyyy HH:mm:ss");
		doReturn(dateFormat).when(cbaseRestHelper).getDateTimeFormat();
		final String strDate = "04.02.2016 13:57-12";
		when(jsonParser.getText()).thenReturn(strDate);

		final Date date = deserializer.deserialize(jsonParser, null);
	}
}
