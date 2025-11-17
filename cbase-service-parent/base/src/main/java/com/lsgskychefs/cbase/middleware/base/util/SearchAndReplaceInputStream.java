/*
 * Copyright (c) 2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.io.IOException;
import java.io.InputStream;

/**
 * Search and Replace in an InputStream
 * 
 * @author U009907
 */
public class SearchAndReplaceInputStream extends InputStream {

	private final InputStream is;
	private final char[] search;
	private final char[] replace;

	private final int len;
	private int pos;
	private int idx;
	private char ch;
	private char[] buf;

	/**
	 * Constructor
	 * 
	 * @param is
	 * @param search
	 * @param replace
	 */
	public SearchAndReplaceInputStream(final InputStream is, final String search, final String replace) {
		this.is = is;
		this.search = search.toCharArray();
		this.replace = replace.toCharArray();

		len = this.search.length;
		pos = 0;
		idx = -1;

		ch = this.search[0];
		buf = new char[Math.max(this.search.length, this.replace.length)];
	}

	@Override
	public int read() throws IOException {
		if (idx == -1) {
			idx = 0;

			int i = -1;
			while ((i = is.read()) != -1 && (buf[pos] = (char) i) == ch) {
				if (++pos == len) {
					break;
				}

				ch = search[pos];
			}

			if (pos == len) {
				buf = new char[Math.max(this.search.length, this.replace.length)];
				System.arraycopy(replace, 0, buf, 0, replace.length);
			}

			pos = 0;
			ch = search[pos];
		}

		int toReturn = -1;
		if (idx > -1 && buf[idx] != 0) {
			toReturn = buf[idx];
			buf[idx] = 0;
			if (idx < buf.length - 1 && buf[idx + 1] != 0) {
				idx++;
			} else {
				idx = -1;
				buf = new char[Math.max(this.search.length, this.replace.length)];
			}
		}

		return toReturn;
	}

}
