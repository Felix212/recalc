/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.query;

import java.lang.reflect.Field;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.hibernate.exception.SQLGrammarException;
import org.hibernate.type.StandardBasicTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.util.ReflectionUtils;

import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;
import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseSequence;

/**
 * Provide method to handle native query on central position. (Only use on persistence layer)
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 */
@Repository
public class NativeQueryProviderImpl implements NativeQueryProvider {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(NativeQueryProviderImpl.class);

	/** the entity manager */
	@PersistenceContext
	private EntityManager em;

	/** current database url */
	@Value("${spring.datasource.url}")
	private String dbUrl;

	/** containing the current database instance name */
	private String databaseInstanceName;

	private boolean isPostgresDb() {
		return dbUrl.startsWith("jdbc:postgresql");
	}

	private boolean isMariaDb() {
		return dbUrl.startsWith("jdbc:mariadb");
	}

	/**
	 * create a native query.
	 *
	 * @param <T> CbaseMiddlewareEntry class in which the result is mapped
	 * @param sqlQuery the complete native sql query
	 * @param pojoClass the result data put into an object of this type.
	 * @return the configured native query
	 */
	public <T extends CbaseMiddlewareEntry> CbaseMiddlewareQuery<T> createNativeQuery(final CbaseMiddlewareNativeQuery sqlQuery,
			final Class<T> pojoClass) {
		final Session session = (Session) em.getDelegate();
		final org.hibernate.Query query = session.createSQLQuery(sqlQuery.getQuery());
		query.setResultTransformer(new CbaseMiddlewareResultTransformer<>(pojoClass));
		return new CbaseMiddlewareQuery<>(query);
	}

	@Override
	public Long getNextSeqValue(final CbaseSequence sequence) {
		final org.hibernate.Query query;

		if (isPostgresDb()) {
			// get postgres query, if db is set PostgreSQL
			query = ((Session) em.getDelegate()).createSQLQuery(String.format("SELECT NEXTVAL('%s') AS num", sequence.name()))
					.addScalar("num", StandardBasicTypes.LONG);
		} else if (isMariaDb()) {
			query = ((Session) em.getDelegate()).createSQLQuery(String.format("SELECT NEXTVAL(%s) AS num", sequence.name()))
					.addScalar("num", StandardBasicTypes.LONG);
		} else {
			query = ((Session) em.getDelegate()).createSQLQuery(String.format("SELECT %s.NEXTVAL as num FROM DUAL", sequence.name()))
					.addScalar("num", StandardBasicTypes.LONG);
		}

		return (Long) query.uniqueResult();
	}

	@Override
	public List<Long> getNextSeqValues(final CbaseSequence sequence, final int amount) {
		final org.hibernate.Query query;

		if (isPostgresDb()) {
			// get postgres query, if db is set PostgreSQL
			query = ((Session) em.getDelegate())
					.createSQLQuery(String.format("SELECT NEXTVAL('%s') AS num FROM GENERATE_SERIES(1, %d)", sequence.name(), amount))
					.addScalar("num", StandardBasicTypes.LONG);
		} else if (isMariaDb()) {
			// get postgres query, if db is set MariaDB
			query = ((Session) em.getDelegate())
					.createSQLQuery(String.format("SELECT NEXTVAL(%s) AS num FROM CEN_OUT LIMIT %d", sequence.name(), amount))
					.addScalar("num", StandardBasicTypes.LONG);
		} else {
			query = ((Session) em.getDelegate())
					.createSQLQuery(String.format("SELECT %s.NEXTVAL as num FROM DUAL CONNECT BY LEVEL <= %d", sequence.name(), amount))
					.addScalar("num", StandardBasicTypes.LONG);
		}

		final List<Long> sequences = new ArrayList<>();
		for (final Object nextSequence : query.list()) {
			sequences.add((Long) nextSequence);
		}

		return sequences;
	}

	@Override
	public TimeZone getDatabaseTimeZone() {
		try {
			final org.hibernate.Query query;

			if (isPostgresDb()) {
				// get postgres query, if db is set PostgreSQL
				query = ((Session) em.getDelegate()).createSQLQuery("SHOW TIMEZONE")
						.addScalar("TimeZone", StandardBasicTypes.STRING);
			} else if (isMariaDb()) {
				return TimeZone.getDefault();
			} else {
				query = ((Session) em.getDelegate()).createSQLQuery("SELECT SESSIONTIMEZONE TZ FROM DUAL")
						.addScalar("TZ", StandardBasicTypes.STRING);
			}

			final String timeZone = (String) query.uniqueResult();

			return TimeZone.getTimeZone(timeZone);
		} catch (final SQLGrammarException e) {
			LOGGER.warn("Could not get the database time zone, use the system default time zone!", e);
		}

		return TimeZone.getDefault();
	}

	/**
	 * Get the current database instance name.
	 *
	 * @return the current database instance name.
	 */
	public String getDBInfo() {
		// ensures that the database instance name is taken only once
		if (StringUtils.isNoneBlank(databaseInstanceName) && !"Error".equals(databaseInstanceName)) {
			return databaseInstanceName;
		}

		// get the database instance name from database meta data
		try {
			final org.hibernate.engine.spi.SessionImplementor sessionImp =
					(org.hibernate.engine.spi.SessionImplementor) em.getDelegate();
			final DatabaseMetaData metadata = sessionImp.connection().getMetaData();
			final Field field = ReflectionUtils.findField(metadata.getConnection().getClass(), "instanceName");
			field.setAccessible(true);
			final Object object = ReflectionUtils.getField(field, metadata.getConnection());

			return object.toString().toUpperCase();
		} catch (final NullPointerException | IllegalStateException | SQLException e) {
			final String msg = "Error reading the database infos!";
			LOGGER.warn(msg + " url: " + dbUrl, e);
			return msg;
		}

	}
}
