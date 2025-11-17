package com.lsgskychefs.cbase.middleware.citp.exception;

import com.lsgskychefs.cbase.middleware.citp.rest.handlers.ComAppCITPException;

/**
 * Custom Exception for handling exceptions of CITP functional task
 *
 * @author U185502
 */
public class CITPTaskFunctionalException extends Exception {

    private static final long serialVersionUID = 1L;

    private String myErrorID = "";
    private String myErrorMessage = "Not Set";

    public CITPTaskFunctionalException(final String msg, String aErrorID) {
        super(msg);
        myErrorID = aErrorID;
        myErrorMessage = msg;
    }
    
    public CITPTaskFunctionalException(final String msg, String aErrorID, String aErrorText) {
        super(msg);
        myErrorID = aErrorID;
        setMyErrorMessage(aErrorText);
    }
    
    public String getErrorID() {
        return myErrorID;
    }

    @Override
    public String toString() {
        return super.toString() + "   Error-ID: " + myErrorID;
    }

    public CITPTaskFunctionalException(ComAppCITPException.ComAppCITPExceptionType type, String message) {
        super(type.name() + " - " + message);
    }

	public String getMyErrorMessage() {
		return myErrorMessage;
	}

	public void setMyErrorMessage(String myErrorMessage) {
		this.myErrorMessage = myErrorMessage;
	}


}