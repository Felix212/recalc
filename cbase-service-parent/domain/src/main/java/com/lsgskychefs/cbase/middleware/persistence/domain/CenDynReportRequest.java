package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 25.06.2021 11:44:31 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_DYN_REPORT_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DYN_REPORT_REQUEST"
)
public class CenDynReportRequest implements DomainObject, java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nrequestKey;
    private SysCustomerReports sysCustomerReports;
    private String crequester;
    private Date dtimestamp;
    private Set<CenDynReportRows> cenDynReportRowses = new HashSet<>(0);
    private Set<CenDynReportHeader> cenDynReportHeaders = new HashSet<>(0);

    public CenDynReportRequest() {
    }

    public CenDynReportRequest(final SysCustomerReports sysCustomerReports, final String crequester, final Date dtimestamp) {
        this.sysCustomerReports = sysCustomerReports;
        this.crequester = crequester;
        this.dtimestamp = dtimestamp;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DYN_REPORT_REQUEST")
    @SequenceGenerator(name = "SEQ_CEN_DYN_REPORT_REQUEST", sequenceName = "SEQ_CEN_DYN_REPORT_REQUEST", allocationSize = 1)
    @Column(name = "NREQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNrequestKey() {
        return this.nrequestKey;
    }

    public void setNrequestKey(long nrequestKey) {
        this.nrequestKey = nrequestKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NREPORT_KEY", nullable = false)
    public SysCustomerReports getSysCustomerReports() {
        return this.sysCustomerReports;
    }

    public void setSysCustomerReports(SysCustomerReports sysCustomerReports) {
        this.sysCustomerReports = sysCustomerReports;
    }

    @Column(name = "CREQUESTER", nullable = false, length = 32)
    public String getCrequester() {
        return this.crequester;
    }

    public void setCrequester(String crequester) {
        this.crequester = crequester;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP", nullable = false, length = 7)
    public Date getDtimestamp() {
        return this.dtimestamp;
    }

    public void setDtimestamp(Date dtimestamp) {
        this.dtimestamp = dtimestamp;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenDynReportRequest")
    public Set<CenDynReportRows> getCenDynReportRowses() {
        return this.cenDynReportRowses;
    }

    public void setCenDynReportRowses(Set<CenDynReportRows> cenDynReportRowses) {
        this.cenDynReportRowses = cenDynReportRowses;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenDynReportRequest")
    public Set<CenDynReportHeader> getCenDynReportHeaders() {
        return this.cenDynReportHeaders;
    }

    public void setCenDynReportHeaders(Set<CenDynReportHeader> cenDynReportHeaders) {
        this.cenDynReportHeaders = cenDynReportHeaders;
    }
}


