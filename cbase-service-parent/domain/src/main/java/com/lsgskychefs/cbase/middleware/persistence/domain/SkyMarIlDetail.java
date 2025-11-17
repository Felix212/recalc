package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 16, 2021 3:22:02 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;

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

import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SKY_MAR_IL_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SKY_MAR_IL_DETAIL")
public class SkyMarIlDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SkyMarIlDetailId id;

	@JsonView(View.SpecialRelation.class)
	private SkyMarIl skyMarIl;

	@JsonView(View.Simple.class)
	private Long ndetailKey;

	@JsonView(View.Simple.class)
	private BigDecimal nquantity;

	@JsonView(View.Simple.class)
	private BigDecimal nquantityRecipe;

	@JsonView(View.Simple.class)
	private BigDecimal nscrapPct;

	@JsonView(View.Simple.class)
	private Long nreckoning;

	@JsonView(View.Simple.class)
	private int nsort;

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cpackinglist", column = @Column(name = "CPACKINGLIST", nullable = false, length = 18)) })
	public SkyMarIlDetailId getId() {
		return this.id;
	}

	public void setId(final SkyMarIlDetailId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false, insertable = false, updatable = false) })
	public SkyMarIl getSkyMarIl() {
		return this.skyMarIl;
	}

	public void setSkyMarIl(final SkyMarIl skyMarIl) {
		this.skyMarIl = skyMarIl;
	}

	@Column(name = "NQUANTITY", precision = 15, scale = 6)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NQUANTITY_RECIPE", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipe() {
		return this.nquantityRecipe;
	}

	public void setNquantityRecipe(final BigDecimal nquantityRecipe) {
		this.nquantityRecipe = nquantityRecipe;
	}

	@Column(name = "NSCRAP_PCT", precision = 15, scale = 6)
	public BigDecimal getNscrapPct() {
		return this.nscrapPct;
	}

	public void setNscrapPct(final BigDecimal nscrapPct) {
		this.nscrapPct = nscrapPct;
	}

	@Column(name = "NRECKONING", precision = 12, scale = 0)
	public Long getNreckoning() {
		return this.nreckoning;
	}

	public void setNreckoning(final Long nreckoning) {
		this.nreckoning = nreckoning;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

}
