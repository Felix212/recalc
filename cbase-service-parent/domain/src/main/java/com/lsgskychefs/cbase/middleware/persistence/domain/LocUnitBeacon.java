package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 16, 2018 12:10:10 PM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table LOC_UNIT_BEACON
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_BEACON", uniqueConstraints = @UniqueConstraint(columnNames = "CIDENTIFIER"))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitBeacon implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbeaconKey;
	private LocUnitTrailpoint locUnitTrailpoint;
	private SysUnits sysUnits;
	private String cclient;
	private int nstate;
	private String cbeacon;
	private String cjson;
	private String cidentifier;
	private String ccolor;
	private String cibeaconUuid;
	private Integer nibeaconMajor;
	private Integer nibeaconMinor;
	private Integer nbatteryPercentage;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_BEACON")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_BEACON", sequenceName = "SEQ_LOC_UNIT_BEACON", allocationSize = 1)
	@Column(name = "NBEACON_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNbeaconKey() {
		return this.nbeaconKey;
	}

	public void setNbeaconKey(final long nbeaconKey) {
		this.nbeaconKey = nbeaconKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTRAILPOINT_KEY")
	@JsonIgnore
	public LocUnitTrailpoint getLocUnitTrailpoint() {
		return this.locUnitTrailpoint;
	}

	public void setLocUnitTrailpoint(final LocUnitTrailpoint locUnitTrailpoint) {
		this.locUnitTrailpoint = locUnitTrailpoint;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	@JsonIgnore
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	@JsonIgnore
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NSTATE", nullable = false, precision = 1, scale = 0)
	@JsonView(View.Simple.class)
	public int getNstate() {
		return this.nstate;
	}

	public void setNstate(final int nstate) {
		this.nstate = nstate;
	}

	@Column(name = "CBEACON", length = 40)
	@JsonView(View.Simple.class)
	public String getCbeacon() {
		return this.cbeacon;
	}

	public void setCbeacon(final String cbeacon) {
		this.cbeacon = cbeacon;
	}

	@Column(name = "CJSON")
	@JsonView(View.Simple.class)
	public String getCjson() {
		return this.cjson;
	}

	public void setCjson(final String cjson) {
		this.cjson = cjson;
	}

	@Column(name = "CIDENTIFIER", unique = true, nullable = false, length = 32)
	@JsonView(View.Simple.class)
	public String getCidentifier() {
		return this.cidentifier;
	}

	public void setCidentifier(final String cidentifier) {
		this.cidentifier = cidentifier;
	}

	@Column(name = "CCOLOR", length = 32)
	@JsonView(View.Simple.class)
	public String getCcolor() {
		return this.ccolor;
	}

	public void setCcolor(final String ccolor) {
		this.ccolor = ccolor;
	}

	@Column(name = "CIBEACON_UUID", nullable = false, length = 32)
	@JsonView(View.Simple.class)
	public String getCibeaconUuid() {
		return this.cibeaconUuid;
	}

	public void setCibeaconUuid(final String cibeaconUuid) {
		this.cibeaconUuid = cibeaconUuid;
	}

	@Column(name = "NIBEACON_MAJOR", precision = 5, scale = 0)
	@JsonView(View.Simple.class)
	public Integer getNibeaconMajor() {
		return this.nibeaconMajor;
	}

	public void setNibeaconMajor(final Integer nibeaconMajor) {
		this.nibeaconMajor = nibeaconMajor;
	}

	@Column(name = "NIBEACON_MINOR", precision = 5, scale = 0)
	@JsonView(View.Simple.class)
	public Integer getNibeaconMinor() {
		return this.nibeaconMinor;
	}

	public void setNibeaconMinor(final Integer nibeaconMinor) {
		this.nibeaconMinor = nibeaconMinor;
	}

	@Column(name = "NBATTERY_PERCENTAGE", precision = 3, scale = 0)
	@JsonView(View.Simple.class)
	public Integer getNbatteryPercentage() {
		return this.nbatteryPercentage;
	}

	public void setNbatteryPercentage(final Integer nbatteryPercentage) {
		this.nbatteryPercentage = nbatteryPercentage;
	}

}
