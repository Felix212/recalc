package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14.10.2019 11:33:07 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_PL_TIME_FRAME_VARIANT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PL_TIME_FRAME_VARIANT")
public class LocPlTimeFrameVariant implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nvariantIndex;

	private LocUnitPpmValidities locUnitPpmValidities;

	private long nvariant;

	private Date dvalidFrom;

	private Date dvalidTo;

	private String cfrequency;

	private String cunit;

	private long nairlineKey;

	private String ctext;

	private int nfreq1;

	private int nfreq2;

	private int nfreq3;

	private int nfreq4;

	private int nfreq5;

	private int nfreq6;

	private int nfreq7;

	private Set<LocPlTimeFrame> locPlTimeFrames = new HashSet<>(0);

	@Id
	@Column(name = "NVARIANT_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNvariantIndex() {
		return this.nvariantIndex;
	}

	public void setNvariantIndex(final long nvariantIndex) {
		this.nvariantIndex = nvariantIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NVALID_INDEX", nullable = false)
	public LocUnitPpmValidities getLocUnitPpmValidities() {
		return this.locUnitPpmValidities;
	}

	public void setLocUnitPpmValidities(final LocUnitPpmValidities locUnitPpmValidities) {
		this.locUnitPpmValidities = locUnitPpmValidities;
	}

	@Column(name = "NVARIANT", nullable = false, precision = 12, scale = 0)
	public long getNvariant() {
		return this.nvariant;
	}

	public void setNvariant(final long nvariant) {
		this.nvariant = nvariant;
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

	@Column(name = "CFREQUENCY", nullable = false, length = 7)
	public String getCfrequency() {
		return this.cfrequency;
	}

	public void setCfrequency(final String cfrequency) {
		this.cfrequency = cfrequency;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NFREQ1", nullable = false, precision = 1, scale = 0)
	public int getNfreq1() {
		return this.nfreq1;
	}

	public void setNfreq1(final int nfreq1) {
		this.nfreq1 = nfreq1;
	}

	@Column(name = "NFREQ2", nullable = false, precision = 1, scale = 0)
	public int getNfreq2() {
		return this.nfreq2;
	}

	public void setNfreq2(final int nfreq2) {
		this.nfreq2 = nfreq2;
	}

	@Column(name = "NFREQ3", nullable = false, precision = 1, scale = 0)
	public int getNfreq3() {
		return this.nfreq3;
	}

	public void setNfreq3(final int nfreq3) {
		this.nfreq3 = nfreq3;
	}

	@Column(name = "NFREQ4", nullable = false, precision = 1, scale = 0)
	public int getNfreq4() {
		return this.nfreq4;
	}

	public void setNfreq4(final int nfreq4) {
		this.nfreq4 = nfreq4;
	}

	@Column(name = "NFREQ5", nullable = false, precision = 1, scale = 0)
	public int getNfreq5() {
		return this.nfreq5;
	}

	public void setNfreq5(final int nfreq5) {
		this.nfreq5 = nfreq5;
	}

	@Column(name = "NFREQ6", nullable = false, precision = 1, scale = 0)
	public int getNfreq6() {
		return this.nfreq6;
	}

	public void setNfreq6(final int nfreq6) {
		this.nfreq6 = nfreq6;
	}

	@Column(name = "NFREQ7", nullable = false, precision = 1, scale = 0)
	public int getNfreq7() {
		return this.nfreq7;
	}

	public void setNfreq7(final int nfreq7) {
		this.nfreq7 = nfreq7;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPlTimeFrameVariant")
	public Set<LocPlTimeFrame> getLocPlTimeFrames() {
		return this.locPlTimeFrames;
	}

	public void setLocPlTimeFrames(final Set<LocPlTimeFrame> locPlTimeFrames) {
		this.locPlTimeFrames = locPlTimeFrames;
	}

}
