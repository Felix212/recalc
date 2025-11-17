package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_CALC_RATIOLIST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CALC_RATIOLIST")
public class CenCalcRatiolist implements DomainObject, Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nratiolistKey;
    private String cclient;
    @JsonIgnore
    private SysCalculator sysCalculator;
    private long ncustomerKey;
    private String ctext;
    private Date dvalidFrom;
    private Date dvalidTo;
    private Date dtimestampModification;
    private Long nownerId;
    private Long nratiolistType;
    private Long nreplaceText = 0L;
    private String cshortName;
    private CenCalcRatiolistCat cenCalcRatiolistCat;
    private Long nmaxLoadVersion = 0L;
    private Long noldRatiolist;
    private BigDecimal ncpcPercentage = new BigDecimal(0);
    private Long considerSpml = 1L;
    
    private List<CenCalcRatiolistDetail> cenCalcRatiolistDetails = new ArrayList<>(0);

    @Id
    @Column(name = "NRATIOLIST_KEY", nullable = false, precision = 12, scale = 0)
    public long getNratiolistKey() {
        return this.nratiolistKey;
    }

    public void setNratiolistKey(long nratiolistKey) {
        this.nratiolistKey = nratiolistKey;
    }

    @Column(name = "CCLIENT", nullable = false, length = 3)
    public String getCclient() {
        return this.cclient;
    }

    public void setCclient(String cclient) {
        this.cclient = cclient;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NCALC_ID", nullable = false)
    public SysCalculator getSysCalculator() {
        return this.sysCalculator;
    }

    public void setSysCalculator(SysCalculator sysCalculator) {
        this.sysCalculator = sysCalculator;
    }

    @Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
    public long getNcustomerKey() {
        return this.ncustomerKey;
    }

    public void setNcustomerKey(long ncustomerKey) {
        this.ncustomerKey = ncustomerKey;
    }

    @Column(name = "CTEXT", nullable = false, length = 60)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(String ctext) {
        this.ctext = ctext;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DVALID_FROM", nullable = false, length = 7)
    public Date getDvalidFrom() {
        return this.dvalidFrom;
    }

    public void setDvalidFrom(Date dvalidFrom) {
        this.dvalidFrom = dvalidFrom;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DVALID_TO", nullable = false, length = 7)
    public Date getDvalidTo() {
        return this.dvalidTo;
    }

    public void setDvalidTo(Date dvalidTo) {
        this.dvalidTo = dvalidTo;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
    public Date getDtimestampModification() {
        return this.dtimestampModification;
    }

    public void setDtimestampModification(Date dtimestampModification) {
        this.dtimestampModification = dtimestampModification;
    }

    @Column(name = "NOWNER_ID", precision = 5, scale = 0)
    public Long getNownerId() {
        return this.nownerId;
    }

    public void setNownerId(Long nownerId) {
        this.nownerId = nownerId;
    }

    @Column(name = "NRATIOLIST_TYPE", precision = 1, scale = 0)
    public Long getNratiolistType() {
        return this.nratiolistType;
    }

    public void setNratiolistType(Long nratiolistType) {
        this.nratiolistType = nratiolistType;
    }

    @Column(name = "NREPLACE_TEXT", precision = 1, scale = 0)
    public Long getNreplaceText() {
        return this.nreplaceText;
    }

    public void setNreplaceText(Long nreplaceText) {
        this.nreplaceText = nreplaceText;
    }

    @Column(name = "CSHORT_NAME", length = 10)
    public String getCshortName() {
        return this.cshortName;
    }

    public void setCshortName(String cshortName) {
        this.cshortName = cshortName;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NRATIOLIST_CAT_KEY")
    public CenCalcRatiolistCat getCenCalcRatiolistCat() {
        return this.cenCalcRatiolistCat;
    }

    public void setCenCalcRatiolistCat(CenCalcRatiolistCat cenCalcRatiolistCat) {
        this.cenCalcRatiolistCat = cenCalcRatiolistCat;
    }

    @Column(name = "NMAX_LOAD_VERSION", precision = 1, scale = 0)
    public Long getNmaxLoadVersion() {
        return this.nmaxLoadVersion;
    }

    public void setNmaxLoadVersion(Long nmaxLoadVersion) {
        this.nmaxLoadVersion = nmaxLoadVersion;
    }

    @Column(name = "NOLD_RATIOLIST", precision = 12, scale = 0)
    public Long getNoldRatiolist() {
        return this.noldRatiolist;
    }

    public void setNoldRatiolist(Long noldRatiolist) {
        this.noldRatiolist = noldRatiolist;
    }

    @Column(name = "NCPC_PERCENTAGE", precision = 12, scale = 4)
    public BigDecimal getNcpcPercentage() {
        return this.ncpcPercentage;
    }

    public void setNcpcPercentage(BigDecimal ncpcPercentage) {
        this.ncpcPercentage = ncpcPercentage;
    }

    @Column(name = "CONSIDER_SPML", precision = 1, scale = 0)
    public Long getConsiderSpml() {
        return this.considerSpml;
    }

    public void setConsiderSpml(Long considerSpml) {
        this.considerSpml = considerSpml;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenCalcRatiolist")
    @OrderBy("nfromPax ASC")
    public List<CenCalcRatiolistDetail> getCenCalcRatiolistDetails() {
        return this.cenCalcRatiolistDetails;
    }

    public void setCenCalcRatiolistDetails(List<CenCalcRatiolistDetail> cenCalcRatiolistDetails) {
        this.cenCalcRatiolistDetails = cenCalcRatiolistDetails;
    }
}