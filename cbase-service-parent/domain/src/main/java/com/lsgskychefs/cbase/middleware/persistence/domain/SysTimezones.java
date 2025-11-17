package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.12.2019 10:30:39 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_TIMEZONES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_TIMEZONES")
public class SysTimezones implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntimezoneKey;

	private String ccountryCode;

	private String ccountryZone;

	private String cgmtOffset;

	private String cdescription;

	private Set<SysThreeLetterCodes> sysThreeLetterCodeses = new HashSet<>(0);

	private Set<SysCountries> sysCountrieses = new HashSet<>(0);

	@Id
	@Column(name = "NTIMEZONE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtimezoneKey() {
		return this.ntimezoneKey;
	}

	public void setNtimezoneKey(final long ntimezoneKey) {
		this.ntimezoneKey = ntimezoneKey;
	}

	@Column(name = "CCOUNTRY_CODE", nullable = false, length = 4)
	public String getCcountryCode() {
		return this.ccountryCode;
	}

	public void setCcountryCode(final String ccountryCode) {
		this.ccountryCode = ccountryCode;
	}

	@Column(name = "CCOUNTRY_ZONE", nullable = false, length = 4)
	public String getCcountryZone() {
		return this.ccountryZone;
	}

	public void setCcountryZone(final String ccountryZone) {
		this.ccountryZone = ccountryZone;
	}

	@Column(name = "CGMT_OFFSET", nullable = false, length = 6)
	public String getCgmtOffset() {
		return this.cgmtOffset;
	}

	public void setCgmtOffset(final String cgmtOffset) {
		this.cgmtOffset = cgmtOffset;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 50)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysTimezones")
	public Set<SysThreeLetterCodes> getSysThreeLetterCodeses() {
		return this.sysThreeLetterCodeses;
	}

	public void setSysThreeLetterCodeses(final Set<SysThreeLetterCodes> sysThreeLetterCodeses) {
		this.sysThreeLetterCodeses = sysThreeLetterCodeses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysTimezones")
	public Set<SysCountries> getSysCountrieses() {
		return this.sysCountrieses;
	}

	public void setSysCountrieses(final Set<SysCountries> sysCountrieses) {
		this.sysCountrieses = sysCountrieses;
	}

}
