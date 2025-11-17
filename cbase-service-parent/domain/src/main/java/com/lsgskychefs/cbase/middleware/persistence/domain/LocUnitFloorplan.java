package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 7, 2018 3:37:46 PM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_FLOORPLAN
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_FLOORPLAN")
public class LocUnitFloorplan implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nfloorplanKey;

	@JsonIgnore
	private SysUnits sysUnits;

	private String ctext;

	@JsonIgnore
	private byte[] bfloorplan;

	private String cfloorplanJson;

	private Date dvalidFrom;

	private Date dvalidTo;

	private String sysUnitId;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_FLOORPLAN")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_FLOORPLAN", sequenceName = "SEQ_LOC_UNIT_FLOORPLAN", allocationSize = 1)
	@Column(name = "NFLOORPLAN_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNfloorplanKey() {
		return this.nfloorplanKey;
	}

	public void setNfloorplanKey(final long nfloorplanKey) {
		this.nfloorplanKey = nfloorplanKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Transient
	public String getSysUnitId() {
		sysUnitId = this.getSysUnits().getCunit();
		return sysUnitId;
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
