package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 3, 2022 11:15:38 AM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table LOC_UNIT_SHELF_IL
 * @author Hibernate Tools
 */
@Entity
@Table(name="LOC_UNIT_SHELF_IL"
)
public class LocUnitShelfIl  implements DomainObject,java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nunitShelfIlKey;
     private LocUnitShelfZones locUnitShelfZones;
     private CenPackinglistIndex cenPackinglistIndex;
     private Date dvalidFrom;
     private Date dvalidTo;

    public LocUnitShelfIl() {
    }

    public LocUnitShelfIl(long nunitShelfIlKey, LocUnitShelfZones locUnitShelfZones, CenPackinglistIndex cenPackinglistIndex, Date dvalidFrom, Date dvalidTo) {
       this.nunitShelfIlKey = nunitShelfIlKey;
       this.locUnitShelfZones = locUnitShelfZones;
       this.cenPackinglistIndex = cenPackinglistIndex;
       this.dvalidFrom = dvalidFrom;
       this.dvalidTo = dvalidTo;
    }
   
     @Id 

    
    @Column(name="NUNIT_SHELF_IL_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNunitShelfIlKey() {
        return this.nunitShelfIlKey;
    }
    
    public void setNunitShelfIlKey(long nunitShelfIlKey) {
        this.nunitShelfIlKey = nunitShelfIlKey;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NSHELF_ZONE_KEY", nullable=false)
    public LocUnitShelfZones getLocUnitShelfZones() {
        return this.locUnitShelfZones;
    }
    
    public void setLocUnitShelfZones(LocUnitShelfZones locUnitShelfZones) {
        this.locUnitShelfZones = locUnitShelfZones;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NPACKINGLIST_INDEX_KEY", nullable=false)
    public CenPackinglistIndex getCenPackinglistIndex() {
        return this.cenPackinglistIndex;
    }
    
    public void setCenPackinglistIndex(CenPackinglistIndex cenPackinglistIndex) {
        this.cenPackinglistIndex = cenPackinglistIndex;
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


