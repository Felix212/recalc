package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_THREE_LETTER_CODES<br>
 * IATA-Flughafencode (engl. IATA airport code oder IATA station code, manchmal auch IATA (Airport) Three Letter Code, (AP)3LC)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_THREE_LETTER_CODES", uniqueConstraints = @UniqueConstraint(columnNames = "CTLC"))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysThreeLetterCodes implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntlcKey;

	@JsonIgnore
	private SysCountries sysCountries;

	@JsonIgnore
	private SysTimezones sysTimezones;

	private String ctlc;

	private String cdestination;

	private BigDecimal ngmt;

	private Integer nloadPrio;

	@JsonIgnore
	private Set<SysUnits> sysUnitses = new HashSet<>(0);

	@Id
	@Column(name = "NTLC_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtlcKey() {
		return this.ntlcKey;
	}

	public void setNtlcKey(final long ntlcKey) {
		this.ntlcKey = ntlcKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCOUNTRY_KEY", nullable = false)
	public SysCountries getSysCountries() {
		return this.sysCountries;
	}

	public void setSysCountries(final SysCountries sysCountries) {
		this.sysCountries = sysCountries;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTIMEZONE_KEY", nullable = false)
	public SysTimezones getSysTimezones() {
		return this.sysTimezones;
	}

	public void setSysTimezones(final SysTimezones sysTimezones) {
		this.sysTimezones = sysTimezones;
	}

	@Column(name = "CTLC", unique = true, nullable = false, length = 3)
	public String getCtlc() {
		return this.ctlc;
	}

	public void setCtlc(final String ctlc) {
		this.ctlc = ctlc;
	}

	@Column(name = "CDESTINATION", nullable = false, length = 50)
	public String getCdestination() {
		return this.cdestination;
	}

	public void setCdestination(final String cdestination) {
		this.cdestination = cdestination;
	}

	@Column(name = "NGMT", nullable = false, precision = 5)
	public BigDecimal getNgmt() {
		return this.ngmt;
	}

	public void setNgmt(final BigDecimal ngmt) {
		this.ngmt = ngmt;
	}

	@Column(name = "NLOAD_PRIO", precision = 1, scale = 0)
	public Integer getNloadPrio() {
		return this.nloadPrio;
	}

	public void setNloadPrio(final Integer nloadPrio) {
		this.nloadPrio = nloadPrio;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysThreeLetterCodes")
	public Set<SysUnits> getSysUnitses() {
		return this.sysUnitses;
	}

	public void setSysUnitses(final Set<SysUnits> sysUnitses) {
		this.sysUnitses = sysUnitses;
	}

}
