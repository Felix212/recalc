/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Component;

import com.google.zxing.common.BitMatrix;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * This class can parse barcodes of types of {@link CbaseMiddlewareBarcodeType}.
 *
 * <pre>
 * All Labels MinLen: 48; only digits
 *
 * FORMAT (Reihenfolge!):
 * 10 Zeichen stückliste       - npackinglistIndexKey
 * 2 Zeichen Tag
 * 2 Zeichen Monat
 * 4 Zeichen Jahr              - referenceDate
 * 10 Zeichen flugschlüssel    - nresultKey
 * 10 Zeichen stauortschlüssel - nstowageKey
 * 10 Zeichen menge            - nquantity
 *
 * Example
 * 000200193118042013003829440300001915980000000001
 *
 * Special PPS Label MinLen: 47; $-seperator
 *
 * FORMAT (Reihenfolge!):
 * 10 Zeichen ContainerKey (cen_pps_container)
 * ?
 * ?
 * ?
 * ?
 * ?
 * ?
 *
 * Example
 * 565683720$3 .62/63 C . $LH/0572 /29$49962$1$1$1
 * </pre>
 *
 * <style type="text/css"> table.tableizer-table { font-size: 12px; border: 1px solid #CCC; font-family: Arial, Helvetica, sans-serif; }
 * .tableizer-table td { padding: 4px; margin: 3px; border: 1px solid #CCC; } .tableizer-table th { background-color: #104E8B; color: #FFF;
 * * font-weight: bold; } </style>
 * <table class="tableizer-table">
 * <thead>
 * <tr class="tableizer-firstrow">
 * <th>Label Typ</th>
 * <th>IndexKey ( 0-10)</th>
 * <th>Date (10-18)</th>
 * <th>ResultKey (18-28)</th>
 * <th>StowageKey (28-38)</th>
 * <th>Quantity (38-48)</th>
 * <th>Barcode</th>
 * </tr>
 * </thead><tbody>
 * <tr>
 * <td><b>Flug-Label</b></td>
 * <td>X</td>
 * <td>X</td>
 * <td>X</td>
 * <td>X</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * </tr>
 * <tr>
 * <td><b>Prod-Label</b></td>
 * <td>X</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * </tr>
 * <tr>
 * <td><b>Stücklisten-Label</b> Enthält das Referenzdatum. Crystal Reports können diesen Label Typ erzeugen indem ein Oracle Plugin
 * verwendet wird LINK</td>
 * <td>X</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * </tr>
 * <tr>
 * <td><b>SPML-Label</b></td>
 * <td>X</td>
 * <td>X?</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * </tr>
 * <tr>
 * <td><b>PPS-Label</b> Muss erst geparst werden um in eine standatisierte Form gebracht zu werden. Serverseitig müssen dafür die folgenden
 * Werte erst aus der Datenbank selektiert werden.</td>
 * <td>X</td>
 * <td>X</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * <td>&nbsp;</td>
 * </tr>
 * </tbody>
 * </table>
 *
 * @author Ingo Rietzschel - U125742
 */
@Component
public class CbaseMiddlewareBarcodeParser {

	/** Map of supported {@link CbaseMiddlewareBarcodeType} */
	private final Map<String, CbaseMiddlewareBarcodeType> barcodeHandler = new HashMap<>();

	/**
	 * All supported Barcode V2 Barcode Parsers will be prepared. For new supported Types add them in Constructor to barcodeHandler map.
	 */
	CbaseMiddlewareBarcodeParser() {
		barcodeHandler.put(CbaseMiddlewareBarcodeType.TROLLEY_LABEL.getBarcodeId(), CbaseMiddlewareBarcodeType.TROLLEY_LABEL);
		barcodeHandler.put(CbaseMiddlewareBarcodeType.PROD_LABEL_VPS.getBarcodeId(), CbaseMiddlewareBarcodeType.PROD_LABEL_VPS);
		barcodeHandler.put(CbaseMiddlewareBarcodeType.FLIGHT_LABEL_VPS.getBarcodeId(), CbaseMiddlewareBarcodeType.FLIGHT_LABEL_VPS);
		barcodeHandler.put(CbaseMiddlewareBarcodeType.SAP_LABEL.getBarcodeId(), CbaseMiddlewareBarcodeType.SAP_LABEL);
		barcodeHandler.put(CbaseMiddlewareBarcodeType.CHILLER_BIN_LABEL.getBarcodeId(), CbaseMiddlewareBarcodeType.CHILLER_BIN_LABEL);
		barcodeHandler.put(CbaseMiddlewareBarcodeType.TOUR_LABEL.getBarcodeId(), CbaseMiddlewareBarcodeType.TOUR_LABEL);
	}

	/**
	 * Parse, prepare and return the given barcode string as {@link CbaseMiddlewareBarcode}. Barcode Format V2 Barcode Format V1
	 *
	 * @param barcodeString the barcode numbers as String
	 * @return the parsed and prepared barcode as {@link CbaseMiddlewareBarcode}
	 * @throws CbaseMiddlewareParsingException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length or wrong format
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN} if contents(data, type, size) cannot be encoded legally in a
	 *             format or if writes the encoded {@link BitMatrix} to the stream fail
	 *             </ul>
	 */
	public CbaseMiddlewareBarcode parse(final String barcodeString)
			throws CbaseMiddlewareParsingException {
		final CbaseMiddlewareBarcode barcode = this.parseByBarcodeId(barcodeString);

		if (barcode == null) {
			return parseV1(barcodeString);
		}

		// Base64 Barcode Images
		final Encoder encoder = Base64.getEncoder();
		barcode.setDataMatrixImgString(
				encoder.encodeToString(CbaseMiddlewareBarcodeWriter.creatDataMatrixCode(barcodeString,
						CbaseMiddlewareBarcodeWriter.DEFAULT_BARCODE_SIZE)));
		barcode.setQrCodeImgString(
				encoder.encodeToString(
						CbaseMiddlewareBarcodeWriter.createQRCode(barcodeString, CbaseMiddlewareBarcodeWriter.DEFAULT_BARCODE_SIZE)));

		return barcode;
	}

	/**
	 * Parse, prepare and return the given barcode string as {@link CbaseMiddlewareBarcode}. Barcode Format V1
	 *
	 * @param barcodeString the barcode numbers as String
	 * @return the parsed and prepared barcode as {@link CbaseMiddlewareBarcode}
	 * @throws CbaseMiddlewareParsingException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length or wrong format
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN} if contents(data, type, size) cannot be encoded legally in a
	 *             format or if writes the encoded {@link BitMatrix} to the stream fail
	 *             </ul>
	 */
	private CbaseMiddlewareBarcode parseV1(final String barcodeString)
			throws CbaseMiddlewareParsingException {
		final CbaseMiddlewareBarcode barcode = new CbaseMiddlewareBarcode();

		final Encoder encoder = Base64.getEncoder();
		barcode.setDataMatrixImgString(
				encoder.encodeToString(CbaseMiddlewareBarcodeWriter.creatDataMatrixCode(barcodeString,
						CbaseMiddlewareBarcodeWriter.DEFAULT_BARCODE_SIZE)));
		barcode.setQrCodeImgString(
				encoder.encodeToString(
						CbaseMiddlewareBarcodeWriter.createQRCode(barcodeString, CbaseMiddlewareBarcodeWriter.DEFAULT_BARCODE_SIZE)));

		if (barcodeString.contains("$")) {
			String containerKey = "";
			try {
				barcode.setBarcodeType(CbaseMiddlewareBarcodeType.PPS_LABEL);
				final String[] split = StringUtils.split(barcodeString, '$');
				containerKey = split[0];
				barcode.setNcontainerKey(Long.valueOf(containerKey));
				return barcode;
			} catch (final NumberFormatException e) {
				throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
						String.format(
								"PPS_LABEL Barcode part(ncontainerKey) does not have the appropriate long format! barcode: %s - part-value: %s",
								barcodeString,
								containerKey),
						e);
			}

		}

		barcode.setNpackinglistIndexKey(CbaseMiddlewareBarcodeParser.parseLongValue(barcodeString, "npackingListKey", 0, 10));
		barcode.setReferenceDate(CbaseMiddlewareBarcodeParser.parseDate(barcodeString, 10));
		barcode.setNresultKey(CbaseMiddlewareBarcodeParser.parseLongValue(barcodeString, "nresultKey", 18, 28));
		barcode.setNstowageKey(CbaseMiddlewareBarcodeParser.parseLongValue(barcodeString, "nstowageKey", 28, 38));
		barcode.setNquantity(CbaseMiddlewareBarcodeParser.parseBigDecimalValue(barcodeString, "nquantity", 38, 48));
		determineType(barcode);
		barcode.setBarcodeString(barcodeString);

		return barcode;
	}

	/**
	 * Parse the reference date and set into given {@link CbaseMiddlewareBarcode} DateFormat must be always DDMMYYYY sample: 14052016
	 * 
	 * @param barcodeString the string to parse
	 * @param startFrom index where the date starts
	 * @return the reference date
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length or
	 *             wrong format
	 */
	public static Date parseDate(final String barcodeString, final int startFrom)
			throws CbaseMiddlewareParsingException {
		String day = "";
		String month = "";
		String year = "";
		try {
			day = barcodeString.substring(startFrom, startFrom + 2);
			month = barcodeString.substring(startFrom + 2, startFrom + 4);
			year = barcodeString.substring(startFrom + 4, startFrom + 8);
			return DateUtils.parseDateStrictly(day + "." + month + "." + year, FormatConstants.DATE);
		} catch (final IndexOutOfBoundsException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"Barcode has wrong length(referenceDate)! barcode: " + barcodeString, e);
		} catch (final ParseException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format(
							"Barcode part(referenceDate) does not have the appropriate format! barcode: %s - day: %s - month: %s - year: %s ",
							barcodeString, day, month, year),
					e);
		}
	}

	/**
	 * Parse the reference date with short year and set into given {@link CbaseMiddlewareBarcode} DateFormat must be always DDMMYY sample:
	 * 140516
	 * 
	 * @param barcodeString the string to parse
	 * @param startFrom index where the date starts
	 * @return the reference date
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length or
	 *             wrong format
	 */
	public static Date parseDateShort(final String barcodeString, final int startFrom)
			throws CbaseMiddlewareParsingException {
		String day = "";
		String month = "";
		String year = "";
		try {
			day = barcodeString.substring(startFrom, startFrom + 2);
			month = barcodeString.substring(startFrom + 2, startFrom + 4);
			year = barcodeString.substring(startFrom + 4, startFrom + 6);
			return DateUtils.parseDateStrictly(day + "." + month + ".20" + year, FormatConstants.DATE);
		} catch (final IndexOutOfBoundsException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"Barcode has wrong length(referenceDate)! barcode: " + barcodeString, e);
		} catch (final ParseException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format(
							"Barcode part(referenceDate) does not have the appropriate format! barcode: %s - day: %s - month: %s - year: %s ",
							barcodeString, day, month, year),
					e);
		}
	}

	/**
	 * Parse and return the value from given position.
	 *
	 * @param barcodeString the string to parse
	 * @param key the current value name (for error messages)
	 * @param from index of start position to parsing
	 * @param to index of end position to parsing
	 * @return the parsed value
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} Parse error, wrong length or wrong
	 *             format
	 */
	public static long parseLongValue(final String barcodeString, final String key, final int from, final int to)
			throws CbaseMiddlewareParsingException {
		String value = "";
		try {
			value = barcodeString.substring(from, to);
			return Long.valueOf(value);
		} catch (final IndexOutOfBoundsException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format("Barcode has wrong length(%s)! barcode: %s", key, barcodeString), e);
		} catch (final NumberFormatException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format(
							"Barcode part(%s) does not have the appropriate long format! barcode: %s - part-value: %s", key, barcodeString,
							value),
					e);
		}
	}

	/**
	 * Parse and return the value from given position.
	 *
	 * @param barcodeString the string to parse
	 * @param key the current value name (for error messages)
	 * @param from index of start position to parsing
	 * @param to index of end position to parsing
	 * @return the parsed value
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} Parse error, wrong length or wrong
	 *             format
	 */
	public static BigDecimal parseBigDecimalValue(final String barcodeString, final String key, final int from, final int to)
			throws CbaseMiddlewareParsingException {
		String value = "";
		try {
			value = barcodeString.substring(from, to);
			return new BigDecimal(value);
		} catch (final IndexOutOfBoundsException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format("Barcode has wrong length(%s)! barcode: %s", key, barcodeString), e);
		} catch (final NumberFormatException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format(
							"Barcode part(%s) does not have the appropriate BigDecimal format! barcode: %s - part-value: %s", key,
							barcodeString,
							value),
					e);
		}
	}

	/**
	 * Parse and return the appropriate {@link CbaseMiddlewareBarcodeType}. For Type detection the first 5 characters/digits will be
	 * scanned.
	 * 
	 * @param barcodeString the string to parse
	 * @return CbaseMiddlewareBarcodeType based on ID inside the barcode
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length
	 */
	private CbaseMiddlewareBarcode2 parseByBarcodeId(final String barcodeString)
			throws CbaseMiddlewareParsingException {
		String barcodeId = "";
		String barcodeValue = "";
		CbaseMiddlewareBarcode2 barcode = null;
		try {
			barcodeId = barcodeString.substring(0, 5);
			barcodeValue = barcodeString.substring(5);
			final CbaseMiddlewareBarcodeType barcodeFactory = barcodeHandler.get(barcodeId);
			if (barcodeFactory != null) {
				barcode = barcodeFactory.create(barcodeValue);
				barcode.setBarcodeString(barcodeString);
			}
			return barcode;
		} catch (final IndexOutOfBoundsException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format(
							"Barcode too short! it must have at least 5 chars for type detection and 1 for content no matter if V1 or V2! barcode: %s",
							barcodeString),
					e);
		}
	}

	/**
	 * Determine and set the {@link CbaseMiddlewareBarcodeType} for given {@link CbaseMiddlewareBarcode}.
	 *
	 * @param barcode to determine the type
	 */
	private void determineType(final CbaseMiddlewareBarcode barcode) {
		if (barcode.getNpackinglistIndexKey() == 0 || barcode.getReferenceDate() == null) {
			barcode.setBarcodeType(CbaseMiddlewareBarcodeType.UNKNOWN);
			return;
		}
		if (barcode.getNquantity().compareTo(BigDecimal.ZERO) > 0 && barcode.getNresultKey() != 0 && barcode.getNstowageKey() != 0) {
			barcode.setBarcodeType(CbaseMiddlewareBarcodeType.FLIGHT_LABEL);
			return;
		}
		if (barcode.getNquantity().compareTo(BigDecimal.ZERO) > 0 && barcode.getNresultKey() != 0) {
			barcode.setBarcodeType(CbaseMiddlewareBarcodeType.SPML_LABEL);
			return;
		}
		if (barcode.getNquantity().compareTo(BigDecimal.ZERO) > 0) {
			barcode.setBarcodeType(CbaseMiddlewareBarcodeType.PROD_LABEL);
			return;
		}
		barcode.setBarcodeType(CbaseMiddlewareBarcodeType.ITEM_LIST_LABEL);

	}
}
