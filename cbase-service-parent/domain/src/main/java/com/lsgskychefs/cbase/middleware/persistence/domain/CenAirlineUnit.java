package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.05.2016 08:27:40 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_UNIT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_UNIT")
public class CenAirlineUnit implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenAirlineUnitId id;
	private String cregion;
	private int ndefault;
	private String ctlc;
	private boolean nenableDocGen;
	private String cpriceGroup;
	private CenAirlines cenAirlines;
	private SysUnits sysUnits;
	private String ccustAcronym;
	private String ccustomer;
	private CenAirlineDlvUnits cenAirlineDlvUnits;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)) })
	public CenAirlineUnitId getId() {
		return this.id;
	}

	public void setId(final CenAirlineUnitId id) {
		this.id = id;
	}

	@Column(name = "CREGION", length = 12)
	public String getCregion() {
		return this.cregion;
	}

	public void setCregion(final String cregion) {
		this.cregion = cregion;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final int ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "CTLC", length = 3)
	public String getCtlc() {
		return this.ctlc;
	}

	public void setCtlc(final String ctlc) {
		this.ctlc = ctlc;
	}

	@Column(name = "NENABLE_DOC_GEN", precision = 1, scale = 0)
	public boolean isNenableDocGen() {
		return this.nenableDocGen;
	}

	public void setNenableDocGen(final boolean nenableDocGen) {
		this.nenableDocGen = nenableDocGen;
	}

	@Column(name = "CPRICE_GROUP", length = 100)
	public String getCpriceGroup() {
		return this.cpriceGroup;
	}

	public void setCpriceGroup(final String cpriceGroup) {
		this.cpriceGroup = cpriceGroup;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false, insertable = false, updatable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CCUST_ACRONYM", length = 10)
	public String getCcustAcronym() {
		return this.ccustAcronym;
	}

	public void setCcustAcronym(String ccustAcronym) {
		this.ccustAcronym = ccustAcronym;
	}

	@Column(name = "CCUSTOMER", length = 20)
	public String getCcustomer() {
		return this.ccustomer;
	}

	public void setCcustomer(String ccustomer) {
		this.ccustomer = ccustomer;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenAirlineUnit")
	public CenAirlineDlvUnits getCenAirlineDlvUnits() {
		return this.cenAirlineDlvUnits;
	}

	public void setCenAirlineDlvUnits(CenAirlineDlvUnits cenAirlineDlvUnits) {
		this.cenAirlineDlvUnits = cenAirlineDlvUnits;
	}

}
