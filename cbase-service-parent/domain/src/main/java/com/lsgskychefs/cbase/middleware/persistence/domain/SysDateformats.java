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
 * Entity(DomainObject) for table SYS_DATEFORMATS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_DATEFORMATS")
public class SysDateformats implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nformatKey;

	private String cdateformat;

	private String cdescription;

	private Set<SysCountries> sysCountrieses = new HashSet<>(0);

	@Id
	@Column(name = "NFORMAT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNformatKey() {
		return this.nformatKey;
	}

	public void setNformatKey(final long nformatKey) {
		this.nformatKey = nformatKey;
	}

	@Column(name = "CDATEFORMAT", nullable = false, length = 20)
	public String getCdateformat() {
		return this.cdateformat;
	}

	public void setCdateformat(final String cdateformat) {
		this.cdateformat = cdateformat;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 128)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysDateformats")
	public Set<SysCountries> getSysCountrieses() {
		return this.sysCountrieses;
	}

	public void setSysCountrieses(final Set<SysCountries> sysCountrieses) {
		this.sysCountrieses = sysCountrieses;
	}

}
