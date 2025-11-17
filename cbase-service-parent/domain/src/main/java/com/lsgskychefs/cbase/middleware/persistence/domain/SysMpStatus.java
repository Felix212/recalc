package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 20, 2024 2:58:31 PM by Hibernate Tools 4.3.5.Final


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_MP_STATUS
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_MP_STATUS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class SysMpStatus  implements DomainObject,java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nmpStatusKey;
     private String cstatus;
     private Date dtimestamp;

     @JsonIgnore
     private List<CenMpProject> cenMpProjects = new ArrayList<>(0);

     @Id
    @Column(name="NMP_STATUS_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmpStatusKey() {
        return this.nmpStatusKey;
    }
    
    public void setNmpStatusKey(long nmpStatusKey) {
        this.nmpStatusKey = nmpStatusKey;
    }


    @Column(name="CSTATUS", nullable=false, length=40)
    public String getCstatus() {
        return this.cstatus;
    }
    
    public void setCstatus(String cstatus) {
        this.cstatus = cstatus;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DTIMESTAMP", length=7)
    public Date getDtimestamp() {
        return this.dtimestamp;
    }
    
    public void setDtimestamp(Date dtimestamp) {
        this.dtimestamp = dtimestamp;
    }

    @OneToMany(fetch=FetchType.LAZY, mappedBy="sysMpStatus")
    public List<CenMpProject> getCenMpProjects() {
        return cenMpProjects;
    }

    public void setCenMpProjects(List<CenMpProject> cenMpProjects) {
        this.cenMpProjects = cenMpProjects;
    }
}


