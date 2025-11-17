package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 18, 2019 3:41:30 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_DISPO_GROUPS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_DISPO_GROUPS")
public class LocDispoGroups implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndispoGroupKey;
	@JsonIgnore
	private SysUnits sysUnits;
	private String cclient;
	private String ctext;
	private String cdescription;
	private String cunit;

	@Id
	@Column(name = "NDISPO_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdispoGroupKey() {
		return this.ndispoGroupKey;
	}

	public void setNdispoGroupKey(final long ndispoGroupKey) {
		this.ndispoGroupKey = ndispoGroupKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT")
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Transient
	public String getCunit() {
		cunit = sysUnits.getCunit();
		return cunit;
	}

}
