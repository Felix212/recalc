package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 16, 2019 5:40:26 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;

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

/**
 * Entity(DomainObject) for table LOC_SUBST_ITEMLIST
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_SUBST_ITEMLIST")
public class LocSubstItemlist implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsubstItemlistKey;
	private LocSubstFlight locSubstFlight;
	private long nplIndexFrom;
	private String cplDescFrom;
	private String cclass;
	private Long nclassNumber;
	private int nclassAll;
	private long nplIndexTo;
	private String cplCtextTo;
	private long ncalcId;
	private long ncalcDetailKey;
	private int npercentage;
	private BigDecimal nvalue;
	private int nmaxValue;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_SUBST_ITEMLIST")
	@SequenceGenerator(name = "SEQ_LOC_SUBST_ITEMLIST", sequenceName = "SEQ_LOC_SUBST_ITEMLIST", allocationSize = 1)
	@Column(name = "NSUBST_ITEMLIST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsubstItemlistKey() {
		return this.nsubstItemlistKey;
	}

	public void setNsubstItemlistKey(final long nsubstItemlistKey) {
		this.nsubstItemlistKey = nsubstItemlistKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSUBST_FLIGHT_KEY", nullable = false)
	public LocSubstFlight getLocSubstFlight() {
		return this.locSubstFlight;
	}

	public void setLocSubstFlight(final LocSubstFlight locSubstFlight) {
		this.locSubstFlight = locSubstFlight;
	}

	@Column(name = "NPL_INDEX_FROM", nullable = false, precision = 12, scale = 0)
	public long getNplIndexFrom() {
		return this.nplIndexFrom;
	}

	public void setNplIndexFrom(final long nplIndexFrom) {
		this.nplIndexFrom = nplIndexFrom;
	}

	@Column(name = "CPL_DESC_FROM", length = 80)
	public String getCplDescFrom() {
		return this.cplDescFrom;
	}

	public void setCplDescFrom(final String cplDescFrom) {
		this.cplDescFrom = cplDescFrom;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NCLASS_ALL", nullable = false, precision = 1, scale = 0)
	public int getNclassAll() {
		return this.nclassAll;
	}

	public void setNclassAll(final int nclassAll) {
		this.nclassAll = nclassAll;
	}

	@Column(name = "NPL_INDEX_TO", nullable = false, precision = 12, scale = 0)
	public long getNplIndexTo() {
		return this.nplIndexTo;
	}

	public void setNplIndexTo(final long nplIndexTo) {
		this.nplIndexTo = nplIndexTo;
	}

	@Column(name = "CPL_CTEXT_TO", length = 80)
	public String getCplCtextTo() {
		return this.cplCtextTo;
	}

	public void setCplCtextTo(final String cplCtextTo) {
		this.cplCtextTo = cplCtextTo;
	}

	@Column(name = "NCALC_ID", nullable = false, precision = 12, scale = 0)
	public long getNcalcId() {
		return this.ncalcId;
	}

	public void setNcalcId(final long ncalcId) {
		this.ncalcId = ncalcId;
	}

	@Column(name = "NCALC_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcalcDetailKey() {
		return this.ncalcDetailKey;
	}

	public void setNcalcDetailKey(final long ncalcDetailKey) {
		this.ncalcDetailKey = ncalcDetailKey;
	}

	@Column(name = "NPERCENTAGE", nullable = false, precision = 3, scale = 0)
	public int getNpercentage() {
		return this.npercentage;
	}

	public void setNpercentage(final int npercentage) {
		this.npercentage = npercentage;
	}

	@Column(name = "NVALUE", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNvalue() {
		return this.nvalue;
	}

	public void setNvalue(final BigDecimal nvalue) {
		this.nvalue = nvalue;
	}

	@Column(name = "NMAX_VALUE", nullable = false, precision = 3, scale = 0)
	public int getNmaxValue() {
		return this.nmaxValue;
	}

	public void setNmaxValue(final int nmaxValue) {
		this.nmaxValue = nmaxValue;
	}

}
