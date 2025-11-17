/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.awt.Font;
import java.awt.font.FontRenderContext;
import java.awt.geom.AffineTransform;

/**
 * Helper Functions for Fonts. This Class is used/referenced in CBASE rich client for generating Jasper Files. So take care when
 * refactoring!!
 *
 * @author Alex Schaab - U524036
 */
public final class CbaseMiddlewareFontUtils {

	/** Constructor */
	private CbaseMiddlewareFontUtils() {
	}

	/**
	 * Helper function to calculate the text width for the given attributes
	 * 
	 * @param text the text to be displayed
	 * @param fontface e.g. Arial - If unknown there is default font for the calculation
	 * @param bold if text is bold
	 * @param fontsize font size of text
	 * @return calculated width
	 */
	private static int getTextWidth(final String text, final String fontface, final boolean bold, final int fontsize) {
		final AffineTransform affinetransform = new AffineTransform();
		final FontRenderContext frc = new FontRenderContext(affinetransform, true, true);
		Font font;
		if (bold) {
			font = new Font(fontface, Font.BOLD, fontsize);
		} else {
			font = new Font(fontface, Font.PLAIN, fontsize);
		}
		return (int) (font.getStringBounds(text, frc).getWidth());
	}

	/**
	 * calculates the most optimum fontSize
	 * 
	 * @param text the text to be displayed
	 * @param fontface e.g. Arial - If unknown there is default font for the calculation
	 * @param bold if text is bold
	 * @param maxfontsize the fontsize to get started with
	 * @param minfontsize at least 1 if nothing or wrong values passed
	 * @param width place to display the text
	 * @return Calculated font size
	 */
	public static int getOptFontSize(final String text, final String fontface, final boolean bold, final Integer maxfontsize,
			final Integer minfontsize, final Integer width) {
		int optfontsize;
		int textwidth;
		int checkedMinFontSize;

		// Check Parameter
		if (text == null || maxfontsize == null || minfontsize == null || width == null) {
			return 0;
		}
		if (maxfontsize < 1 || width < 1) {
			return 0;
		}

		// Set minfontsize to at least 1
		checkedMinFontSize = (minfontsize < 1) ? 1 : minfontsize;

		// get started
		optfontsize = maxfontsize + 1;
		do {
			optfontsize--;
			textwidth = getTextWidth(text, fontface, bold, optfontsize);
		} while (textwidth > width && optfontsize > checkedMinFontSize);
		return optfontsize;
	}

}
