/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.file;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.query.CbaseMiddlewareNativeQuery;

/**
 * Class for file utility methods.
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 */
@Component
public class FileHelper {
	/** current database url */
	@Value("${spring.datasource.url}")
	private String dbUrl;

	/** The path to sql files. */
	private static String sqlPath = "sql/";

	/** The path to postgres sql files. */
	private static String postgresSqlPath = "postgres-sql/";

	/** The path to mariadb sql files. */
	private static String mariadbSqlPath = "mariadb-sql/";

	/**
	 * Load the native sql file by given name and return the content as String.
	 *
	 * @param fileName the name of the file to be loaded
	 * @return the native query
	 */
	public CbaseMiddlewareNativeQuery getSqlQuery(final String fileName) {
		try {
			final ClassLoader cl = Thread.currentThread().getContextClassLoader();
			InputStream queryAsStream = cl.getResourceAsStream(sqlPath + fileName);

			// get postgres query, if db is set PostgreSQL
			if (dbUrl.startsWith("jdbc:postgresql")) {
				final InputStream postgresQueryAsStream = cl.getResourceAsStream(postgresSqlPath + fileName);
				if (postgresQueryAsStream != null) {
					queryAsStream = postgresQueryAsStream;
				}
			}

			// get postgres query, if db is set MariaDB
			if (dbUrl.startsWith("jdbc:mariadb")) {
				final InputStream postgresQueryAsStream = cl.getResourceAsStream(mariadbSqlPath + fileName);
				if (postgresQueryAsStream != null) {
					queryAsStream = postgresQueryAsStream;
				}
			}

			String statement = IOUtils.toString(queryAsStream, StandardCharsets.UTF_8);

			// using a regex to remove comments
			// note that there is a problem when the statement includes a very large multiline comment block
			// you will have to remove or split this large comment block in order to parse the statement
			final StringBuilder statementNoComments = new StringBuilder();
			int lastCommentEndPos = 0;
			final Pattern commentPattern = Pattern.compile("(?:'.*')|(/\\*(?:.|\r|\n)*?\\*/)|(--.*)");
			final Matcher commentMatcher = commentPattern.matcher(statement);

			while (commentMatcher.find()) {
				for (int groupNo = 1; groupNo <= commentMatcher.groupCount(); groupNo++) {
					final String matchedText = commentMatcher.group(groupNo);
					if (matchedText != null) {
						statementNoComments.append(statement.substring(lastCommentEndPos, commentMatcher.start(groupNo)));
						lastCommentEndPos = commentMatcher.end(groupNo);
					}
				}
			}
			statementNoComments.append(statement.substring(lastCommentEndPos));
			statement = statementNoComments.toString();

			// remove line breaks, tabs and unnecessary whitespaces
			statement = statement.replaceAll("\n", " ").replaceAll("\r", " ").replaceAll("\t", " ").replaceAll("[ ]+", " ");
			return new CbaseMiddlewareNativeQuery(statement);
		} catch (final IOException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, e.getMessage(), e);
		}
	}

	/**
	 * Load the file by given name and return the content as String.
	 *
	 * @param fileName the name of the file to be loaded
	 * @return the file content as String
	 */
	public String getFile(final String fileName) {
		try (final InputStream fileStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(fileName)) {
			return IOUtils.toString(fileStream, StandardCharsets.UTF_8);
		} catch (final IOException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, e.getMessage(), e);
		}
	}
}
