package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 25, 2018 12:18:36 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_QUEUE_FDR_TRANSFER
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_QUEUE_FDR_TRANSFER"
)
public class SysQueueFdrTransfer  implements DomainObject,java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long njobNr;
     private long nresultKey;
     private long ntransaction;
     private int ninsertingEvent;
     private String cinsertingEvent;
     private Date dcreated;
     private String cuser;
     private Date dstartProcessing;
     private Date dendProcessing;
     private String cinstance;
     private Integer nprocessStatus;

    public SysQueueFdrTransfer() {
    }

	
    public SysQueueFdrTransfer(long njobNr, long nresultKey, long ntransaction, int ninsertingEvent, String cinsertingEvent, Date dcreated, String cuser) {
        this.njobNr = njobNr;
        this.nresultKey = nresultKey;
        this.ntransaction = ntransaction;
        this.ninsertingEvent = ninsertingEvent;
        this.cinsertingEvent = cinsertingEvent;
        this.dcreated = dcreated;
        this.cuser = cuser;
    }
    public SysQueueFdrTransfer(long njobNr, long nresultKey, long ntransaction, int ninsertingEvent, String cinsertingEvent, Date dcreated, String cuser, Date dstartProcessing, Date dendProcessing, String cinstance, Integer nprocessStatus) {
       this.njobNr = njobNr;
       this.nresultKey = nresultKey;
       this.ntransaction = ntransaction;
       this.ninsertingEvent = ninsertingEvent;
       this.cinsertingEvent = cinsertingEvent;
       this.dcreated = dcreated;
       this.cuser = cuser;
       this.dstartProcessing = dstartProcessing;
       this.dendProcessing = dendProcessing;
       this.cinstance = cinstance;
       this.nprocessStatus = nprocessStatus;
    }
   
     @Id 

    
    @Column(name="NJOB_NR", unique=true, nullable=false, precision=12, scale=0)
    public long getNjobNr() {
        return this.njobNr;
    }
    
    public void setNjobNr(long njobNr) {
        this.njobNr = njobNr;
    }

    
    @Column(name="NRESULT_KEY", nullable=false, precision=12, scale=0)
    public long getNresultKey() {
        return this.nresultKey;
    }
    
    public void setNresultKey(long nresultKey) {
        this.nresultKey = nresultKey;
    }

    
    @Column(name="NTRANSACTION", nullable=false, precision=12, scale=0)
    public long getNtransaction() {
        return this.ntransaction;
    }
    
    public void setNtransaction(long ntransaction) {
        this.ntransaction = ntransaction;
    }

    
    @Column(name="NINSERTING_EVENT", nullable=false, precision=2, scale=0)
    public int getNinsertingEvent() {
        return this.ninsertingEvent;
    }
    
    public void setNinsertingEvent(int ninsertingEvent) {
        this.ninsertingEvent = ninsertingEvent;
    }

    
    @Column(name="CINSERTING_EVENT", nullable=false, length=30)
    public String getCinsertingEvent() {
        return this.cinsertingEvent;
    }
    
    public void setCinsertingEvent(String cinsertingEvent) {
        this.cinsertingEvent = cinsertingEvent;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DCREATED", nullable=false, length=7)
    public Date getDcreated() {
        return this.dcreated;
    }
    
    public void setDcreated(Date dcreated) {
        this.dcreated = dcreated;
    }

    
    @Column(name="CUSER", nullable=false, length=40)
    public String getCuser() {
        return this.cuser;
    }
    
    public void setCuser(String cuser) {
        this.cuser = cuser;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DSTART_PROCESSING", length=7)
    public Date getDstartProcessing() {
        return this.dstartProcessing;
    }
    
    public void setDstartProcessing(Date dstartProcessing) {
        this.dstartProcessing = dstartProcessing;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DEND_PROCESSING", length=7)
    public Date getDendProcessing() {
        return this.dendProcessing;
    }
    
    public void setDendProcessing(Date dendProcessing) {
        this.dendProcessing = dendProcessing;
    }

    
    @Column(name="CINSTANCE", length=30)
    public String getCinstance() {
        return this.cinstance;
    }
    
    public void setCinstance(String cinstance) {
        this.cinstance = cinstance;
    }

    
    @Column(name="NPROCESS_STATUS", precision=6, scale=0)
    public Integer getNprocessStatus() {
        return this.nprocessStatus;
    }
    
    public void setNprocessStatus(Integer nprocessStatus) {
        this.nprocessStatus = nprocessStatus;
    }




}


