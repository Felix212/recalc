package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.04.2016 09:24:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.NamedQuery;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.NamedQueries;

/**
 * Entity(DomainObject) for table LOC_PPS_PROD_BOM <br/>
 * Die für PPS relevanten Produktionsstücklisten.
 *
 * @author Hibernate Tools
 */
@Entity
@NamedQuery(name = NamedQueries.LOC_PPS_PROD_BOM_BY_CONTAINER,
		query = "SELECT prodBom FROM LocPpsProdBom prodBom "
				+ "JOIN prodBom.cenPpsContainers container "
				+ "JOIN container.cenPpsCateringOrder cat "
				+ "WHERE container.ncontainerKey = :ncontainerKey "
				+ "AND cat.ddeparture BETWEEN prodBom.dvalidFrom AND prodBom.dvalidTo ")
@Table(name = "LOC_PPS_PROD_BOM", uniqueConstraints = @UniqueConstraint(columnNames = { "NPACKINGLIST_INDEX_KEY", "DVALID_FROM", "CUNIT" }))
public class LocPpsProdBom implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nprodBomKey;
	private SysUnits sysUnits;
	private LocPpsProdBom locPpsProdBom;
	private long npackinglistIndexKey;
	private int ncoldFlag;
	private int nprimary;
	private String cprodText;
	private BigDecimal nlength;
	private BigDecimal ndepthFactor;
	private BigDecimal nntwFactor;
	private int nrunRate;
	private int nsettingUp;
	private int nmaxProdCount;
	private int nmaxProdTime;
	private Date dvalidTo;
	private Integer nnoLot;
	private Date dvalidFrom;
	private Integer nboxAllocationType;
	private Integer nearliestStartDelta;
	private Integer nlatestEndDelta;
	private Long nplAreaKey;
	private int nintegritycheck;
	private Set<LocPpsProdBom> locPpsProdBoms = new HashSet<>(0);
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);

	@Id
	@Column(name = "NPROD_BOM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprodBomKey() {
		return this.nprodBomKey;
	}

	public void setNprodBomKey(final long nprodBomKey) {
		this.nprodBomKey = nprodBomKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRIMARY_BOM")
	public LocPpsProdBom getLocPpsProdBom() {
		return this.locPpsProdBom;
	}

	public void setLocPpsProdBom(final LocPpsProdBom locPpsProdBom) {
		this.locPpsProdBom = locPpsProdBom;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NCOLD_FLAG", nullable = false, precision = 1, scale = 0)
	public int getNcoldFlag() {
		return this.ncoldFlag;
	}

	public void setNcoldFlag(final int ncoldFlag) {
		this.ncoldFlag = ncoldFlag;
	}

	@Column(name = "NPRIMARY", nullable = false, precision = 1, scale = 0)
	public int getNprimary() {
		return this.nprimary;
	}

	public void setNprimary(final int nprimary) {
		this.nprimary = nprimary;
	}

	@Column(name = "CPROD_TEXT", nullable = false, length = 50)
	public String getCprodText() {
		return this.cprodText;
	}

	public void setCprodText(final String cprodText) {
		this.cprodText = cprodText;
	}

	@Column(name = "NLENGTH", nullable = false, precision = 14)
	public BigDecimal getNlength() {
		return this.nlength;
	}

	public void setNlength(final BigDecimal nlength) {
		this.nlength = nlength;
	}

	@Column(name = "NDEPTH_FACTOR", nullable = false, precision = 5, scale = 4)
	public BigDecimal getNdepthFactor() {
		return this.ndepthFactor;
	}

	public void setNdepthFactor(final BigDecimal ndepthFactor) {
		this.ndepthFactor = ndepthFactor;
	}

	@Column(name = "NNTW_FACTOR", nullable = false, precision = 5, scale = 4)
	public BigDecimal getNntwFactor() {
		return this.nntwFactor;
	}

	public void setNntwFactor(final BigDecimal nntwFactor) {
		this.nntwFactor = nntwFactor;
	}

	@Column(name = "NRUN_RATE", nullable = false, precision = 4, scale = 0)
	public int getNrunRate() {
		return this.nrunRate;
	}

	public void setNrunRate(final int nrunRate) {
		this.nrunRate = nrunRate;
	}

	@Column(name = "NSETTING_UP", nullable = false, precision = 4, scale = 0)
	public int getNsettingUp() {
		return this.nsettingUp;
	}

	public void setNsettingUp(final int nsettingUp) {
		this.nsettingUp = nsettingUp;
	}

	@Column(name = "NMAX_PROD_COUNT", nullable = false, precision = 4, scale = 0)
	public int getNmaxProdCount() {
		return this.nmaxProdCount;
	}

	public void setNmaxProdCount(final int nmaxProdCount) {
		this.nmaxProdCount = nmaxProdCount;
	}

	@Column(name = "NMAX_PROD_TIME", nullable = false, precision = 5, scale = 0)
	public int getNmaxProdTime() {
		return this.nmaxProdTime;
	}

	public void setNmaxProdTime(final int nmaxProdTime) {
		this.nmaxProdTime = nmaxProdTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NNO_LOT", precision = 1, scale = 0)
	public Integer getNnoLot() {
		return this.nnoLot;
	}

	public void setNnoLot(final Integer nnoLot) {
		this.nnoLot = nnoLot;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Column(name = "NBOX_ALLOCATION_TYPE", precision = 1, scale = 0)
	public Integer getNboxAllocationType() {
		return this.nboxAllocationType;
	}

	public void setNboxAllocationType(final Integer nboxAllocationType) {
		this.nboxAllocationType = nboxAllocationType;
	}

	@Column(name = "NEARLIEST_START_DELTA", precision = 4, scale = 0)
	public Integer getNearliestStartDelta() {
		return this.nearliestStartDelta;
	}

	public void setNearliestStartDelta(final Integer nearliestStartDelta) {
		this.nearliestStartDelta = nearliestStartDelta;
	}

	@Column(name = "NLATEST_END_DELTA", precision = 4, scale = 0)
	public Integer getNlatestEndDelta() {
		return this.nlatestEndDelta;
	}

	public void setNlatestEndDelta(final Integer nlatestEndDelta) {
		this.nlatestEndDelta = nlatestEndDelta;
	}

	@Column(name = "NPL_AREA_KEY", precision = 12, scale = 0)
	public Long getNplAreaKey() {
		return this.nplAreaKey;
	}

	public void setNplAreaKey(final Long nplAreaKey) {
		this.nplAreaKey = nplAreaKey;
	}

	@Column(name = "NINTEGRITYCHECK", nullable = false, precision = 1, scale = 0)
	public int getNintegritycheck() {
		return this.nintegritycheck;
	}

	public void setNintegritycheck(final int nintegritycheck) {
		this.nintegritycheck = nintegritycheck;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsProdBom")
	public Set<LocPpsProdBom> getLocPpsProdBoms() {
		return this.locPpsProdBoms;
	}

	public void setLocPpsProdBoms(final Set<LocPpsProdBom> locPpsProdBoms) {
		this.locPpsProdBoms = locPpsProdBoms;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsProdBom")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

}
