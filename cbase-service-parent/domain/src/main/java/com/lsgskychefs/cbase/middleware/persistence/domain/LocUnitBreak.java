package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.09.2017 20:57:55 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_BREAK
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_BREAK")
public class LocUnitBreak implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbreakKey;
	@JsonIgnore
	private SysUnits sysUnits;
	private String cclient;
	private String cbreak;
	private String cdescription;
	private int nduration;
	private byte[] bpicture;

	@Id
	@Column(name = "NBREAK_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbreakKey() {
		return this.nbreakKey;
	}

	public void setNbreakKey(final long nbreakKey) {
		this.nbreakKey = nbreakKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
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

	@Column(name = "CBREAK", nullable = false, length = 40)
	public String getCbreak() {
		return this.cbreak;
	}

	public void setCbreak(final String cbreak) {
		this.cbreak = cbreak;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NDURATION", nullable = false, precision = 3, scale = 0)
	public int getNduration() {
		return this.nduration;
	}

	public void setNduration(final int nduration) {
		this.nduration = nduration;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

}
