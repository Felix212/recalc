package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 02.01.2025 10:46:37 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_DLV_UNITS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_DLV_UNITS")
public class CenAirlineDlvUnits implements DomainObject, java.io.Serializable {

	private CenAirlineUnitId id;
	private CenAirlineUnit cenAirlineUnit;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String crecipient;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)) })
	public CenAirlineUnitId getId() {
		return this.id;
	}

	public void setId(CenAirlineUnitId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY) @PrimaryKeyJoinColumn
	public CenAirlineUnit getCenAirlineUnit() {
		return this.cenAirlineUnit;
	}

	public void setCenAirlineUnit(CenAirlineUnit cenAirlineUnit) {
		this.cenAirlineUnit = cenAirlineUnit;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CRECIPIENT", length = 1000)
	public String getCrecipient() {
		return this.crecipient;
	}

	public void setCrecipient(String crecipient) {
		this.crecipient = crecipient;
	}

}


