/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfSmartCopy;

/**
 * Helper for PDF-Merge.
 *
 * @author Dirk Bunk - U200035
 */
public final class CbaseMiddlewarePdfMerger {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewarePdfMerger.class);

	private CbaseMiddlewarePdfMerger() {
	}

	/**
	 * Merges a List of pdf files in memory
	 * 
	 * @param pdfs the list of pdf files to merge
	 * @return the merged pdf document
	 * @throws DocumentException
	 * @throws IOException
	 */
	public static byte[] mergeInMemory(final List<byte[]> pdfs) {
		final ByteArrayOutputStream baos = new ByteArrayOutputStream();

		try {
			if (!pdfs.isEmpty()) {
				final Document document = new Document();
				final PdfCopy copy = new PdfSmartCopy(document, baos);

				document.open();
				for (final byte[] pdf : pdfs) {
					final PdfReader reader = new PdfReader(pdf);
					final int numberOfPages = reader.getNumberOfPages();

					for (int pageNumber = 1; pageNumber <= numberOfPages; pageNumber++) {
						copy.addPage(copy.getImportedPage(reader, pageNumber));
					}
				}
				document.close();
			}
		} catch (final DocumentException | IOException e) {
			LOGGER.error("Failed to merge pdf.", e);
		}

		return baos.toByteArray();
	}
}
