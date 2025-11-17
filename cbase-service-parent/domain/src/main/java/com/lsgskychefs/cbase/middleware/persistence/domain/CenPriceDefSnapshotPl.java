package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13.04.2022 09:24:43 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PRICE_DEF_SNAPSHOT_PL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PRICE_DEF_SNAPSHOT_PL"
)
public class CenPriceDefSnapshotPl implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPriceDefSnapshotPlId id;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private Date dvalidate;
	private Long nsumValuePoints;
	private BigDecimal nsumCostPrice;
	private BigDecimal nsumMatCosts;
	private BigDecimal nsumMatCostsMarkup;
	private BigDecimal nsumSeconds;
	private String ccategory;
	private String cmodified;
	private String cunitBase;
	private Long nairlineKeyBase;
	private Date dtimestamp;
	private BigDecimal nsumLabourCostsMarkup;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPriceDefSnapshotPlId getId() {
		return this.id;
	}

	public void setId(final CenPriceDefSnapshotPlId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false, insertable = false, updatable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALIDATE", nullable = false, length = 7)
	public Date getDvalidate() {
		return this.dvalidate;
	}

	public void setDvalidate(final Date dvalidate) {
		this.dvalidate = dvalidate;
	}

	@Column(name = "NSUM_VALUE_POINTS", precision = 12, scale = 0)
	public Long getNsumValuePoints() {
		return this.nsumValuePoints;
	}

	public void setNsumValuePoints(final Long nsumValuePoints) {
		this.nsumValuePoints = nsumValuePoints;
	}

	@Column(name = "NSUM_COST_PRICE", nullable = false, precision = 13, scale = 5)
	public BigDecimal getNsumCostPrice() {
		return this.nsumCostPrice;
	}

	public void setNsumCostPrice(final BigDecimal nsumCostPrice) {
		this.nsumCostPrice = nsumCostPrice;
	}

	@Column(name = "NSUM_MAT_COSTS", nullable = false, precision = 13, scale = 5)
	public BigDecimal getNsumMatCosts() {
		return this.nsumMatCosts;
	}

	public void setNsumMatCosts(final BigDecimal nsumMatCosts) {
		this.nsumMatCosts = nsumMatCosts;
	}

	@Column(name = "NSUM_MAT_COSTS_MARKUP", nullable = false, precision = 13, scale = 5)
	public BigDecimal getNsumMatCostsMarkup() {
		return this.nsumMatCostsMarkup;
	}

	public void setNsumMatCostsMarkup(final BigDecimal nsumMatCostsMarkup) {
		this.nsumMatCostsMarkup = nsumMatCostsMarkup;
	}

	@Column(name = "NSUM_SECONDS", nullable = false, precision = 13, scale = 5)
	public BigDecimal getNsumSeconds() {
		return this.nsumSeconds;
	}

	public void setNsumSeconds(final BigDecimal nsumSeconds) {
		this.nsumSeconds = nsumSeconds;
	}

	@Column(name = "CCATEGORY", nullable = false, length = 30)
	public String getCcategory() {
		return this.ccategory;
	}

	public void setCcategory(final String ccategory) {
		this.ccategory = ccategory;
	}

	@Column(name = "CMODIFIED", nullable = false, length = 40)
	public String getCmodified() {
		return this.cmodified;
	}

	public void setCmodified(final String cmodified) {
		this.cmodified = cmodified;
	}

	@Column(name = "CUNIT_BASE", nullable = false, length = 5)
	public String getCunitBase() {
		return this.cunitBase;
	}

	public void setCunitBase(final String cunitBase) {
		this.cunitBase = cunitBase;
	}

	@Column(name = "NAIRLINE_KEY_BASE", precision = 12, scale = 0)
	public Long getNairlineKeyBase() {
		return this.nairlineKeyBase;
	}

	public void setNairlineKeyBase(final Long nairlineKeyBase) {
		this.nairlineKeyBase = nairlineKeyBase;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSUM_LABOUR_COSTS_MARKUP", nullable = false, precision = 13, scale = 5)
	public BigDecimal getNsumLabourCostsMarkup() {
		return this.nsumLabourCostsMarkup;
	}

	public void setNsumLabourCostsMarkup(final BigDecimal nsumLabourCostsMarkup) {
		this.nsumLabourCostsMarkup = nsumLabourCostsMarkup;
	}

}


