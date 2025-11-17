/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

/**
 * Utils class for IO operations
 * 
 * @author U524036
 */
public final class CbaseMiddlewareIOUtils {

	/** Constructor */
	private CbaseMiddlewareIOUtils() {
	}

	/**
	 * extracts embedded files/folders inside our jar to a specified place
	 * 
	 * @param source e.g. /report/shared/ (in base module)
	 * @param target e.g. destination location
	 * @throws URISyntaxException
	 * @throws IOException
	 */
	public static void copyEmbeddedFilesTo(final String source, final File target) throws URISyntaxException, IOException {
		final URL resource = CbaseMiddlewareIOUtils.class.getResource("/" + source);
		final char exclamationMark = 33;
		if (resource != null) {
			/**
			 * Sample URI when source is located as inner jar in jar
			 * jar:file:/Development/Sourcen%20Alm/cbase-middleware-parent/all/target/all-2.0.0-SNAPSHOT-application.jar!/BOOT-INF/lib/base-2.0.0-SNAPSHOT.jar!/report/shared/
			 */
			final URI uri = resource.toURI();
			if ("jar".equals(uri.getScheme())) {
				// Support JAR in JAR
				String lastJarInUri = uri.toString();
				lastJarInUri = lastJarInUri.substring(0, lastJarInUri.lastIndexOf(exclamationMark));

				CbaseMiddlewareIOUtils.unzip(lastJarInUri, target, source);
			} else {
				FileUtils.copyDirectory(new File(uri.getPath()), target);
			}
		}

	}

	/**
	 * unzip source to destination
	 * 
	 * @param source absolute path to source file
	 * @param target target directory
	 * @param subfolder [optional] only the contents of this folder inside the archive will be extracted.
	 * @throws IOException when extraction failed
	 */
	public static void unzip(final String source, final File target, final String subfolder) throws IOException {
		final ZipInputStream zipStream = new ZipInputStream(new URL(source).openStream());
		ZipEntry nextEntry;
		while ((nextEntry = zipStream.getNextEntry()) != null) {
			String name = nextEntry.getName();
			if (subfolder != null) {
				// skip the parent folder and all files that are not part of the subfolder
				if (subfolder.equals(name) || !name.contains(subfolder)) {
					continue;
				}
				name = name.replace(subfolder, "");
			}
			// only extract files
			if (!name.endsWith("/")) {
				final File nextFile = new File(target, name);

				// create directories
				final File parent = nextFile.getParentFile();
				if (parent != null) {
					parent.mkdirs();
				}

				// write file
				try (OutputStream targetStream = new FileOutputStream(nextFile)) {
					IOUtils.copy(zipStream, targetStream);
				}
			}
		}
	}

}
