package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_PACKINGLIST_KINDS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PACKINGLIST_KINDS", uniqueConstraints = @UniqueConstraint(columnNames = "CKIND"))
public class SysPackinglistKinds implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplKindKey;
	private String ckind;
	private String ctext;
	private int nselection;
	private String ctext2;
	private String ctext3;
	private String ctext4;
	private String ctext5;
	private Integer nyieldable;
	private Integer npriceable;
	private Integer nuseReserve;
	private int nbulkRecipe;
	private Integer nuseforarticle;
	private Integer nuseforitemlist;
	private Integer nsort;
	private int nbulkDecimals;
	private int nusepricingdetails;
	private int nuseIngredients;
	private int nuseAllergens;
	private String csapKind;
	private int nroleId;
	private int nxsl;

	@Id
	@Column(name = "NPL_KIND_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "CKIND", unique = true, nullable = false, length = 10)
	public String getCkind() {
		return this.ckind;
	}

	public void setCkind(final String ckind) {
		this.ckind = ckind;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NSELECTION", nullable = false, precision = 1, scale = 0)
	public int getNselection() {
		return this.nselection;
	}

	public void setNselection(final int nselection) {
		this.nselection = nselection;
	}

	@Column(name = "CTEXT2", length = 40)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 40)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", length = 40)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

	@Column(name = "CTEXT5", length = 40)
	public String getCtext5() {
		return this.ctext5;
	}

	public void setCtext5(final String ctext5) {
		this.ctext5 = ctext5;
	}

	@Column(name = "NYIELDABLE", precision = 1, scale = 0)
	public Integer getNyieldable() {
		return this.nyieldable;
	}

	public void setNyieldable(final Integer nyieldable) {
		this.nyieldable = nyieldable;
	}

	@Column(name = "NPRICEABLE", precision = 1, scale = 0)
	public Integer getNpriceable() {
		return this.npriceable;
	}

	public void setNpriceable(final Integer npriceable) {
		this.npriceable = npriceable;
	}

	@Column(name = "NUSE_RESERVE", precision = 1, scale = 0)
	public Integer getNuseReserve() {
		return this.nuseReserve;
	}

	public void setNuseReserve(final Integer nuseReserve) {
		this.nuseReserve = nuseReserve;
	}

	@Column(name = "NBULK_RECIPE", nullable = false, precision = 1, scale = 0)
	public int getNbulkRecipe() {
		return this.nbulkRecipe;
	}

	public void setNbulkRecipe(final int nbulkRecipe) {
		this.nbulkRecipe = nbulkRecipe;
	}

	@Column(name = "NUSEFORARTICLE", precision = 1, scale = 0)
	public Integer getNuseforarticle() {
		return this.nuseforarticle;
	}

	public void setNuseforarticle(final Integer nuseforarticle) {
		this.nuseforarticle = nuseforarticle;
	}

	@Column(name = "NUSEFORITEMLIST", precision = 1, scale = 0)
	public Integer getNuseforitemlist() {
		return this.nuseforitemlist;
	}

	public void setNuseforitemlist(final Integer nuseforitemlist) {
		this.nuseforitemlist = nuseforitemlist;
	}

	@Column(name = "NSORT", precision = 2, scale = 0)
	public Integer getNsort() {
		return this.nsort;
	}

	public void setNsort(final Integer nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NBULK_DECIMALS", nullable = false, precision = 1, scale = 0)
	public int getNbulkDecimals() {
		return this.nbulkDecimals;
	}

	public void setNbulkDecimals(final int nbulkDecimals) {
		this.nbulkDecimals = nbulkDecimals;
	}

	@Column(name = "NUSEPRICINGDETAILS", nullable = false, precision = 1, scale = 0)
	public int getNusepricingdetails() {
		return this.nusepricingdetails;
	}

	public void setNusepricingdetails(final int nusepricingdetails) {
		this.nusepricingdetails = nusepricingdetails;
	}

	@Column(name = "NUSE_INGREDIENTS", nullable = false, precision = 1, scale = 0)
	public int getNuseIngredients() {
		return this.nuseIngredients;
	}

	public void setNuseIngredients(final int nuseIngredients) {
		this.nuseIngredients = nuseIngredients;
	}

	@Column(name = "NUSE_ALLERGENS", nullable = false, precision = 1, scale = 0)
	public int getNuseAllergens() {
		return this.nuseAllergens;
	}

	public void setNuseAllergens(final int nuseAllergens) {
		this.nuseAllergens = nuseAllergens;
	}

	@Column(name = "CSAP_KIND", length = 1)
	public String getCsapKind() {
		return this.csapKind;
	}

	public void setCsapKind(final String csapKind) {
		this.csapKind = csapKind;
	}

	@Column(name = "NROLE_ID", nullable = false, precision = 5, scale = 0)
	public int getNroleId() {
		return this.nroleId;
	}

	public void setNroleId(final int nroleId) {
		this.nroleId = nroleId;
	}

	@Column(name = "NXSL", nullable = false, precision = 1, scale = 0)
	public int getNxsl() {
		return this.nxsl;
	}

	public void setNxsl(final int nxsl) {
		this.nxsl = nxsl;
	}

}
