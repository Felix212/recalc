package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 20, 2024 2:58:31 PM by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_MP_WORKSTATIONS
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_MP_WORKSTATIONS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class CenMpWorkstations extends AuditableDomainObject {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nmpWorkstationKey;
     private String cname;

     @JsonIgnore
     private List<CenMpWorkstationTeam> cenMpWorkstationTeams = new ArrayList<>(0);
    @JsonIgnore
     private List<CenPlMpProject> cenPlMpProjects = new ArrayList<>(0);

   
     @Id
     @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_WORKSTATIONS")
     @SequenceGenerator(name = "SEQ_CEN_MP_WORKSTATIONS", sequenceName = "SEQ_CEN_MP_WORKSTATIONS", allocationSize = 1)
    @Column(name="NMP_WORKSTATION_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmpWorkstationKey() {
        return this.nmpWorkstationKey;
    }
    
    public void setNmpWorkstationKey(long nmpWorkstationKey) {
        this.nmpWorkstationKey = nmpWorkstationKey;
    }


    @Column(name="CNAME", nullable=false, length=256)
    public String getCname() {
        return this.cname;
    }
    
    public void setCname(String cname) {
        this.cname = cname;
    }


    @OneToMany(fetch=FetchType.LAZY, mappedBy="cenMpWorkstations")
    public List<CenMpWorkstationTeam> getCenMpWorkstationTeams() {
        return cenMpWorkstationTeams;
    }

    public void setCenMpWorkstationTeams(
            List<CenMpWorkstationTeam> cenMpWorkstationTeams) {
        this.cenMpWorkstationTeams = cenMpWorkstationTeams;
    }

    @OneToMany(fetch=FetchType.LAZY, mappedBy="cenMpWorkstations")
    public List<CenPlMpProject> getCenPlMpProjects() {
        return cenPlMpProjects;
    }

    public void setCenPlMpProjects(List<CenPlMpProject> cenPlMpProjects) {
        this.cenPlMpProjects = cenPlMpProjects;
    }
}


