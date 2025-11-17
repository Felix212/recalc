package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14.07.2021 14:08:48 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_CLASS_FORECAST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_CLASS_FORECAST"
)
public class LocClassForecast implements DomainObject, java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private LocClassForecastId id;
    private CenAirlines cenAirlines;
    private CenRouting cenRouting;
    private Date dvalidTo;
    private BigDecimal nloadFactorFreq1;
    private BigDecimal nloadFactorFreq2;
    private BigDecimal nloadFactorFreq3;
    private BigDecimal nloadFactorFreq4;
    private BigDecimal nloadFactorFreq5;
    private BigDecimal nloadFactorFreq6;
    private BigDecimal nloadFactorFreq7;
    private String ctimeTo;

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
            @AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "cclass", column = @Column(name = "CCLASS", nullable = false, length = 10)),
            @AttributeOverride(name = "nroutingId", column = @Column(name = "NROUTING_ID", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)),
            @AttributeOverride(name = "ctimeFrom", column = @Column(name = "CTIME_FROM", nullable = false, length = 5))})
    public LocClassForecastId getId() {
        return this.id;
    }

    public void setId(LocClassForecastId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
    public CenAirlines getCenAirlines() {
        return this.cenAirlines;
    }

    public void setCenAirlines(CenAirlines cenAirlines) {
        this.cenAirlines = cenAirlines;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NROUTING_ID", nullable = false, insertable = false, updatable = false)
    public CenRouting getCenRouting() {
        return this.cenRouting;
    }

    public void setCenRouting(CenRouting cenRouting) {
        this.cenRouting = cenRouting;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DVALID_TO", nullable = false, length = 7)
    public Date getDvalidTo() {
        return this.dvalidTo;
    }

    public void setDvalidTo(Date dvalidTo) {
        this.dvalidTo = dvalidTo;
    }


    @Column(name = "NLOAD_FACTOR_FREQ1", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq1() {
        return this.nloadFactorFreq1;
    }

    public void setNloadFactorFreq1(BigDecimal nloadFactorFreq1) {
        this.nloadFactorFreq1 = nloadFactorFreq1;
    }


    @Column(name = "NLOAD_FACTOR_FREQ2", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq2() {
        return this.nloadFactorFreq2;
    }

    public void setNloadFactorFreq2(BigDecimal nloadFactorFreq2) {
        this.nloadFactorFreq2 = nloadFactorFreq2;
    }


    @Column(name = "NLOAD_FACTOR_FREQ3", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq3() {
        return this.nloadFactorFreq3;
    }

    public void setNloadFactorFreq3(BigDecimal nloadFactorFreq3) {
        this.nloadFactorFreq3 = nloadFactorFreq3;
    }


    @Column(name = "NLOAD_FACTOR_FREQ4", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq4() {
        return this.nloadFactorFreq4;
    }

    public void setNloadFactorFreq4(BigDecimal nloadFactorFreq4) {
        this.nloadFactorFreq4 = nloadFactorFreq4;
    }


    @Column(name = "NLOAD_FACTOR_FREQ5", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq5() {
        return this.nloadFactorFreq5;
    }

    public void setNloadFactorFreq5(BigDecimal nloadFactorFreq5) {
        this.nloadFactorFreq5 = nloadFactorFreq5;
    }


    @Column(name = "NLOAD_FACTOR_FREQ6", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq6() {
        return this.nloadFactorFreq6;
    }

    public void setNloadFactorFreq6(BigDecimal nloadFactorFreq6) {
        this.nloadFactorFreq6 = nloadFactorFreq6;
    }


    @Column(name = "NLOAD_FACTOR_FREQ7", nullable = false, precision = 6)
    public BigDecimal getNloadFactorFreq7() {
        return this.nloadFactorFreq7;
    }

    public void setNloadFactorFreq7(BigDecimal nloadFactorFreq7) {
        this.nloadFactorFreq7 = nloadFactorFreq7;
    }


    @Column(name = "CTIME_TO", length = 5)
    public String getCtimeTo() {
        return this.ctimeTo;
    }

    public void setCtimeTo(String ctimeTo) {
        this.ctimeTo = ctimeTo;
    }
}


