package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13.12.2022 14:30:50 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_ORDER_REQUEST_STATUS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ORDER_REQUEST_STATUS"
)
public class SysOrderRequestStatus implements DomainObject, Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private int nrequestStatus;
    private String ctext;
    private String cdescription;
    private Set<CenOutOrderRequestHistory> cenOutOrderRequestHistories = new HashSet<>(0);
    private Set<CenOutOrderRequest> cenOutOrderRequests = new HashSet<>(0);

    @Id
    @Column(name = "NREQUEST_STATUS", unique = true, nullable = false, precision = 2, scale = 0)
    public int getNrequestStatus() {
        return this.nrequestStatus;
    }

    public void setNrequestStatus(int nrequestStatus) {
        this.nrequestStatus = nrequestStatus;
    }


    @Column(name = "CTEXT", nullable = false, length = 16)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(String ctext) {
        this.ctext = ctext;
    }


    @Column(name = "CDESCRIPTION", nullable = false, length = 64)
    public String getCdescription() {
        return this.cdescription;
    }

    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sysOrderRequestStatus")
    public Set<CenOutOrderRequestHistory> getCenOutOrderRequestHistories() {
        return this.cenOutOrderRequestHistories;
    }

    public void setCenOutOrderRequestHistories(Set<CenOutOrderRequestHistory> cenOutOrderRequestHistories) {
        this.cenOutOrderRequestHistories = cenOutOrderRequestHistories;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sysOrderRequestStatus")
    public Set<CenOutOrderRequest> getCenOutOrderRequests() {
        return this.cenOutOrderRequests;
    }

    public void setCenOutOrderRequests(Set<CenOutOrderRequest> cenOutOrderRequests) {
        this.cenOutOrderRequests = cenOutOrderRequests;
    }
}


