package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 8, 2025 12:44:35 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_MP_SERVICE
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_MP_SERVICE")
public class CenMpService extends AuditableDomainObject {

     private long nmpServiceKey;
     private String ccode;
     private String cserviceName;

     @JsonIgnore
     private Set<CenMpMenugrid> cenMpMenugrids = new HashSet<CenMpMenugrid>(0);

     @Id
     @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_SERVICE")
     @SequenceGenerator(name = "SEQ_CEN_MP_SERVICE", sequenceName = "SEQ_CEN_MP_SERVICE", allocationSize = 1)
    @Column(name="NMP_SERVICE_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmpServiceKey() {
        return this.nmpServiceKey;
    }

    public void setNmpServiceKey(long nmpServiceKey) {
        this.nmpServiceKey = nmpServiceKey;
    }


    @Column(name="CCODE", nullable=false, length=40)
    public String getCcode() {
        return this.ccode;
    }

    public void setCcode(String ccode) {
        this.ccode = ccode;
    }


    @Column(name="CSERVICE_NAME", nullable=false, length=40)
    public String getCserviceName() {
        return this.cserviceName;
    }

    public void setCserviceName(String cserviceName) {
        this.cserviceName = cserviceName;
    }

    @OneToMany(fetch=FetchType.LAZY, mappedBy="cenMpService")
    public Set<CenMpMenugrid> getCenMpMenugrids() {
        return this.cenMpMenugrids;
    }

    public void setCenMpMenugrids(Set<CenMpMenugrid> cenMpMenugrids) {
        this.cenMpMenugrids = cenMpMenugrids;
    }


}


