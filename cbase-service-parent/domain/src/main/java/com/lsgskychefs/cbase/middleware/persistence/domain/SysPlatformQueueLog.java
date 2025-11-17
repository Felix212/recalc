package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Nov 15, 2022 7:14:44 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
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

/**
 * Entity(DomainObject) for table SYS_PLATFORM_QUEUE_LOG
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PLATFORM_QUEUE_LOG"
)
public class SysPlatformQueueLog implements DomainObject, java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nplatformQueueLogKey;
    private SysPlatformQueue sysPlatformQueue;
    private Date dtimestamp;
    private int ntype;
    private String cmessage;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_PLATFORM_QUEUE_LOG")
    @SequenceGenerator(name = "SEQ_SYS_PLATFORM_QUEUE_LOG", sequenceName = "SEQ_SYS_PLATFORM_QUEUE_LOG", allocationSize = 1)
    @Column(name = "NPLATFORM_QUEUE_LOG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNplatformQueueLogKey() {
        return this.nplatformQueueLogKey;
    }

    public void setNplatformQueueLogKey(long nplatformQueueLogKey) {
        this.nplatformQueueLogKey = nplatformQueueLogKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NJOB_NR", nullable = false)
    public SysPlatformQueue getSysPlatformQueue() {
        return this.sysPlatformQueue;
    }

    public void setSysPlatformQueue(SysPlatformQueue sysPlatformQueue) {
        this.sysPlatformQueue = sysPlatformQueue;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP", nullable = false, length = 7)
    public Date getDtimestamp() {
        return this.dtimestamp;
    }

    public void setDtimestamp(Date dtimestamp) {
        this.dtimestamp = dtimestamp;
    }


    @Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
    public int getNtype() {
        return this.ntype;
    }

    public void setNtype(int ntype) {
        this.ntype = ntype;
    }


    @Column(name = "CMESSAGE", nullable = false)
    public String getCmessage() {
        return this.cmessage;
    }

    public void setCmessage(String cmessage) {
        this.cmessage = cmessage;
    }


}


