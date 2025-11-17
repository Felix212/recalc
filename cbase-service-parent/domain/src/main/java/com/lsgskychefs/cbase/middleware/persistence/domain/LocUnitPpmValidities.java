package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_UNIT_PPM_VALIDITIES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PPM_VALIDITIES")
public class LocUnitPpmValidities implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nvalidIndex;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String ctext;
	private String cunit;
	private Set<LocUnitProdTimeFrame> locUnitProdTimeFrames = new HashSet<>(0);
	private Set<LocUnitWsSchedIncrease> locUnitWsSchedIncreases = new HashSet<>(0);
	private Set<LocUnitWsSchedule> locUnitWsSchedules = new HashSet<>(0);

	@Id

	@Column(name = "NVALID_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNvalidIndex() {
		return this.nvalidIndex;
	}

	public void setNvalidIndex(final long nvalidIndex) {
		this.nvalidIndex = nvalidIndex;
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

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitPpmValidities")
	public Set<LocUnitProdTimeFrame> getLocUnitProdTimeFrames() {
		return this.locUnitProdTimeFrames;
	}

	public void setLocUnitProdTimeFrames(final Set<LocUnitProdTimeFrame> locUnitProdTimeFrames) {
		this.locUnitProdTimeFrames = locUnitProdTimeFrames;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitPpmValidities")
	public Set<LocUnitWsSchedule> getLocUnitWsSchedules() {
		return this.locUnitWsSchedules;
	}

	public void setLocUnitWsSchedules(final Set<LocUnitWsSchedule> locUnitWsSchedules) {
		this.locUnitWsSchedules = locUnitWsSchedules;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitPpmValidities")
	public Set<LocUnitWsSchedIncrease> getLocUnitWsSchedIncreases() {
		return this.locUnitWsSchedIncreases;
	}

	public void setLocUnitWsSchedIncreases(final Set<LocUnitWsSchedIncrease> locUnitWsSchedIncreases) {
		this.locUnitWsSchedIncreases = locUnitWsSchedIncreases;
	}

}
