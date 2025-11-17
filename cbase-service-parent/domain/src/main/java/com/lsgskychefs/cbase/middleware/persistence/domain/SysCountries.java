package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
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

/**
 * Entity(DomainObject) for table SYS_COUNTRIES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_COUNTRIES")
public class SysCountries implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncountryKey;

	private SysTimezones sysTimezones;

	private SysDateformats sysDateformats;

	private String ccountryUk;

	private String ccountryGer;

	private String ccountryShort;

	private Set<SysThreeLetterCodes> sysThreeLetterCodeses = new HashSet<>(0);

	@Id
	@Column(name = "NCOUNTRY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcountryKey() {
		return this.ncountryKey;
	}

	public void setNcountryKey(final long ncountryKey) {
		this.ncountryKey = ncountryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTIMEZONE_KEY", nullable = false)
	public SysTimezones getSysTimezones() {
		return this.sysTimezones;
	}

	public void setSysTimezones(final SysTimezones sysTimezones) {
		this.sysTimezones = sysTimezones;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFORMAT_KEY", nullable = false)
	public SysDateformats getSysDateformats() {
		return this.sysDateformats;
	}

	public void setSysDateformats(final SysDateformats sysDateformats) {
		this.sysDateformats = sysDateformats;
	}

	@Column(name = "CCOUNTRY_UK", nullable = false, length = 40)
	public String getCcountryUk() {
		return this.ccountryUk;
	}

	public void setCcountryUk(final String ccountryUk) {
		this.ccountryUk = ccountryUk;
	}

	@Column(name = "CCOUNTRY_GER", nullable = false, length = 40)
	public String getCcountryGer() {
		return this.ccountryGer;
	}

	public void setCcountryGer(final String ccountryGer) {
		this.ccountryGer = ccountryGer;
	}

	@Column(name = "CCOUNTRY_SHORT", length = 5)
	public String getCcountryShort() {
		return this.ccountryShort;
	}

	public void setCcountryShort(final String ccountryShort) {
		this.ccountryShort = ccountryShort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysCountries")
	public Set<SysThreeLetterCodes> getSysThreeLetterCodeses() {
		return this.sysThreeLetterCodeses;
	}

	public void setSysThreeLetterCodeses(final Set<SysThreeLetterCodes> sysThreeLetterCodeses) {
		this.sysThreeLetterCodeses = sysThreeLetterCodeses;
	}

}
