package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Feb-2025 17:50:19 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_MEAL_ORDER_TYPES
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_MEAL_ORDER_TYPES"
)
public class SysMealOrderTypes  implements DomainObject,java.io.Serializable {


     private long nmotKey;
     private String cmealOrderType;
     private String cdescription;
     private String cshort;
     private String cairline;
     private Set<CenMealCoverMo> cenMealCoverMos = new HashSet<CenMealCoverMo>(0);

    public SysMealOrderTypes() {
    }

	
    public SysMealOrderTypes(long nmotKey, String cmealOrderType) {
        this.nmotKey = nmotKey;
        this.cmealOrderType = cmealOrderType;
    }
    public SysMealOrderTypes(long nmotKey, String cmealOrderType, String cdescription, String cshort, String cairline, Set<CenMealCoverMo> cenMealCoverMos) {
       this.nmotKey = nmotKey;
       this.cmealOrderType = cmealOrderType;
       this.cdescription = cdescription;
       this.cshort = cshort;
       this.cairline = cairline;
       this.cenMealCoverMos = cenMealCoverMos;
    }
   
     @Id 

    
    @Column(name="NMOT_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmotKey() {
        return this.nmotKey;
    }
    
    public void setNmotKey(long nmotKey) {
        this.nmotKey = nmotKey;
    }

    
    @Column(name="CMEAL_ORDER_TYPE", nullable=false, length=40)
    public String getCmealOrderType() {
        return this.cmealOrderType;
    }
    
    public void setCmealOrderType(String cmealOrderType) {
        this.cmealOrderType = cmealOrderType;
    }

    
    @Column(name="CDESCRIPTION", length=256)
    public String getCdescription() {
        return this.cdescription;
    }
    
    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
    }

    
    @Column(name="CSHORT", length=10)
    public String getCshort() {
        return this.cshort;
    }
    
    public void setCshort(String cshort) {
        this.cshort = cshort;
    }

    
    @Column(name="CAIRLINE", length=3)
    public String getCairline() {
        return this.cairline;
    }
    
    public void setCairline(String cairline) {
        this.cairline = cairline;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="sysMealOrderTypes")
    public Set<CenMealCoverMo> getCenMealCoverMos() {
        return this.cenMealCoverMos;
    }
    
    public void setCenMealCoverMos(Set<CenMealCoverMo> cenMealCoverMos) {
        this.cenMealCoverMos = cenMealCoverMos;
    }




}


