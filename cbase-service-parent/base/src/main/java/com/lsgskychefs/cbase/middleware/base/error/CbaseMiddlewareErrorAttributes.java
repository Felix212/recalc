/*
 * CbaseMiddlewareErrorAttributes.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.ExceptionHandlerExceptionResolver;

import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareUserLoginException;
import com.lsgskychefs.cbase.middleware.base.rest.RequestLoggerHandlerInterceptorAdapter;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * Class responsible for retrieving exception data to be sent to the caller via REST/JSON. This class is a modified copy of the Spring Boot
 * class <code>DefaultErrorAttributes</code>.
 *
 * @author Andreas Morgenstern
 */
public class CbaseMiddlewareErrorAttributes extends ExceptionHandlerExceptionResolver
		implements ErrorAttributes {

	/** JAVAX_SERVLET_ERROR_MESSAGE */
	private static final String JAVAX_SERVLET_ERROR_MESSAGE = "javax.servlet.error.message";

	/** JAVAX_SERVLET_ERROR_STATUS_CODE - current {@link HttpStatus} error code */
	public static final String JAVAX_SERVLET_ERROR_STATUS_CODE = "javax.servlet.error.status_code";

	/** Unknown http status */
	private static final int UNKNOWN_STATUS = 999;

	/** Key for timestamp storage in the map. */
	protected static final String TIMESTAMP_KEY = "timestamp";

	/** Key for http status storage in the map. */
	protected static final String HTTP_STATUS_KEY = "http-status";

	/** Key for http error(reason phrase) storage in the map. */
	protected static final String HTTP_ERROR_KEY = "http-error";

	/** Key for uri path storage in the map. */
	private static final String PATH_KEY = "path";

	/** Key used to set and get the exception as request attribute. */
	protected static final String ERROR_ATTRIBUTE = CbaseMiddlewareErrorAttributes.class.getName() + ".ERROR";

	/** Key for error code storage in the map. */
	protected static final String ERROR_CODE_KEY = "error-code";

	/** Key for error message storage in the map. */
	protected static final String ERROR_MESSAGE_KEY = "error-message";

	/** Key for the corresponding database entry */
	protected static final String DB_ERROR_KEY = "db-key";

	/** Handler for setting error attributes. */
	private final AbstractExceptionHandler<? extends Throwable> exceptionHandler;

	/** The entity manager */
	@PersistenceContext
	protected EntityManager em;

	/** The config service */
	@Autowired
	protected CbaseMiddlewareConfigurationService configService;

	/** Initialize the exception/error handler(Chain of Responsibility Pattern) */
	public CbaseMiddlewareErrorAttributes() {
		super();
		final DefaultExceptionHandler deHandler = new DefaultExceptionHandler(null);
		final ServletRequestBindingExceptionHandler srbeHandler = new ServletRequestBindingExceptionHandler(deHandler);
		final BindExceptionHandler bindExceptionHandler = new BindExceptionHandler(srbeHandler);
		final MethodArgumentTypeMismatchExceptionHandler mismatchHandler =
				new MethodArgumentTypeMismatchExceptionHandler(bindExceptionHandler);
		final MethodArgumentNotValidExceptionHandler manveHandler = new MethodArgumentNotValidExceptionHandler(mismatchHandler);
		final HttpMessageNotReadableExceptionHandler hmnrException = new HttpMessageNotReadableExceptionHandler(manveHandler);
		final CbaseMiddlewareUserLoginExceptionHandler uleHandler = new CbaseMiddlewareUserLoginExceptionHandler(hmnrException);
		final CbaseMiddlewareTechnicalExceptionHandler teHandler = new CbaseMiddlewareTechnicalExceptionHandler(uleHandler);
		final CbaseMiddlewareBusinessExceptionHandler beHandler = new CbaseMiddlewareBusinessExceptionHandler(teHandler);
		final ConstraintViolationExceptionHandler cveHandler = new ConstraintViolationExceptionHandler(beHandler);

		exceptionHandler = cveHandler;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public int getOrder() {
		return Ordered.HIGHEST_PRECEDENCE;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public ModelAndView resolveException(final HttpServletRequest request, final HttpServletResponse response, final Object handler,
			final Exception ex) {
		request.setAttribute(CbaseMiddlewareErrorAttributes.ERROR_ATTRIBUTE, ex);
		request.setAttribute("origRequest", request);
		super.resolveException(request, response, handler, ex);
		try {
			return resolveResponseStatus(response, ex);
		} catch (IOException | IllegalStateException resolveEx) {
			logger.warn("Handling of @ResponseStatus resulted in Exception", resolveEx);
		}
		return null;
	}

	/**
	 * Method that handles {@link ResponseStatus @ResponseStatus} annotation and the {@link CbaseMiddlewareBusinessExceptionType} status.
	 * <p>
	 * Sends a response error using {@link HttpServletResponse#sendError(int)} or {@link HttpServletResponse#sendError(int, String)} if the
	 * annotation or {@link CbaseMiddlewareBusinessException} has a reason and then returns an empty ModelAndView.
	 *
	 * @param response current HTTP response
	 * @param ex the exception that got thrown during handler execution or the exception that has the ResponseStatus annotation if found on
	 *            the cause.
	 * @return an empty ModelAndView.
	 * @exception IOException If an input or output exception occurs
	 * @exception IllegalStateException If the response was committed
	 */
	protected ModelAndView resolveResponseStatus(
			final HttpServletResponse response, final Exception ex) throws IOException {
		final ResponseStatus responseStatus = AnnotatedElementUtils.findMergedAnnotation(ex.getClass(), ResponseStatus.class);
		int statusCode = 0;
		String reason = "";

		if (responseStatus != null) {
			statusCode = responseStatus.code().value();
			reason = responseStatus.reason();

		}

		if (ex instanceof CbaseMiddlewareBusinessException) {

			final CbaseMiddlewareBusinessException e = (CbaseMiddlewareBusinessException) ex;
			statusCode = e.getType().getHttpStatus().value();
			reason = e.getMessage();

		} else if (ex instanceof CbaseMiddlewareUserLoginException) {

			final CbaseMiddlewareUserLoginException e = (CbaseMiddlewareUserLoginException) ex;
			statusCode = HttpStatus.UNAUTHORIZED.value();
			reason = e.getMessage();

		}

		if (statusCode != 0) {
			if (StringUtils.isBlank(reason)) {
				response.sendError(statusCode);
			} else {
				response.sendError(statusCode, reason);
			}
			return new ModelAndView();
		}
		return null;
	}

	/**
	 * {@inheritDoc}
	 */
	public Map<String, Object> getErrorAttributes(final WebRequest requestAttributes, final boolean includeStackTrace) {
		final Map<String, Object> errorAttributes = new LinkedHashMap<>();
		final Date date = new Date();
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX", FormatConstants.DEFAULT_LOCALE);
		errorAttributes.put(CbaseMiddlewareErrorAttributes.TIMESTAMP_KEY,
				date.getTime() + " - " + sdf.format(date) + " - dateFormat: " + sdf.toPattern());
		final HttpStatus exceptionHttpStatus = addErrorMessageAndCode(errorAttributes, requestAttributes);
		addStatus(errorAttributes, requestAttributes, exceptionHttpStatus);
		addPath(errorAttributes, requestAttributes);
		try {
			final CbaseMiddlewareExceptionToDatabase exceptionToDb = new CbaseMiddlewareExceptionToDatabase(this.em, this.configService);
			exceptionToDb.logToDatabase(requestAttributes, errorAttributes, getError(requestAttributes));
		} catch (final Exception e) {
			logger.debug("Could not save exception to Database!", e);
		}

		return errorAttributes;
	}

	/**
	 * Adds http status and http error to the error attributes map.
	 *
	 * @param errAttr The error attributes map to be filled.
	 * @param requestAttributes The <code>RequestAttributes</code> object containing the servlet container request data.
	 * @param exceptionHttpStatus The HttpStatus determined from exceptionHandler responsibility chain.
	 */
	private void addStatus(final Map<String, Object> errAttr, final RequestAttributes requestAttributes,
			final HttpStatus exceptionHttpStatus) {
		final Integer statusCode = (Integer) getAttribute(requestAttributes, JAVAX_SERVLET_ERROR_STATUS_CODE);

		Integer value = exceptionHttpStatus != null ? Integer.valueOf(exceptionHttpStatus.value()) : statusCode;

		// no status is changed to 999 status
		if (value == null) {
			value = Integer.valueOf(CbaseMiddlewareErrorAttributes.UNKNOWN_STATUS);
			errAttr.put(CbaseMiddlewareErrorAttributes.HTTP_STATUS_KEY, value);
			errAttr.put(CbaseMiddlewareErrorAttributes.HTTP_ERROR_KEY, "None");
		}

		// status determined by exception overwrite current status -> log this change
		if (exceptionHttpStatus != null && value != null && !value.equals(statusCode)) {
			logger.info("HttpStatusCode changed by exception: " + statusCode + " -> " + exceptionHttpStatus);
			requestAttributes.setAttribute(JAVAX_SERVLET_ERROR_STATUS_CODE, value, 0);
		}

		errAttr.put(CbaseMiddlewareErrorAttributes.HTTP_STATUS_KEY, value);

		// unknown status is changed to internal server error
		try {
			errAttr.put(CbaseMiddlewareErrorAttributes.HTTP_ERROR_KEY, HttpStatus.valueOf(value).getReasonPhrase());
		} catch (final IllegalArgumentException ex) {
			logger.error("Unknown Http status " + value, ex);
			errAttr.put(CbaseMiddlewareErrorAttributes.HTTP_ERROR_KEY, "Http Status " + value);
			requestAttributes.setAttribute(JAVAX_SERVLET_ERROR_STATUS_CODE, HttpStatus.INTERNAL_SERVER_ERROR.value(),
					RequestAttributes.SCOPE_REQUEST);
		}

		// no CBASE Middleware error message -> us default java servlet error message
		final String currentErrorMsg = (String) errAttr.get(ERROR_MESSAGE_KEY);
		if (currentErrorMsg == null) {
			final String errorMsg = (String) requestAttributes.getAttribute(JAVAX_SERVLET_ERROR_MESSAGE, RequestAttributes.SCOPE_REQUEST);
			if (StringUtils.isNotBlank(errorMsg)) {
				errAttr.put(ERROR_MESSAGE_KEY, errorMsg);
			}
		}

	}

	/**
	 * Adds the error message and error code from the given Throwable to the error attributes map depending on the concrete exception type.
	 * If the type is unknown to this method error message and error code will be left null.
	 *
	 * @param errorAttributes The error attributes map to be filled.
	 * @param requestAttributes The <code>WebRequest</code> object containing the servlet container request data.
	 * @return the HttpStatus determined from exceptionHandler responsibility chain.
	 */
	protected HttpStatus addErrorMessageAndCode(final Map<String, Object> errorAttributes, final WebRequest requestAttributes) {
		// get the exception
		Throwable error = getError(requestAttributes);
		if (error != null) {
			while ((error instanceof ServletException) && (error.getCause() != null)) {
				error = ((ServletException) error).getCause();
			}
		}

		return exceptionHandler.handleException(errorAttributes, error);
	}

	/**
	 * Adds the URL path that led to an error to the error attributes map.
	 *
	 * @param errorAttributes The error attributes map to be filled.
	 * @param requestAttributes The <code>RequestAttributes</code> object.
	 */
	private void addPath(final Map<String, Object> errorAttributes, final RequestAttributes requestAttributes) {
		final String path = (String) getAttribute(requestAttributes, "javax.servlet.error.request_uri");
		errorAttributes.put(CbaseMiddlewareErrorAttributes.PATH_KEY, path);
	}

	/** {@inheritDoc} */
	@Override
	public Throwable getError(final WebRequest requestAttributes) {
		Throwable exception = (Throwable) getAttribute(requestAttributes, CbaseMiddlewareErrorAttributes.ERROR_ATTRIBUTE);
		if (exception == null) {
			exception = (Throwable) getAttribute(requestAttributes, "javax.servlet.error.exception");
		}
		return exception;
	}

	/**
	 * Returns the attribute with the given name from the given <code>RequestAttributes</code> object.
	 *
	 * @param requestAttributes The <code>RequestAttributes</code> object.
	 * @param name The attribute name.
	 * @return The attribute value.
	 */
	private Object getAttribute(final RequestAttributes requestAttributes, final String name) {
		return requestAttributes.getAttribute(name, 0);
	}

	/**
	 * Log the given exception as error, inclusive stacktrace.
	 */
	@Override
	protected void logException(final Exception ex, final HttpServletRequest request) {
		final String reqInfos = RequestLoggerHandlerInterceptorAdapter.getDescription(request, null);
		logger.error(buildLogMessage(ex, request) + " \r\n " + reqInfos, ex);
	}

}
