package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.01.2021 15:33:18 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_LOADINGLISTS
 *
 * @author Hibernate Tools
 */
@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "CEN_LOADINGLISTS", uniqueConstraints = @UniqueConstraint(columnNames = { "CFREQUENCY", "CTIME_FROM", "NSTOWAGE_KEY",
		"NBELLY_CONTAINER", "NLOADINGLIST_INDEX_KEY", "CACTIONCODE", "NFOR_TO_CODE", "NTLC_KEY", "NSTOWAGE_SORT" }))
public class CenLoadinglists implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nloadinglistDetailKey;
	@JsonIgnore
	private SysThreeLetterCodes sysThreeLetterCodes;
	private Long nstowageKey;
	private CenPackinglistIndex cenPackinglistIndex;
	@JsonIgnore
	private CenLoadinglistIndex cenLoadinglistIndex;
	private String cfrequency;
	private int nbellyContainer;
	private int nforToCode;
	private String cactioncode;
	private String cclass;
	private String ctimeFrom;
	private String ctimeTo;
	private BigDecimal nquantity;
	private int nlabelQuantity;
	private String caddOnText;
	private String cmealControlCode;
	private String cmealControlCode2;
	private String cmealControlCode3;
	private Date dtimestampModification;
	private int nstowageSort;
	private Integer ncateringLeg;
	private Integer nranking;
	private Integer nrankingSpml;
	private Long nreckoning;
	private Integer nlimit;
	private Integer nlimitSpml;
	private String cclass1;
	private String cclass2;
	private String cclass3;
	private Integer nseparator;
	private String carticleLabourCode;
	private String cclass4;
	private String cclass5;
	private String cclass6;
	private String csalesRel;
	private String cprocessingStatus;
	private String cgoodsRecipient;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Integer ntrCartGroup;
	private int npaxFrom;
	private int npaxTo;
	private Set<CenLoadinglistsDynload> cenLoadinglistsDynloads = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_LOADINGLISTS")
	@SequenceGenerator(name = "SEQ_CEN_LOADINGLISTS", sequenceName = "SEQ_CEN_LOADINGLISTS", allocationSize = 1)
	@Column(name = "NLOADINGLIST_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadinglistDetailKey() {
		return this.nloadinglistDetailKey;
	}

	public void setNloadinglistDetailKey(long nloadinglistDetailKey) {
		this.nloadinglistDetailKey = nloadinglistDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_KEY", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodes() {
		return this.sysThreeLetterCodes;
	}

	public void setSysThreeLetterCodes(SysThreeLetterCodes sysThreeLetterCodes) {
		this.sysThreeLetterCodes = sysThreeLetterCodes;
	}

	@Column(name = "NSTOWAGE_KEY", nullable = false)
	public Long getNstowageKey() {
		return this.nstowageKey;
	}

	public void setNstowageKey(Long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOADINGLIST_INDEX_KEY", nullable = false)
	public CenLoadinglistIndex getCenLoadinglistIndex() {
		return this.cenLoadinglistIndex;
	}

	public void setCenLoadinglistIndex(CenLoadinglistIndex cenLoadinglistIndex) {
		this.cenLoadinglistIndex = cenLoadinglistIndex;
	}

	@Column(name = "CFREQUENCY", nullable = false, length = 7)
	public String getCfrequency() {
		return this.cfrequency;
	}

	public void setCfrequency(String cfrequency) {
		this.cfrequency = cfrequency;
	}

	@Column(name = "NBELLY_CONTAINER", nullable = false, precision = 3, scale = 0)
	public int getNbellyContainer() {
		return this.nbellyContainer;
	}

	public void setNbellyContainer(int nbellyContainer) {
		this.nbellyContainer = nbellyContainer;
	}

	@Column(name = "NFOR_TO_CODE", nullable = false, precision = 1, scale = 0)
	public int getNforToCode() {
		return this.nforToCode;
	}

	public void setNforToCode(int nforToCode) {
		this.nforToCode = nforToCode;
	}

	@Column(name = "CACTIONCODE", nullable = false, length = 1)
	public String getCactioncode() {
		return this.cactioncode;
	}

	public void setCactioncode(String cactioncode) {
		this.cactioncode = cactioncode;
	}

	@Column(name = "CCLASS", length = 12)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CTIME_FROM", nullable = false, length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", nullable = false, length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NLABEL_QUANTITY", nullable = false, precision = 6, scale = 0)
	public int getNlabelQuantity() {
		return this.nlabelQuantity;
	}

	public void setNlabelQuantity(int nlabelQuantity) {
		this.nlabelQuantity = nlabelQuantity;
	}

	@Column(name = "CADD_ON_TEXT", length = 40)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "CMEAL_CONTROL_CODE2", length = 4)
	public String getCmealControlCode2() {
		return this.cmealControlCode2;
	}

	public void setCmealControlCode2(String cmealControlCode2) {
		this.cmealControlCode2 = cmealControlCode2;
	}

	@Column(name = "CMEAL_CONTROL_CODE3", length = 4)
	public String getCmealControlCode3() {
		return this.cmealControlCode3;
	}

	public void setCmealControlCode3(String cmealControlCode3) {
		this.cmealControlCode3 = cmealControlCode3;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NSTOWAGE_SORT", nullable = false, precision = 6, scale = 0)
	public int getNstowageSort() {
		return this.nstowageSort;
	}

	public void setNstowageSort(int nstowageSort) {
		this.nstowageSort = nstowageSort;
	}

	@Column(name = "NCATERING_LEG", precision = 6, scale = 0)
	public Integer getNcateringLeg() {
		return this.ncateringLeg;
	}

	public void setNcateringLeg(Integer ncateringLeg) {
		this.ncateringLeg = ncateringLeg;
	}

	@Column(name = "NRANKING", precision = 6, scale = 0)
	public Integer getNranking() {
		return this.nranking;
	}

	public void setNranking(Integer nranking) {
		this.nranking = nranking;
	}

	@Column(name = "NRANKING_SPML", precision = 6, scale = 0)
	public Integer getNrankingSpml() {
		return this.nrankingSpml;
	}

	public void setNrankingSpml(Integer nrankingSpml) {
		this.nrankingSpml = nrankingSpml;
	}

	@Column(name = "NRECKONING", precision = 12, scale = 0)
	public Long getNreckoning() {
		return this.nreckoning;
	}

	public void setNreckoning(Long nreckoning) {
		this.nreckoning = nreckoning;
	}

	@Column(name = "NLIMIT", precision = 6, scale = 0)
	public Integer getNlimit() {
		return this.nlimit;
	}

	public void setNlimit(Integer nlimit) {
		this.nlimit = nlimit;
	}

	@Column(name = "NLIMIT_SPML", precision = 6, scale = 0)
	public Integer getNlimitSpml() {
		return this.nlimitSpml;
	}

	public void setNlimitSpml(Integer nlimitSpml) {
		this.nlimitSpml = nlimitSpml;
	}

	@Column(name = "CCLASS1", length = 5)
	public String getCclass1() {
		return this.cclass1;
	}

	public void setCclass1(String cclass1) {
		this.cclass1 = cclass1;
	}

	@Column(name = "CCLASS2", length = 5)
	public String getCclass2() {
		return this.cclass2;
	}

	public void setCclass2(String cclass2) {
		this.cclass2 = cclass2;
	}

	@Column(name = "CCLASS3", length = 5)
	public String getCclass3() {
		return this.cclass3;
	}

	public void setCclass3(String cclass3) {
		this.cclass3 = cclass3;
	}

	@Column(name = "NSEPARATOR", precision = 1, scale = 0)
	public Integer getNseparator() {
		return this.nseparator;
	}

	public void setNseparator(Integer nseparator) {
		this.nseparator = nseparator;
	}

	@Column(name = "CARTICLE_LABOUR_CODE", length = 2)
	public String getCarticleLabourCode() {
		return this.carticleLabourCode;
	}

	public void setCarticleLabourCode(String carticleLabourCode) {
		this.carticleLabourCode = carticleLabourCode;
	}

	@Column(name = "CCLASS4", length = 5)
	public String getCclass4() {
		return this.cclass4;
	}

	public void setCclass4(String cclass4) {
		this.cclass4 = cclass4;
	}

	@Column(name = "CCLASS5", length = 5)
	public String getCclass5() {
		return this.cclass5;
	}

	public void setCclass5(String cclass5) {
		this.cclass5 = cclass5;
	}

	@Column(name = "CCLASS6", length = 5)
	public String getCclass6() {
		return this.cclass6;
	}

	public void setCclass6(String cclass6) {
		this.cclass6 = cclass6;
	}

	@Column(name = "CSALES_REL", length = 1)
	public String getCsalesRel() {
		return this.csalesRel;
	}

	public void setCsalesRel(String csalesRel) {
		this.csalesRel = csalesRel;
	}

	@Column(name = "CPROCESSING_STATUS", length = 1)
	public String getCprocessingStatus() {
		return this.cprocessingStatus;
	}

	public void setCprocessingStatus(String cprocessingStatus) {
		this.cprocessingStatus = cprocessingStatus;
	}

	@Column(name = "CGOODS_RECIPIENT", length = 10)
	public String getCgoodsRecipient() {
		return this.cgoodsRecipient;
	}

	public void setCgoodsRecipient(String cgoodsRecipient) {
		this.cgoodsRecipient = cgoodsRecipient;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "NTR_CART_GROUP", precision = 3, scale = 0)
	public Integer getNtrCartGroup() {
		return this.ntrCartGroup;
	}

	public void setNtrCartGroup(Integer ntrCartGroup) {
		this.ntrCartGroup = ntrCartGroup;
	}

	@Column(name = "NPAX_FROM", nullable = false, precision = 4, scale = 0)
	public int getNpaxFrom() {
		return this.npaxFrom;
	}

	public void setNpaxFrom(int npaxFrom) {
		this.npaxFrom = npaxFrom;
	}

	@Column(name = "NPAX_TO", nullable = false, precision = 4, scale = 0)
	public int getNpaxTo() {
		return this.npaxTo;
	}

	public void setNpaxTo(int npaxTo) {
		this.npaxTo = npaxTo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLoadinglists")
	public Set<CenLoadinglistsDynload> getCenLoadinglistsDynloads() {
		return this.cenLoadinglistsDynloads;
	}

	public void setCenLoadinglistsDynloads(final Set<CenLoadinglistsDynload> cenLoadinglistsDynloads) {
		this.cenLoadinglistsDynloads = cenLoadinglistsDynloads;
	}

}
