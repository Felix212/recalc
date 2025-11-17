package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_UNIT_TIMES_BB
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TIMES_BB")
public class LocUnitTimesBb implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private LocUnitTimesBbId id;
	private Long nminutes;
	private Date dvalidTo;

	public LocUnitTimesBb() {
	}

	public LocUnitTimesBb(final LocUnitTimesBbId id, final Date dvalidTo) {
		this.id = id;
		this.dvalidTo = dvalidTo;
	}

	public LocUnitTimesBb(final LocUnitTimesBbId id, final Long nminutes, final Date dvalidTo) {
		this.id = id;
		this.nminutes = nminutes;
		this.dvalidTo = dvalidTo;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "cclient", column = @Column(name = "CCLIENT", nullable = false, length = 3)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)) })
	public LocUnitTimesBbId getId() {
		return this.id;
	}

	public void setId(final LocUnitTimesBbId id) {
		this.id = id;
	}

	@Column(name = "NMINUTES", precision = 12, scale = 0)
	public Long getNminutes() {
		return this.nminutes;
	}

	public void setNminutes(final Long nminutes) {
		this.nminutes = nminutes;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

}
