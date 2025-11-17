package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 16.11.2017 11:47:42 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_UNIT_GATES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_GATES", uniqueConstraints = @UniqueConstraint(columnNames = { "CGATE", "CUNIT", "CCLIENT" }))
public class LocUnitGates implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ngateKey;
	private String cunit;
	private String cclient;
	private String cgate;

	public LocUnitGates() {
	}

	public LocUnitGates(final long ngateKey, final String cunit, final String cclient, final String cgate) {
		this.ngateKey = ngateKey;
		this.cunit = cunit;
		this.cclient = cclient;
		this.cgate = cgate;
	}

	@Id

	@Column(name = "NGATE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNgateKey() {
		return this.ngateKey;
	}

	public void setNgateKey(final long ngateKey) {
		this.ngateKey = ngateKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CGATE", nullable = false, length = 40)
	public String getCgate() {
		return this.cgate;
	}

	public void setCgate(final String cgate) {
		this.cgate = cgate;
	}

}
