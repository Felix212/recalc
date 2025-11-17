package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 10, 2025 3:00:23 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_MG_CYCLE_VERSION
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_MG_CYCLE_VERSION"
)

public class CenMgCycleVersion implements DomainObject, java.io.Serializable {

    private long nmgCycleVersionKey;
    private CenMpMenugrid cenMpMenugrid;
    private CenMpMenugridCycle cenMpMenugridCycle;
    private String cname;
    private long nsort;
    private long nversionNumber;
    private Date dtimestamp;
    private Date dcreatedOn;
    private String ccreatedBy;
    private Date dupdatedOn;
    private String cupdatedBy;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MG_CYCLE_VERSION")
    @SequenceGenerator(name = "SEQ_CEN_MG_CYCLE_VERSION", sequenceName = "SEQ_CEN_MG_CYCLE_VERSION", allocationSize = 1)
    @Column(name="NMG_CYCLE_VERSION_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmgCycleVersionKey() {
        return this.nmgCycleVersionKey;
    }

    public void setNmgCycleVersionKey(long nmgCycleVersionKey) {
        this.nmgCycleVersionKey = nmgCycleVersionKey;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMP_MENUGRID_KEY", nullable=false)
    public CenMpMenugrid getCenMpMenugrid() {
        return this.cenMpMenugrid;
    }

    public void setCenMpMenugrid(CenMpMenugrid cenMpMenugrid) {
        this.cenMpMenugrid = cenMpMenugrid;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMP_MENUGRID_CYCLE_KEY", nullable=false)
    public CenMpMenugridCycle getCenMpMenugridCycle() {
        return this.cenMpMenugridCycle;
    }

    public void setCenMpMenugridCycle(CenMpMenugridCycle cenMpMenugridCycle) {
        this.cenMpMenugridCycle = cenMpMenugridCycle;
    }


    @Column(name="CNAME", length=256)
    public String getCname() {
        return this.cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }


    @Column(name="NSORT", nullable=false, precision=12, scale=0)
    public long getNsort() {
        return this.nsort;
    }

    public void setNsort(long nsort) {
        this.nsort = nsort;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DCREATED_ON", length=7)
    public Date getDcreatedOn() {
        return this.dcreatedOn;
    }

    public void setDcreatedOn(Date dcreatedOn) {
        this.dcreatedOn = dcreatedOn;
    }


    @Column(name="CCREATED_BY", length=40)
    public String getCcreatedBy() {
        return this.ccreatedBy;
    }

    public void setCcreatedBy(String ccreatedBy) {
        this.ccreatedBy = ccreatedBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DUPDATED_ON", length=7)
    public Date getDupdatedOn() {
        return this.dupdatedOn;
    }

    public void setDupdatedOn(Date dupdatedOn) {
        this.dupdatedOn = dupdatedOn;
    }


    @Column(name="CUPDATED_BY", length=40)
    public String getCupdatedBy() {
        return this.cupdatedBy;
    }

    public void setCupdatedBy(String cupdatedBy) {
        this.cupdatedBy = cupdatedBy;
    }


    @Column(name="NVERSION_NUMBER", nullable=false, precision=12, scale=0)
    public long getNversionNumber() {
        return this.nversionNumber;
    }

    public void setNversionNumber(long nversionNumber) {
        this.nversionNumber = nversionNumber;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DTIMESTAMP", nullable=false, length=7)
    public Date getDtimestamp() {
        return this.dtimestamp;
    }

    public void setDtimestamp(Date dtimestamp) {
        this.dtimestamp = dtimestamp;
    }

}


