package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 18, 2025 11:21:36 AM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_MP_PL_STATUS
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_MP_PL_STATUS")
public class SysMpPlStatus  implements DomainObject,java.io.Serializable {


     private long nmpPlStatusKey;
     private String ctype;
     private Date dtimestamp;

     @Id
    @Column(name="NMP_PL_STATUS_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNmpPlStatusKey() {
        return this.nmpPlStatusKey;
    }
    
    public void setNmpPlStatusKey(long nmpPlStatusKey) {
        this.nmpPlStatusKey = nmpPlStatusKey;
    }

    
    @Column(name="CTYPE", nullable=false, length=40)
    public String getCtype() {
        return this.ctype;
    }
    
    public void setCtype(String ctype) {
        this.ctype = ctype;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DTIMESTAMP", length=7)
    public Date getDtimestamp() {
        return this.dtimestamp;
    }
    
    public void setDtimestamp(Date dtimestamp) {
        this.dtimestamp = dtimestamp;
    }

}


