package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 20, 2024 2:58:31 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_MP_WORKSTATION_TEAM
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_MP_WORKSTATION_TEAM"
)
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class CenMpWorkstationTeam  implements DomainObject,java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long nmpWorkstationTeamKey;

     private CenMpWorkstations cenMpWorkstations;
     @JsonIgnore
     private CenMpTeams cenMpTeams;
     private Date dcreatedOn;
     private String ccreatedBy;
     private Long noffsetDays;


     @Id
     @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_WORKSTATION_TEAM")
     @SequenceGenerator(name = "SEQ_CEN_MP_WORKSTATION_TEAM", sequenceName = "SEQ_CEN_MP_WORKSTATION_TEAM", allocationSize = 1)
    @Column(name="NMP_WORKSTATION_TEAM_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmpWorkstationTeamKey() {
        return this.nmpWorkstationTeamKey;
    }
    
    public void setNmpWorkstationTeamKey(long nmpWorkstationTeamKey) {
        this.nmpWorkstationTeamKey = nmpWorkstationTeamKey;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMP_WORKSTATION_KEY", nullable=false)
    public CenMpWorkstations getCenMpWorkstations() {
        return this.cenMpWorkstations;
    }
    
    public void setCenMpWorkstations(CenMpWorkstations cenMpWorkstations) {
        this.cenMpWorkstations = cenMpWorkstations;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NMP_TEAM_KEY", nullable=false)
    public CenMpTeams getCenMpTeams() {
        return this.cenMpTeams;
    }
    
    public void setCenMpTeams(CenMpTeams cenMpTeams) {
        this.cenMpTeams = cenMpTeams;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DCREATED_ON", length=7)
    public Date getDcreatedOn() {
        return this.dcreatedOn;
    }
    
    public void setDcreatedOn(Date dcreatedOn) {
        this.dcreatedOn = dcreatedOn;
    }

    
    @Column(name="CCREATED_BY", length=40)
    public String getCcreatedBy() {
        return this.ccreatedBy;
    }
    
    public void setCcreatedBy(String ccreatedBy) {
        this.ccreatedBy = ccreatedBy;
    }
    @Column(name = "NOFFSET_DAYS", nullable = false, precision = 12, scale = 0)
    public Long getNoffsetDays() {
        return noffsetDays;
    }

    public void setNoffsetDays(Long noffsetDays) {
        this.noffsetDays = noffsetDays;
    }
}


