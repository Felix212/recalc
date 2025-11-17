package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table LOC_UNIT_CHECKPT_MATE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CHECKPT_MATE")
public class LocUnitCheckptMate implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitCheckptMateId id;
	private LocUnitCheckpt locUnitCheckptByNcheckpointKey;
	private LocUnitCheckpt locUnitCheckptByNcheckpointMateKey;
	private int nsort;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "ncheckpointKey",
					column = @Column(name = "NCHECKPOINT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ncheckpointMateKey",
					column = @Column(name = "NCHECKPOINT_MATE_KEY", nullable = false, precision = 12, scale = 0)) })
	public LocUnitCheckptMateId getId() {
		return this.id;
	}

	public void setId(final LocUnitCheckptMateId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCHECKPOINT_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitCheckpt getLocUnitCheckptByNcheckpointKey() {
		return this.locUnitCheckptByNcheckpointKey;
	}

	public void setLocUnitCheckptByNcheckpointKey(final LocUnitCheckpt locUnitCheckptByNcheckpointKey) {
		this.locUnitCheckptByNcheckpointKey = locUnitCheckptByNcheckpointKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCHECKPOINT_MATE_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitCheckpt getLocUnitCheckptByNcheckpointMateKey() {
		return this.locUnitCheckptByNcheckpointMateKey;
	}

	public void setLocUnitCheckptByNcheckpointMateKey(final LocUnitCheckpt locUnitCheckptByNcheckpointMateKey) {
		this.locUnitCheckptByNcheckpointMateKey = locUnitCheckptByNcheckpointMateKey;
	}

	@Column(name = "NSORT", nullable = false, precision = 5, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

}
