package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 10, 2025 3:00:23 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_PL_MP_PROJECT_VERSION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_MP_PROJECT_VERSION")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "mp.pl.project.fetchpackinglists", attributeNodes = {
				@NamedAttributeNode(value = "cenPackinglists", subgraph = "packinglist.details")
		}, subgraphs = {
				@NamedSubgraph(name = "packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistIf")
				})
		})
})
public class CenPlMpProjectVersion extends AuditableDomainObject {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nplMpProjectVersionKey;
	private CenPlMpProject cenPlMpProject;
	private CenMpProject cenMpProject;
	private CenMpWorkstations cenMpWorkstations;
	private CenPackinglists cenPackinglists;
	private CenPackinglistDetail cenPackinglistDetail;
	private CenFollowUpMaster cenFollowUpMaster;
	private SysMpPlStatus sysMpPlStatus;
	private String cproductionNo;
	private boolean nisHeader;
	private boolean nisContent;
	private String cdescription;
	private BigDecimal nquantity;
	private String cunit;
	private BigDecimal nquantityManual;
	private String cunitManual;
	private Date dproductiondate;
	private Long nisInvalidated;
	private String cpackinglistHeader;
	private boolean nisNotNeeded;
	private BigDecimal nquantityProduced;
	private String cunitProduced;
	private Date dstartedDate;
	private Date dfinishedDate;
	private Date dunderReviewDate;
	private Long noffsetDays;
	private String cstatusUpdatedBy;
	private String cdirectAncestor;
	private boolean nisInlinePrep;
	private long nversionNumber;
	private Date dtimestamp;
	private String cancestors;
	private BigDecimal nquantityEach;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PL_MP_PROJECT_VERSION")
	@SequenceGenerator(name = "SEQ_CEN_PL_MP_PROJECT_VERSION", sequenceName = "SEQ_CEN_PL_MP_PROJECT_VERSION", allocationSize = 1)
	@Column(name = "NPL_MP_PROJECT_VERSION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplMpProjectVersionKey() {
		return nplMpProjectVersionKey;
	}

	public void setNplMpProjectVersionKey(long nplMpProjectVersionKey) {
		this.nplMpProjectVersionKey = nplMpProjectVersionKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_MP_PROJECT_KEY", nullable = false)
	public CenPlMpProject getCenPlMpProject() {
		return this.cenPlMpProject;
	}

	public void setCenPlMpProject(CenPlMpProject cenPlMpProject) {
		this.cenPlMpProject = cenPlMpProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_PROJECT_KEY", nullable = false)
	public CenMpProject getCenMpProject() {
		return this.cenMpProject;
	}

	public void setCenMpProject(CenMpProject cenMpProject) {
		this.cenMpProject = cenMpProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_WORKSTATION_KEY")
	public CenMpWorkstations getCenMpWorkstations() {
		return this.cenMpWorkstations;
	}

	public void setCenMpWorkstations(CenMpWorkstations cenMpWorkstations) {
		this.cenMpWorkstations = cenMpWorkstations;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPARENT_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY"),
			@JoinColumn(name = "NPARENT_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY"),
			@JoinColumn(name = "NDETAIL_KEY", referencedColumnName = "NDETAIL_KEY"),
			@JoinColumn(name = "NSORT", referencedColumnName = "NSORT") })
	public CenPackinglistDetail getCenPackinglistDetail() {
		return this.cenPackinglistDetail;
	}

	public void setCenPackinglistDetail(CenPackinglistDetail cenPackinglistDetail) {
		this.cenPackinglistDetail = cenPackinglistDetail;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return this.cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_PL_STATUS_KEY")
	public SysMpPlStatus getSysMpPlStatus() {
		return this.sysMpPlStatus;
	}

	public void setSysMpPlStatus(SysMpPlStatus sysMpPlStatus) {
		this.sysMpPlStatus = sysMpPlStatus;
	}

	public String getCproductionNo() {
		return cproductionNo;
	}

	public void setCproductionNo(String cproductionNo) {
		this.cproductionNo = cproductionNo;
	}

	@Column(name = "NIS_HEADER", nullable = false, precision = 22, scale = 0)
	public boolean getNisHeader() {
		return this.nisHeader;
	}

	public void setNisHeader(boolean nisHeader) {
		this.nisHeader = nisHeader;
	}

	@Column(name = "NIS_CONTENT", nullable = false, precision = 22, scale = 0)
	public boolean getNisContent() {
		return this.nisContent;
	}

	public void setNisContent(boolean nisContent) {
		this.nisContent = nisContent;
	}

	@Column(name = "CDESCRIPTION", length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	public BigDecimal getNquantity() {
		return nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CUNIT", length = 256)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	public BigDecimal getNquantityManual() {
		return nquantityManual;
	}

	public void setNquantityManual(BigDecimal nquantityManual) {
		this.nquantityManual = nquantityManual;
	}

	@Column(name = "CUNIT_MANUAL", length = 256)
	public String getCunitManual() {
		return this.cunitManual;
	}

	public void setCunitManual(String cunitManual) {
		this.cunitManual = cunitManual;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPRODUCTIONDATE", length = 7)
	public Date getDproductiondate() {
		return this.dproductiondate;
	}

	public void setDproductiondate(Date dproductiondate) {
		this.dproductiondate = dproductiondate;
	}

	public Long getNisInvalidated() {
		return nisInvalidated;
	}

	public void setNisInvalidated(Long nisInvalidated) {
		this.nisInvalidated = nisInvalidated;
	}

	public String getCpackinglistHeader() {
		return cpackinglistHeader;
	}

	public void setCpackinglistHeader(String cpackinglistHeader) {
		this.cpackinglistHeader = cpackinglistHeader;
	}

	@Column(name = "NIS_NOTNEEDED", precision = 1, scale = 0)
	public boolean getNisNotNeeded() {
		return nisNotNeeded;
	}

	public void setNisNotNeeded(boolean nisNotNeeded) {
		this.nisNotNeeded = nisNotNeeded;
	}

	@Column(name = "NQUANTITY_PRODUCED", precision = 38, scale = 5)
	public BigDecimal getNquantityProduced() {
		return nquantityProduced;
	}

	public void setNquantityProduced(BigDecimal nquantityProduced) {
		this.nquantityProduced = nquantityProduced;
	}

	@Column(name = "CUNIT_PRODUCED", length = 256)
	public String getCunitProduced() {
		return this.cunitProduced;
	}

	public void setCunitProduced(String cunitProduced) {
		this.cunitProduced = cunitProduced;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTARTED_DATE")
	public Date getDstartedDate() {
		return dstartedDate;
	}

	public void setDstartedDate(Date dstartedDate) {
		this.dstartedDate = dstartedDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DFINISHED_DATE")
	public Date getDfinishedDate() {
		return dfinishedDate;
	}

	public void setDfinishedDate(Date dfinishedDate) {
		this.dfinishedDate = dfinishedDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUNDER_REVIEW_DATE")
	public Date getDunderReviewDate() {
		return dunderReviewDate;
	}

	public void setDunderReviewDate(Date dunderReviewDate) {
		this.dunderReviewDate = dunderReviewDate;
	}

	@Column(name = "NOFFSET_DAYS", precision = 12, scale = 0)
	public Long getNoffsetDays() {
		return noffsetDays;
	}

	public void setNoffsetDays(Long noffsetDays) {
		this.noffsetDays = noffsetDays;
	}

	@Column(name = "CSTATUS_UPDATED_BY")
	public String getCstatusUpdatedBy() {
		return cstatusUpdatedBy;
	}

	public void setCstatusUpdatedBy(String cstatusUpdatedBy) {
		this.cstatusUpdatedBy = cstatusUpdatedBy;
	}

	public String getCdirectAncestor() {
		return cdirectAncestor;
	}

	public void setCdirectAncestor(String cdirectAncestor) {
		this.cdirectAncestor = cdirectAncestor;
	}

	@Column(name = "NIS_INLINE_PREP", precision = 1, scale = 0)
	public boolean getNisInlinePrep() {
		return nisInlinePrep;
	}

	public void setNisInlinePrep(boolean nisInlinePrep) {
		this.nisInlinePrep = nisInlinePrep;
	}

	@Column(name = "NVERSION_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNversionNumber() {
		return this.nversionNumber;
	}

	public void setNversionNumber(long nversionNumber) {
		this.nversionNumber = nversionNumber;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	public String getCancestors() {
		return cancestors;
	}

	public void setCancestors(String cancestors) {
		this.cancestors = cancestors;
	}

	@Column(name = "NQUANTITY_EACH", precision = 38, scale = 5)
	public BigDecimal getNquantityEach() {
		return nquantityEach;
	}

	public void setNquantityEach(BigDecimal nquantityEach) {
		this.nquantityEach = nquantityEach;
	}
}
