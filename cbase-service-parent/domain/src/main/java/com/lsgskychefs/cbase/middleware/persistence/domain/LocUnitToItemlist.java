package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.02.2016 12:58:31 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table LOC_UNIT_TO_ITEMLIST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TO_ITEMLIST")
public class LocUnitToItemlist implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntoItemlistKey;
	private CenPackinglistIndex cenPackinglistIndex;
	private LocUnitToCategories locUnitToCategories;
	private CenAirlines cenAirlines;
	private String cunit;
	private long nclassNumber;
	private int nsort;
	private int nmoduleType;
	private int ncontrolling;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String cclass;
	private long npackinglistIndexKey;

	@Id
	@Column(name = "NTO_ITEMLIST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtoItemlistKey() {
		return this.ntoItemlistKey;
	}

	public void setNtoItemlistKey(final long ntoItemlistKey) {
		this.ntoItemlistKey = ntoItemlistKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(final CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCATEGORY_KEY", nullable = false)
	public LocUnitToCategories getLocUnitToCategories() {
		return this.locUnitToCategories;
	}

	public void setLocUnitToCategories(final LocUnitToCategories locUnitToCategories) {
		this.locUnitToCategories = locUnitToCategories;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NMODULE_TYPE", nullable = false, precision = 2, scale = 0)
	public int getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(final int nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NCONTROLLING", nullable = false, precision = 1, scale = 0)
	public int getNcontrolling() {
		return this.ncontrolling;
	}

	public void setNcontrolling(final int ncontrolling) {
		this.ncontrolling = ncontrolling;
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

	@Column(name = "CCLASS", length = 30)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	/**
	 * Get npackinglistIndexKey
	 *
	 * @return the npackinglistIndexKey
	 */
	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, updatable = false, insertable = false)
	public long getNpackinglistIndexKey() {
		return npackinglistIndexKey;
	}

	/**
	 * set npackinglistIndexKey
	 *
	 * @param npackinglistIndexKey the npackinglistIndexKey to set
	 */
	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

}
