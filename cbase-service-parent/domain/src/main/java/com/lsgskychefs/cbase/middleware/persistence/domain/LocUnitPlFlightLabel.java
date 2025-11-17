package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table LOC_UNIT_PL_FLIGHT_LABEL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PL_FLIGHT_LABEL")
public class LocUnitPlFlightLabel implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private LocUnitPlFlightLabelId id;
	private LocUnitPlAreas locUnitPlAreas;
	private CenLabelType cenLabelType;
	private int nlabelPrint;
	private Date dvalidFrom;
	private Date dvalidTo;
	private int nsort;
	private String ctext;
	private String ctext2;
	private Integer nquantity;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nplAreaKey", column = @Column(name = "NPL_AREA_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nworkstationKey", column = @Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)) })
	public LocUnitPlFlightLabelId getId() {
		return this.id;
	}

	public void setId(final LocUnitPlFlightLabelId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_AREA_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitPlAreas getLocUnitPlAreas() {
		return this.locUnitPlAreas;
	}

	public void setLocUnitPlAreas(final LocUnitPlAreas locUnitPlAreas) {
		this.locUnitPlAreas = locUnitPlAreas;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLABEL_TYPE_KEY", nullable = false)
	public CenLabelType getCenLabelType() {
		return this.cenLabelType;
	}

	public void setCenLabelType(final CenLabelType cenLabelType) {
		this.cenLabelType = cenLabelType;
	}

	@Column(name = "NLABEL_PRINT", nullable = false, precision = 1, scale = 0)
	public int getNlabelPrint() {
		return this.nlabelPrint;
	}

	public void setNlabelPrint(final int nlabelPrint) {
		this.nlabelPrint = nlabelPrint;
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

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT2", length = 40)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "NQUANTITY", precision = 1, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

}
