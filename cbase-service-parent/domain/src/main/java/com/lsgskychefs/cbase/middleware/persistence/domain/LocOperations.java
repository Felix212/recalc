package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 19, 2017 12:23:35 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table LOC_OPERATIONS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_OPERATIONS")
public class LocOperations implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocOperationsId id;
	private String ctimeFrom;
	private String ctimeTo;
	private int nsort;

	public LocOperations() {
	}

	public LocOperations(final LocOperationsId id, final String ctimeFrom, final String ctimeTo, final int nsort) {
		this.id = id;
		this.ctimeFrom = ctimeFrom;
		this.ctimeTo = ctimeTo;
		this.nsort = nsort;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "cclient", column = @Column(name = "CCLIENT", nullable = false, length = 3)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
			@AttributeOverride(name = "ctext", column = @Column(name = "CTEXT", nullable = false, length = 20)) })
	public LocOperationsId getId() {
		return this.id;
	}

	public void setId(final LocOperationsId id) {
		this.id = id;
	}

	@Column(name = "CTIME_FROM", nullable = false, length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(final String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", nullable = false, length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(final String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

}
