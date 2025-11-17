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
 * Entity(DomainObject) for table CEN_DISTRIBUTION
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_DISTRIBUTION"
    , uniqueConstraints = @UniqueConstraint(columnNames={"CTEXT", "NAIRLINE_KEY", "DVALID_FROM"}) 
)
public class CenDistribution  implements DomainObject,java.io.Serializable {


     private long ndistributionKey;
     private CenAirlines cenAirlines;
     private String ctext;
     private String cdescription;
     private int nmcd;
     private Integer naccumulate;
     private Integer nmixed;
     private Date dvalidFrom;
     private Date dvalidTo;

    public CenDistribution() {
    }

	
    public CenDistribution(long ndistributionKey, CenAirlines cenAirlines, String ctext, int nmcd, Date dvalidFrom, Date dvalidTo) {
        this.ndistributionKey = ndistributionKey;
        this.cenAirlines = cenAirlines;
        this.ctext = ctext;
        this.nmcd = nmcd;
        this.dvalidFrom = dvalidFrom;
        this.dvalidTo = dvalidTo;
    }
    public CenDistribution(long ndistributionKey, CenAirlines cenAirlines, String ctext, String cdescription, int nmcd, Integer naccumulate, Integer nmixed, Date dvalidFrom, Date dvalidTo) {
       this.ndistributionKey = ndistributionKey;
       this.cenAirlines = cenAirlines;
       this.ctext = ctext;
       this.cdescription = cdescription;
       this.nmcd = nmcd;
       this.naccumulate = naccumulate;
       this.nmixed = nmixed;
       this.dvalidFrom = dvalidFrom;
       this.dvalidTo = dvalidTo;
    }
   
     @Id 

    
    @Column(name="NDISTRIBUTION_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNdistributionKey() {
        return this.ndistributionKey;
    }
    
    public void setNdistributionKey(long ndistributionKey) {
        this.ndistributionKey = ndistributionKey;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NAIRLINE_KEY", nullable=false)
    public CenAirlines getCenAirlines() {
        return this.cenAirlines;
    }
    
    public void setCenAirlines(CenAirlines cenAirlines) {
        this.cenAirlines = cenAirlines;
    }

    
    @Column(name="CTEXT", nullable=false, length=40)
    public String getCtext() {
        return this.ctext;
    }
    
    public void setCtext(String ctext) {
        this.ctext = ctext;
    }

    
    @Column(name="CDESCRIPTION", length=256)
    public String getCdescription() {
        return this.cdescription;
    }
    
    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
    }

    
    @Column(name="NMCD", nullable=false, precision=1, scale=0)
    public int getNmcd() {
        return this.nmcd;
    }
    
    public void setNmcd(int nmcd) {
        this.nmcd = nmcd;
    }

    
    @Column(name="NACCUMULATE", precision=1, scale=0)
    public Integer getNaccumulate() {
        return this.naccumulate;
    }
    
    public void setNaccumulate(Integer naccumulate) {
        this.naccumulate = naccumulate;
    }

    
    @Column(name="NMIXED", precision=1, scale=0)
    public Integer getNmixed() {
        return this.nmixed;
    }
    
    public void setNmixed(Integer nmixed) {
        this.nmixed = nmixed;
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




}


