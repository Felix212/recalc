package com.lsgskychefs.cbase.middleware.citp.exception;

import java.util.HashMap;
import java.util.Map;

import com.dlh.zambas.mw.exception.MiddlewareException;
import com.google.common.base.Optional;

public class AmadeusRequestException extends Exception {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** The type to define(describe the reason) for exception. */
	public enum AmadeusRequestExceptionType {
		/**
		 * During communication the sequence number in the SOAP headers is incremented
		 * logically. When running as threads in a non thread-safe manner this could be
		 * messed up potentially
		 */
		ILLOGICAL_CONVERSATION(93, "Session|Illogical conversation", true),

		UNKNOWN(null, "UNKNOWN ERROR", true);

		/** assigned error code */
		private Integer errorCode;

		private String description;

		private boolean retryOnOccurrence;
		/**
		 * Contains mapping between the long value and
		 * {@link AmadeusRequestExceptionType}
		 */
		private static Map<Integer, AmadeusRequestExceptionType> map;

		static {
			map = new HashMap<>();
			for (final AmadeusRequestExceptionType label : AmadeusRequestExceptionType.values()) {
				map.put(label.errorCode, label);
			}
		}

		/**
		 * Constructor
		 *
		 * @param errorCode error code for this exception type.
		 */
		AmadeusRequestExceptionType(final Integer errorCode, final String description,
				final boolean retryOnOccurrence) {
			this.errorCode = errorCode;
			this.description = description;
			this.retryOnOccurrence = retryOnOccurrence;
		}

		/**
		 * Get errorCode
		 *
		 * @return the errorCode
		 */
		public Integer getErrorCode() {
			return this.errorCode;
		}

		public String getDescription() {
			return this.description;
		}

		public boolean isRetryOnOccurrence() {
			return this.retryOnOccurrence;
		}

		public static AmadeusRequestExceptionType getEnum(final Integer errorCode) {
			return Optional.fromNullable(map.get(errorCode)).or(AmadeusRequestExceptionType.UNKNOWN);
		}

		public static AmadeusRequestExceptionType getEnum(final String errorCode) {
			final String withoutWhitespace = errorCode.replaceAll("\\s", "");
			if (withoutWhitespace.matches("-?\\d+")) { // any positive or negetive integer or not!
				return getEnum(Integer.valueOf(withoutWhitespace));
			} else {
				return AmadeusRequestExceptionType.UNKNOWN;
			}

		}

		public static boolean is(final MiddlewareException exception, final AmadeusRequestExceptionType type) {
			return exception.getErrorCode() != null && getEnum(exception.getErrorCode()).equals(type);
		}
	}

	/** type/reason of Exception */
	private final AmadeusRequestExceptionType type;

	/**
	 * Public constructor taking message and throwable.
	 *
	 * @param type     the exception reason
	 * @param message  the message
	 * @param original the original throwable.
	 */
	public AmadeusRequestException(final AmadeusRequestExceptionType type, final String message,
			final Throwable original) {
		super(type.name() + " - " + message, original);
		this.type = type;
	}

	/**
	 * Public constructor taking message and throwable.
	 *
	 * @param type    the exception reason
	 * @param message the message
	 */
	public AmadeusRequestException(final AmadeusRequestExceptionType type, final String message) {
		super(type.name() + " - " + message);
		this.type = type;
	}

	/**
	 * Get the exception type(reason).
	 *
	 * @return the type(reason) of current exception
	 */
	public AmadeusRequestExceptionType getType() {
		return type;
	}

}
