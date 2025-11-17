package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 3, 2022 11:15:38 AM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table LOC_UNIT_SHELF
 * @author Hibernate Tools
 */
@Entity
@Table(name="LOC_UNIT_SHELF"
)
public class LocUnitShelf  implements DomainObject,java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nunitShelfKey;
     private SysUnits sysUnits;
     private String cshelf;
     private String cdescription;
     private Set<LocUnitShelfZones> locUnitShelfZoneses = new HashSet<>(0);

    public LocUnitShelf() {
    }

	
    public LocUnitShelf(long nunitShelfKey, SysUnits sysUnits, String cshelf) {
        this.nunitShelfKey = nunitShelfKey;
        this.sysUnits = sysUnits;
        this.cshelf = cshelf;
    }
    public LocUnitShelf(long nunitShelfKey, SysUnits sysUnits, String cshelf, String cdescription, Set<LocUnitShelfZones> locUnitShelfZoneses) {
       this.nunitShelfKey = nunitShelfKey;
       this.sysUnits = sysUnits;
       this.cshelf = cshelf;
       this.cdescription = cdescription;
       this.locUnitShelfZoneses = locUnitShelfZoneses;
    }
   
     @Id 

    
    @Column(name="NUNIT_SHELF_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNunitShelfKey() {
        return this.nunitShelfKey;
    }
    
    public void setNunitShelfKey(long nunitShelfKey) {
        this.nunitShelfKey = nunitShelfKey;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="CUNIT", nullable=false)
    public SysUnits getSysUnits() {
        return this.sysUnits;
    }
    
    public void setSysUnits(SysUnits sysUnits) {
        this.sysUnits = sysUnits;
    }

    
    @Column(name="CSHELF", nullable=false, length=20)
    public String getCshelf() {
        return this.cshelf;
    }
    
    public void setCshelf(String cshelf) {
        this.cshelf = cshelf;
    }

    
    @Column(name="CDESCRIPTION", length=200)
    public String getCdescription() {
        return this.cdescription;
    }
    
    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="locUnitShelf")
    public Set<LocUnitShelfZones> getLocUnitShelfZoneses() {
        return this.locUnitShelfZoneses;
    }
    
    public void setLocUnitShelfZoneses(Set<LocUnitShelfZones> locUnitShelfZoneses) {
        this.locUnitShelfZoneses = locUnitShelfZoneses;
    }




}


