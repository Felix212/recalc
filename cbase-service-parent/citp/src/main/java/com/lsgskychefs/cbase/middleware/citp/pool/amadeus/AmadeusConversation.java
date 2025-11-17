package com.lsgskychefs.cbase.middleware.citp.pool.amadeus;

import java.rmi.RemoteException;

import com.dlh.zambas.mw.exception.MiddlewareException;

public interface AmadeusConversation<T> {
	public T execute() throws RemoteException, MiddlewareException;

	public void onMaxRetryFailed();
}
