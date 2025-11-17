package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 3, 2018 4:59:37 PM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table LOC_PLO_WO_DEF
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PLO_WO_DEF")
public class LocPloWoDef implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nwoDefKey;
	@JsonIgnore
	private SysUnits sysUnits;
	@JsonIgnore
	private LocPloShift locPloShift;
	@JsonIgnore
	private LocPloItemlist locPloItemlist;
	private String cclient;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String cdepartureFrom;
	private String cdepartureTo;
	private int noffset;
	private int nempCount;
	private String itemlistName;
	private String itemlistDescription;
	private String areaName;
	private String workstationName;
	private String shiftName;
	private String shiftStart;
	private String shiftEnd;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_PLO_WO_DEF")
	@SequenceGenerator(name = "SEQ_LOC_PLO_WO_DEF", sequenceName = "SEQ_LOC_PLO_WO_DEF", allocationSize = 1)
	@Column(name = "NWO_DEF_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNwoDefKey() {
		return this.nwoDefKey;
	}

	public void setNwoDefKey(final long nwoDefKey) {
		this.nwoDefKey = nwoDefKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSHIFT_KEY", nullable = false)
	public LocPloShift getLocPloShift() {
		return this.locPloShift;
	}

	public void setLocPloShift(final LocPloShift locPloShift) {
		this.locPloShift = locPloShift;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NITEMLIST_KEY", nullable = false)
	public LocPloItemlist getLocPloItemlist() {
		return this.locPloItemlist;
	}

	public void setLocPloItemlist(final LocPloItemlist locPloItemlist) {
		this.locPloItemlist = locPloItemlist;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
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

	@Column(name = "CDEPARTURE_FROM", nullable = false, length = 5)
	public String getCdepartureFrom() {
		return this.cdepartureFrom;
	}

	public void setCdepartureFrom(final String cdepartureFrom) {
		this.cdepartureFrom = cdepartureFrom;
	}

	@Column(name = "CDEPARTURE_TO", nullable = false, length = 5)
	public String getCdepartureTo() {
		return this.cdepartureTo;
	}

	public void setCdepartureTo(final String cdepartureTo) {
		this.cdepartureTo = cdepartureTo;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 1, scale = 0)
	public int getNoffset() {
		return this.noffset;
	}

	public void setNoffset(final int noffset) {
		this.noffset = noffset;
	}

	@Column(name = "NEMP_COUNT", nullable = false, precision = 3, scale = 0)
	public int getNempCount() {
		return this.nempCount;
	}

	public void setNempCount(final int nempCount) {
		this.nempCount = nempCount;
	}

	@Transient
	public String getItemlistName() {
		itemlistName = locPloItemlist.getCitemlist();
		return itemlistName;
	}

	@Transient
	public String getItemlistDescription() {
		itemlistDescription = locPloItemlist.getCtext();
		return itemlistDescription;
	}

	@Transient
	public String getAreaName() {
		areaName = locPloItemlist.getAreaName();
		return areaName;
	}

	@Transient
	public String getWorkstationName() {
		workstationName = locPloItemlist.getWorkstationName();
		return workstationName;
	}

	@Transient
	public String getShiftName() {
		shiftName = locPloShift.getCshift();
		return shiftName;
	}

	@Transient
	public String getShiftStart() {
		shiftStart = locPloShift.getCtimeStart();
		return shiftStart;
	}

	@Transient
	public String getShiftEnd() {
		shiftEnd = locPloShift.getCtimeEnd();
		return shiftEnd;
	}

}
