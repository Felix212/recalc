package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PfProdlabelDatachanged;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpProdLabelTracking;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_PROD_LABEL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_PROD_LABEL")
// @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nppmProdLabelKey")
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpProdLabelTracking.PP_PROD_LABEL_TRACKING, procedureName = "CBASE_Trail."
				+ PpProdLabelTracking.PP_PROD_LABEL_TRACKING, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpProdLabelTracking.P_TRAILPOINT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpProdLabelTracking.P_RET_MSG, type = String.class)
		}),
		@NamedStoredProcedureQuery(name = PfProdlabelDatachanged.PF_PRODLABEL_DATACHANGED, procedureName = "CBASE_LABEL."
				+ PfProdlabelDatachanged.PF_PRODLABEL_DATACHANGED, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfProdlabelDatachanged.P_BACTH_SEQ, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PfProdlabelDatachanged.P_DATACHANGED, type = Integer.class)
		})
})
@NamedEntityGraph(name = "CenOutPpmProdLabel.details", attributeNodes = {
		@NamedAttributeNode(value = "cenOutPpmLabelCos"),
		@NamedAttributeNode(value = "cenOutPpmPrLabDetails", subgraph = "cenOutPpmProdLabel.details.trailpoint")
}, subgraphs = {
		@NamedSubgraph(name = "cenOutPpmProdLabel.details.trailpoint", attributeNodes = {
				@NamedAttributeNode(value = "cenOutPpmPrLabDtlTps")
		})
})
public class CenOutPpmProdLabel implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private Long nppmProdLabelKey;

	@JsonView(View.Simple.class)
	private CenOutPpmTrolley cenOutPpmTrolley;

	@JsonView(View.Simple.class)
	private long nbatchSeq;

	@JsonView(View.Simple.class)
	private int nlabelCount;

	@JsonView(View.Simple.class)
	private int nlabelMax;

	@JsonView(View.Simple.class)
	private Long nlabelTypeKey;

	@JsonView(View.Simple.class)
	private Long nplIndexKey;

	@JsonView(View.Simple.class)
	private String cpackinglist;

	@JsonView(View.Simple.class)
	private long nlabelGroupKey;

	@JsonView(View.Simple.class)
	private int nprinted;

	@JsonView(View.Simple.class)
	private Long nstowageKey;

	@JsonView(View.Simple.class)
	private String cgalley;

	@JsonView(View.Simple.class)
	private String cstowage;

	@JsonView(View.Simple.class)
	private String cplace;

	@JsonView(View.Simple.class)
	private Date dcreated;

	@JsonView(View.Simple.class)
	private Integer nlabelCountFlight;

	@JsonView(View.Simple.class)
	private Integer nlabelMaxFlight;

	@JsonView(View.Simple.class)
	private long nresultKey;

	@JsonView(View.Simple.class)
	private Integer nsortStow;

	@JsonView(View.Simple.class)
	private Long nppmProdLabelKeyMaster;

	@JsonIgnore
	private Set<CenOutPpmPrLabSpotch> cenOutPpmPrLabSpotches = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenOutPpmLabelCo> cenOutPpmLabelCos = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenOutPpmPrLabDetail> cenOutPpmPrLabDetails = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private List<CenOutPpmTrailDetail> trailDetails = new ArrayList<>();

	/** Quantity which has to be calculated through prodLabelDetails */
	private BigDecimal ntraySize;

	/** This Flag can be used to mark a prodLabel as scanned when returning a List */
	private boolean scanned = false;

	/** Container unit of the label */
	private String cunit = null;

	@Id
	@Column(name = "NPPM_PROD_LABEL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNppmProdLabelKey() {
		return this.nppmProdLabelKey;
	}

	public void setNppmProdLabelKey(final Long nppmProdLabelKey) {
		this.nppmProdLabelKey = nppmProdLabelKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_TROLLEY_KEY")
	public CenOutPpmTrolley getCenOutPpmTrolley() {
		return this.cenOutPpmTrolley;
	}

	public void setCenOutPpmTrolley(final CenOutPpmTrolley cenOutPpmTrolley) {
		this.cenOutPpmTrolley = cenOutPpmTrolley;
	}

	@Column(name = "NBATCH_SEQ", nullable = false, precision = 12, scale = 0)
	public long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Column(name = "NLABEL_COUNT", nullable = false, precision = 5, scale = 0)
	public int getNlabelCount() {
		return this.nlabelCount;
	}

	public void setNlabelCount(final int nlabelCount) {
		this.nlabelCount = nlabelCount;
	}

	@Column(name = "NLABEL_MAX", nullable = false, precision = 5, scale = 0)
	public int getNlabelMax() {
		return this.nlabelMax;
	}

	public void setNlabelMax(final int nlabelMax) {
		this.nlabelMax = nlabelMax;
	}

	@Column(name = "NLABEL_TYPE_KEY", precision = 12, scale = 0)
	public Long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(final Long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "NPL_INDEX_KEY", precision = 12, scale = 0)
	public Long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final Long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmProdLabel")
	@JsonManagedReference(value = "prodLabelToPrLabDetail")
	public Set<CenOutPpmPrLabDetail> getCenOutPpmPrLabDetails() {
		return this.cenOutPpmPrLabDetails;
	}

	public void setCenOutPpmPrLabDetails(final Set<CenOutPpmPrLabDetail> cenOutPpmPrLabDetails) {
		this.cenOutPpmPrLabDetails = cenOutPpmPrLabDetails;
	}

	@Column(name = "NLABEL_GROUP_KEY", nullable = false, precision = 12, scale = 0, columnDefinition = "number(12) default 0")
	public long getNlabelGroupKey() {
		return this.nlabelGroupKey;
	}

	public void setNlabelGroupKey(final long nlabelGroupKey) {
		this.nlabelGroupKey = nlabelGroupKey;
	}

	@Column(name = "NPRINTED", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNprinted() {
		return this.nprinted;
	}

	public void setNprinted(final int nprinted) {
		this.nprinted = nprinted;
	}

	@Column(name = "NSTOWAGE_KEY", precision = 12, scale = 0)
	public Long getNstowageKey() {
		return this.nstowageKey;
	}

	public void setNstowageKey(final Long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	@Column(name = "CGALLEY", nullable = false, length = 5)
	public String getCgalley() {
		return this.cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "CSTOWAGE", nullable = false, length = 5)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CPLACE", nullable = false, length = 3)
	public String getCplace() {
		return this.cplace;
	}

	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "NLABEL_COUNT_FLIGHT", precision = 5, scale = 0)
	public Integer getNlabelCountFlight() {
		return this.nlabelCountFlight;
	}

	public void setNlabelCountFlight(final Integer nlabelCountFlight) {
		this.nlabelCountFlight = nlabelCountFlight;
	}

	@Column(name = "NLABEL_MAX_FLIGHT", precision = 5, scale = 0)
	public Integer getNlabelMaxFlight() {
		return this.nlabelMaxFlight;
	}

	public void setNlabelMaxFlight(final Integer nlabelMaxFlight) {
		this.nlabelMaxFlight = nlabelMaxFlight;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NSORT_STOW", precision = 6, scale = 0)
	public Integer getNsortStow() {
		return this.nsortStow;
	}

	public void setNsortStow(final Integer nsortStow) {
		this.nsortStow = nsortStow;
	}

	@Column(name = "NPPM_PROD_LABEL_KEY_MASTER", precision = 12, scale = 0)
	public Long getNppmProdLabelKeyMaster() {
		return this.nppmProdLabelKeyMaster;
	}

	public void setNppmProdLabelKeyMaster(final Long nppmProdLabelKeyMaster) {
		this.nppmProdLabelKeyMaster = nppmProdLabelKeyMaster;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmProdLabel")
	public Set<CenOutPpmPrLabSpotch> getCenOutPpmPrLabSpotches() {
		return this.cenOutPpmPrLabSpotches;
	}

	public void setCenOutPpmPrLabSpotches(final Set<CenOutPpmPrLabSpotch> cenOutPpmPrLabSpotches) {
		this.cenOutPpmPrLabSpotches = cenOutPpmPrLabSpotches;
	}

	/**
	 * Get ntraySize
	 *
	 * @return the ntraySize
	 */
	@Transient
	public BigDecimal getNtraySize() {
		return ntraySize;
	}

	/**
	 * Set ntraySize
	 *
	 * @param ntraySize the ntraySize to set
	 */
	public void setNtraySize(final BigDecimal ntraySize) {
		this.ntraySize = ntraySize;
	}

	/**
	 * Get scanned
	 *
	 * @return the scanned
	 */
	@Transient
	public boolean isScanned() {
		return scanned;
	}

	/**
	 * Set scanned
	 *
	 * @param scanned the scanned to set
	 */
	public void setScanned(final boolean scanned) {
		this.scanned = scanned;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmProdLabel")
	public Set<CenOutPpmLabelCo> getCenOutPpmLabelCos() {
		return this.cenOutPpmLabelCos;
	}

	public void setCenOutPpmLabelCos(final Set<CenOutPpmLabelCo> cenOutPpmLabelCos) {
		this.cenOutPpmLabelCos = cenOutPpmLabelCos;
	}

	/**
	 * Get cunit
	 *
	 * @return the cunit
	 */
	@Transient
	public String getCunit() {
		return cunit;
	}

	/**
	 * Set cunit
	 *
	 * @param cunit the cunit to set
	 */
	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	/**
	 * Transient information about all related Trailpoints where this label needs to be scanned
	 *
	 * @return List of {@link CenOutPpmTrailDetail}
	 */
	@Transient
	public List<CenOutPpmTrailDetail> getTrailDetails() {
		return trailDetails;
	}

	public void setTrailDetails(List<CenOutPpmTrailDetail> trailDetails) {
		this.trailDetails = trailDetails;
	}
}
