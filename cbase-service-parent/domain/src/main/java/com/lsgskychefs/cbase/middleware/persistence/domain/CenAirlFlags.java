package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 17, 2025 12:31:04 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_AIRL_FLAGS
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_AIRL_FLAGS"
)
public class CenAirlFlags  implements DomainObject,java.io.Serializable {


     private CenAirlFlagsId id;
     private CenAirlines cenAirlines;
     private SysAirlineFlags sysAirlineFlags;
     private int nflagMandatory;

     @JsonIgnore
     private Set<CenPackinglistFlags> cenPackinglistFlagses = new HashSet<CenPackinglistFlags>(0);

   
     @EmbeddedId
    @AttributeOverrides( {
        @AttributeOverride(name="nflagId", column=@Column(name="NFLAG_ID", nullable=false, precision=12, scale=0) ), 
        @AttributeOverride(name="nairlineKey", column=@Column(name="NAIRLINE_KEY", nullable=false, precision=12, scale=0) ), 
        @AttributeOverride(name="nplKindKey", column=@Column(name="NPL_KIND_KEY", nullable=false, precision=12, scale=0) ) } )
    public CenAirlFlagsId getId() {
        return this.id;
    }
    
    public void setId(CenAirlFlagsId id) {
        this.id = id;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NAIRLINE_KEY", nullable=false, insertable=false, updatable=false)
    public CenAirlines getCenAirlines() {
        return this.cenAirlines;
    }
    
    public void setCenAirlines(CenAirlines cenAirlines) {
        this.cenAirlines = cenAirlines;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NFLAG_ID", nullable=false, insertable=false, updatable=false)
    public SysAirlineFlags getSysAirlineFlags() {
        return this.sysAirlineFlags;
    }
    
    public void setSysAirlineFlags(SysAirlineFlags sysAirlineFlags) {
        this.sysAirlineFlags = sysAirlineFlags;
    }

    
    @Column(name="NFLAG_MANDATORY", nullable=false, precision=1, scale=0)
    public int getNflagMandatory() {
        return this.nflagMandatory;
    }
    
    public void setNflagMandatory(int nflagMandatory) {
        this.nflagMandatory = nflagMandatory;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="cenAirlFlags")
    public Set<CenPackinglistFlags> getCenPackinglistFlagses() {
        return this.cenPackinglistFlagses;
    }
    
    public void setCenPackinglistFlagses(Set<CenPackinglistFlags> cenPackinglistFlagses) {
        this.cenPackinglistFlagses = cenPackinglistFlagses;
    }




}


