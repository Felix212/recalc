package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 5, 2017 12:15:04 PM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table LOC_UNIT_TRAIL_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TRAIL_DETAIL")
public class LocUnitTrailDetail implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntrailDetailKey;
	private LocUnitTrailpoint locUnitTrailpoint;
	private LocUnitTrail locUnitTrail;
	private Date dvalidFrom;
	private Date dvalidTo;
	private int nsort;
	private int noffset;
	private int noffsetType;
	private Long nstoreKey;
	private Integer nstoreTransaction;
	private boolean nsupplierStatusRelevant;

	@Id
	@Column(name = "NTRAIL_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtrailDetailKey() {
		return this.ntrailDetailKey;
	}

	public void setNtrailDetailKey(final long ntrailDetailKey) {
		this.ntrailDetailKey = ntrailDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTRAILPOINT_KEY", nullable = false)
	public LocUnitTrailpoint getLocUnitTrailpoint() {
		return this.locUnitTrailpoint;
	}

	public void setLocUnitTrailpoint(final LocUnitTrailpoint locUnitTrailpoint) {
		this.locUnitTrailpoint = locUnitTrailpoint;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTRAIL_KEY", nullable = false)
	public LocUnitTrail getLocUnitTrail() {
		return this.locUnitTrail;
	}

	public void setLocUnitTrail(final LocUnitTrail locUnitTrail) {
		this.locUnitTrail = locUnitTrail;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NSORT", nullable = false, precision = 2, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 5, scale = 0)
	public int getNoffset() {
		return this.noffset;
	}

	public void setNoffset(final int noffset) {
		this.noffset = noffset;
	}

	@Column(name = "NOFFSET_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNoffsetType() {
		return this.noffsetType;
	}

	public void setNoffsetType(final int noffsetType) {
		this.noffsetType = noffsetType;
	}

	@Column(name = "NSTORE_KEY", precision = 12, scale = 0)
	public Long getNstoreKey() {
		return this.nstoreKey;
	}

	public void setNstoreKey(final Long nstoreKey) {
		this.nstoreKey = nstoreKey;
	}

	@Column(name = "NSTORE_TRANSACTION", precision = 1, scale = 0)
	public Integer getNstoreTransaction() {
		return this.nstoreTransaction;
	}

	public void setNstoreTransaction(final Integer nstoreTransaction) {
		this.nstoreTransaction = nstoreTransaction;
	}

	@Column(name = "NSUPPLIER_STATUS_RELEVANT", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean getNsupplierStatusRelevant() {
		return this.nsupplierStatusRelevant;
	}

	public void setNsupplierStatusRelevant(final boolean nsupplierStatusRelevant) {
		this.nsupplierStatusRelevant = nsupplierStatusRelevant;
	}

}
