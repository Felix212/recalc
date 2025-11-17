package com.lsgskychefs.cbase.middleware.citp.rest.handlers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class ComAppCITPException extends Exception {

    /**
     * serial version uid
     */
    private static final long serialVersionUID = 1521997802285429392L;
    /**
     * type/reason of exception
     */
    private final ComAppCITPExceptionType type;

    /**
     * Public constructor taking message and throwable.
     *
     * @param type    the exception reason
     * @param message the message
     */
    public ComAppCITPException(final ComAppCITPExceptionType type, final String message) {
        super(type.name() + " - " + message);
        this.type = type;

    }

    /**
     * @return the type
     */
    public ComAppCITPExceptionType getType() {
        return type;
    }

    public enum ComAppCITPExceptionType {

        /**
         * not a known record
         */
        NOT_FOUND(HttpStatus.NOT_FOUND),

        BAD_REQUEST(HttpStatus.BAD_REQUEST);

        /**
         * build http status
         */
        private HttpStatus status;

        ComAppCITPExceptionType(final HttpStatus status) {
            this.status = status;
        }

        /**
         * @return the status
         */
        public HttpStatus getStatus() {
            return status;
        }

    }

}