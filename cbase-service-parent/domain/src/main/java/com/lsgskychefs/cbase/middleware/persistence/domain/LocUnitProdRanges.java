package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_UNIT_PROD_RANGES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PROD_RANGES", uniqueConstraints = @UniqueConstraint(columnNames = { "CCLIENT", "CUNIT", "CRANGE" }))
public class LocUnitProdRanges implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nrangeKey;
	private String cclient;
	private String cunit;
	private String crange;
	private int nsort;
	private String cdescription;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_PROD_RANGES")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_PROD_RANGES", sequenceName = "SEQ_LOC_UNIT_PROD_RANGES", allocationSize = 1)
	@Column(name = "NRANGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNrangeKey() {
		return this.nrangeKey;
	}

	public void setNrangeKey(final long nrangeKey) {
		this.nrangeKey = nrangeKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CRANGE", nullable = false, length = 12)
	public String getCrange() {
		return this.crange;
	}

	public void setCrange(final String crange) {
		this.crange = crange;
	}

	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

}
