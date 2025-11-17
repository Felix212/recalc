package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_DETAIL")
public class CenPackinglistDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPackinglistDetailId id;

	private CenAirlinePackages cenAirlinePackages;

	private CenPackinglists cenPackinglists;

	private SysPortionTool sysPortionTool;

	private Date dvalidFrom;

	private Date dvalidTo;

	private BigDecimal nquantity;

	private String caddOnText;

	private Date dtimestampModification;

	private Integer nnumberPackages;

	private Long nreckoning;

	private BigDecimal nyield;

	private BigDecimal nquantityNet;

	private Long nyieldCalcKey;

	private String carticleLabourCode;

	private BigDecimal nquantityRecipe;

	private BigDecimal nquantityRecipeNet;

	private Long nlayoutContentKey;

	private BigDecimal nquantityConv;

	private BigDecimal nquantityNetConv;

	private BigDecimal nquantityRecipeConv;

	private BigDecimal nquantityRecipeNetConv;

	private String cunitConv;

	private String cunitRecipeConv;

	private Integer nlegNumber;

	private String cpositionType;

	private String cproductionRel;

	private String cbillingRel;

	private String cprocessingStatus;

	private String cgoodsRecipient;

	private String csalesRel;

	private Integer nflagMassupdate;

	private String citmIdent;

	private String cupdatedBy;

	private Date dupdatedDate;

	private String cupdatedByPrev;

	private Date dupdatedDatePrev;

	private BigDecimal nquantityAme;

	private BigDecimal nquantityAmeNet;

	private String cunitAme;

	private Integer ninvRelevant;

	private String coption;

	private String csuggestion;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ndetailKey", column = @Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nsort", column = @Column(name = "NSORT", nullable = false, precision = 6, scale = 0)) })
	public CenPackinglistDetailId getId() {
		return this.id;
	}

	public void setId(final CenPackinglistDetailId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_PACKAGE_KEY")
	public CenAirlinePackages getCenAirlinePackages() {
		return this.cenAirlinePackages;
	}

	public void setCenAirlinePackages(final CenAirlinePackages cenAirlinePackages) {
		this.cenAirlinePackages = cenAirlinePackages;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPORTION_TOOL_KEY")
	public SysPortionTool getSysPortionTool() {
		return this.sysPortionTool;
	}

	public void setSysPortionTool(final SysPortionTool sysPortionTool) {
		this.sysPortionTool = sysPortionTool;
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

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 6)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CADD_ON_TEXT", length = 40)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NNUMBER_PACKAGES", precision = 6, scale = 0)
	public Integer getNnumberPackages() {
		return this.nnumberPackages;
	}

	public void setNnumberPackages(final Integer nnumberPackages) {
		this.nnumberPackages = nnumberPackages;
	}

	@Column(name = "NRECKONING", precision = 12, scale = 0)
	public Long getNreckoning() {
		return this.nreckoning;
	}

	public void setNreckoning(final Long nreckoning) {
		this.nreckoning = nreckoning;
	}

	@Column(name = "NYIELD", precision = 6, scale = 3)
	public BigDecimal getNyield() {
		return this.nyield;
	}

	public void setNyield(final BigDecimal nyield) {
		this.nyield = nyield;
	}

	@Column(name = "NQUANTITY_NET", precision = 15, scale = 6)
	public BigDecimal getNquantityNet() {
		return this.nquantityNet;
	}

	public void setNquantityNet(final BigDecimal nquantityNet) {
		this.nquantityNet = nquantityNet;
	}

	@Column(name = "NYIELD_CALC_KEY", precision = 12, scale = 0)
	public Long getNyieldCalcKey() {
		return this.nyieldCalcKey;
	}

	public void setNyieldCalcKey(final Long nyieldCalcKey) {
		this.nyieldCalcKey = nyieldCalcKey;
	}

	@Column(name = "CARTICLE_LABOUR_CODE", length = 2)
	public String getCarticleLabourCode() {
		return this.carticleLabourCode;
	}

	public void setCarticleLabourCode(final String carticleLabourCode) {
		this.carticleLabourCode = carticleLabourCode;
	}

	@Column(name = "NQUANTITY_RECIPE", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipe() {
		return this.nquantityRecipe;
	}

	public void setNquantityRecipe(final BigDecimal nquantityRecipe) {
		this.nquantityRecipe = nquantityRecipe;
	}

	@Column(name = "NQUANTITY_RECIPE_NET", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipeNet() {
		return this.nquantityRecipeNet;
	}

	public void setNquantityRecipeNet(final BigDecimal nquantityRecipeNet) {
		this.nquantityRecipeNet = nquantityRecipeNet;
	}

	@Column(name = "NLAYOUT_CONTENT_KEY", precision = 12, scale = 0)
	public Long getNlayoutContentKey() {
		return this.nlayoutContentKey;
	}

	public void setNlayoutContentKey(final Long nlayoutContentKey) {
		this.nlayoutContentKey = nlayoutContentKey;
	}

	@Column(name = "NQUANTITY_CONV", precision = 15, scale = 6)
	public BigDecimal getNquantityConv() {
		return this.nquantityConv;
	}

	public void setNquantityConv(final BigDecimal nquantityConv) {
		this.nquantityConv = nquantityConv;
	}

	@Column(name = "NQUANTITY_NET_CONV", precision = 15, scale = 6)
	public BigDecimal getNquantityNetConv() {
		return this.nquantityNetConv;
	}

	public void setNquantityNetConv(final BigDecimal nquantityNetConv) {
		this.nquantityNetConv = nquantityNetConv;
	}

	@Column(name = "NQUANTITY_RECIPE_CONV", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipeConv() {
		return this.nquantityRecipeConv;
	}

	public void setNquantityRecipeConv(final BigDecimal nquantityRecipeConv) {
		this.nquantityRecipeConv = nquantityRecipeConv;
	}

	@Column(name = "NQUANTITY_RECIPE_NET_CONV", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipeNetConv() {
		return this.nquantityRecipeNetConv;
	}

	public void setNquantityRecipeNetConv(final BigDecimal nquantityRecipeNetConv) {
		this.nquantityRecipeNetConv = nquantityRecipeNetConv;
	}

	@Column(name = "CUNIT_CONV", length = 5)
	public String getCunitConv() {
		return this.cunitConv;
	}

	public void setCunitConv(final String cunitConv) {
		this.cunitConv = cunitConv;
	}

	@Column(name = "CUNIT_RECIPE_CONV", length = 5)
	public String getCunitRecipeConv() {
		return this.cunitRecipeConv;
	}

	public void setCunitRecipeConv(final String cunitRecipeConv) {
		this.cunitRecipeConv = cunitRecipeConv;
	}

	@Column(name = "NLEG_NUMBER", precision = 7, scale = 0)
	public Integer getNlegNumber() {
		return this.nlegNumber;
	}

	public void setNlegNumber(final Integer nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	@Column(name = "CPOSITION_TYPE", length = 1)
	public String getCpositionType() {
		return this.cpositionType;
	}

	public void setCpositionType(final String cpositionType) {
		this.cpositionType = cpositionType;
	}

	@Column(name = "CPRODUCTION_REL", length = 1)
	public String getCproductionRel() {
		return this.cproductionRel;
	}

	public void setCproductionRel(final String cproductionRel) {
		this.cproductionRel = cproductionRel;
	}

	@Column(name = "CBILLING_REL", length = 1)
	public String getCbillingRel() {
		return this.cbillingRel;
	}

	public void setCbillingRel(final String cbillingRel) {
		this.cbillingRel = cbillingRel;
	}

	@Column(name = "CPROCESSING_STATUS", length = 1)
	public String getCprocessingStatus() {
		return this.cprocessingStatus;
	}

	public void setCprocessingStatus(final String cprocessingStatus) {
		this.cprocessingStatus = cprocessingStatus;
	}

	@Column(name = "CGOODS_RECIPIENT", length = 10)
	public String getCgoodsRecipient() {
		return this.cgoodsRecipient;
	}

	public void setCgoodsRecipient(final String cgoodsRecipient) {
		this.cgoodsRecipient = cgoodsRecipient;
	}

	@Column(name = "CSALES_REL", length = 1)
	public String getCsalesRel() {
		return this.csalesRel;
	}

	public void setCsalesRel(final String csalesRel) {
		this.csalesRel = csalesRel;
	}

	@Column(name = "NFLAG_MASSUPDATE", precision = 1, scale = 0)
	public Integer getNflagMassupdate() {
		return this.nflagMassupdate;
	}

	public void setNflagMassupdate(final Integer nflagMassupdate) {
		this.nflagMassupdate = nflagMassupdate;
	}

	@Column(name = "CITM_IDENT", length = 8)
	public String getCitmIdent() {
		return this.citmIdent;
	}

	public void setCitmIdent(final String citmIdent) {
		this.citmIdent = citmIdent;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "NQUANTITY_AME", precision = 15, scale = 6)
	public BigDecimal getNquantityAme() {
		return this.nquantityAme;
	}

	public void setNquantityAme(final BigDecimal nquantityAme) {
		this.nquantityAme = nquantityAme;
	}

	@Column(name = "NQUANTITY_AME_NET", precision = 15, scale = 6)
	public BigDecimal getNquantityAmeNet() {
		return this.nquantityAmeNet;
	}

	public void setNquantityAmeNet(final BigDecimal nquantityAmeNet) {
		this.nquantityAmeNet = nquantityAmeNet;
	}

	@Column(name = "CUNIT_AME", length = 5)
	public String getCunitAme() {
		return this.cunitAme;
	}

	public void setCunitAme(final String cunitAme) {
		this.cunitAme = cunitAme;
	}

	@Column(name = "NINV_RELEVANT", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNinvRelevant() {
		return ninvRelevant;
	}

	public void setNinvRelevant(Integer ninvRelevant) {
		this.ninvRelevant = ninvRelevant;
	}

	public String getCoption() {
		return coption;
	}

	public void setCoption(String coption) {
		this.coption = coption;
	}

	public String getCsuggestion() {
		return csuggestion;
	}

	public void setCsuggestion(String csuggestion) {
		this.csuggestion = csuggestion;
	}
}
