/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.TimeZone;

import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.hibernate.Session;
import org.hibernate.type.StandardBasicTypes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.context.request.RequestAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Throwables;
import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;
import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareUser;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;

/**
 * This Class can be used to save Exceptions to Database for Maintenance
 *
 * @author Alex Schaab - U524036
 */
public class CbaseMiddlewareExceptionToDatabase {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareExceptionToDatabase.class);

	/** The entity manager */
	private final EntityManager em;

	/** The config service */
	private final CbaseMiddlewareConfigurationService configService;

	/**
	 * Pass by the object instances for data & config access
	 * 
	 * @param em the hibernate instance
	 * @param configService the config instance
	 */
	public CbaseMiddlewareExceptionToDatabase(final EntityManager em, final CbaseMiddlewareConfigurationService configService) {
		this.em = em;
		this.configService = configService;
	}

	/**
	 * Saves the exception and some HTTP values to the Database for better Maintenance
	 * 
	 * @param requestAttributes The <code>RequestAttributes</code> object containing the servlet container request data.
	 * @param errorAttributes The error attributes map with custom values.
	 * @param ex the exception that got thrown during handler execution
	 */
	public void logToDatabase(final RequestAttributes requestAttributes, final Map<String, Object> errorAttributes, final Throwable ex) {

		final Object customException = errorAttributes.get(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY);

		if (customException != null && (customException.equals(CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID.name()) ||
				customException.equals(CbaseMiddlewareBusinessExceptionType.SPECIAL_AUTHORIZATION.name()) ||
				customException.equals(CbaseMiddlewareBusinessExceptionType.NOT_FOUND.name()))) {
			return;
		}

		HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference("request");
		if (request.getAttribute("origRequest") != null) {
			request = (HttpServletRequest) request.getAttribute("origRequest");
		}

		String jsonParameter = "";
		try {
			jsonParameter = new ObjectMapper().writeValueAsString(request.getParameterMap());
		} catch (final JsonProcessingException e) {
			LOGGER.debug("Could not process object request parameter map to JSON!", e);
		}

		String jsonErrorResponse = "";
		try {
			jsonErrorResponse = new ObjectMapper().writeValueAsString(errorAttributes);
		} catch (final JsonProcessingException e) {
			LOGGER.debug("Could not process object ErrorAttributes map to JSON!", e);
		}

		String httpBody = "";
		try {
			httpBody = IOUtils.toString(request.getInputStream(), request.getCharacterEncoding());
		} catch (final IOException e) {
			LOGGER.debug("Could not read http body!", e);
		}

		String stackTrance = "N/A";
		if (ex != null) {
			stackTrance = Throwables.getStackTraceAsString(ex);
		}

		final Long exceptionKey = getNextExceptionSequence();
		errorAttributes.put(CbaseMiddlewareErrorAttributes.DB_ERROR_KEY, exceptionKey);

		final org.hibernate.Query query = ((Session) em.getDelegate()).createSQLQuery(
				"insert into SYS_SPRING_EXCEPTIONS	( NERROR_KEY, DTIMESTAMP, CDATABASE, CAPPLICATION, CINSTANCE, CVERSION, CUSER, CSESSIONID, CENDPOINT, CQUERY, CBODY, CSTACKTRACE, CRESPONSE) "
						+ "values	(:NERROR_KEY,:DTIMESTAMP,:CDATABASE,:CAPPLICATION,:CINSTANCE,:CVERSION,:CUSER,:CSESSIONID,:CENDPOINT,:CQUERY,:CBODY,:CSTACKTRACE,:CRESPONSE)");

		query.setParameter("NERROR_KEY", exceptionKey);
		query.setParameter("DTIMESTAMP", getTimeStamp());
		query.setParameter("CDATABASE", getDatabaseName());
		query.setParameter("CAPPLICATION", configService.getApplicationName());
		query.setParameter("CINSTANCE", configService.getJvmRoute());
		query.setParameter("CVERSION", configService.getVersion());
		query.setParameter("CUSER", getUserNameFromRequest(request));
		query.setParameter("CSESSIONID", request.getRequestedSessionId());
		query.setParameter("CENDPOINT", request.getMethod() + ": " + request.getRequestURI().substring(request.getContextPath().length()));
		query.setParameter("CQUERY", jsonParameter);
		query.setParameter("CBODY", httpBody);
		query.setParameter("CSTACKTRACE", stackTrance);
		query.setParameter("CRESPONSE", jsonErrorResponse);

		query.executeUpdate();
	}

	/**
	 * Get the current date with database timezone
	 *
	 * @return the current date with database timezone
	 */
	private Date getTimeStamp() {
		TimeZone dbTimeZone = TimeZone.getDefault();
		try {
			final org.hibernate.Query timeZoneQuery =
					((Session) em.getDelegate()).createSQLQuery("SELECT SESSIONTIMEZONE TZ FROM DUAL")
							.addScalar("TZ", StandardBasicTypes.STRING);
			final String timeZone = (String) timeZoneQuery.uniqueResult();
			dbTimeZone = TimeZone.getTimeZone(timeZone);
		} catch (final NonUniqueResultException e) {
			LOGGER.debug("Could not get the database time zone, use the system default time zone!", e);
			dbTimeZone = TimeZone.getDefault();
		}
		return Calendar.getInstance(dbTimeZone).getTime();
	}

	/**
	 * Gets the next sequence number for SYS_SPRING_EXCEPTIONS
	 * 
	 * @return sequence number
	 */
	private Long getNextExceptionSequence() {
		final org.hibernate.Query nextSequence =
				((Session) em.getDelegate())
						.createSQLQuery("SELECT SEQ_SYS_SPRING_EXCEPTIONS.NEXTVAL as num FROM DUAL")
						.addScalar("num", StandardBasicTypes.LONG);
		return (long) nextSequence.uniqueResult();
	}

	/**
	 * Get the database instance name from database meta data (e.g. MAINT_US)
	 * 
	 * @return database instance name or N/A if not readable for some reason
	 */
	private String getDatabaseName() {
		try {
			final org.hibernate.engine.spi.SessionImplementor sessionImp =
					(org.hibernate.engine.spi.SessionImplementor) em.getDelegate();
			final DatabaseMetaData metadata = sessionImp.connection().getMetaData();

			final Field field = ReflectionUtils.findField(metadata.getConnection().getClass(), "instanceName");
			field.setAccessible(true);
			final Object object = ReflectionUtils.getField(field, metadata.getConnection());
			return object.toString().toUpperCase();

		} catch (final NullPointerException | IllegalStateException | SQLException e) {
			LOGGER.debug("Error reading the database infos!", e);
			return "N/A";
		}
	}

	/**
	 * Get the User who made the request
	 * 
	 * @param request the HTTP request
	 * @return user as CbaseMiddlewareUser object
	 */
	private String getUserNameFromRequest(final HttpServletRequest request) {
		try {
			final HttpSession session = request.getSession();
			final SecurityContext ctx = (SecurityContext) session.getAttribute("SPRING_SECURITY_CONTEXT");

			final Authentication auth = ctx.getAuthentication();
			final CbaseMiddlewareUser user = (CbaseMiddlewareUser) auth.getPrincipal();
			return user.getUsername();
		} catch (final NullPointerException e) {
			LOGGER.debug("Could not find a session!", e);
			return "";
		}
	}
}
