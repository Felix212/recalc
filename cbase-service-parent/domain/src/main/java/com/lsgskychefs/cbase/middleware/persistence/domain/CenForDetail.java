package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 11, 2019 12:20:45 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_FOR_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_FOR_DETAIL")
public class CenForDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long fordNkey;
	private CenForMaster cenForMaster;
	private CenEmailGroupsMaster cenEmailGroupsMaster;
	private CenEmailSignMaster cenEmailSignMasterByFordEsmNkeyHeader;
	private CenEmailSignMaster cenEmailSignMasterByFordEsmNkeyFooter;
	private Date fordDvalidFrom;
	private Date fordDvalidTo;

	@Id
	@Column(name = "FORD_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getFordNkey() {
		return this.fordNkey;
	}

	public void setFordNkey(final long fordNkey) {
		this.fordNkey = fordNkey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORD_FORM_NKEY", nullable = false)
	public CenForMaster getCenForMaster() {
		return this.cenForMaster;
	}

	public void setCenForMaster(final CenForMaster cenForMaster) {
		this.cenForMaster = cenForMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORD_EGM_NKEY", nullable = false)
	public CenEmailGroupsMaster getCenEmailGroupsMaster() {
		return this.cenEmailGroupsMaster;
	}

	public void setCenEmailGroupsMaster(final CenEmailGroupsMaster cenEmailGroupsMaster) {
		this.cenEmailGroupsMaster = cenEmailGroupsMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORD_ESM_NKEY_HEADER", nullable = false)
	public CenEmailSignMaster getCenEmailSignMasterByFordEsmNkeyHeader() {
		return this.cenEmailSignMasterByFordEsmNkeyHeader;
	}

	public void setCenEmailSignMasterByFordEsmNkeyHeader(final CenEmailSignMaster cenEmailSignMasterByFordEsmNkeyHeader) {
		this.cenEmailSignMasterByFordEsmNkeyHeader = cenEmailSignMasterByFordEsmNkeyHeader;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORD_ESM_NKEY_FOOTER", nullable = false)
	public CenEmailSignMaster getCenEmailSignMasterByFordEsmNkeyFooter() {
		return this.cenEmailSignMasterByFordEsmNkeyFooter;
	}

	public void setCenEmailSignMasterByFordEsmNkeyFooter(final CenEmailSignMaster cenEmailSignMasterByFordEsmNkeyFooter) {
		this.cenEmailSignMasterByFordEsmNkeyFooter = cenEmailSignMasterByFordEsmNkeyFooter;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORD_DVALID_FROM", length = 7)
	public Date getFordDvalidFrom() {
		return this.fordDvalidFrom;
	}

	public void setFordDvalidFrom(final Date fordDvalidFrom) {
		this.fordDvalidFrom = fordDvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORD_DVALID_TO", length = 7)
	public Date getFordDvalidTo() {
		return this.fordDvalidTo;
	}

	public void setFordDvalidTo(final Date fordDvalidTo) {
		this.fordDvalidTo = fordDvalidTo;
	}

}
