package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 16, 2019 5:40:26 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_SUBST_FLIGHT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_SUBST_FLIGHT")
public class LocSubstFlight implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsubstFlightKey;
	private SysThreeLetterCodes sysThreeLetterCodes;
	private SysUnits sysUnits;
	private CenRouting cenRouting;
	private CenAircraft cenAircraft;
	private CenAirlines cenAirlines;
	private int naircraftAll;
	private int nhandlingTypeAll;
	private int nroutingIdAll;
	private int ntlcFromAll;
	private int ntlcToAll;
	private int nflightNumber;
	private int nflightNumberAll;
	private String csuffix;
	private int nsuffixAll;
	private int nfreq1;
	private int nfreq2;
	private int nfreq3;
	private int nfreq4;
	private int nfreq5;
	private int nfreq6;
	private int nfreq7;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String ctimeFrom;
	private String ctimeTo;
	private String copsctext;
	private Integer nactive;
	private String cflightKey;
	private Long nresultKey;
	private Set<LocSubstItemlist> locSubstItemlists = new HashSet<>(0);
	private Set<CenHandlingTypes> cenHandlingTypeses = new HashSet<>(0);
	private Set<SysThreeLetterCodes> sysThreeLetterCodeses = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_SUBST_FLIGHT")
	@SequenceGenerator(name = "SEQ_LOC_SUBST_FLIGHT", sequenceName = "SEQ_LOC_SUBST_FLIGHT", allocationSize = 1)
	@Column(name = "NSUBST_FLIGHT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsubstFlightKey() {
		return this.nsubstFlightKey;
	}

	public void setNsubstFlightKey(final long nsubstFlightKey) {
		this.nsubstFlightKey = nsubstFlightKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_FROM", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodes() {
		return this.sysThreeLetterCodes;
	}

	public void setSysThreeLetterCodes(final SysThreeLetterCodes sysThreeLetterCodes) {
		this.sysThreeLetterCodes = sysThreeLetterCodes;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROUTING_ID", nullable = false)
	public CenRouting getCenRouting() {
		return this.cenRouting;
	}

	public void setCenRouting(final CenRouting cenRouting) {
		this.cenRouting = cenRouting;
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
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "NAIRCRAFT_ALL", nullable = false, precision = 1, scale = 0)
	public int getNaircraftAll() {
		return this.naircraftAll;
	}

	public void setNaircraftAll(final int naircraftAll) {
		this.naircraftAll = naircraftAll;
	}

	@Column(name = "NHANDLING_TYPE_ALL", nullable = false, precision = 1, scale = 0)
	public int getNhandlingTypeAll() {
		return this.nhandlingTypeAll;
	}

	public void setNhandlingTypeAll(final int nhandlingTypeAll) {
		this.nhandlingTypeAll = nhandlingTypeAll;
	}

	@Column(name = "NROUTING_ID_ALL", nullable = false, precision = 1, scale = 0)
	public int getNroutingIdAll() {
		return this.nroutingIdAll;
	}

	public void setNroutingIdAll(final int nroutingIdAll) {
		this.nroutingIdAll = nroutingIdAll;
	}

	@Column(name = "NTLC_FROM_ALL", nullable = false, precision = 1, scale = 0)
	public int getNtlcFromAll() {
		return this.ntlcFromAll;
	}

	public void setNtlcFromAll(final int ntlcFromAll) {
		this.ntlcFromAll = ntlcFromAll;
	}

	@Column(name = "NTLC_TO_ALL", nullable = false, precision = 1, scale = 0)
	public int getNtlcToAll() {
		return this.ntlcToAll;
	}

	public void setNtlcToAll(final int ntlcToAll) {
		this.ntlcToAll = ntlcToAll;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "NFLIGHT_NUMBER_ALL", nullable = false, precision = 1, scale = 0)
	public int getNflightNumberAll() {
		return this.nflightNumberAll;
	}

	public void setNflightNumberAll(final int nflightNumberAll) {
		this.nflightNumberAll = nflightNumberAll;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Column(name = "NSUFFIX_ALL", nullable = false, precision = 1, scale = 0)
	public int getNsuffixAll() {
		return this.nsuffixAll;
	}

	public void setNsuffixAll(final int nsuffixAll) {
		this.nsuffixAll = nsuffixAll;
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

	@Column(name = "CTIME_FROM", nullable = false, length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(final String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", nullable = false, length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(final String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Column(name = "COPSCTEXT", length = 20)
	public String getCopsctext() {
		return this.copsctext;
	}

	public void setCopsctext(final String copsctext) {
		this.copsctext = copsctext;
	}

	@Column(name = "NACTIVE", precision = 1, scale = 0)
	public Integer getNactive() {
		return this.nactive;
	}

	public void setNactive(final Integer nactive) {
		this.nactive = nactive;
	}

	@Column(name = "CFLIGHT_KEY", length = 25)
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "NRESULT_KEY", precision = 12, scale = 0)
	public Long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final Long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locSubstFlight")
	public Set<LocSubstItemlist> getLocSubstItemlists() {
		return this.locSubstItemlists;
	}

	public void setLocSubstItemlists(final Set<LocSubstItemlist> locSubstItemlists) {
		this.locSubstItemlists = locSubstItemlists;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "LOC_SUBST_HANDLING", joinColumns = {
			@JoinColumn(name = "NSUBST_FLIGHT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NHANDLING_TYPE_KEY", nullable = false, updatable = false) })
	public Set<CenHandlingTypes> getCenHandlingTypeses() {
		return this.cenHandlingTypeses;
	}

	public void setCenHandlingTypeses(final Set<CenHandlingTypes> cenHandlingTypeses) {
		this.cenHandlingTypeses = cenHandlingTypeses;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "LOC_SUBST_TLCTO", joinColumns = {
			@JoinColumn(name = "NSUBST_FLIGHT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NTLC_KEY", nullable = false, updatable = false) })
	public Set<SysThreeLetterCodes> getSysThreeLetterCodeses() {
		return this.sysThreeLetterCodeses;
	}

	public void setSysThreeLetterCodeses(final Set<SysThreeLetterCodes> sysThreeLetterCodeses) {
		this.sysThreeLetterCodeses = sysThreeLetterCodeses;
	}

}
