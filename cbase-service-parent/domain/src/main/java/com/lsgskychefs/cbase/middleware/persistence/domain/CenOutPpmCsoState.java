package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.08.2019 09:48:55 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CSO_STATE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CSO_STATE")
public class CenOutPpmCsoState implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmCsoStateKey;

	@JsonIgnore
	private CenOutPpm cenOutPpm;

	private int ncsoStatus;

	private String ccsoUser;

	private Date dcsoDate;

	private String ccsoComment;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CSO_STATE")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CSO_STATE", sequenceName = "SEQ_CEN_OUT_PPM_CSO_STATE", allocationSize = 1)
	@Column(name = "NPPM_CSO_STATE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmCsoStateKey() {
		return this.nppmCsoStateKey;
	}

	public void setNppmCsoStateKey(final long nppmCsoStateKey) {
		this.nppmCsoStateKey = nppmCsoStateKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_DETAIL_KEY", nullable = false)
	public CenOutPpm getCenOutPpm() {
		return this.cenOutPpm;
	}

	public void setCenOutPpm(final CenOutPpm cenOutPpm) {
		this.cenOutPpm = cenOutPpm;
	}

	@Column(name = "NCSO_STATUS", nullable = false, precision = 5, scale = 0)
	public int getNcsoStatus() {
		return this.ncsoStatus;
	}

	public void setNcsoStatus(final int ncsoStatus) {
		this.ncsoStatus = ncsoStatus;
	}

	@Column(name = "CCSO_USER", length = 40)
	public String getCcsoUser() {
		return this.ccsoUser;
	}

	public void setCcsoUser(final String ccsoUser) {
		this.ccsoUser = ccsoUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCSO_DATE", length = 7)
	public Date getDcsoDate() {
		return this.dcsoDate;
	}

	public void setDcsoDate(final Date dcsoDate) {
		this.dcsoDate = dcsoDate;
	}

	@Column(name = "CCSO_COMMENT", length = 200)
	public String getCcsoComment() {
		return this.ccsoComment;
	}

	public void setCcsoComment(final String ccsoComment) {
		this.ccsoComment = ccsoComment;
	}

}
