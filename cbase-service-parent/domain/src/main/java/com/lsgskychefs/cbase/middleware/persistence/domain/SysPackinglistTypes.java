package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_PACKINGLIST_TYPES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PACKINGLIST_TYPES", uniqueConstraints = @UniqueConstraint(columnNames = "CTEXT"))
public class SysPackinglistTypes implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long npltypeKey;
	private String ctext;
	private String cdescription;
	private int ndefault;
	private String cimportKey;
	private Integer nsystem;
	@JsonIgnore
	private Set<CenPackinglists> cenPackinglistses = new HashSet<>(0);

	public SysPackinglistTypes() {
	}

	public SysPackinglistTypes(final long npltypeKey, final String ctext, final String cdescription, final int ndefault) {
		this.npltypeKey = npltypeKey;
		this.ctext = ctext;
		this.cdescription = cdescription;
		this.ndefault = ndefault;
	}

	public SysPackinglistTypes(final long npltypeKey, final String ctext, final String cdescription, final int ndefault,
			final String cimportKey, final Integer nsystem, final Set<CenPackinglists> cenPackinglistses) {
		this.npltypeKey = npltypeKey;
		this.ctext = ctext;
		this.cdescription = cdescription;
		this.ndefault = ndefault;
		this.cimportKey = cimportKey;
		this.nsystem = nsystem;
		this.cenPackinglistses = cenPackinglistses;
	}

	@Id

	@Column(name = "NPLTYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "CTEXT", unique = true, nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", nullable = false)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final int ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "CIMPORT_KEY", length = 20)
	public String getCimportKey() {
		return this.cimportKey;
	}

	public void setCimportKey(final String cimportKey) {
		this.cimportKey = cimportKey;
	}

	@Column(name = "NSYSTEM", precision = 1, scale = 0)
	public Integer getNsystem() {
		return this.nsystem;
	}

	public void setNsystem(final Integer nsystem) {
		this.nsystem = nsystem;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPackinglistTypes")
	public Set<CenPackinglists> getCenPackinglistses() {
		return this.cenPackinglistses;
	}

	public void setCenPackinglistses(final Set<CenPackinglists> cenPackinglistses) {
		this.cenPackinglistses = cenPackinglistses;
	}

}
