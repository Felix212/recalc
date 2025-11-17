package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 5, 2017 1:49:34 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_TRAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_TRAIL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenOutPpmTrail implements DomainObject, java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private long nppmtrailKey;

	@JsonIgnore
	private CenOutPpmFlights cenOutPpmFlights;

	private String cairline;

	private int nflightNumber;

	private String csuffix;

	private Date ddeparture;

	private String cdepartureTime;

	private long nplIndexKey;

	private String cpackinglist;

	private String cclass;

	private BigDecimal nquantity;

	private long ntrailKey;

	private String ctrail;

	private BigDecimal nquantityIncrease;

	private String cservingUnit;

	private String cservingUnitText;

	private BigDecimal nquantitySw;

	@JsonIgnore
	private Set<CenOutPpmTrailDetail> cenOutPpmTrailDetails = new HashSet<>(0);

	@Id
	@Column(name = "NPPMTRAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmtrailKey() {
		return this.nppmtrailKey;
	}

	public void setNppmtrailKey(final long nppmtrailKey) {
		this.nppmtrailKey = nppmtrailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false) })
	public CenOutPpmFlights getCenOutPpmFlights() {
		return this.cenOutPpmFlights;
	}

	public void setCenOutPpmFlights(final CenOutPpmFlights cenOutPpmFlights) {
		this.cenOutPpmFlights = cenOutPpmFlights;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CDEPARTURE_TIME", nullable = false, length = 5)
	public String getCdepartureTime() {
		return this.cdepartureTime;
	}

	public void setCdepartureTime(final String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
	}

	@Column(name = "NPL_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CCLASS", length = 40)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NTRAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNtrailKey() {
		return this.ntrailKey;
	}

	public void setNtrailKey(final long ntrailKey) {
		this.ntrailKey = ntrailKey;
	}

	@Column(name = "CTRAIL", nullable = false, length = 40)
	public String getCtrail() {
		return this.ctrail;
	}

	public void setCtrail(final String ctrail) {
		this.ctrail = ctrail;
	}

	@Column(name = "NQUANTITY_INCREASE", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantityIncrease() {
		return nquantityIncrease;
	}

	public void setNquantityIncrease(final BigDecimal nquantityIncrease) {
		this.nquantityIncrease = nquantityIncrease;
	}

	@Column(name = "CSERVING_UNIT", length = 4)
	public String getCservingUnit() {
		return this.cservingUnit;
	}

	public void setCservingUnit(String cservingUnit) {
		this.cservingUnit = cservingUnit;
	}

	@Column(name = "CSERVING_UNIT_TEXT", length = 30)
	public String getCservingUnitText() {
		return this.cservingUnitText;
	}

	public void setCservingUnitText(String cservingUnitText) {
		this.cservingUnitText = cservingUnitText;
	}

	@Column(name = "NQUANTITY_SW", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantitySw() {
		return this.nquantitySw;
	}

	public void setNquantitySw(BigDecimal nquantitySw) {
		this.nquantitySw = nquantitySw;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmTrail")
	public Set<CenOutPpmTrailDetail> getCenOutPpmTrailDetails() {
		return this.cenOutPpmTrailDetails;
	}

	public void setCenOutPpmTrailDetails(final Set<CenOutPpmTrailDetail> cenOutPpmTrailDetails) {
		this.cenOutPpmTrailDetails = cenOutPpmTrailDetails;
	}

}
