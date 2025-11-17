package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_CALC_RATIOLIST_CAT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CALC_RATIOLIST_CAT")
public class CenCalcRatiolistCat implements DomainObject, Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nratiolistCatKey;
    private long ncustomerKey;
    private String ctext;
    private Date dvalidFrom;
    private Date dvalidTo;
    private Date dtimestampModification;
    private Long nskyscopeFlag = 0L;
    
    @JsonIgnore
    private Set<CenCalcRatiolist> cenCalcRatiolists = new HashSet<>(0);

    public CenCalcRatiolistCat() {
    }

    @Id
    @Column(name = "NRATIOLIST_CAT_KEY", nullable = false, precision = 12, scale = 0)
    public long getNratiolistCatKey() {
        return this.nratiolistCatKey;
    }

    public void setNratiolistCatKey(long nratiolistCatKey) {
        this.nratiolistCatKey = nratiolistCatKey;
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

    @Column(name = "NSKYSCOPE_FLAG", nullable = false, precision = 1, scale = 0)
    public Long getNskyscopeFlag() {
        return this.nskyscopeFlag;
    }

    public void setNskyscopeFlag(Long nskyscopeFlag) {
        this.nskyscopeFlag = nskyscopeFlag;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenCalcRatiolistCat")
    public Set<CenCalcRatiolist> getCenCalcRatiolists() {
        return this.cenCalcRatiolists;
    }

    public void setCenCalcRatiolists(Set<CenCalcRatiolist> cenCalcRatiolists) {
        this.cenCalcRatiolists = cenCalcRatiolists;
    }
}