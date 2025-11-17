/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.serializer;

import static com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants.DATE_PATTERN;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.mockito.Mockito.doReturn;

import java.io.StringWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;
import com.lsgskychefs.cbase.middleware.base.util.CbaseMiddlewareDateFormatter;

/**
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareDateSerializerTest {

	private StringWriter stringJson;

	private JsonGenerator generator;

	private CbaseMiddlewareRestHelper cbaseRestHelper;

	private CbaseMiddlewareDateSerializer serializer;

	@Before
	public void setUp() throws Exception {
		stringJson = new StringWriter();
		generator = new JsonFactory().createGenerator(stringJson);
		cbaseRestHelper = Mockito.spy(CbaseMiddlewareRestHelper.class);
		serializer = new CbaseMiddlewareDateSerializer(cbaseRestHelper);

	}

	@Test
	public void testConvenientDate() throws Exception {
		final SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
		final String dateStr = "04.02.2016 13:00";

		final Date date = dateFormat.parse(dateStr);

		serializer.serialize(date, generator, null);
		generator.flush();

		assertEquals(dateStr, stringJson.toString().replace("\"", ""));
	}

	@Test(expected = ParseException.class)
	public void testDifferentDate() throws Exception {
		final SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
		final String dateStr = "04.02.2016 13:15:12";

		final Date date = dateFormat.parse(dateStr);

		serializer.serialize(date, generator, null);
		generator.flush();

		final String actual = stringJson.toString().replace("\"", "");
		assertNotEquals(dateStr, actual);
		assertEquals("04.02.2016 13:15", actual);
		dateFormat.parse(actual);
	}

	@Test
	public void testUseParameterFormat() throws Exception {
		// "2016-03-16T05:07:19Z"
		final CbaseMiddlewareDateFormatter dateFormat = new CbaseMiddlewareDateFormatter("dd.MM.yyyy HH:mm:ss.S");
		doReturn(dateFormat).when(cbaseRestHelper).getDateTimeFormat();

		final String dateStr = "04.02.2016 13:15:12.123";
		final Date date = dateFormat.parse(dateStr);

		serializer.serialize(date, generator, null);
		generator.flush();

		final String actual = stringJson.toString().replace("\"", "");
		assertEquals(dateStr, actual);
	}

	@Test
	public void testUseParameterFormatUTC() throws Exception {
		final CbaseMiddlewareDateFormatter dateFormat = new CbaseMiddlewareDateFormatter("yyyy-MM-dd'T'HH:mm:ss'Z'");
		doReturn(dateFormat).when(cbaseRestHelper).getDateTimeFormat();

		final String dateStr = "2016-03-16T05:07:19Z";
		final Date date = dateFormat.parse(dateStr);

		serializer.serialize(date, generator, null);
		generator.flush();

		final String actual = stringJson.toString().replace("\"", "");
		assertEquals(dateStr, actual);
	}
}
