package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 09.10.2025 10:32:07 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_OUT_QP
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_QP"
)
public class CenOutQp implements DomainObject, java.io.Serializable {

	private CenOutQpId id;
	private CenAirlineQp cenAirlineQp;
	private Date drunAt;
	private Date ddone;
	private int nignore;

	public CenOutQp() {
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nairlineQpKey", column = @Column(name = "NAIRLINE_QP_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutQpId getId() {
		return this.id;
	}

	public void setId(CenOutQpId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_QP_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlineQp getCenAirlineQp() {
		return this.cenAirlineQp;
	}

	public void setCenAirlineQp(CenAirlineQp cenAirlineQp) {
		this.cenAirlineQp = cenAirlineQp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRUN_AT", nullable = false, length = 7)
	public Date getDrunAt() {
		return this.drunAt;
	}

	public void setDrunAt(Date drunAt) {
		this.drunAt = drunAt;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDONE", length = 7)
	public Date getDdone() {
		return this.ddone;
	}

	public void setDdone(Date ddone) {
		this.ddone = ddone;
	}

	@Column(name = "NIGNORE", nullable = false, precision = 1, scale = 0)
	public int getNignore() {
		return this.nignore;
	}

	public void setNignore(int nignore) {
		this.nignore = nignore;
	}

}


