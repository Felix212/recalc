package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Sep 15, 2016 12:40:57 PM by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_UNIT_CHECKPT_PRIOR
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CHECKPT_PRIOR")
public class LocUnitCheckptPrior implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitCheckptPriorId id;
	private LocUnitCheckpt predecessor;
	private LocUnitCheckpt successor;
	private boolean npruefen;
	private Date dvalidto;
	private int nsort;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "ncheckpointKey", column = @Column(name = "NCHECKPOINT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ncheckpointPriorKey", column = @Column(name = "NCHECKPOINT_PRIOR_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidfrom", column = @Column(name = "DVALIDFROM", nullable = false, length = 7)) })
	public LocUnitCheckptPriorId getId() {
		return this.id;
	}

	public void setId(final LocUnitCheckptPriorId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCHECKPOINT_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitCheckpt getPredecessor() {
		return this.predecessor;
	}

	public void setPredecessor(final LocUnitCheckpt predecessor) {
		this.predecessor = predecessor;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCHECKPOINT_PRIOR_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitCheckpt getSuccessor() {
		return this.successor;
	}

	public void setSuccessor(final LocUnitCheckpt successor) {
		this.successor = successor;
	}

	@Column(name = "NPRUEFEN", nullable = false, precision = 1, scale = 0)
	public boolean isNpruefen() {
		return this.npruefen;
	}

	public void setNpruefen(final boolean npruefen) {
		this.npruefen = npruefen;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DVALIDTO", nullable = false, length = 7)
	public Date getDvalidto() {
		return this.dvalidto;
	}

	public void setDvalidto(final Date dvalidto) {
		this.dvalidto = dvalidto;
	}

	@Column(name = "NSORT", nullable = false, precision = 5, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

}
