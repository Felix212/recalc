package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 25.01.2016 17:11:04 by Hibernate Tools 4.3.1.Final

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

/**
 * Entity(DomainObject) for table LOC_UNIT_CHECKPT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CHECKPT", uniqueConstraints = @UniqueConstraint(columnNames = { "CUNIT", "CCHECKPOINT" }))
public class LocUnitCheckpt implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncheckpointKey;
	private SysUnits sysUnits;
	private String cunit;
	private String ccheckpoint;
	private String ctext;
	private int nworkstationsactiveflag;
	private int nsort;
	private Set<CenOutCheckpt> cenOutCheckpts = new HashSet<>(0);
	private Set<LocUnitCheckptMate> locUnitCheckptMatesForNcheckpointKey = new HashSet<>(0);
	private Set<LocUnitCheckptMate> locUnitCheckptMatesForNcheckpointMateKey = new HashSet<>(0);
	private Set<LocUnitCheckptPrior> predecessorRelations = new HashSet<>(0);
	private Set<LocUnitCheckptPrior> successorRelations = new HashSet<>(0);

	@Id
	@Column(name = "NCHECKPOINT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcheckpointKey() {
		return this.ncheckpointKey;
	}

	public void setNcheckpointKey(final long ncheckpointKey) {
		this.ncheckpointKey = ncheckpointKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CUNIT", insertable = false, updatable = false)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCHECKPOINT", nullable = false, length = 12)
	public String getCcheckpoint() {
		return this.ccheckpoint;
	}

	public void setCcheckpoint(final String ccheckpoint) {
		this.ccheckpoint = ccheckpoint;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NWORKSTATIONSACTIVEFLAG", nullable = false, precision = 1, scale = 0)
	public int getNworkstationsactiveflag() {
		return this.nworkstationsactiveflag;
	}

	public void setNworkstationsactiveflag(final int nworkstationsactiveflag) {
		this.nworkstationsactiveflag = nworkstationsactiveflag;
	}

	@Column(name = "NSORT", nullable = false, precision = 5, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitCheckpt")
	public Set<CenOutCheckpt> getCenOutCheckpts() {
		return this.cenOutCheckpts;
	}

	public void setCenOutCheckpts(final Set<CenOutCheckpt> cenOutCheckpts) {
		this.cenOutCheckpts = cenOutCheckpts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitCheckptByNcheckpointKey")
	public Set<LocUnitCheckptMate> getLocUnitCheckptMatesForNcheckpointKey() {
		return this.locUnitCheckptMatesForNcheckpointKey;
	}

	public void setLocUnitCheckptMatesForNcheckpointKey(final Set<LocUnitCheckptMate> locUnitCheckptMatesForNcheckpointKey) {
		this.locUnitCheckptMatesForNcheckpointKey = locUnitCheckptMatesForNcheckpointKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitCheckptByNcheckpointMateKey")
	public Set<LocUnitCheckptMate> getLocUnitCheckptMatesForNcheckpointMateKey() {
		return this.locUnitCheckptMatesForNcheckpointMateKey;
	}

	public void setLocUnitCheckptMatesForNcheckpointMateKey(final Set<LocUnitCheckptMate> locUnitCheckptMatesForNcheckpointMateKey) {
		this.locUnitCheckptMatesForNcheckpointMateKey = locUnitCheckptMatesForNcheckpointMateKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "predecessor")
	public Set<LocUnitCheckptPrior> getPredecessorRelations() {
		return this.predecessorRelations;
	}

	public void setPredecessorRelations(final Set<LocUnitCheckptPrior> predecessorRelations) {
		this.predecessorRelations = predecessorRelations;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "successor")
	public Set<LocUnitCheckptPrior> getSuccessorRelations() {
		return this.successorRelations;
	}

	public void setSuccessorRelations(final Set<LocUnitCheckptPrior> successorRelations) {
		this.successorRelations = successorRelations;
	}

}
