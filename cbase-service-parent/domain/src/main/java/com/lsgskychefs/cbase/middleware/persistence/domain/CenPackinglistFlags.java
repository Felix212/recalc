package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 17, 2025 12:31:04 PM by Hibernate Tools 4.3.5.Final


import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_FLAGS
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_PACKINGLIST_FLAGS"
)
public class CenPackinglistFlags  implements DomainObject,java.io.Serializable {


     private CenPackinglistFlagsId id;
     private CenAirlFlags cenAirlFlags;
     private CenPackinglists cenPackinglists;
     private SysAirlineFlags sysAirlineFlags;
     private String cflagvalue;

     //our approach to be able to insert records because can not be done by CenAirlFlags because nFlagId is used in two places
     private Long nairlineKey;
     private Long nplKindKey;


     @EmbeddedId
    @AttributeOverrides( {
        @AttributeOverride(name="npackinglistIndexKey", column=@Column(name="NPACKINGLIST_INDEX_KEY", nullable=false, precision=12, scale=0) ), 
        @AttributeOverride(name="npackinglistDetailKey", column=@Column(name="NPACKINGLIST_DETAIL_KEY", nullable=false, precision=12, scale=0) ), 
        @AttributeOverride(name="nflagId", column=@Column(name="NFLAG_ID", nullable=false, precision=12, scale=0) ) } )
    public CenPackinglistFlagsId getId() {
        return this.id;
    }
    
    public void setId(CenPackinglistFlagsId id) {
        this.id = id;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumns( {
            @JoinColumn(name="NFLAG_ID", referencedColumnName="NFLAG_ID", nullable=false, insertable=false, updatable=false),
            @JoinColumn(name="NAIRLINE_KEY", referencedColumnName="NAIRLINE_KEY", nullable=false, insertable=false, updatable=false),
            @JoinColumn(name="NPL_KIND_KEY", referencedColumnName="NPL_KIND_KEY", nullable=false, insertable=false, updatable=false)
    } )
    public CenAirlFlags getCenAirlFlags() {
        return this.cenAirlFlags;
    }

    public void setCenAirlFlags(CenAirlFlags cenAirlFlags) {
        this.cenAirlFlags = cenAirlFlags;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumns( { 
        @JoinColumn(name="NPACKINGLIST_INDEX_KEY", referencedColumnName="NPACKINGLIST_INDEX_KEY", nullable=false, insertable=false, updatable=false), 
        @JoinColumn(name="NPACKINGLIST_DETAIL_KEY", referencedColumnName="NPACKINGLIST_DETAIL_KEY", nullable=false, insertable=false, updatable=false) } )
    public CenPackinglists getCenPackinglists() {
        return this.cenPackinglists;
    }
    
    public void setCenPackinglists(CenPackinglists cenPackinglists) {
        this.cenPackinglists = cenPackinglists;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NFLAG_ID", nullable=false, insertable=false, updatable=false)
    public SysAirlineFlags getSysAirlineFlags() {
        return this.sysAirlineFlags;
    }
    
    public void setSysAirlineFlags(SysAirlineFlags sysAirlineFlags) {
        this.sysAirlineFlags = sysAirlineFlags;
    }

    
    @Column(name="CFLAGVALUE", length=40)
    public String getCflagvalue() {
        return this.cflagvalue;
    }
    
    public void setCflagvalue(String cflagvalue) {
        this.cflagvalue = cflagvalue;
    }

    @Column(name="NAIRLINE_KEY", nullable=false)
    public Long getNairlineKey() {
        return nairlineKey;
    }

    public void setNairlineKey(Long nairlineKey) {
        this.nairlineKey = nairlineKey;
    }

    @Column(name="NPL_KIND_KEY", nullable=false)
    public Long getNplKindKey() {
        return nplKindKey;
    }

    public void setNplKindKey(Long nplKindKey) {
        this.nplKindKey = nplKindKey;
    }
}


