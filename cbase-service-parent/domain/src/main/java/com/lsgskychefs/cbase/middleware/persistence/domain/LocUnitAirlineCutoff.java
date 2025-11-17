package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 29.09.2025 11:50:50 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table LOC_UNIT_AIRLINE_CUTOFF
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_AIRLINE_CUTOFF")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitAirlineCutoff implements DomainObject, java.io.Serializable {

	private long nunitAirlineCutoffKey;
	private SysUnits sysUnits;
	private CenAirlines cenAirlines;
	private int nflightNumberFrom;
	private int nflightNumberTo;
	private String crouting;
	private String cdeptimeFrom;
	private String cdeptimeTo;
	private int ncutoffMinutes;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_AIRLINE_CUTOFF")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_AIRLINE_CUTOFF", sequenceName = "SEQ_LOC_UNIT_AIRLINE_CUTOFF", allocationSize = 1)
	@Column(name = "NUNIT_AIRLINE_CUTOFF_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNunitAirlineCutoffKey() {
		return this.nunitAirlineCutoffKey;
	}

	public void setNunitAirlineCutoffKey(long nunitAirlineCutoffKey) {
		this.nunitAirlineCutoffKey = nunitAirlineCutoffKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "NFLIGHT_NUMBER_FROM", nullable = false, precision = 4, scale = 0)
	public int getNflightNumberFrom() {
		return this.nflightNumberFrom;
	}

	public void setNflightNumberFrom(int nflightNumberFrom) {
		this.nflightNumberFrom = nflightNumberFrom;
	}

	@Column(name = "NFLIGHT_NUMBER_TO", nullable = false, precision = 4, scale = 0)
	public int getNflightNumberTo() {
		return this.nflightNumberTo;
	}

	public void setNflightNumberTo(int nflightNumberTo) {
		this.nflightNumberTo = nflightNumberTo;
	}

	@Column(name = "CROUTING", nullable = false, length = 5)
	public String getCrouting() {
		return this.crouting;
	}

	public void setCrouting(String crouting) {
		this.crouting = crouting;
	}

	@Column(name = "CDEPTIME_FROM", nullable = false, length = 5)
	public String getCdeptimeFrom() {
		return this.cdeptimeFrom;
	}

	public void setCdeptimeFrom(String cdeptimeFrom) {
		this.cdeptimeFrom = cdeptimeFrom;
	}

	@Column(name = "CDEPTIME_TO", nullable = false, length = 5)
	public String getCdeptimeTo() {
		return this.cdeptimeTo;
	}

	public void setCdeptimeTo(String cdeptimeTo) {
		this.cdeptimeTo = cdeptimeTo;
	}

	@Column(name = "NCUTOFF_MINUTES", nullable = false, precision = 4, scale = 0)
	public int getNcutoffMinutes() {
		return this.ncutoffMinutes;
	}

	public void setNcutoffMinutes(int ncutoffMinutes) {
		this.ncutoffMinutes = ncutoffMinutes;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CUPDATED_BY", length = 15)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 15)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

}


