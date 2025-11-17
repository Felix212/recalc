package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 6, 2020 9:25:20 AM by Hibernate Tools 4.3.5.Final


import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_REQUEST_TYPES
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_REQUEST_TYPES"
)
public class CenRequestTypes  implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject,java.io.Serializable {


     private long nrequestType;
     private String cinOut;
     private String ccomment;
     private Set<CenRequest> cenRequests = new HashSet<CenRequest>(0);

    public CenRequestTypes() {
    }

	
    public CenRequestTypes(long nrequestType, String cinOut, String ccomment) {
        this.nrequestType = nrequestType;
        this.cinOut = cinOut;
        this.ccomment = ccomment;
    }
    public CenRequestTypes(long nrequestType, String cinOut, String ccomment, Set<CenRequest> cenRequests) {
       this.nrequestType = nrequestType;
       this.cinOut = cinOut;
       this.ccomment = ccomment;
       this.cenRequests = cenRequests;
    }
   
     @Id 

    
    @Column(name="NREQUEST_TYPE", unique=true, nullable=false, precision=12, scale=0)
    public long getNrequestType() {
        return this.nrequestType;
    }
    
    public void setNrequestType(long nrequestType) {
        this.nrequestType = nrequestType;
    }

    
    @Column(name="CIN_OUT", nullable=false, length=10)
    public String getCinOut() {
        return this.cinOut;
    }
    
    public void setCinOut(String cinOut) {
        this.cinOut = cinOut;
    }

    
    @Column(name="CCOMMENT", nullable=false, length=50)
    public String getCcomment() {
        return this.ccomment;
    }
    
    public void setCcomment(String ccomment) {
        this.ccomment = ccomment;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="cenRequestTypes")
    public Set<CenRequest> getCenRequests() {
        return this.cenRequests;
    }
    
    public void setCenRequests(Set<CenRequest> cenRequests) {
        this.cenRequests = cenRequests;
    }




}


