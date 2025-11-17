package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.11.2016 10:41:13 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_EU_ALLERGENS_ADD_TEXT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_EU_ALLERGENS_ADD_TEXT")
public class SysEuAllergensAddText implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long neuAllgAddTextKey;
	private SysLanguages sysLanguages;
	private int nsort;
	private String ctext;
	private int nactive;

	public SysEuAllergensAddText() {
	}

	public SysEuAllergensAddText(final long neuAllgAddTextKey, final SysLanguages sysLanguages, final int nsort, final String ctext,
			final int nactive) {
		this.neuAllgAddTextKey = neuAllgAddTextKey;
		this.sysLanguages = sysLanguages;
		this.nsort = nsort;
		this.ctext = ctext;
		this.nactive = nactive;
	}

	@Id

	@Column(name = "NEU_ALLG_ADD_TEXT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuAllgAddTextKey() {
		return this.neuAllgAddTextKey;
	}

	public void setNeuAllgAddTextKey(final long neuAllgAddTextKey) {
		this.neuAllgAddTextKey = neuAllgAddTextKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLANG_KEY", nullable = false)
	public SysLanguages getSysLanguages() {
		return this.sysLanguages;
	}

	public void setSysLanguages(final SysLanguages sysLanguages) {
		this.sysLanguages = sysLanguages;
	}

	@Column(name = "NSORT", nullable = false, precision = 1, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CTEXT", nullable = false, length = 200)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NACTIVE", nullable = false, precision = 1, scale = 0)
	public int getNactive() {
		return this.nactive;
	}

	public void setNactive(final int nactive) {
		this.nactive = nactive;
	}

}
