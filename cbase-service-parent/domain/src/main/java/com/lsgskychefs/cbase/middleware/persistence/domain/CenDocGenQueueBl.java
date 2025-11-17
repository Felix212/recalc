package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 18, 2018 3:37:46 PM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_QUEUE_BL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_QUEUE_BL"
)
public class CenDocGenQueueBl implements DomainObject, java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long ndocGenQueueBl;
    private Integer ngenStatus;
    private Date dtimestamp;
    private Date djobStart;
    private Date djobEnd;
    private String cviewunit;
    private String clabeltype;
    private String cinstance;
    private Date ddeparture;
    private Integer njobType;
    private Integer nuserId;
    private String cusername;
    private String cworkstationfilter;
    private Integer nprocessStatus;
    private String csvcDatabase;
    private String csvcTerminal;
    private String csvcModule;
    private Set<CenDocGenBlData> cenDocGenBlDatas = new HashSet<>(0);

    @Id
    @Column(name = "NDOC_GEN_QUEUE_BL", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNdocGenQueueBl() {
        return this.ndocGenQueueBl;
    }

    public void setNdocGenQueueBl(long ndocGenQueueBl) {
        this.ndocGenQueueBl = ndocGenQueueBl;
    }

    @Column(name = "NGEN_STATUS", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
    public Integer getNgenStatus() {
        return this.ngenStatus;
    }

    public void setNgenStatus(Integer ngenStatus) {
        this.ngenStatus = ngenStatus;
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
    @Column(name = "DJOB_START", length = 7)
    public Date getDjobStart() {
        return this.djobStart;
    }

    public void setDjobStart(Date djobStart) {
        this.djobStart = djobStart;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DJOB_END", length = 7)
    public Date getDjobEnd() {
        return this.djobEnd;
    }

    public void setDjobEnd(Date djobEnd) {
        this.djobEnd = djobEnd;
    }

    @Column(name = "CVIEWUNIT", length = 10)
    public String getCviewunit() {
        return this.cviewunit;
    }

    public void setCviewunit(String cviewunit) {
        this.cviewunit = cviewunit;
    }

    @Column(name = "CLABELTYPE", length = 14)
    public String getClabeltype() {
        return this.clabeltype;
    }

    public void setClabeltype(String clabeltype) {
        this.clabeltype = clabeltype;
    }

    @Column(name = "CINSTANCE", length = 80)
    public String getCinstance() {
        return this.cinstance;
    }

    public void setCinstance(String cinstance) {
        this.cinstance = cinstance;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DDEPARTURE", length = 7)
    public Date getDdeparture() {
        return this.ddeparture;
    }

    public void setDdeparture(Date ddeparture) {
        this.ddeparture = ddeparture;
    }

    @Column(name = "NJOB_TYPE", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 1")
    public Integer getNjobType() {
        return this.njobType;
    }

    public void setNjobType(Integer njobType) {
        this.njobType = njobType;
    }

    @Column(name = "NUSER_ID", precision = 5, scale = 0)
    public Integer getNuserId() {
        return this.nuserId;
    }

    public void setNuserId(Integer nuserId) {
        this.nuserId = nuserId;
    }

    @Column(name = "CUSERNAME", length = 40)
    public String getCusername() {
        return this.cusername;
    }

    public void setCusername(String cusername) {
        this.cusername = cusername;
    }

    @Column(name = "CWORKSTATIONFILTER", length = 4000)
    public String getCworkstationfilter() {
        return this.cworkstationfilter;
    }

    public void setCworkstationfilter(String cworkstationfilter) {
        this.cworkstationfilter = cworkstationfilter;
    }

    @Column(name = "NPROCESS_STATUS", precision = 4, scale = 0, columnDefinition = "NUMBER(4) DEFAULT 4")
    public Integer getNprocessStatus() {
        return this.nprocessStatus;
    }

    public void setNprocessStatus(Integer nprocessStatus) {
        this.nprocessStatus = nprocessStatus;
    }

    @Column(name = "CSVC_DATABASE", nullable = false, length = 20)
    public String getCsvcDatabase() {
        return this.csvcDatabase;
    }

    public void setCsvcDatabase(String csvcDatabase) {
        this.csvcDatabase = csvcDatabase;
    }

    @Column(name = "CSVC_TERMINAL", nullable = false, length = 20)
    public String getCsvcTerminal() {
        return this.csvcTerminal;
    }

    public void setCsvcTerminal(String csvcTerminal) {
        this.csvcTerminal = csvcTerminal;
    }

    @Column(name = "CSVC_MODULE", nullable = false, length = 50)
    public String getCsvcModule() {
        return this.csvcModule;
    }

    public void setCsvcModule(String csvcModule) {
        this.csvcModule = csvcModule;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenDocGenQueueBl")
    public Set<CenDocGenBlData> getCenDocGenBlDatas() {
        return this.cenDocGenBlDatas;
    }

    public void setCenDocGenBlDatas(Set<CenDocGenBlData> cenDocGenBlDatas) {
        this.cenDocGenBlDatas = cenDocGenBlDatas;
    }
}
