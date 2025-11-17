package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 25.06.2021 11:44:31 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_DYN_REPORT_ROWS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DYN_REPORT_ROWS"
)
public class CenDynReportRows implements DomainObject, java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private CenDynReportRowsId id;
    private CenDynReportRequest cenDynReportRequest;
    private String cvalue;

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "nrequestKey", column = @Column(name = "NREQUEST_KEY", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "nrow", column = @Column(name = "NROW", nullable = false, precision = 4, scale = 0)),
            @AttributeOverride(name = "ccolumn", column = @Column(name = "CCOLUMN", nullable = false, length = 32))})
    public CenDynReportRowsId getId() {
        return this.id;
    }

    public void setId(CenDynReportRowsId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NREQUEST_KEY", nullable = false, insertable = false, updatable = false)
    public CenDynReportRequest getCenDynReportRequest() {
        return this.cenDynReportRequest;
    }

    public void setCenDynReportRequest(CenDynReportRequest cenDynReportRequest) {
        this.cenDynReportRequest = cenDynReportRequest;
    }

    @Column(name = "CVALUE", length = 50)
    public String getCvalue() {
        return this.cvalue;
    }

    public void setCvalue(String cvalue) {
        this.cvalue = cvalue;
    }
}


