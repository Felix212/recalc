package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 09.12.2019 10:20:03 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_PORTION_TOOL
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_PORTION_TOOL"
    , uniqueConstraints = @UniqueConstraint(columnNames="CPORTION_TOOL") 
)
public class SysPortionTool  implements DomainObject,java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nportionToolKey;
     private String cportionTool;
     private String cportionSize;
     private int nred;
     private int ngreen;
     private int nblue;
     private Long ncolorcodeMs;
     private Long ncolorcode;
     private String ccolorcodeHex;
     private String ccolorText;
     private Integer ntextcolor;
     private Set<CenPackinglistDetail> cenPackinglistDetails = new HashSet<>(0);

    public SysPortionTool() {
    }

	
    public SysPortionTool(long nportionToolKey, String cportionTool, String cportionSize, int nred, int ngreen, int nblue) {
        this.nportionToolKey = nportionToolKey;
        this.cportionTool = cportionTool;
        this.cportionSize = cportionSize;
        this.nred = nred;
        this.ngreen = ngreen;
        this.nblue = nblue;
    }
    public SysPortionTool(long nportionToolKey, String cportionTool, String cportionSize, int nred, int ngreen, int nblue, Long ncolorcodeMs, Long ncolorcode, String ccolorcodeHex, String ccolorText, Integer ntextcolor, Set<CenPackinglistDetail> cenPackinglistDetails) {
       this.nportionToolKey = nportionToolKey;
       this.cportionTool = cportionTool;
       this.cportionSize = cportionSize;
       this.nred = nred;
       this.ngreen = ngreen;
       this.nblue = nblue;
       this.ncolorcodeMs = ncolorcodeMs;
       this.ncolorcode = ncolorcode;
       this.ccolorcodeHex = ccolorcodeHex;
       this.ccolorText = ccolorText;
       this.ntextcolor = ntextcolor;
       this.cenPackinglistDetails = cenPackinglistDetails;
    }
   
     @Id 

    
    @Column(name="NPORTION_TOOL_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNportionToolKey() {
        return this.nportionToolKey;
    }
    
    public void setNportionToolKey(long nportionToolKey) {
        this.nportionToolKey = nportionToolKey;
    }

    
    @Column(name="CPORTION_TOOL", unique=true, nullable=false, length=10)
    public String getCportionTool() {
        return this.cportionTool;
    }
    
    public void setCportionTool(String cportionTool) {
        this.cportionTool = cportionTool;
    }

    
    @Column(name="CPORTION_SIZE", nullable=false, length=50)
    public String getCportionSize() {
        return this.cportionSize;
    }
    
    public void setCportionSize(String cportionSize) {
        this.cportionSize = cportionSize;
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

    
    @Column(name="CCOLOR_TEXT", length=20)
    public String getCcolorText() {
        return this.ccolorText;
    }
    
    public void setCcolorText(String ccolorText) {
        this.ccolorText = ccolorText;
    }

    
    @Column(name="NTEXTCOLOR", precision=1, scale=0)
    public Integer getNtextcolor() {
        return this.ntextcolor;
    }
    
    public void setNtextcolor(Integer ntextcolor) {
        this.ntextcolor = ntextcolor;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="sysPortionTool")
    public Set<CenPackinglistDetail> getCenPackinglistDetails() {
        return this.cenPackinglistDetails;
    }
    
    public void setCenPackinglistDetails(Set<CenPackinglistDetail> cenPackinglistDetails) {
        this.cenPackinglistDetails = cenPackinglistDetails;
    }




}


