package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 17, 2025 12:31:04 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_AIRLINE_FLAGS
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_AIRLINE_FLAGS"
)
public class SysAirlineFlags  implements DomainObject,java.io.Serializable {


     private long nflagId;
     private String cflagname;
     private Set<CenAirlFlags> cenAirlFlagses = new HashSet<CenAirlFlags>(0);
     private Set<CenPackinglistFlags> cenPackinglistFlagses = new HashSet<CenPackinglistFlags>(0);

     @Id

    
    @Column(name="NFLAG_ID", unique=true, nullable=false, precision=12, scale=0)
    public long getNflagId() {
        return this.nflagId;
    }
    
    public void setNflagId(long nflagId) {
        this.nflagId = nflagId;
    }

    
    @Column(name="CFLAGNAME", nullable=false, length=40)
    public String getCflagname() {
        return this.cflagname;
    }
    
    public void setCflagname(String cflagname) {
        this.cflagname = cflagname;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="sysAirlineFlags")
    public Set<CenAirlFlags> getCenAirlFlagses() {
        return this.cenAirlFlagses;
    }
    
    public void setCenAirlFlagses(Set<CenAirlFlags> cenAirlFlagses) {
        this.cenAirlFlagses = cenAirlFlagses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="sysAirlineFlags")
    public Set<CenPackinglistFlags> getCenPackinglistFlagses() {
        return this.cenPackinglistFlagses;
    }
    
    public void setCenPackinglistFlagses(Set<CenPackinglistFlags> cenPackinglistFlagses) {
        this.cenPackinglistFlagses = cenPackinglistFlagses;
    }




}


