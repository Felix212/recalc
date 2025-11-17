package com.lsgskychefs.cbase.middleware.citp.common.pojo;

/**
 * Pojo Class for the collection of seat information
 *
 * @author U185502
 */
public class SeatObject {

    // initialise seat row
    private Integer cSeatRow;

    // initialise seat column
    private String cSeatCol;

    // initialise name
    private String cName;


    /**
     * Creates the constructor with parameters
     *
     * @param cSeatRow
     * @param cSeatCol
     * @param cName
     */
    public SeatObject(Integer cSeatRow, String cSeatCol, String cName) {
        this.cSeatRow = cSeatRow;
        this.cSeatCol = cSeatCol;
        this.cName = cName;
    }

    public Integer getcSeatRow() {
        return cSeatRow;
    }

    public void setcSeatRow(Integer cSEATROW) {
        cSeatRow = cSEATROW;
    }

    public String getcSeatCol() {
        return cSeatCol;
    }

    public void setcSeatCol(String cSEATCOL) {
        cSeatCol = cSEATCOL;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cNAME) {
        cName = cNAME;
    }
}
