package com.lsgskychefs.cbase.middleware.citp.pool.amadeus;

import java.rmi.RemoteException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dlh.zambas.mw.exception.MiddlewareException;
import com.lsgskychefs.cbase.middleware.citp.exception.AmadeusRequestException.AmadeusRequestExceptionType;

public abstract class AmadeusConversationHelper {
	private static final Logger LOGGER = LoggerFactory.getLogger(AmadeusConversationHelper.class);

	/**
	 * Common exception handling for all amadeus service requests. For specific
	 * errors during requests it gonna retry!
	 * 
	 * @param maxRetries - max number to retry if failed e.g. due to Session
	 * @param request
	 * @return
	 */
	public static <T> T process(final int maxRetries, final AmadeusConversation<T> request) {
		try {
			return request.execute();
		} catch (final RemoteException e) {
			LOGGER.error("Conversation failed due to RemoteException: {}", e);
			return null;
		} catch (final MiddlewareException e) {
			final AmadeusRequestExceptionType exception = AmadeusRequestExceptionType.getEnum(e.getErrorCode());
			if (exception.isRetryOnOccurrence()) {
				if (maxRetries > 0) {
					LOGGER.info("retrying due to: {}", e.getErrorDescription(), e);
					return process(maxRetries - 1, request);
				} else {
					LOGGER.error("Amadeus service call failed -> too many retries!", e);
					request.onMaxRetryFailed();
				}

			} else {
				LOGGER.error("Conversation failed due to MiddlewareException: {}", e);

			}
			return null;
		}
	}
}