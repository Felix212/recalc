package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Feb-2025 17:50:19 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_MOP_MASTER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MOP_MASTER")
public class CenMopMaster implements DomainObject, java.io.Serializable {

    private long nmopKey;
    private CenHandling cenHandlingByNhandlingKeyConc;
    private CenHandling cenHandlingByNhandlingKey;
    private CenAirlines cenAirlines;
    private SysLogin sysLogin;
    private CenClassName cenClassName;
    private CenRotations cenRotations;
    private Long npictureIndexKey;
    private Date dvalidFrom;
    private Date dvalidTo;
    private int nask4passenger;
    private String cquestionText;
    private int nplanningPercent;
    private String ctext;
    private int nstatusIkit;
    private int nstatusPortal;
    private int nmopType;
    private int nactive;
    private int nconcChange;
    private Date dtimestamp;
    private Date dtimestampMzdef;
    private Long ndefaultAccountKey;
    private int nservice;
    private int nethnic;
    private int nexportFlag;
    private Date ddateExport;

    @Id
    @Column(name = "NMOP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNmopKey() {
        return this.nmopKey;
    }

    public void setNmopKey(long nmopKey) {
        this.nmopKey = nmopKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NHANDLING_KEY_CONC", nullable = false)
    public CenHandling getCenHandlingByNhandlingKeyConc() {
        return this.cenHandlingByNhandlingKeyConc;
    }

    public void setCenHandlingByNhandlingKeyConc(CenHandling cenHandlingByNhandlingKeyConc) {
        this.cenHandlingByNhandlingKeyConc = cenHandlingByNhandlingKeyConc;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NHANDLING_KEY", nullable = false)
    public CenHandling getCenHandlingByNhandlingKey() {
        return this.cenHandlingByNhandlingKey;
    }

    public void setCenHandlingByNhandlingKey(CenHandling cenHandlingByNhandlingKey) {
        this.cenHandlingByNhandlingKey = cenHandlingByNhandlingKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NAIRLINE_KEY", nullable = false)
    public CenAirlines getCenAirlines() {
        return this.cenAirlines;
    }

    public void setCenAirlines(CenAirlines cenAirlines) {
        this.cenAirlines = cenAirlines;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NUSER_ID")
    public SysLogin getSysLogin() {
        return this.sysLogin;
    }

    public void setSysLogin(SysLogin sysLogin) {
        this.sysLogin = sysLogin;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumns({
            @JoinColumn(name = "NAIRLINE_KEY", referencedColumnName = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false),
            @JoinColumn(name = "CCLASS", referencedColumnName = "CCLASS", nullable = false, insertable = false, updatable = false)
    })
    public CenClassName getCenClassName() {
        return this.cenClassName;
    }

    public void setCenClassName(CenClassName cenClassName) {
        this.cenClassName = cenClassName;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NROTATION_KEY", nullable = false)
    public CenRotations getCenRotations() {
        return this.cenRotations;
    }

    public void setCenRotations(CenRotations cenRotations) {
        this.cenRotations = cenRotations;
    }

    @Column(name = "NPICTURE_INDEX_KEY", precision = 12, scale = 0)
    public Long getNpictureIndexKey() {
        return this.npictureIndexKey;
    }

    public void setNpictureIndexKey(Long npictureIndexKey) {
        this.npictureIndexKey = npictureIndexKey;
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

    @Column(name = "NASK4PASSENGER", nullable = false, precision = 1, scale = 0)
    public int getNask4passenger() {
        return this.nask4passenger;
    }

    public void setNask4passenger(int nask4passenger) {
        this.nask4passenger = nask4passenger;
    }

    @Column(name = "CQUESTION_TEXT", length = 40)
    public String getCquestionText() {
        return this.cquestionText;
    }

    public void setCquestionText(String cquestionText) {
        this.cquestionText = cquestionText;
    }

    @Column(name = "NPLANNING_PERCENT", nullable = false, precision = 3, scale = 0)
    public int getNplanningPercent() {
        return this.nplanningPercent;
    }

    public void setNplanningPercent(int nplanningPercent) {
        this.nplanningPercent = nplanningPercent;
    }

    @Column(name = "CTEXT", length = 40)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(String ctext) {
        this.ctext = ctext;
    }

    @Column(name = "NSTATUS_IKIT", nullable = false, precision = 1, scale = 0)
    public int getNstatusIkit() {
        return this.nstatusIkit;
    }

    public void setNstatusIkit(int nstatusIkit) {
        this.nstatusIkit = nstatusIkit;
    }

    @Column(name = "NSTATUS_PORTAL", nullable = false, precision = 1, scale = 0)
    public int getNstatusPortal() {
        return this.nstatusPortal;
    }

    public void setNstatusPortal(int nstatusPortal) {
        this.nstatusPortal = nstatusPortal;
    }

    @Column(name = "NMOP_TYPE", nullable = false, precision = 1, scale = 0)
    public int getNmopType() {
        return this.nmopType;
    }

    public void setNmopType(int nmopType) {
        this.nmopType = nmopType;
    }

    @Column(name = "NACTIVE", nullable = false, precision = 1, scale = 0)
    public int getNactive() {
        return this.nactive;
    }

    public void setNactive(int nactive) {
        this.nactive = nactive;
    }

    @Column(name = "NCONC_CHANGE", nullable = false, precision = 1, scale = 0)
    public int getNconcChange() {
        return this.nconcChange;
    }

    public void setNconcChange(int nconcChange) {
        this.nconcChange = nconcChange;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP", length = 7)
    public Date getDtimestamp() {
        return this.dtimestamp;
    }

    public void setDtimestamp(Date dtimestamp) {
        this.dtimestamp = dtimestamp;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP_MZDEF", length = 7)
    public Date getDtimestampMzdef() {
        return this.dtimestampMzdef;
    }

    public void setDtimestampMzdef(Date dtimestampMzdef) {
        this.dtimestampMzdef = dtimestampMzdef;
    }

    @Column(name = "NDEFAULT_ACCOUNT_KEY", precision = 12, scale = 0)
    public Long getNdefaultAccountKey() {
        return this.ndefaultAccountKey;
    }

    public void setNdefaultAccountKey(Long ndefaultAccountKey) {
        this.ndefaultAccountKey = ndefaultAccountKey;
    }

    @Column(name = "NSERVICE", nullable = false, precision = 1, scale = 0)
    public int getNservice() {
        return this.nservice;
    }

    public void setNservice(int nservice) {
        this.nservice = nservice;
    }

    @Column(name = "NETHNIC", nullable = false, precision = 1, scale = 0)
    public int getNethnic() {
        return this.nethnic;
    }

    public void setNethnic(int nethnic) {
        this.nethnic = nethnic;
    }

    @Column(name = "NEXPORT_FLAG", nullable = false, precision = 1, scale = 0)
    public int getNexportFlag() {
        return this.nexportFlag;
    }

    public void setNexportFlag(int nexportFlag) {
        this.nexportFlag = nexportFlag;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DDATE_EXPORT", length = 7)
    public Date getDdateExport() {
        return this.ddateExport;
    }

    public void setDdateExport(Date ddateExport) {
        this.ddateExport = ddateExport;
    }

}
