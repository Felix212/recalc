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
 * Entity(DomainObject) for table CEN_MG_VERSION
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_MG_VERSION"
)
public class CenMgVersion  implements DomainObject, java.io.Serializable {

    private long nmgVersionKey;
    private CenMpMenugrid cenMpMenugrid;
    private CenMpProject cenMpProject;
    private CenAirlines cenAirlines;
    private CenFollowUpMaster cenFollowUpMaster;
    private SysMpMgStatus sysMpMgStatus;
    private CenMpService cenMpService;
    private String cname;
    private String cclass;
    private long ncycleno;
    private String cdescription;
    private Date dcreatedOn;
    private String ccreatedBy;
    private Date dupdatedOn;
    private String cupdatedBy;
    private Long nserviceNumber;
    private long nversionNumber;
    private Date dtimestamp;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MG_VERSION")
    @SequenceGenerator(name = "SEQ_CEN_MG_VERSION", sequenceName = "SEQ_CEN_MG_VERSION", allocationSize = 1)
    @Column(name="NMG_VERSION_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmgVersionKey() {
        return this.nmgVersionKey;
    }

    public void setNmgVersionKey(long nmgVersionKey) {
        this.nmgVersionKey = nmgVersionKey;
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
    @JoinColumn(name="NMP_PROJECT_KEY", nullable=false)
    public CenMpProject getCenMpProject() {
        return this.cenMpProject;
    }

    public void setCenMpProject(CenMpProject cenMpProject) {
        this.cenMpProject = cenMpProject;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NAIRLINE_KEY", nullable=false)
    public CenAirlines getCenAirlines() {
        return this.cenAirlines;
    }

    public void setCenAirlines(CenAirlines cenAirlines) {
        this.cenAirlines = cenAirlines;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NFOLLOW_UP_MASTER_KEY")
    public CenFollowUpMaster getCenFollowUpMaster() {
        return this.cenFollowUpMaster;
    }

    public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
        this.cenFollowUpMaster = cenFollowUpMaster;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMP_MG_STATUS_KEY")
    public SysMpMgStatus getSysMpMgStatus() {
        return this.sysMpMgStatus;
    }

    public void setSysMpMgStatus(SysMpMgStatus sysMpMgStatus) {
        this.sysMpMgStatus = sysMpMgStatus;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMP_SERVICE_KEY")
    public CenMpService getCenMpService() {
        return this.cenMpService;
    }

    public void setCenMpService(CenMpService cenMpService) {
        this.cenMpService = cenMpService;
    }


    @Column(name="CNAME", nullable=false, length=256)
    public String getCname() {
        return this.cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }


    @Column(name="CCLASS", nullable=false, length=256)
    public String getCclass() {
        return this.cclass;
    }

    public void setCclass(String cclass) {
        this.cclass = cclass;
    }


    @Column(name="NCYCLENO", nullable=false, precision=12, scale=0)
    public long getNcycleno() {
        return this.ncycleno;
    }

    public void setNcycleno(long ncycleno) {
        this.ncycleno = ncycleno;
    }


    @Column(name="CDESCRIPTION", nullable=false, length=512)
    public String getCdescription() {
        return this.cdescription;
    }

    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
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


    @Column(name="NSERVICE_NUMBER", precision=12, scale=0)
    public Long getNserviceNumber() {
        return this.nserviceNumber;
    }

    public void setNserviceNumber(Long nserviceNumber) {
        this.nserviceNumber = nserviceNumber;
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


