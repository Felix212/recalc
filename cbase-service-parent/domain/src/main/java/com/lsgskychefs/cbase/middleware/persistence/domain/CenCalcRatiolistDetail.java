package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_CALC_RATIOLIST_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CALC_RATIOLIST_DETAIL")
public class CenCalcRatiolistDetail implements DomainObject, Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nratiolistDetailKey;
    @JsonIgnore
    private CenCalcRatiolist cenCalcRatiolist;
    private Long nfromPax;
    private Long ntoPax;
    private BigDecimal nquantity;
    private Date dtimestampModification;
    private Long nindexKey;

    @Id
    @Column(name = "NRATIOLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
    public long getNratiolistDetailKey() {
        return this.nratiolistDetailKey;
    }

    public void setNratiolistDetailKey(long nratiolistDetailKey) {
        this.nratiolistDetailKey = nratiolistDetailKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NRATIOLIST_KEY", nullable = false)
    public CenCalcRatiolist getCenCalcRatiolist() {
        return this.cenCalcRatiolist;
    }

    public void setCenCalcRatiolist(CenCalcRatiolist cenCalcRatiolist) {
        this.cenCalcRatiolist = cenCalcRatiolist;
    }

    @Column(name = "NFROM_PAX", nullable = false, precision = 6, scale = 0)
    public Long getNfromPax() {
        return this.nfromPax;
    }

    public void setNfromPax(Long nfromPax) {
        this.nfromPax = nfromPax;
    }

    @Column(name = "NTO_PAX", nullable = false, precision = 6, scale = 0)
    public Long getNtoPax() {
        return this.ntoPax;
    }

    public void setNtoPax(Long ntoPax) {
        this.ntoPax = ntoPax;
    }

    @Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
    public BigDecimal getNquantity() {
        return this.nquantity;
    }

    public void setNquantity(BigDecimal nquantity) {
        this.nquantity = nquantity;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
    public Date getDtimestampModification() {
        return this.dtimestampModification;
    }

    public void setDtimestampModification(Date dtimestampModification) {
        this.dtimestampModification = dtimestampModification;
    }

    @Column(name = "NINDEX_KEY", precision = 12, scale = 0)
    public Long getNindexKey() {
        return this.nindexKey;
    }

    public void setNindexKey(Long nindexKey) {
        this.nindexKey = nindexKey;
    }
}