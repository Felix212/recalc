package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 15, 2021 3:00:24 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_ROTATION_CAT
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_ROTATION_CAT"
)
public class CenRotationCat  implements DomainObject,java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nrotationCatKey;
     private CenAirlines cenAirlines;
     private String ctext;
     private Date dvalidFrom;
     private Date dvalidTo;
     private Date dtimestampModification;
     private int nskyscopeFlag;
     private Set<CenRotations> cenRotationses = new HashSet<>(0);
   
    @Id 
    @Column(name="NROTATION_CAT_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNrotationCatKey() {
        return this.nrotationCatKey;
    }
    
    public void setNrotationCatKey(long nrotationCatKey) {
        this.nrotationCatKey = nrotationCatKey;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NCUSTOMER_KEY", nullable=false)
    public CenAirlines getCenAirlines() {
        return this.cenAirlines;
    }
    
    public void setCenAirlines(CenAirlines cenAirlines) {
        this.cenAirlines = cenAirlines;
    }

    
    @Column(name="CTEXT", nullable=false, length=60)
    public String getCtext() {
        return this.ctext;
    }
    
    public void setCtext(String ctext) {
        this.ctext = ctext;
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

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DTIMESTAMP_MODIFICATION", length=7)
    public Date getDtimestampModification() {
        return this.dtimestampModification;
    }
    
    public void setDtimestampModification(Date dtimestampModification) {
        this.dtimestampModification = dtimestampModification;
    }

    
    @Column(name="NSKYSCOPE_FLAG", nullable=false, precision=1, scale=0)
    public int getNskyscopeFlag() {
        return this.nskyscopeFlag;
    }
    
    public void setNskyscopeFlag(int nskyscopeFlag) {
        this.nskyscopeFlag = nskyscopeFlag;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="cenRotationCat")
    public Set<CenRotations> getCenRotationses() {
        return this.cenRotationses;
    }
    
    public void setCenRotationses(Set<CenRotations> cenRotationses) {
        this.cenRotationses = cenRotationses;
    }




}


