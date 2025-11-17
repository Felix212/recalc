package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 20, 2022 12:11:12 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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
 * Entity(DomainObject) for table CEN_SCHEDULE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SCHEDULE")
public class CenSchedule implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nscheduleKey;
	private CenAirlines cenAirlines;
	private CenAircraft cenAircraft;
	private SysThreeLetterCodes sysThreeLetterCodesByNtlcFrom;
	private SysThreeLetterCodes sysThreeLetterCodesByNtlcTo;
	private long nscheduleIndex;
	private int nflightNumber;
	private String csuffix;
	private Date ddvalidFrom;
	private Date ddvalidTo;
	private String cdepartureTime;
	private int nfreq1;
	private int nfreq2;
	private int nfreq3;
	private int nfreq4;
	private int nfreq5;
	private int nfreq6;
	private int nfreq7;
	private Integer nownerId;
	private int nlegNumber;
	private String carrivalTime;
	private String cblockTime;
	private BigDecimal ndepartureFaktor;
	private BigDecimal narrivalFaktor;
	private Long nriskOwner;
	private Long nonwardAirline;
	private Integer nonwardFlightNumber;
	private String conwardSuffix;
	private Date dimportDate;
	private Date dlastModification;
	private String ccountryFrom;
	private String ccountryTo;
	private Integer nimportFlag;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@Column(name = "NSCHEDULE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNscheduleKey() {
		return this.nscheduleKey;
	}

	public void setNscheduleKey(final long nscheduleKey) {
		this.nscheduleKey = nscheduleKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", nullable = false)
	public CenAircraft getCenAircraft() {
		return this.cenAircraft;
	}

	public void setCenAircraft(final CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_FROM", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodesByNtlcFrom() {
		return this.sysThreeLetterCodesByNtlcFrom;
	}

	public void setSysThreeLetterCodesByNtlcFrom(final SysThreeLetterCodes sysThreeLetterCodesByNtlcFrom) {
		this.sysThreeLetterCodesByNtlcFrom = sysThreeLetterCodesByNtlcFrom;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_TO", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodesByNtlcTo() {
		return this.sysThreeLetterCodesByNtlcTo;
	}

	public void setSysThreeLetterCodesByNtlcTo(final SysThreeLetterCodes sysThreeLetterCodesByNtlcTo) {
		this.sysThreeLetterCodesByNtlcTo = sysThreeLetterCodesByNtlcTo;
	}

	@Column(name = "NSCHEDULE_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNscheduleIndex() {
		return this.nscheduleIndex;
	}

	public void setNscheduleIndex(final long nscheduleIndex) {
		this.nscheduleIndex = nscheduleIndex;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDVALID_FROM", nullable = false, length = 7)
	public Date getDdvalidFrom() {
		return this.ddvalidFrom;
	}

	public void setDdvalidFrom(final Date ddvalidFrom) {
		this.ddvalidFrom = ddvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDVALID_TO", nullable = false, length = 7)
	public Date getDdvalidTo() {
		return this.ddvalidTo;
	}

	public void setDdvalidTo(final Date ddvalidTo) {
		this.ddvalidTo = ddvalidTo;
	}

	@Column(name = "CDEPARTURE_TIME", nullable = false, length = 5)
	public String getCdepartureTime() {
		return this.cdepartureTime;
	}

	public void setCdepartureTime(final String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
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

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NLEG_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNlegNumber() {
		return this.nlegNumber;
	}

	public void setNlegNumber(final int nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	@Column(name = "CARRIVAL_TIME", nullable = false, length = 5)
	public String getCarrivalTime() {
		return this.carrivalTime;
	}

	public void setCarrivalTime(final String carrivalTime) {
		this.carrivalTime = carrivalTime;
	}

	@Column(name = "CBLOCK_TIME", nullable = false, length = 5)
	public String getCblockTime() {
		return this.cblockTime;
	}

	public void setCblockTime(final String cblockTime) {
		this.cblockTime = cblockTime;
	}

	@Column(name = "NDEPARTURE_FAKTOR", nullable = false, precision = 7)
	public BigDecimal getNdepartureFaktor() {
		return this.ndepartureFaktor;
	}

	public void setNdepartureFaktor(final BigDecimal ndepartureFaktor) {
		this.ndepartureFaktor = ndepartureFaktor;
	}

	@Column(name = "NARRIVAL_FAKTOR", nullable = false, precision = 7)
	public BigDecimal getNarrivalFaktor() {
		return this.narrivalFaktor;
	}

	public void setNarrivalFaktor(final BigDecimal narrivalFaktor) {
		this.narrivalFaktor = narrivalFaktor;
	}

	@Column(name = "NRISK_OWNER", precision = 12, scale = 0)
	public Long getNriskOwner() {
		return this.nriskOwner;
	}

	public void setNriskOwner(final Long nriskOwner) {
		this.nriskOwner = nriskOwner;
	}

	@Column(name = "NONWARD_AIRLINE", precision = 12, scale = 0)
	public Long getNonwardAirline() {
		return this.nonwardAirline;
	}

	public void setNonwardAirline(final Long nonwardAirline) {
		this.nonwardAirline = nonwardAirline;
	}

	@Column(name = "NONWARD_FLIGHT_NUMBER", precision = 6, scale = 0)
	public Integer getNonwardFlightNumber() {
		return this.nonwardFlightNumber;
	}

	public void setNonwardFlightNumber(final Integer nonwardFlightNumber) {
		this.nonwardFlightNumber = nonwardFlightNumber;
	}

	@Column(name = "CONWARD_SUFFIX", length = 1)
	public String getConwardSuffix() {
		return this.conwardSuffix;
	}

	public void setConwardSuffix(final String conwardSuffix) {
		this.conwardSuffix = conwardSuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DIMPORT_DATE", length = 7)
	public Date getDimportDate() {
		return this.dimportDate;
	}

	public void setDimportDate(final Date dimportDate) {
		this.dimportDate = dimportDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLAST_MODIFICATION", length = 7)
	public Date getDlastModification() {
		return this.dlastModification;
	}

	public void setDlastModification(final Date dlastModification) {
		this.dlastModification = dlastModification;
	}

	@Column(name = "CCOUNTRY_FROM", length = 5)
	public String getCcountryFrom() {
		return this.ccountryFrom;
	}

	public void setCcountryFrom(final String ccountryFrom) {
		this.ccountryFrom = ccountryFrom;
	}

	@Column(name = "CCOUNTRY_TO", length = 5)
	public String getCcountryTo() {
		return this.ccountryTo;
	}

	public void setCcountryTo(final String ccountryTo) {
		this.ccountryTo = ccountryTo;
	}

	@Column(name = "NIMPORT_FLAG", precision = 1, scale = 0)
	public Integer getNimportFlag() {
		return this.nimportFlag;
	}

	public void setNimportFlag(final Integer nimportFlag) {
		this.nimportFlag = nimportFlag;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

}
