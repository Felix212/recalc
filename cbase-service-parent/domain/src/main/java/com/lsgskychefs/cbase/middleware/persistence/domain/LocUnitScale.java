package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 14, 2018 4:17:17 PM by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table LOC_UNIT_SCALE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_SCALE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitScale implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nscaleKey;
	private SysUnits sysUnits;
	private String cclient;
	private int nstate;
	private String cscale;
	private String cserialNumber;
	private String cpairedDevice;
	private String cpairedDeviceUuid;
	private Date dcreated;
	private String ccreatedBy;
	private Date dupdated;
	private String cupdatedBy;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_SCALE")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_SCALE", sequenceName = "SEQ_LOC_UNIT_SCALE", allocationSize = 1)
	@Column(name = "NSCALE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNscaleKey() {
		return this.nscaleKey;
	}

	public void setNscaleKey(final long nscaleKey) {
		this.nscaleKey = nscaleKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	@JsonIgnore
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	@JsonIgnore
	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NSTATE", nullable = false, precision = 1, scale = 0)
	public int getNstate() {
		return this.nstate;
	}

	public void setNstate(final int nstate) {
		this.nstate = nstate;
	}

	@Column(name = "CSCALE", length = 200)
	public String getCscale() {
		return this.cscale;
	}

	public void setCscale(final String cscale) {
		this.cscale = cscale;
	}

	@Column(name = "CSERIAL_NUMBER", unique = true, nullable = false, length = 36)
	public String getCserialNumber() {
		return this.cserialNumber;
	}

	public void setCserialNumber(final String cserialNumber) {
		this.cserialNumber = cserialNumber;
	}

	@Column(name = "CPAIRED_DEVICE", length = 100)
	public String getCpairedDevice() {
		return this.cpairedDevice;
	}

	public void setCpairedDevice(final String cpairedDevice) {
		this.cpairedDevice = cpairedDevice;
	}

	@Column(name = "CPAIRED_DEVICE_UUID", nullable = false, length = 36)
	public String getCpairedDeviceUuid() {
		return this.cpairedDeviceUuid;
	}

	public void setCpairedDeviceUuid(final String cpairedDeviceUuid) {
		this.cpairedDeviceUuid = cpairedDeviceUuid;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED", length = 7)
	public Date getDupdated() {
		return this.dupdated;
	}

	public void setDupdated(final Date dupdated) {
		this.dupdated = dupdated;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}
}
