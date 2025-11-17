package com.lsgskychefs.cbase.middleware.citp.common.forecast.send;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.lsgskychefs.cbase.middleware.citp.utils.JsonDateSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * @author
 */
public class Request implements Serializable {

    private static final Logger LOGGER = LoggerFactory.getLogger(Request.class);

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    /** njobNr */
    @JsonProperty("cbase_id")
    private Long njobNr;

    /** ddeparture */
    @JsonProperty("departure_datetime")
    @JsonSerialize(using= JsonDateSerializer.class)
    private Date ddeparture;

    /** cairline */
    @JsonProperty("airline_iata")
    private String cairline;

    /** nflightNumber */
    @JsonProperty("flight_number")
    private Long nflightNumber;

    /** csuffix */
    @JsonProperty("suffix")
    private String csuffix;

    /** ctlcFrom */
    @JsonProperty("origin_iata")
    private String ctlcFrom;

    /** ctlcTo */
    @JsonProperty("destination_iata")
    private String ctlcTo;

    /** crouting */
    @JsonProperty("routing")
    private String crouting;

    /** cqueryPeriod */
    @JsonProperty("query_period")
    private String cqueryPeriod;

    @JsonProperty("csc")
    private int nunit;

    /** dreceived */
    @JsonProperty("query_datetime")
    @JsonSerialize(using=JsonDateSerializer.class)
    private Date dreceived;

    /** cacType */
    @JsonProperty("aircraft_type")
    private String cacType;

    /** specialMeals */
    @JsonProperty("special_meals")
    private SpecialMeals specialMeals;

    /** seats */
    private InfoClass seats;

    /** booked */
    private InfoClass booked;

    /** expected */
    private InfoClass expected;

    /** pad */
    private InfoClass pad;

    /**
     * Get seats
     *
     * @return the seats
     */
    public InfoClass getSeats() {
        return seats;
    }

    /**
     * set seats
     *
     * @param seats the seats to set
     */
    public void setSeats(final InfoClass seats) {
        this.seats = seats;
    }

    /**
     * Get booked
     *
     * @return the booked
     */
    public InfoClass getBooked() {
        return booked;
    }

    /**
     * set booked
     *
     * @param booked the booked to set
     */
    public void setBooked(final InfoClass booked) {
        this.booked = booked;
    }

    /**
     * Get expected
     *
     * @return the expected
     */
    public InfoClass getExpected() {
        return expected;
    }

    /**
     * set expected
     *
     * @param expected the expected to set
     */
    public void setExpected(final InfoClass expected) {
        this.expected = expected;
    }

    /**
     * Get pad
     *
     * @return the pad
     */
    public InfoClass getPad() {
        return pad;
    }

    /**
     * set pad
     *
     * @param pad the pad to set
     */
    public void setPad(final InfoClass pad) {
        this.pad = pad;
    }

    /**
     * Get specialMeals
     *
     * @return the specialMeals
     */
    public SpecialMeals getSpecialMeals() {
        return specialMeals;
    }

    /**
     * set specialMeals
     *
     * @param specialMeals the specialMeals to set
     */
    public void setSpecialMeals(final SpecialMeals specialMeals) {
        this.specialMeals = specialMeals;
    }

    /**
     * Get njobNr
     *
     * @return the njobNr
     */
    public Long getNjobNr() {
        return njobNr;
    }

    /**
     * set njobNr
     *
     * @param njobNr the njobNr to set
     */
    public void setNjobNr(final Long njobNr) {
        this.njobNr = njobNr;
    }

    /**
     * Get ddeparture
     *
     * @return the ddeparture
     */
    public Date getDdeparture() {
        return ddeparture;
    }

    public String getDdepartureDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyy-MM-dd");
        return dateFormat.format(ddeparture);
    }
    /**
     * set ddeparture
     *
     * @param ddeparture the ddeparture to set
     */
    public void setDdeparture(final Date ddeparture) {
        this.ddeparture = ddeparture;
    }

    /**
     * Get cairline
     *
     * @return the cairline
     */
    public String getCairline() {
        return cairline;
    }

    /**
     * set cairline
     *
     * @param cairline the cairline to set
     */
    public void setCairline(final String cairline) {
        this.cairline = cairline;
    }

    /**
     * Get nflightNumber
     *
     * @return the nflightNumber
     */
    public Long getNflightNumber() {
        return nflightNumber;
    }

    /**
     * set nflightNumber
     *
     * @param nflightNumber the nflightNumber to set
     */
    public void setNflightNumber(final Long nflightNumber) {
        this.nflightNumber = nflightNumber;
    }

    /**
     * Get csuffix
     *
     * @return the csuffix
     */
    public String getCsuffix() {
        return csuffix;
    }

    /**
     * set csuffix
     *
     * @param csuffix the csuffix to set
     */
    public void setCsuffix(final String csuffix) {
        this.csuffix = csuffix;
    }

    /**
     * Get ctlcFrom
     *
     * @return the ctlcFrom
     */
    public String getCtlcFrom() {
        return ctlcFrom;
    }

    /**
     * set ctlcFrom
     *
     * @param ctlcFrom the ctlcFrom to set
     */
    public void setCtlcFrom(final String ctlcFrom) {
        this.ctlcFrom = ctlcFrom;
    }

    /**
     * Get ctlcTo
     *
     * @return the ctlcTo
     */
    public String getCtlcTo() {
        return ctlcTo;
    }

    /**
     * set ctlcTo
     *
     * @param ctlcTo the ctlcTo to set
     */
    public void setCtlcTo(final String ctlcTo) {
        this.ctlcTo = ctlcTo;
    }

    /**
     * Get crouting
     *
     * @return the crouting
     */
    public String getCrouting() {
        return crouting;
    }

    /**
     * set crouting
     *
     * @param crouting the crouting to set
     */
    public void setCrouting(final String crouting) {
        this.crouting = crouting;
    }

    /**
     * Get cqueryPeriod
     *
     * @return the cqueryPeriod
     */
    public String getCqueryPeriod() {
        return cqueryPeriod;
    }

    /**
     * set cqueryPeriod
     *
     * @param cqueryPeriod the cqueryPeriod to set
     */
    public void setCqueryPeriod(final String cqueryPeriod) {
        this.cqueryPeriod = cqueryPeriod;
    }

    public int getNunit() {
        return nunit;
    }

    public void setNunit(int nunit) {
        this.nunit = nunit;
    }

    /**
     * Get dreceived
     *
     * @return the dreceived
     */
    public Date getDreceived() {
        return dreceived;
    }

    /**
     * set dreceived
     *
     * @param dreceived the dreceived to set
     */
    public void setDreceived(final Date dreceived) {
        this.dreceived = dreceived;
    }

    /**
     * Get cacType
     *
     * @return the cacType
     */
    public String getCacType() {
        return cacType;
    }

    /**
     * set cacType
     *
     * @param cacType the cacType to set
     */
    public void setCacType(final String cacType) {
        this.cacType = cacType;
    }

//    public void updateSent(Database db) throws MyFatalException {
//
//        String module = "[updateSent] ";
//        LOGGER.debug(module + "Entering...");
//
//        int updatedRows = 0;
//
//        SimpleDateFormat df = new SimpleDateFormat("dd:MM:yyyy HH:mm:ss");
//        String datum = df.format(new Date());
//
//        String table = "CEN_REQUEST_FC";
//
//        final String statement = "UPDATE " + table
//                + " set  "
//                + "dsent = TO_DATE(?,'DD:MM:YYYY HH24:MI:SS'), "
//                + "nstatus = ? "
//                + "WHERE njob_nr = ? ";
//
//        // Wenn beim Update/Commit etwas passiert, dann zur�ck auf LOS!
//        try {
//
//            updatedRows = db.performUpdate(statement, datum, Database.STATUS_STARTED, njobNr);
//
//        } catch (Exception e) {
//
//            String message = "Error Update Status: " + e.getMessage();
//            LOGGER.error(module + message + "...Leaving (ERROR)");
//            throw new MyFatalException(message);
//
//        }
//
//        LOGGER.debug(module + "...Leaving(SUCCESS: " + updatedRows +")");
//    }

    public String getJobInfo(){
        String sret = "Job-Nr ";
        sret = sret.concat(getNjobNr().toString());
        sret = sret.concat(" - ");
        DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        sret = sret.concat( dateFormat.format(getDdeparture()));
        sret = sret.concat("/");
        sret = sret.concat(getCairline());
        sret = sret.concat(getNflightNumber().toString());

        return sret;
    }
}
