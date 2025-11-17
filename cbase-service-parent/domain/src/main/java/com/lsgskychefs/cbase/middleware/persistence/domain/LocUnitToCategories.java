package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.02.2016 12:58:31 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table LOC_UNIT_TO_CATEGORIES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TO_CATEGORIES")
public class LocUnitToCategories implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long ncategoryKey;
	private SysUnits sysUnits;
	private String ccategory;
	private String cdescription;
	private Set<LocUnitToItemlist> locUnitToItemlists = new HashSet<>(0);

	@Id
	@Column(name = "NCATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcategoryKey() {
		return this.ncategoryKey;
	}

	public void setNcategoryKey(final long ncategoryKey) {
		this.ncategoryKey = ncategoryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CCATEGORY", nullable = false, length = 20)
	public String getCcategory() {
		return this.ccategory;
	}

	public void setCcategory(final String ccategory) {
		this.ccategory = ccategory;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 80)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitToCategories")
	public Set<LocUnitToItemlist> getLocUnitToItemlists() {
		return this.locUnitToItemlists;
	}

	public void setLocUnitToItemlists(final Set<LocUnitToItemlist> locUnitToItemlists) {
		this.locUnitToItemlists = locUnitToItemlists;
	}

}
