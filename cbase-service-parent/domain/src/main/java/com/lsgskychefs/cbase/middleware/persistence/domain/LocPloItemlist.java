package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 3, 2018 4:59:37 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table LOC_PLO_ITEMLIST
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PLO_ITEMLIST")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocPloItemlist implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nitemlistKey;
	@JsonIgnore
	private LocUnitWorkstation locUnitWorkstation;
	@JsonIgnore
	private SysUnits sysUnits;
	@JsonIgnore
	private String cclient;
	private String citemlist;
	private String ctext;
	private Date dvalidFrom;
	private Date dvalidTo;
	private long nitemlistLevel;
	private int nsetuprate;
	private int nrunrate;
	private int nphf;
	private int nbatchsize;
	private String cairline;
	private String workstationName;
	private String areaName;
	@JsonIgnore
	private Set<LocPloWoDef> locPloWoDefs = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_PLO_ITEMLIST")
	@SequenceGenerator(name = "SEQ_LOC_PLO_ITEMLIST", sequenceName = "SEQ_LOC_PLO_ITEMLIST", allocationSize = 1)
	@Column(name = "NITEMLIST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNitemlistKey() {
		return this.nitemlistKey;
	}

	public void setNitemlistKey(final long nitemlistKey) {
		this.nitemlistKey = nitemlistKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false)
	public LocUnitWorkstation getLocUnitWorkstation() {
		return this.locUnitWorkstation;
	}

	public void setLocUnitWorkstation(final LocUnitWorkstation locUnitWorkstation) {
		this.locUnitWorkstation = locUnitWorkstation;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

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

	@Column(name = "CITEMLIST", nullable = false, length = 18)
	public String getCitemlist() {
		return this.citemlist;
	}

	public void setCitemlist(final String citemlist) {
		this.citemlist = citemlist;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
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

	@Column(name = "NITEMLIST_LEVEL", nullable = false, precision = 12, scale = 0)
	public long getNitemlistLevel() {
		return this.nitemlistLevel;
	}

	public void setNitemlistLevel(final long nitemlistLevel) {
		this.nitemlistLevel = nitemlistLevel;
	}

	@Column(name = "NSETUPRATE", nullable = false, precision = 6, scale = 0)
	public int getNsetuprate() {
		return this.nsetuprate;
	}

	public void setNsetuprate(final int nsetuprate) {
		this.nsetuprate = nsetuprate;
	}

	@Column(name = "NRUNRATE", nullable = false, precision = 6, scale = 0)
	public int getNrunrate() {
		return this.nrunrate;
	}

	public void setNrunrate(final int nrunrate) {
		this.nrunrate = nrunrate;
	}

	@Column(name = "NPHF", nullable = false, precision = 1, scale = 0)
	public int getNphf() {
		return this.nphf;
	}

	public void setNphf(final int nphf) {
		this.nphf = nphf;
	}

	@Column(name = "NBATCHSIZE", nullable = false, precision = 6, scale = 0)
	public int getNbatchsize() {
		return this.nbatchsize;
	}

	public void setNbatchsize(final int nbatchsize) {
		this.nbatchsize = nbatchsize;
	}

	@Column(name = "CAIRLINE", length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Transient
	public String getWorkstationName() {
		workstationName = locUnitWorkstation.getCworkstation();
		return workstationName;
	}

	@Transient
	public String getAreaName() {
		areaName = locUnitWorkstation.getLocUnitAreas().getCarea();
		return areaName;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPloItemlist")
	public Set<LocPloWoDef> getLocPloWoDefs() {
		return this.locPloWoDefs;
	}

	public void setLocPloWoDefs(final Set<LocPloWoDef> locPloWoDefs) {
		this.locPloWoDefs = locPloWoDefs;
	}

}
