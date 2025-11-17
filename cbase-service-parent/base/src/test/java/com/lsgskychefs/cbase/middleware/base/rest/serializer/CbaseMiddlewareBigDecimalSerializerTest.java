/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.serializer;

import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.doReturn;

import java.io.StringWriter;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.lsgskychefs.cbase.middleware.base.CbaseDefaultParameter;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;

/**
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareBigDecimalSerializerTest {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareBigDecimalSerializerTest.class);

	private StringWriter stringJson;

	private JsonGenerator generator;

	private CbaseMiddlewareRestHelper cbaseRestHelper;

	private CbaseMiddlewareBigDecimalSerializer serializer;

	@Before
	public void setUp() throws Exception {
		stringJson = new StringWriter();
		generator = new JsonFactory().createGenerator(stringJson);
		cbaseRestHelper = Mockito.spy(CbaseMiddlewareRestHelper.class);
		serializer = new CbaseMiddlewareBigDecimalSerializer(cbaseRestHelper);
	}

	@Test
	public void testSerializeDefault() throws Exception {
		final String strNumber = "100.123321";

		serializer.serialize(new BigDecimal(strNumber), generator, null);
		generator.flush();

		final String checkNumber = "100.123321";
		assertTrue(checkNumber + " expected in : " + stringJson.toString(), stringJson.toString().contains(checkNumber));
	}

	@Test
	public void testSerializeComma() throws Exception {
		doReturn(Boolean.TRUE).when(cbaseRestHelper).isDecimalPointParameterSet();
		doReturn(Boolean.FALSE.toString()).when(cbaseRestHelper).getParamValue(CbaseDefaultParameter.USE_DECIMAL_POINT);

		final String strNumber = "100.123";

		serializer.serialize(new BigDecimal(strNumber), generator, null);
		generator.flush();

		final String checkNumber = "100,123";
		assertTrue(checkNumber + " expected in : " + stringJson.toString(), stringJson.toString().contains(checkNumber));
	}

	@Test
	public void testSerializePoint() throws Exception {
		doReturn(Boolean.TRUE.toString()).when(cbaseRestHelper).getParamValue(CbaseDefaultParameter.USE_DECIMAL_POINT);

		final String strNumber = "100.123";

		serializer.serialize(new BigDecimal(strNumber), generator, null);
		generator.flush();

		final String checkNumber = "100.123";
		Assert.assertTrue(checkNumber + " expected in : " + stringJson.toString(), stringJson.toString().contains(checkNumber));
	}

	@Test
	public void testSerializeLeading0() throws Exception {
		doReturn(Boolean.TRUE).when(cbaseRestHelper).isDecimalPointParameterSet();

		final String strNumber = "0.123";

		serializer.serialize(new BigDecimal(strNumber), generator, null);
		generator.flush();

		final String checkNumber = "0.123";
		Assert.assertTrue(checkNumber + " expected in : " + stringJson.toString(), stringJson.toString().contains(checkNumber));
	}

	@Test
	public void testSerializeThousandAndRound() throws Exception {
		doReturn(Boolean.TRUE).when(cbaseRestHelper).isDecimalPointParameterSet();
		doReturn(Boolean.FALSE.toString()).when(cbaseRestHelper).getParamValue(CbaseDefaultParameter.USE_DECIMAL_POINT);

		final String strNumber = "1000000.1239";

		serializer.serialize(new BigDecimal(strNumber), generator, null);
		generator.flush();

		final String checkNumber = "1000000,124";
		Assert.assertTrue(checkNumber + " expected in : " + stringJson.toString(), stringJson.toString().contains(checkNumber));
	}

	@Test
	public void testSerializeCustomPattern() throws Exception {
		doReturn(Boolean.TRUE).when(cbaseRestHelper).isDecimalPointParameterSet();
		doReturn("###,###,###.######").when(cbaseRestHelper).getParamValue(CbaseDefaultParameter.BIG_DECIMAL_FORMAT);

		final String strNumber = "1000000.123999";

		serializer.serialize(new BigDecimal(strNumber), generator, null);
		generator.flush();

		final String checkNumber = "1,000,000.123999";
		Assert.assertTrue(checkNumber + " expected in : " + stringJson.toString(), stringJson.toString().contains(checkNumber));
	}

	@Test
	public void testFormat() throws Exception {
		final DecimalFormat decimalFormat = (DecimalFormat) NumberFormat.getInstance(Locale.GERMANY);
		decimalFormat.applyPattern("###.00");
		decimalFormat.setParseBigDecimal(true);
		final String string = decimalFormat.format(new BigDecimal("100.234"));
		LOGGER.info(string);
		final Number number = decimalFormat.parse("100,234");
		LOGGER.info("" + number);

	}
}
