package com.lsgskychefs.cbase.middleware.citp.common.pojo;

import lombok.Data;

/**
 * Pojo Class for the collection of special meals information
 *
 * @author U185502
 */
@Data
public class SpmlObject {

    // initialise quantity
    private int nquantity;

    // initialise class
    private String cclass;

    // initialise spml
    private String cspml;

    // initialise class number
    private int nClassNumber;

    // initialise class
    private String cClass;

    // initialise text
    private String caddText;

    // initialise comment
    private String ccomment;

    // initialise name
    private String cname;

    // initialise status
    private String cStatus = "";

}
