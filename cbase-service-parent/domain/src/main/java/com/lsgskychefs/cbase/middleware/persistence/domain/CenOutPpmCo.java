package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Arrays;
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
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.OneToMany;
import javax.persistence.ParameterMode;
import javax.persistence.SequenceGenerator;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpCopyCo;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpIncrease;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpUpdateStorage;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CO (content of CenOutPpm)
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpCopyCo.PP_COPY_CO, procedureName = "CBASE_PPM."
				+ PpCopyCo.PP_COPY_CO, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpCopyCo.P_BATCH_SEQ_OLD, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpCopyCo.P_BATCH_SEQ_NEW, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpCopyCo.P_RET_VALUE, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpCopyCo.P_RET_MSG, type = String.class)
		}),
		@NamedStoredProcedureQuery(name = PpUpdateStorage.PP_UPDATE_STORAGES, procedureName = "CBASE_PPM_UK."
				+ PpUpdateStorage.PP_UPDATE_STORAGES, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpUpdateStorage.P_NRESULT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpUpdateStorage.P_TRANSACTION, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpUpdateStorage.P_RET_MSG, type = String.class)
		}),
		@NamedStoredProcedureQuery(name = PpIncrease.PP_INCREASE, procedureName = "CBASE_PPM_UK."
				+ PpIncrease.PP_INCREASE, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpIncrease.P_NRESULT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpIncrease.P_NPL_INDEX_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpIncrease.P_NQUANTITY, type = BigDecimal.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpIncrease.P_NSHORTAGEWATE_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpIncrease.P_MSG, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpIncrease.P_NBATCH_SEQ, type = Long.class)
		}),
		@NamedStoredProcedureQuery(name = CbaseMiddlewareDbConstants.PfGetPlAllergens.PF_GET_PL_ALLERGENS, procedureName =
				"CBASE_ALLERGENS."
						+ CbaseMiddlewareDbConstants.PfGetPlAllergens.PF_GET_PL_ALLERGENS, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_PL_INDEX_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_PL_DETAIL_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_INCLUDE_TRACES, type = Integer.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_DELIMITER_CODE, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_DELIMITER_TEXT, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_LANGUAGE_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_ALLERGEN_CODES, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = CbaseMiddlewareDbConstants.PfGetPlAllergens.P_ALLERGEN_TEXTS, type = String.class),
		})
})

@Entity
@Table(name = "CEN_OUT_PPM_CO")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenOutPpmCo implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long nppmCoKey;

	@JsonIgnore
	private CenOutPpm cenOutPpm;

	private String cpackinglist;

	private long npackinglistIndexKey;

	private long npackinglistDetailKey;

	private String ctext;

	private String caddOnText;

	private BigDecimal ntempStart;

	private Boolean ntempStartManual;

	private BigDecimal ntempStop;

	private Boolean ntempStopManual;

	private Integer nalertLevel;

	private String cuserStart;

	private String cuserStop;

	private Date dtimeStart;

	private Date dtimeStop;

	private int nphfFlag;

	private String ctextShort;

	private Long nplKindKey;

	private String ckind;

	private Long npackinglistKey;

	private Integer npackingListLevel;

	private String caddOnTextDetail;

	private Integer nsort;

	private String cunit;

	private BigDecimal nquantity;

	private String cunitOrig;

	private BigDecimal nquantityOrig;

	private Long npictureIndexKey;

	private Long nbatchSeq;

	private int nclassification;

	private boolean nmdco;

	private Long nmdcoSpml;

	private String cmdcoRemark;

	private Long nmdcoPltypeKey;

	private String cmdcoPlType;

	private Long nmdcoClassNumber;

	private String cmdcoClass;

	private String cmdcoMealControlCode;

	private int npacked;

	private String csubstitution;

	/** Can be used to provide the trail status */
	private Integer statusPrevTrailpoint;

	/** Can be used to provide the trail name */
	private String namePrevTrailpoint;

	private String cverificationUser;

	private Long nproductIndexKey;

	private String cproductGroup;

	private String ctextProductGroup;

	private Integer nreckoning;

	private String ctextLocUnitPlProdLabel;

	private BigDecimal nquantityRecipe;

	private BigDecimal nquantityRecipeConv;

	private BigDecimal nquantityRecipeNet;

	private BigDecimal nquantityRecipeNetConv;

	private BigDecimal npackedQuantity;

	private Long nportionToolKey;

	private String cportionTool;

	private String cportionSize;

	private Integer nptRed;

	private Integer nptGreen;

	private Integer nptBlue;

	private Long nptColorcodeMs;

	private Long nptColorcode;

	private String cptColorcodeHex;

	private String cptColorText;

	private Integer nptTextcolor;

	private BigDecimal nyield;

	private BigDecimal nquantityNet;

	private BigDecimal nquantityBatch;

	private BigDecimal nquantityNetBatch;

	private String ccustomerPl;

	private String ccustomerText;

	@JsonManagedReference
	private Set<CenOutPpmCoBatchcode> cenOutPpmCoBatchcodes = new HashSet<>(0);

	@JsonManagedReference
	private Set<CenOutPpmCoWeight> cenOutPpmCoWeights = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutPpmCoCom> cenOutPpmCoComs = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CO")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CO", sequenceName = "SEQ_CEN_OUT_PPM_CO", allocationSize = 1)
	@Column(name = "NPPM_CO_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNppmCoKey() {
		return this.nppmCoKey;
	}

	public void setNppmCoKey(final Long nppmCoKey) {
		this.nppmCoKey = nppmCoKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_DETAIL_KEY", nullable = false)
	public CenOutPpm getCenOutPpm() {
		return this.cenOutPpm;
	}

	public void setCenOutPpm(final CenOutPpm cenOutPpm) {
		this.cenOutPpm = cenOutPpm;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CADD_ON_TEXT", length = 80)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "NTEMP_START", precision = 12)
	public BigDecimal getNtempStart() {
		return this.ntempStart;
	}

	public void setNtempStart(final BigDecimal ntempStart) {
		this.ntempStart = ntempStart;
	}

	@Column(name = "NTEMP_START_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempStartManual() {
		return this.ntempStartManual;
	}

	public void setNtempStartManual(final Boolean ntempStartManual) {
		this.ntempStartManual = ntempStartManual;
	}

	@Column(name = "NTEMP_STOP", precision = 12)
	public BigDecimal getNtempStop() {
		return this.ntempStop;
	}

	public void setNtempStop(final BigDecimal ntempStop) {
		this.ntempStop = ntempStop;
	}

	@Column(name = "NTEMP_STOP_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempStopManual() {
		return this.ntempStopManual;
	}

	public void setNtempStopManual(final Boolean ntempStopManual) {
		this.ntempStopManual = ntempStopManual;
	}

	@Column(name = "NALERT_LEVEL", precision = 6, scale = 0)
	public Integer getNalertLevel() {
		return this.nalertLevel;
	}

	public void setNalertLevel(final Integer nalertLevel) {
		this.nalertLevel = nalertLevel;
	}

	@Column(name = "CUSER_START", length = 40)
	public String getCuserStart() {
		return this.cuserStart;
	}

	public void setCuserStart(final String cuserStart) {
		this.cuserStart = cuserStart;
	}

	@Column(name = "CUSER_STOP", length = 40)
	public String getCuserStop() {
		return this.cuserStop;
	}

	public void setCuserStop(final String cuserStop) {
		this.cuserStop = cuserStop;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_START", length = 7)
	public Date getDtimeStart() {
		return this.dtimeStart;
	}

	public void setDtimeStart(final Date dtimeStart) {
		this.dtimeStart = dtimeStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_STOP", length = 7)
	public Date getDtimeStop() {
		return this.dtimeStop;
	}

	public void setDtimeStop(final Date dtimeStop) {
		this.dtimeStop = dtimeStop;
	}

	@Column(name = "NPHF_FLAG", nullable = false, precision = 1, scale = 0)
	public int getNphfFlag() {
		return this.nphfFlag;
	}

	public void setNphfFlag(final int nphfFlag) {
		this.nphfFlag = nphfFlag;
	}

	@Column(name = "CTEXT_SHORT", length = 40)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "CKIND", length = 10)
	public String getCkind() {
		return this.ckind;
	}

	public void setCkind(final String ckind) {
		this.ckind = ckind;
	}

	@Column(name = "NPACKINGLIST_KEY", precision = 12, scale = 0)
	public Long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@Column(name = "NPACKING_LIST_LEVEL", precision = 2, scale = 0)
	public Integer getNpackingListLevel() {
		return this.npackingListLevel;
	}

	public void setNpackingListLevel(final Integer npackingListLevel) {
		this.npackingListLevel = npackingListLevel;
	}

	@Column(name = "CADD_ON_TEXT_DETAIL", length = 40)
	public String getCaddOnTextDetail() {
		return this.caddOnTextDetail;
	}

	public void setCaddOnTextDetail(final String caddOnTextDetail) {
		this.caddOnTextDetail = caddOnTextDetail;
	}

	@Column(name = "NSORT", precision = 6, scale = 0)
	public Integer getNsort() {
		return this.nsort;
	}

	public void setNsort(final Integer nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NQUANTITY", precision = 15, scale = 6)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CUNIT_ORIG", length = 5)
	public String getCunitOrig() {
		return this.cunitOrig;
	}

	public void setCunitOrig(final String cunitOrig) {
		this.cunitOrig = cunitOrig;
	}

	@Column(name = "NQUANTITY_ORIG", precision = 15, scale = 6)
	public BigDecimal getNquantityOrig() {
		return this.nquantityOrig;
	}

	public void setNquantityOrig(final BigDecimal nquantityOrig) {
		this.nquantityOrig = nquantityOrig;
	}

	@Column(name = "NPICTURE_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpictureIndexKey() {
		return this.npictureIndexKey;
	}

	public void setNpictureIndexKey(final Long npictureIndexKey) {
		this.npictureIndexKey = npictureIndexKey;
	}

	@Column(name = "NBATCH_SEQ", precision = 12, scale = 0)
	public Long getNbatchSeq() {
		return nbatchSeq;
	}

	public void setNbatchSeq(final Long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Column(name = "NCLASSIFICATION", nullable = false, precision = 2, scale = 0)
	public int getNclassification() {
		return this.nclassification;
	}

	public void setNclassification(final int nclassification) {
		this.nclassification = nclassification;
	}

	@Column(name = "NMDCO", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean isNmdco() {
		return this.nmdco;
	}

	public void setNmdco(final boolean nmdco) {
		this.nmdco = nmdco;
	}

	@Column(name = "NMDCO_SPML", precision = 12, scale = 0)
	public Long getNmdcoSpml() {
		return this.nmdcoSpml;
	}

	public void setNmdcoSpml(final Long nmdcoSpml) {
		this.nmdcoSpml = nmdcoSpml;
	}

	@Column(name = "CMDCO_REMARK", length = 40)
	public String getCmdcoRemark() {
		return this.cmdcoRemark;
	}

	public void setCmdcoRemark(final String cmdcoRemark) {
		this.cmdcoRemark = cmdcoRemark;
	}

	@Column(name = "NMDCO_PLTYPE_KEY", precision = 12, scale = 0)
	public Long getNmdcoPltypeKey() {
		return this.nmdcoPltypeKey;
	}

	public void setNmdcoPltypeKey(final Long nmdcoPltypeKey) {
		this.nmdcoPltypeKey = nmdcoPltypeKey;
	}

	@Column(name = "CMDCO_PL_TYPE", length = 20)
	public String getCmdcoPlType() {
		return this.cmdcoPlType;
	}

	public void setCmdcoPlType(final String cmdcoPlType) {
		this.cmdcoPlType = cmdcoPlType;
	}

	@Column(name = "NMDCO_CLASS_NUMBER", precision = 12, scale = 0)
	public Long getNmdcoClassNumber() {
		return this.nmdcoClassNumber;
	}

	public void setNmdcoClassNumber(final Long nmdcoClassNumber) {
		this.nmdcoClassNumber = nmdcoClassNumber;
	}

	@Column(name = "CMDCO_CLASS", length = 10)
	public String getCmdcoClass() {
		return this.cmdcoClass;
	}

	public void setCmdcoClass(final String cmdcoClass) {
		this.cmdcoClass = cmdcoClass;
	}

	@Column(name = "CMDCO_MEAL_CONTROL_CODE", length = 10)
	public String getCmdcoMealControlCode() {
		return this.cmdcoMealControlCode;
	}

	public void setCmdcoMealControlCode(final String cmdcoMealControlCode) {
		this.cmdcoMealControlCode = cmdcoMealControlCode;
	}

	@Column(name = "NPACKED", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNpacked() {
		return this.npacked;
	}

	public void setNpacked(final int npacked) {
		this.npacked = npacked;
	}

	@Column(name = "CSUBSTITUTION", length = 80)
	public String getCsubstitution() {
		return this.csubstitution;
	}

	public void setCsubstitution(final String csubstitution) {
		this.csubstitution = csubstitution;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmCo")
	public Set<CenOutPpmCoBatchcode> getCenOutPpmCoBatchcodes() {
		return this.cenOutPpmCoBatchcodes;
	}

	public void setCenOutPpmCoBatchcodes(final Set<CenOutPpmCoBatchcode> cenOutPpmCoBatchcodes) {
		this.cenOutPpmCoBatchcodes = cenOutPpmCoBatchcodes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmCo")
	public Set<CenOutPpmCoWeight> getCenOutPpmCoWeights() {
		return this.cenOutPpmCoWeights;
	}

	public void setCenOutPpmCoWeights(final Set<CenOutPpmCoWeight> cenOutPpmCoWeights) {
		this.cenOutPpmCoWeights = cenOutPpmCoWeights;
	}

	/** {@inheritDoc} */
	@Override
	public String toString() {
		return ReflectionToStringBuilder.toStringExclude(this,
				Arrays.asList("cenOutPpm", "cenOutPpmCoComs", "cenOutPpmCoWeights", "cenOutPpmCoBatchcodes"));
	}

	@Transient
	public Integer getStatusPrevTrailpoint() {
		return statusPrevTrailpoint;
	}

	public void setStatusPrevTrailpoint(final Integer integer) {
		this.statusPrevTrailpoint = integer;
	}

	@Transient
	public String getNamePrevTrailpoint() {
		return namePrevTrailpoint;
	}

	public void setNamePrevTrailpoint(final String value) {
		this.namePrevTrailpoint = value;
	}

	@Column(name = "CVERIFICATION_USER", length = 40)
	public String getCverificationUser() {
		return this.cverificationUser;
	}

	public void setCverificationUser(final String cverificationUser) {
		this.cverificationUser = cverificationUser;
	}

	@Column(name = "NPRODUCT_INDEX_KEY", precision = 12, scale = 0)
	public Long getNproductIndexKey() {
		return this.nproductIndexKey;
	}

	public void setNproductIndexKey(final Long nproductIndexKey) {
		this.nproductIndexKey = nproductIndexKey;
	}

	@Column(name = "CPRODUCT_GROUP", length = 18)
	public String getCproductGroup() {
		return this.cproductGroup;
	}

	public void setCproductGroup(final String cproductGroup) {
		this.cproductGroup = cproductGroup;
	}

	@Column(name = "CTEXT_PRODUCT_GROUP", length = 40)
	public String getCtextProductGroup() {
		return this.ctextProductGroup;
	}

	public void setCtextProductGroup(final String ctextProductGroup) {
		this.ctextProductGroup = ctextProductGroup;
	}

	@Column(name = "NRECKONING", precision = 1, scale = 0)
	public Integer getNreckoning() {
		return nreckoning;
	}

	public void setNreckoning(final Integer nreckoning) {
		this.nreckoning = nreckoning;
	}

	@Column(name = "CTEXT_LOC_UNIT_PL_PROD_LABEL", length = 80)
	public String getCtextLocUnitPlProdLabel() {
		return ctextLocUnitPlProdLabel;
	}

	public void setCtextLocUnitPlProdLabel(final String ctextLocUnitPlProdLabel) {
		this.ctextLocUnitPlProdLabel = ctextLocUnitPlProdLabel;
	}

	@Column(name = "NQUANTITY_RECIPE", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipe() {
		return this.nquantityRecipe;
	}

	public void setNquantityRecipe(final BigDecimal nquantityRecipe) {
		this.nquantityRecipe = nquantityRecipe;
	}

	@Column(name = "NQUANTITY_RECIPE_CONV", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipeConv() {
		return this.nquantityRecipeConv;
	}

	public void setNquantityRecipeConv(final BigDecimal nquantityRecipeConv) {
		this.nquantityRecipeConv = nquantityRecipeConv;
	}

	@Column(name = "NQUANTITY_RECIPE_NET", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipeNet() {
		return this.nquantityRecipeNet;
	}

	public void setNquantityRecipeNet(final BigDecimal nquantityRecipeNet) {
		this.nquantityRecipeNet = nquantityRecipeNet;
	}

	@Column(name = "NQUANTITY_RECIPE_NET_CONV", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipeNetConv() {
		return this.nquantityRecipeNetConv;
	}

	public void setNquantityRecipeNetConv(final BigDecimal nquantityRecipeNetConv) {
		this.nquantityRecipeNetConv = nquantityRecipeNetConv;
	}

	@Column(name = "NPACKED_QUANTITY", precision = 15, scale = 6)
	public BigDecimal getNpackedQuantity() {
		return this.npackedQuantity;
	}

	public void setNpackedQuantity(final BigDecimal npackedQuantity) {
		this.npackedQuantity = npackedQuantity;
	}

	@Column(name = "NPORTION_TOOL_KEY", precision = 12, scale = 0)
	public Long getNportionToolKey() {
		return this.nportionToolKey;
	}

	public void setNportionToolKey(final Long nportionToolKey) {
		this.nportionToolKey = nportionToolKey;
	}

	@Column(name = "CPORTION_TOOL", length = 10)
	public String getCportionTool() {
		return this.cportionTool;
	}

	public void setCportionTool(final String cportionTool) {
		this.cportionTool = cportionTool;
	}

	@Column(name = "CPORTION_SIZE", length = 50)
	public String getCportionSize() {
		return this.cportionSize;
	}

	public void setCportionSize(final String cportionSize) {
		this.cportionSize = cportionSize;
	}

	@Column(name = "NPT_RED", precision = 3, scale = 0)
	public Integer getNptRed() {
		return this.nptRed;
	}

	public void setNptRed(final Integer nptRed) {
		this.nptRed = nptRed;
	}

	@Column(name = "NPT_GREEN", precision = 3, scale = 0)
	public Integer getNptGreen() {
		return this.nptGreen;
	}

	public void setNptGreen(final Integer nptGreen) {
		this.nptGreen = nptGreen;
	}

	@Column(name = "NPT_BLUE", precision = 3, scale = 0)
	public Integer getNptBlue() {
		return this.nptBlue;
	}

	public void setNptBlue(final Integer nptBlue) {
		this.nptBlue = nptBlue;
	}

	@Column(name = "NPT_COLORCODE_MS", precision = 12, scale = 0)
	public Long getNptColorcodeMs() {
		return this.nptColorcodeMs;
	}

	public void setNptColorcodeMs(final Long nptColorcodeMs) {
		this.nptColorcodeMs = nptColorcodeMs;
	}

	@Column(name = "NPT_COLORCODE", precision = 12, scale = 0)
	public Long getNptColorcode() {
		return this.nptColorcode;
	}

	public void setNptColorcode(final Long nptColorcode) {
		this.nptColorcode = nptColorcode;
	}

	@Column(name = "CPT_COLORCODE_HEX", length = 6)
	public String getCptColorcodeHex() {
		return this.cptColorcodeHex;
	}

	public void setCptColorcodeHex(final String cptColorcodeHex) {
		this.cptColorcodeHex = cptColorcodeHex;
	}

	@Column(name = "CPT_COLOR_TEXT", length = 20)
	public String getCptColorText() {
		return this.cptColorText;
	}

	public void setCptColorText(final String cptColorText) {
		this.cptColorText = cptColorText;
	}

	@Column(name = "NPT_TEXTCOLOR", precision = 1, scale = 0)
	public Integer getNptTextcolor() {
		return this.nptTextcolor;
	}

	public void setNptTextcolor(final Integer nptTextcolor) {
		this.nptTextcolor = nptTextcolor;
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

	@Column(name = "NQUANTITY_BATCH", precision = 15, scale = 6)
	public BigDecimal getNquantityBatch() {
		return this.nquantityBatch;
	}

	public void setNquantityBatch(final BigDecimal nquantityBatch) {
		this.nquantityBatch = nquantityBatch;
	}

	@Column(name = "NQUANTITY_NET_BATCH", precision = 15, scale = 6)
	public BigDecimal getNquantityNetBatch() {
		return this.nquantityNetBatch;
	}

	public void setNquantityNetBatch(final BigDecimal nquantityNetBatch) {
		this.nquantityNetBatch = nquantityNetBatch;
	}

	@Column(name = "CCUSTOMER_PL", length = 54)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 150)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmCo")
	public Set<CenOutPpmCoCom> getCenOutPpmCoComs() {
		return this.cenOutPpmCoComs;
	}

	public void setCenOutPpmCoComs(final Set<CenOutPpmCoCom> cenOutPpmCoComs) {
		this.cenOutPpmCoComs = cenOutPpmCoComs;
	}

}
