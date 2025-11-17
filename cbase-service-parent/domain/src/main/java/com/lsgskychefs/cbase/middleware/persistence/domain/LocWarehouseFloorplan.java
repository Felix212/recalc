package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 23, 2019 5:34:05 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_WAREHOUSE_FLOORPLAN
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_WAREHOUSE_FLOORPLAN", uniqueConstraints = @UniqueConstraint(columnNames = "NWAREHOUSE_KEY"))
public class LocWarehouseFloorplan implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nfloorplanKey;
	@JsonIgnore
	private LocUnitChWarehouse locUnitChWarehouse;
	private String ctext;
	@JsonIgnore
	private byte[] bfloorplan;
	private String cfloorplanJson;
	private Date dvalidFrom;
	private Date dvalidTo;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_WAREHOUSE_FLOORPLAN")
	@SequenceGenerator(name = "SEQ_LOC_WAREHOUSE_FLOORPLAN", sequenceName = "SEQ_LOC_WAREHOUSE_FLOORPLAN", allocationSize = 1)
	@Column(name = "NFLOORPLAN_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNfloorplanKey() {
		return this.nfloorplanKey;
	}

	public void setNfloorplanKey(final long nfloorplanKey) {
		this.nfloorplanKey = nfloorplanKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWAREHOUSE_KEY", nullable = false)
	public LocUnitChWarehouse getLocUnitChWarehouse() {
		return this.locUnitChWarehouse;
	}

	public void setLocUnitChWarehouse(final LocUnitChWarehouse locUnitChWarehouse) {
		this.locUnitChWarehouse = locUnitChWarehouse;
	}

	@Column(name = "CTEXT", nullable = false, length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "BFLOORPLAN")
	public byte[] getBfloorplan() {
		return this.bfloorplan;
	}

	public void setBfloorplan(final byte[] bfloorplan) {
		this.bfloorplan = bfloorplan;
	}

	@Column(name = "CFLOORPLAN_JSON", nullable = false)
	public String getCfloorplanJson() {
		return this.cfloorplanJson;
	}

	public void setCfloorplanJson(final String cfloorplanJson) {
		this.cfloorplanJson = cfloorplanJson;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
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
