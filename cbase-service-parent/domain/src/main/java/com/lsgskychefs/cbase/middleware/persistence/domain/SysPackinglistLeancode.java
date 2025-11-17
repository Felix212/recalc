package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.04.2022 13:05:50 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_PACKINGLIST_LEANCODE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PACKINGLIST_LEANCODE")
public class SysPackinglistLeancode implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nleancodeKey;
	private String cleancode;
	private String ctext;
	private String cshortText;
	private int ndonotuse;
	@JsonIgnore
	private Set<CenPackinglistCscVal> cenPackinglistCscVals = new HashSet<>(0);

	@Id
	@Column(name = "NLEANCODE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNleancodeKey() {
		return this.nleancodeKey;
	}

	public void setNleancodeKey(final long nleancodeKey) {
		this.nleancodeKey = nleancodeKey;
	}

	@Column(name = "CLEANCODE", nullable = false, length = 5)
	public String getCleancode() {
		return this.cleancode;
	}

	public void setCleancode(final String cleancode) {
		this.cleancode = cleancode;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CSHORT_TEXT", length = 10)
	public String getCshortText() {
		return this.cshortText;
	}

	public void setCshortText(final String cshortText) {
		this.cshortText = cshortText;
	}

	@Column(name = "NDONOTUSE", nullable = false, precision = 1, scale = 0)
	public int getNdonotuse() {
		return this.ndonotuse;
	}

	public void setNdonotuse(final int ndonotuse) {
		this.ndonotuse = ndonotuse;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPackinglistLeancode")
	public Set<CenPackinglistCscVal> getCenPackinglistCscVals() {
		return this.cenPackinglistCscVals;
	}

	public void setCenPackinglistCscVals(final Set<CenPackinglistCscVal> cenPackinglistCscVals) {
		this.cenPackinglistCscVals = cenPackinglistCscVals;
	}

}


