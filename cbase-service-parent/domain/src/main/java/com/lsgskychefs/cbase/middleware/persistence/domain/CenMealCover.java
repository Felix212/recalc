package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Feb-2025 17:50:19 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_MEAL_COVER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MEAL_COVER", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "NAIRCRAFT_KEY",
        "NACG_MASTER_KEY", "NHANDLING_FOREIGN_KEY", "NHANDLING_TYPE_KEY", "NHANDLING_KEY", "DVALID_FROM", "CTIME_FROM",
        "NPAX_FROM", "NPLANNING_PERCENT", "CQUESTION_TEXT", "CPREFIX", "NREDUCE", "COVERUNDERLOAD", "NSERVICE_SEQUENCE",
        "NASK4PASSENGER" }))
public class CenMealCover
        implements DomainObject, java.io.Serializable {

    private long nhandlingDetailKey;
    private CenHandling cenHandlingByNhandlingKey;
    private CenHandling cenHandlingByNhandlingForeignKey;
    private CenHandlingTypes cenHandlingTypes;
    private CenAirlines cenAirlinesByNairlineKey;
    private CenAirlines cenAirlinesByNcustomerKey;
    private int nprio;
    private long naircraftKey;
    private CenAircraft cenAircraft;
    private int naircraftDefault;
    private Date dvalidFrom;
    private Date dvalidTo;
    private String ctimeFrom;
    private String ctimeTo;
    private int npaxFrom;
    private int npaxTo;
    private Long ndistributionKey;
    private int nownerOnly;
    private String cupdatedBy;
    private Date dupdatedDate;
    private String cupdatedByPrev;
    private Date dupdatedDatePrev;
    private long nacgMasterKey;
    private int nask4passenger;
    private int nplanningPercent;
    private String cquestionText;
    private String cprefix;
    private int nreduce;
    private String coverunderload;
    private Integer nserviceSequence;
    private Long noldHandlingDetailkey;
    private String csalesBom;
    private Long ngalleyRegionKey;

    @Id
    @Column(name = "NHANDLING_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNhandlingDetailKey() {
        return this.nhandlingDetailKey;
    }

    public void setNhandlingDetailKey(long nhandlingDetailKey) {
        this.nhandlingDetailKey = nhandlingDetailKey;
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
    @JoinColumn(name = "NHANDLING_FOREIGN_KEY", nullable = false)
    public CenHandling getCenHandlingByNhandlingForeignKey() {
        return this.cenHandlingByNhandlingForeignKey;
    }

    public void setCenHandlingByNhandlingForeignKey(CenHandling cenHandlingByNhandlingForeignKey) {
        this.cenHandlingByNhandlingForeignKey = cenHandlingByNhandlingForeignKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NHANDLING_TYPE_KEY", nullable = false)
    public CenHandlingTypes getCenHandlingTypes() {
        return this.cenHandlingTypes;
    }

    public void setCenHandlingTypes(CenHandlingTypes cenHandlingTypes) {
        this.cenHandlingTypes = cenHandlingTypes;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NAIRLINE_KEY", nullable = false)
    public CenAirlines getCenAirlinesByNairlineKey() {
        return this.cenAirlinesByNairlineKey;
    }

    public void setCenAirlinesByNairlineKey(CenAirlines cenAirlinesByNairlineKey) {
        this.cenAirlinesByNairlineKey = cenAirlinesByNairlineKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NCUSTOMER_KEY", nullable = false)
    public CenAirlines getCenAirlinesByNcustomerKey() {
        return this.cenAirlinesByNcustomerKey;
    }

    public void setCenAirlinesByNcustomerKey(CenAirlines cenAirlinesByNcustomerKey) {
        this.cenAirlinesByNcustomerKey = cenAirlinesByNcustomerKey;
    }

    @Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
    public int getNprio() {
        return this.nprio;
    }

    public void setNprio(int nprio) {
        this.nprio = nprio;
    }

    @Column(name = "NAIRCRAFT_KEY", nullable = false, precision = 12, scale = 0)
    public long getNaircraftKey() {
        return this.naircraftKey;
    }

    public void setNaircraftKey(long naircraftKey) {
        this.naircraftKey = naircraftKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NAIRCRAFT_KEY", nullable = false, insertable = false, updatable = false)
    public CenAircraft getCenAircraft() {
        return this.cenAircraft;
    }

    public void setCenAircraft(CenAircraft cenAircraft) {
        this.cenAircraft = cenAircraft;
    }

    @Column(name = "NAIRCRAFT_DEFAULT", nullable = false, precision = 1, scale = 0)
    public int getNaircraftDefault() {
        return this.naircraftDefault;
    }

    public void setNaircraftDefault(int naircraftDefault) {
        this.naircraftDefault = naircraftDefault;
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

    @Column(name = "CTIME_FROM", nullable = false, length = 5)
    public String getCtimeFrom() {
        return this.ctimeFrom;
    }

    public void setCtimeFrom(String ctimeFrom) {
        this.ctimeFrom = ctimeFrom;
    }

    @Column(name = "CTIME_TO", nullable = false, length = 5)
    public String getCtimeTo() {
        return this.ctimeTo;
    }

    public void setCtimeTo(String ctimeTo) {
        this.ctimeTo = ctimeTo;
    }

    @Column(name = "NPAX_FROM", nullable = false, precision = 6, scale = 0)
    public int getNpaxFrom() {
        return this.npaxFrom;
    }

    public void setNpaxFrom(int npaxFrom) {
        this.npaxFrom = npaxFrom;
    }

    @Column(name = "NPAX_TO", nullable = false, precision = 6, scale = 0)
    public int getNpaxTo() {
        return this.npaxTo;
    }

    public void setNpaxTo(int npaxTo) {
        this.npaxTo = npaxTo;
    }

    @Column(name = "NDISTRIBUTION_KEY", precision = 12, scale = 0)
    public Long getNdistributionKey() {
        return this.ndistributionKey;
    }

    public void setNdistributionKey(Long ndistributionKey) {
        this.ndistributionKey = ndistributionKey;
    }

    @Column(name = "NOWNER_ONLY", nullable = false, precision = 1, scale = 0)
    public int getNownerOnly() {
        return this.nownerOnly;
    }

    public void setNownerOnly(int nownerOnly) {
        this.nownerOnly = nownerOnly;
    }

    @Column(name = "CUPDATED_BY", length = 40)
    public String getCupdatedBy() {
        return this.cupdatedBy;
    }

    public void setCupdatedBy(String cupdatedBy) {
        this.cupdatedBy = cupdatedBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DUPDATED_DATE", length = 7)
    public Date getDupdatedDate() {
        return this.dupdatedDate;
    }

    public void setDupdatedDate(Date dupdatedDate) {
        this.dupdatedDate = dupdatedDate;
    }

    @Column(name = "CUPDATED_BY_PREV", length = 40)
    public String getCupdatedByPrev() {
        return this.cupdatedByPrev;
    }

    public void setCupdatedByPrev(String cupdatedByPrev) {
        this.cupdatedByPrev = cupdatedByPrev;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DUPDATED_DATE_PREV", length = 7)
    public Date getDupdatedDatePrev() {
        return this.dupdatedDatePrev;
    }

    public void setDupdatedDatePrev(Date dupdatedDatePrev) {
        this.dupdatedDatePrev = dupdatedDatePrev;
    }

    @Column(name = "NACG_MASTER_KEY", nullable = false, precision = 12, scale = 0)
    public long getNacgMasterKey() {
        return this.nacgMasterKey;
    }

    public void setNacgMasterKey(long nacgMasterKey) {
        this.nacgMasterKey = nacgMasterKey;
    }

    @Column(name = "NASK4PASSENGER", nullable = false, precision = 1, scale = 0)
    public int getNask4passenger() {
        return this.nask4passenger;
    }

    public void setNask4passenger(int nask4passenger) {
        this.nask4passenger = nask4passenger;
    }

    @Column(name = "NPLANNING_PERCENT", nullable = false, precision = 3, scale = 0)
    public int getNplanningPercent() {
        return this.nplanningPercent;
    }

    public void setNplanningPercent(int nplanningPercent) {
        this.nplanningPercent = nplanningPercent;
    }

    @Column(name = "CQUESTION_TEXT", length = 45)
    public String getCquestionText() {
        return this.cquestionText;
    }

    public void setCquestionText(String cquestionText) {
        this.cquestionText = cquestionText;
    }

    @Column(name = "CPREFIX", length = 10)
    public String getCprefix() {
        return this.cprefix;
    }

    public void setCprefix(String cprefix) {
        this.cprefix = cprefix;
    }

    @Column(name = "NREDUCE", nullable = false, precision = 1, scale = 0)
    public int getNreduce() {
        return this.nreduce;
    }

    public void setNreduce(int nreduce) {
        this.nreduce = nreduce;
    }

    @Column(name = "COVERUNDERLOAD", length = 4)
    public String getCoverunderload() {
        return this.coverunderload;
    }

    public void setCoverunderload(String coverunderload) {
        this.coverunderload = coverunderload;
    }

    @Column(name = "NSERVICE_SEQUENCE", precision = 1, scale = 0)
    public Integer getNserviceSequence() {
        return this.nserviceSequence;
    }

    public void setNserviceSequence(Integer nserviceSequence) {
        this.nserviceSequence = nserviceSequence;
    }

    @Column(name = "NOLD_HANDLING_DETAILKEY", precision = 12, scale = 0)
    public Long getNoldHandlingDetailkey() {
        return this.noldHandlingDetailkey;
    }

    public void setNoldHandlingDetailkey(Long noldHandlingDetailkey) {
        this.noldHandlingDetailkey = noldHandlingDetailkey;
    }

    @Column(name = "CSALES_BOM", length = 18)
    public String getCsalesBom() {
        return this.csalesBom;
    }

    public void setCsalesBom(String csalesBom) {
        this.csalesBom = csalesBom;
    }

    @Column(name = "NGALLEY_REGION_KEY", precision = 12, scale = 0)
    public Long getNgalleyRegionKey() {
        return this.ngalleyRegionKey;
    }

    public void setNgalleyRegionKey(Long ngalleyRegionKey) {
        this.ngalleyRegionKey = ngalleyRegionKey;
    }

}
