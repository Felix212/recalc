/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.Writer;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.datamatrix.DataMatrixWriter;
import com.google.zxing.qrcode.QRCodeWriter;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Generate a Barcode-PNG-Image.
 *
 * @author Ingo Rietzschel - U125742
 */
public final class CbaseMiddlewareBarcodeWriter {

	/** The default barcode image size (128) */
	public static final int DEFAULT_BARCODE_SIZE = 128;

	/** Constructor */
	private CbaseMiddlewareBarcodeWriter() {
		// do nothing.
	}

	/**
	 * Create a QR-Code-PNG-Image with given data and return the bytes.
	 *
	 * @param qrCodeData the data to encoded into QR-Code-PNG-Image
	 * @param size the dimension of QR-Code-PNG-Image
	 * @return the bytes for QR-Code-PNG-Image
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN} if contents(data, type, size) cannot be
	 *             encoded legally in a format or if writes the encoded {@link BitMatrix} to the stream fail
	 */
	public static byte[] createQRCode(final String qrCodeData, final int size)
			throws CbaseMiddlewareParsingException {
		return createCode(BarcodeFormat.QR_CODE, qrCodeData, size);
	}

	/**
	 * Create a DataMatrix-PNG-Image with given data and return the bytes.
	 *
	 * @param dataMatrixData the data to encoded into DataMatrix-PNG-Image
	 * @param size the dimension of DataMatrix-PNG-Image
	 * @return the bytes for DataMatrix-PNG-Image
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN} if contents(data, type, size) cannot be
	 *             encoded legally in a format or if writes the encoded {@link BitMatrix} to the stream fail
	 */
	public static byte[] creatDataMatrixCode(final String dataMatrixData, final int size)
			throws CbaseMiddlewareParsingException {
		return createCode(BarcodeFormat.DATA_MATRIX, dataMatrixData, size);
	}

	/**
	 * Create a Barcode-PNG-Image with given data and format and return the bytes. The QR_CODE is default.
	 *
	 * @param format the {@link BarcodeFormat}
	 * @param data the data to encoded into Barcode-PNG-Image
	 * @param size the dimension of Barcode-PNG-Image
	 * @return the bytes for Barcode-PNG-Images.
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN} if contents(data, type, size) cannot be
	 *             encoded legally in a format or if writes the encoded {@link BitMatrix} to the stream fail
	 */
	private static byte[] createCode(final BarcodeFormat format, final String data, final int size)
			throws CbaseMiddlewareParsingException {
		try {
			final ByteArrayOutputStream bout = new ByteArrayOutputStream();
			Writer writer;
			if (BarcodeFormat.DATA_MATRIX == format) {
				writer = new DataMatrixWriter();
			} else { // QR_CODE is default
				writer = new QRCodeWriter();
			}
			final BitMatrix byteMatrix = writer.encode(data, format, size, size);
			MatrixToImageWriter.writeToStream(byteMatrix, "png", bout);
			return bout.toByteArray();

		} catch (WriterException | IOException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.UNKNOWN, "Could not create the barcode image!",
					e);
		}
	}

}
