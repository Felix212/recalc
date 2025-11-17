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
 * Entity(DomainObject) for table CEN_MEAL_COVER_MO
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_MEAL_COVER_MO"
    , uniqueConstraints = @UniqueConstraint(columnNames={"NAIRLINE_KEY", "NAIRCRAFT_KEY", "NHANDLING_FOREIGN_KEY", "NHANDLING_TYPE_KEY", "NHANDLING_KEY", "DVALID_FROM", "CTIME_FROM", "NPAX_FROM"}) 
)
public class CenMealCoverMo  implements DomainObject,java.io.Serializable {


     private long nhandlingDetailKey;
     private CenHandling cenHandling;
     private SysMealOrderTypes sysMealOrderTypes;
     private int nprio;
     private long nairlineKey;
     private long ncustomerKey;
     private long naircraftKey;
     private int naircraftDefault;
     private int nownerOnly;
     private Date dvalidFrom;
     private Date dvalidTo;
     private String ctimeFrom;
     private String ctimeTo;
     private int npaxFrom;
     private int npaxTo;
     private long nhandlingForeignKey;
     private long nhandlingTypeKey;
     private Long ndistributionKey;
     private String cupdatedBy;
     private Date dupdatedDate;
     private String cupdatedByPrev;
     private Date dupdatedDatePrev;
     private int nask4passenger;
     private int nplanningPercent;
     private String cquestionText;
     private String cprefix;
     private int nreduce;
     private String coverunderload;
     private Integer nserviceSequence;
     private long noverruleClass;

    public CenMealCoverMo() {
    }

	
    public CenMealCoverMo(long nhandlingDetailKey, CenHandling cenHandling, SysMealOrderTypes sysMealOrderTypes, int nprio, long nairlineKey, long ncustomerKey, long naircraftKey, int naircraftDefault, int nownerOnly, Date dvalidFrom, Date dvalidTo, String ctimeFrom, String ctimeTo, int npaxFrom, int npaxTo, long nhandlingForeignKey, long nhandlingTypeKey, int nask4passenger, int nplanningPercent, int nreduce, long noverruleClass) {
        this.nhandlingDetailKey = nhandlingDetailKey;
        this.cenHandling = cenHandling;
        this.sysMealOrderTypes = sysMealOrderTypes;
        this.nprio = nprio;
        this.nairlineKey = nairlineKey;
        this.ncustomerKey = ncustomerKey;
        this.naircraftKey = naircraftKey;
        this.naircraftDefault = naircraftDefault;
        this.nownerOnly = nownerOnly;
        this.dvalidFrom = dvalidFrom;
        this.dvalidTo = dvalidTo;
        this.ctimeFrom = ctimeFrom;
        this.ctimeTo = ctimeTo;
        this.npaxFrom = npaxFrom;
        this.npaxTo = npaxTo;
        this.nhandlingForeignKey = nhandlingForeignKey;
        this.nhandlingTypeKey = nhandlingTypeKey;
        this.nask4passenger = nask4passenger;
        this.nplanningPercent = nplanningPercent;
        this.nreduce = nreduce;
        this.noverruleClass = noverruleClass;
    }
    public CenMealCoverMo(long nhandlingDetailKey, CenHandling cenHandling, SysMealOrderTypes sysMealOrderTypes, int nprio, long nairlineKey, long ncustomerKey, long naircraftKey, int naircraftDefault, int nownerOnly, Date dvalidFrom, Date dvalidTo, String ctimeFrom, String ctimeTo, int npaxFrom, int npaxTo, long nhandlingForeignKey, long nhandlingTypeKey, Long ndistributionKey, String cupdatedBy, Date dupdatedDate, String cupdatedByPrev, Date dupdatedDatePrev, int nask4passenger, int nplanningPercent, String cquestionText, String cprefix, int nreduce, String coverunderload, Integer nserviceSequence, long noverruleClass) {
       this.nhandlingDetailKey = nhandlingDetailKey;
       this.cenHandling = cenHandling;
       this.sysMealOrderTypes = sysMealOrderTypes;
       this.nprio = nprio;
       this.nairlineKey = nairlineKey;
       this.ncustomerKey = ncustomerKey;
       this.naircraftKey = naircraftKey;
       this.naircraftDefault = naircraftDefault;
       this.nownerOnly = nownerOnly;
       this.dvalidFrom = dvalidFrom;
       this.dvalidTo = dvalidTo;
       this.ctimeFrom = ctimeFrom;
       this.ctimeTo = ctimeTo;
       this.npaxFrom = npaxFrom;
       this.npaxTo = npaxTo;
       this.nhandlingForeignKey = nhandlingForeignKey;
       this.nhandlingTypeKey = nhandlingTypeKey;
       this.ndistributionKey = ndistributionKey;
       this.cupdatedBy = cupdatedBy;
       this.dupdatedDate = dupdatedDate;
       this.cupdatedByPrev = cupdatedByPrev;
       this.dupdatedDatePrev = dupdatedDatePrev;
       this.nask4passenger = nask4passenger;
       this.nplanningPercent = nplanningPercent;
       this.cquestionText = cquestionText;
       this.cprefix = cprefix;
       this.nreduce = nreduce;
       this.coverunderload = coverunderload;
       this.nserviceSequence = nserviceSequence;
       this.noverruleClass = noverruleClass;
    }
   
     @Id 

    
    @Column(name="NHANDLING_DETAIL_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNhandlingDetailKey() {
        return this.nhandlingDetailKey;
    }
    
    public void setNhandlingDetailKey(long nhandlingDetailKey) {
        this.nhandlingDetailKey = nhandlingDetailKey;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NHANDLING_KEY", nullable=false)
    public CenHandling getCenHandling() {
        return this.cenHandling;
    }
    
    public void setCenHandling(CenHandling cenHandling) {
        this.cenHandling = cenHandling;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMOT_KEY", nullable=false)
    public SysMealOrderTypes getSysMealOrderTypes() {
        return this.sysMealOrderTypes;
    }
    
    public void setSysMealOrderTypes(SysMealOrderTypes sysMealOrderTypes) {
        this.sysMealOrderTypes = sysMealOrderTypes;
    }

    
    @Column(name="NPRIO", nullable=false, precision=6, scale=0)
    public int getNprio() {
        return this.nprio;
    }
    
    public void setNprio(int nprio) {
        this.nprio = nprio;
    }

    
    @Column(name="NAIRLINE_KEY", nullable=false, precision=12, scale=0)
    public long getNairlineKey() {
        return this.nairlineKey;
    }
    
    public void setNairlineKey(long nairlineKey) {
        this.nairlineKey = nairlineKey;
    }

    
    @Column(name="NCUSTOMER_KEY", nullable=false, precision=12, scale=0)
    public long getNcustomerKey() {
        return this.ncustomerKey;
    }
    
    public void setNcustomerKey(long ncustomerKey) {
        this.ncustomerKey = ncustomerKey;
    }

    
    @Column(name="NAIRCRAFT_KEY", nullable=false, precision=12, scale=0)
    public long getNaircraftKey() {
        return this.naircraftKey;
    }
    
    public void setNaircraftKey(long naircraftKey) {
        this.naircraftKey = naircraftKey;
    }

    
    @Column(name="NAIRCRAFT_DEFAULT", nullable=false, precision=1, scale=0)
    public int getNaircraftDefault() {
        return this.naircraftDefault;
    }
    
    public void setNaircraftDefault(int naircraftDefault) {
        this.naircraftDefault = naircraftDefault;
    }

    
    @Column(name="NOWNER_ONLY", nullable=false, precision=1, scale=0)
    public int getNownerOnly() {
        return this.nownerOnly;
    }
    
    public void setNownerOnly(int nownerOnly) {
        this.nownerOnly = nownerOnly;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DVALID_FROM", nullable=false, length=7)
    public Date getDvalidFrom() {
        return this.dvalidFrom;
    }
    
    public void setDvalidFrom(Date dvalidFrom) {
        this.dvalidFrom = dvalidFrom;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DVALID_TO", nullable=false, length=7)
    public Date getDvalidTo() {
        return this.dvalidTo;
    }
    
    public void setDvalidTo(Date dvalidTo) {
        this.dvalidTo = dvalidTo;
    }

    
    @Column(name="CTIME_FROM", nullable=false, length=5)
    public String getCtimeFrom() {
        return this.ctimeFrom;
    }
    
    public void setCtimeFrom(String ctimeFrom) {
        this.ctimeFrom = ctimeFrom;
    }

    
    @Column(name="CTIME_TO", nullable=false, length=5)
    public String getCtimeTo() {
        return this.ctimeTo;
    }
    
    public void setCtimeTo(String ctimeTo) {
        this.ctimeTo = ctimeTo;
    }

    
    @Column(name="NPAX_FROM", nullable=false, precision=6, scale=0)
    public int getNpaxFrom() {
        return this.npaxFrom;
    }
    
    public void setNpaxFrom(int npaxFrom) {
        this.npaxFrom = npaxFrom;
    }

    
    @Column(name="NPAX_TO", nullable=false, precision=6, scale=0)
    public int getNpaxTo() {
        return this.npaxTo;
    }
    
    public void setNpaxTo(int npaxTo) {
        this.npaxTo = npaxTo;
    }

    
    @Column(name="NHANDLING_FOREIGN_KEY", nullable=false, precision=12, scale=0)
    public long getNhandlingForeignKey() {
        return this.nhandlingForeignKey;
    }
    
    public void setNhandlingForeignKey(long nhandlingForeignKey) {
        this.nhandlingForeignKey = nhandlingForeignKey;
    }

    
    @Column(name="NHANDLING_TYPE_KEY", nullable=false, precision=12, scale=0)
    public long getNhandlingTypeKey() {
        return this.nhandlingTypeKey;
    }
    
    public void setNhandlingTypeKey(long nhandlingTypeKey) {
        this.nhandlingTypeKey = nhandlingTypeKey;
    }

    
    @Column(name="NDISTRIBUTION_KEY", precision=12, scale=0)
    public Long getNdistributionKey() {
        return this.ndistributionKey;
    }
    
    public void setNdistributionKey(Long ndistributionKey) {
        this.ndistributionKey = ndistributionKey;
    }

    
    @Column(name="CUPDATED_BY", length=40)
    public String getCupdatedBy() {
        return this.cupdatedBy;
    }
    
    public void setCupdatedBy(String cupdatedBy) {
        this.cupdatedBy = cupdatedBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DUPDATED_DATE", length=7)
    public Date getDupdatedDate() {
        return this.dupdatedDate;
    }
    
    public void setDupdatedDate(Date dupdatedDate) {
        this.dupdatedDate = dupdatedDate;
    }

    
    @Column(name="CUPDATED_BY_PREV", length=40)
    public String getCupdatedByPrev() {
        return this.cupdatedByPrev;
    }
    
    public void setCupdatedByPrev(String cupdatedByPrev) {
        this.cupdatedByPrev = cupdatedByPrev;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DUPDATED_DATE_PREV", length=7)
    public Date getDupdatedDatePrev() {
        return this.dupdatedDatePrev;
    }
    
    public void setDupdatedDatePrev(Date dupdatedDatePrev) {
        this.dupdatedDatePrev = dupdatedDatePrev;
    }

    
    @Column(name="NASK4PASSENGER", nullable=false, precision=1, scale=0)
    public int getNask4passenger() {
        return this.nask4passenger;
    }
    
    public void setNask4passenger(int nask4passenger) {
        this.nask4passenger = nask4passenger;
    }

    
    @Column(name="NPLANNING_PERCENT", nullable=false, precision=3, scale=0)
    public int getNplanningPercent() {
        return this.nplanningPercent;
    }
    
    public void setNplanningPercent(int nplanningPercent) {
        this.nplanningPercent = nplanningPercent;
    }

    
    @Column(name="CQUESTION_TEXT", length=45)
    public String getCquestionText() {
        return this.cquestionText;
    }
    
    public void setCquestionText(String cquestionText) {
        this.cquestionText = cquestionText;
    }

    
    @Column(name="CPREFIX", length=10)
    public String getCprefix() {
        return this.cprefix;
    }
    
    public void setCprefix(String cprefix) {
        this.cprefix = cprefix;
    }

    
    @Column(name="NREDUCE", nullable=false, precision=1, scale=0)
    public int getNreduce() {
        return this.nreduce;
    }
    
    public void setNreduce(int nreduce) {
        this.nreduce = nreduce;
    }

    
    @Column(name="COVERUNDERLOAD", length=4)
    public String getCoverunderload() {
        return this.coverunderload;
    }
    
    public void setCoverunderload(String coverunderload) {
        this.coverunderload = coverunderload;
    }

    
    @Column(name="NSERVICE_SEQUENCE", precision=1, scale=0)
    public Integer getNserviceSequence() {
        return this.nserviceSequence;
    }
    
    public void setNserviceSequence(Integer nserviceSequence) {
        this.nserviceSequence = nserviceSequence;
    }

    
    @Column(name="NOVERRULE_CLASS", nullable=false, precision=12, scale=0)
    public long getNoverruleClass() {
        return this.noverruleClass;
    }
    
    public void setNoverruleClass(long noverruleClass) {
        this.noverruleClass = noverruleClass;
    }




}


