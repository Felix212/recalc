package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 11.04.2016 15:18:07 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_REPORT_PARAMETERS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REPORT_PARAMETERS")
public class CenReportParameters implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nparameterId;
	private long nparameterGroup;
	private Long nvalue;
	private String cvalue;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_REPORT_PARAMETERS")
	@SequenceGenerator(name = "SEQ_CEN_REPORT_PARAMETERS", sequenceName = "SEQ_CEN_REPORT_PARAMETERS", allocationSize = 1)
	@Column(name = "NPARAMETER_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNparameterId() {
		return this.nparameterId;
	}

	public void setNparameterId(final long nparameterId) {
		this.nparameterId = nparameterId;
	}

	@Column(name = "NPARAMETER_GROUP", nullable = false, precision = 12, scale = 0)
	public long getNparameterGroup() {
		return this.nparameterGroup;
	}

	public void setNparameterGroup(final long nparameterGroup) {
		this.nparameterGroup = nparameterGroup;
	}

	@Column(name = "NVALUE", precision = 12, scale = 0)
	public Long getNvalue() {
		return this.nvalue;
	}

	public void setNvalue(final Long nvalue) {
		this.nvalue = nvalue;
	}

	@Column(name = "CVALUE", length = 40)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
