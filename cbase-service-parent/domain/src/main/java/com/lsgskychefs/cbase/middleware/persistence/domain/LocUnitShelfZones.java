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
 * Entity(DomainObject) for table LOC_UNIT_SHELF_ZONES
 * @author Hibernate Tools
 */
@Entity
@Table(name="LOC_UNIT_SHELF_ZONES"
)
public class LocUnitShelfZones  implements DomainObject,java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nshelfZoneKey;
     private LocUnitShelf locUnitShelf;
     private String czone;
     private int norder;
     private int nred;
     private int ngreen;
     private int nblue;
     private Long ncolorcodeMs;
     private Long ncolorcode;
     private String ccolorcodeHex;
     private Integer ntextcolor;
     private Set<LocUnitShelfIl> locUnitShelfIls = new HashSet<>(0);

    public LocUnitShelfZones() {
    }

	
    public LocUnitShelfZones(long nshelfZoneKey, LocUnitShelf locUnitShelf, String czone, int norder, int nred, int ngreen, int nblue) {
        this.nshelfZoneKey = nshelfZoneKey;
        this.locUnitShelf = locUnitShelf;
        this.czone = czone;
        this.norder = norder;
        this.nred = nred;
        this.ngreen = ngreen;
        this.nblue = nblue;
    }
    public LocUnitShelfZones(long nshelfZoneKey, LocUnitShelf locUnitShelf, String czone, int norder, int nred, int ngreen, int nblue, Long ncolorcodeMs, Long ncolorcode, String ccolorcodeHex, Integer ntextcolor, Set<LocUnitShelfIl> locUnitShelfIls) {
       this.nshelfZoneKey = nshelfZoneKey;
       this.locUnitShelf = locUnitShelf;
       this.czone = czone;
       this.norder = norder;
       this.nred = nred;
       this.ngreen = ngreen;
       this.nblue = nblue;
       this.ncolorcodeMs = ncolorcodeMs;
       this.ncolorcode = ncolorcode;
       this.ccolorcodeHex = ccolorcodeHex;
       this.ntextcolor = ntextcolor;
       this.locUnitShelfIls = locUnitShelfIls;
    }
   
     @Id 

    
    @Column(name="NSHELF_ZONE_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNshelfZoneKey() {
        return this.nshelfZoneKey;
    }
    
    public void setNshelfZoneKey(long nshelfZoneKey) {
        this.nshelfZoneKey = nshelfZoneKey;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NSHELF_KEY", nullable=false)
    public LocUnitShelf getLocUnitShelf() {
        return this.locUnitShelf;
    }
    
    public void setLocUnitShelf(LocUnitShelf locUnitShelf) {
        this.locUnitShelf = locUnitShelf;
    }

    
    @Column(name="CZONE", nullable=false, length=20)
    public String getCzone() {
        return this.czone;
    }
    
    public void setCzone(String czone) {
        this.czone = czone;
    }

    
    @Column(name="NORDER", nullable=false, precision=2, scale=0)
    public int getNorder() {
        return this.norder;
    }
    
    public void setNorder(int norder) {
        this.norder = norder;
    }

    
    @Column(name="NRED", nullable=false, precision=3, scale=0)
    public int getNred() {
        return this.nred;
    }
    
    public void setNred(int nred) {
        this.nred = nred;
    }

    
    @Column(name="NGREEN", nullable=false, precision=3, scale=0)
    public int getNgreen() {
        return this.ngreen;
    }
    
    public void setNgreen(int ngreen) {
        this.ngreen = ngreen;
    }

    
    @Column(name="NBLUE", nullable=false, precision=3, scale=0)
    public int getNblue() {
        return this.nblue;
    }
    
    public void setNblue(int nblue) {
        this.nblue = nblue;
    }

    
    @Column(name="NCOLORCODE_MS", precision=12, scale=0)
    public Long getNcolorcodeMs() {
        return this.ncolorcodeMs;
    }
    
    public void setNcolorcodeMs(Long ncolorcodeMs) {
        this.ncolorcodeMs = ncolorcodeMs;
    }

    
    @Column(name="NCOLORCODE", precision=12, scale=0)
    public Long getNcolorcode() {
        return this.ncolorcode;
    }
    
    public void setNcolorcode(Long ncolorcode) {
        this.ncolorcode = ncolorcode;
    }

    
    @Column(name="CCOLORCODE_HEX", length=6)
    public String getCcolorcodeHex() {
        return this.ccolorcodeHex;
    }
    
    public void setCcolorcodeHex(String ccolorcodeHex) {
        this.ccolorcodeHex = ccolorcodeHex;
    }

    
    @Column(name="NTEXTCOLOR", precision=1, scale=0)
    public Integer getNtextcolor() {
        return this.ntextcolor;
    }
    
    public void setNtextcolor(Integer ntextcolor) {
        this.ntextcolor = ntextcolor;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="locUnitShelfZones")
    public Set<LocUnitShelfIl> getLocUnitShelfIls() {
        return this.locUnitShelfIls;
    }
    
    public void setLocUnitShelfIls(Set<LocUnitShelfIl> locUnitShelfIls) {
        this.locUnitShelfIls = locUnitShelfIls;
    }




}


