package com.lsgskychefs.cbase.middleware.citp.pool.amadeus;

import com.dlh.zambas.mw.client.Context;

public interface AmadeusConnectionInterface {
	/**
	 * @return get id
	 */
	String getID();

	/**
	 * @return get call id
	 */
	String getCallId();

	/**
	 * @return get caller id
	 */
	String getCallerID();

	/**
	 * @return get client context
	 */
	Context getClientContext();

	public <T, S> T initializeAmadeusService(final Class<T> targetClass, final Class<S> clazz);

	public void traceSoapHeaders(String phase);

	public boolean isSessionExpired();

	public void refreshContext();
}
