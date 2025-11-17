package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_CITY_PAIRS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CITY_PAIRS")
public class CenCityPairs implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** ncityPairKey */
	private long ncityPairKey;

	/** sysThreeLetterCodesByNtlcTo */
	private SysThreeLetterCodes sysThreeLetterCodesByNtlcTo;

	/** sysThreeLetterCodesByNtlcFrom */
	private SysThreeLetterCodes sysThreeLetterCodesByNtlcFrom;

	/** cenRouting */
	private CenRouting cenRouting;

	/** cenTrafficAreas */
	private CenTrafficAreas cenTrafficAreas;

	/** dvalidFrom */
	private Date dvalidFrom;

	/** dvalidTo */
	private Date dvalidTo;

	/** dtimestampModification */
	private Date dtimestampModification;

	/** nrefund */
	private Integer nrefund;

	@Id
	@Column(name = "NCITY_PAIR_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcityPairKey() {
		return this.ncityPairKey;
	}

	public void setNcityPairKey(final long ncityPairKey) {
		this.ncityPairKey = ncityPairKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_TO", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodesByNtlcTo() {
		return this.sysThreeLetterCodesByNtlcTo;
	}

	public void setSysThreeLetterCodesByNtlcTo(final SysThreeLetterCodes sysThreeLetterCodesByNtlcTo) {
		this.sysThreeLetterCodesByNtlcTo = sysThreeLetterCodesByNtlcTo;
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
	@JoinColumn(name = "NROUTING_ID")
	public CenRouting getCenRouting() {
		return this.cenRouting;
	}

	public void setCenRouting(final CenRouting cenRouting) {
		this.cenRouting = cenRouting;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAREA_KEY", nullable = false)
	public CenTrafficAreas getCenTrafficAreas() {
		return this.cenTrafficAreas;
	}

	public void setCenTrafficAreas(final CenTrafficAreas cenTrafficAreas) {
		this.cenTrafficAreas = cenTrafficAreas;
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

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NREFUND", precision = 1, scale = 0)
	public Integer getNrefund() {
		return this.nrefund;
	}

	public void setNrefund(final Integer nrefund) {
		this.nrefund = nrefund;
	}

}
