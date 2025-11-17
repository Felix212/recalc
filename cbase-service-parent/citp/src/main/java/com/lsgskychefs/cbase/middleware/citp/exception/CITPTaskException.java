package com.lsgskychefs.cbase.middleware.citp.exception;

import org.springframework.http.HttpStatus;

/**
 * Custom Exception for handling exceptions of CITP Task
 *
 * @author U185502
 */
public class CITPTaskException extends Exception {

    private static final long serialVersionUID = 1L;

    public CITPTaskException(String msg) {
        super(msg);
    }

    public CITPTaskException(String type, String message) {
        super(type + " - " + message);
    }

    public CITPTaskException(com.lsgskychefs.cbase.middleware.citp.rest.handlers.ComAppCITPException.ComAppCITPExceptionType type, String message) {
        super(type.name() + " - " + message);
    }

    public static enum ComAppCITPExceptionType {
        NOT_FOUND(HttpStatus.NOT_FOUND),
        BAD_REQUEST(HttpStatus.BAD_REQUEST);

        private HttpStatus status;

        private ComAppCITPExceptionType(HttpStatus status) {
            this.status = status;
        }

        public HttpStatus getStatus() {
            return this.status;
        }
    }
}
