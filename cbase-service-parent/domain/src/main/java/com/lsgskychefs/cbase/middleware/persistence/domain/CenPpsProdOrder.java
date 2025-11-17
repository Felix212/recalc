package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.06.2016 17:02:58 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
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

/**
 * Entity(DomainObject) for table CEN_PPS_PROD_ORDER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PPS_PROD_ORDER")
public class CenPpsProdOrder implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nprodOrderKey;
	private CenPpsCateringOrder cenPpsCateringOrder;
	private LocPpsProdBom locPpsProdBom;
	private long nprodOrderKindKey;
	private Long nprodLotKey;
	private int nquantity;
	private BigDecimal nreserve;
	private String cclass;
	private String cmealControlCode;
	private Integer npercentage;
	private Integer ncomponentGroup;
	private Long ncoverKey;
	private Integer ndistribute;
	private Integer nmoduleType;
	private Long npltypeKey;
	private Integer ncoverPrio;
	private Integer nprio;
	private String cproductionText;
	private Date dearliestStart;
	private Date dallocationTime;
	private String cancestorPl;
	private Long nflightOrigin;
	private Integer nboxAllocationType;
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);
	private Set<CenPpsMealLayout> cenPpsMealLayouts = new HashSet<>(0);

	@Id
	@Column(name = "NPROD_ORDER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprodOrderKey() {
		return this.nprodOrderKey;
	}

	public void setNprodOrderKey(final long nprodOrderKey) {
		this.nprodOrderKey = nprodOrderKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCO_KEY")
	public CenPpsCateringOrder getCenPpsCateringOrder() {
		return this.cenPpsCateringOrder;
	}

	public void setCenPpsCateringOrder(final CenPpsCateringOrder cenPpsCateringOrder) {
		this.cenPpsCateringOrder = cenPpsCateringOrder;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROD_BOM_KEY")
	public LocPpsProdBom getLocPpsProdBom() {
		return this.locPpsProdBom;
	}

	public void setLocPpsProdBom(final LocPpsProdBom locPpsProdBom) {
		this.locPpsProdBom = locPpsProdBom;
	}

	@Column(name = "NPROD_ORDER_KIND_KEY", nullable = false, precision = 12, scale = 0)
	public long getNprodOrderKindKey() {
		return this.nprodOrderKindKey;
	}

	public void setNprodOrderKindKey(final long nprodOrderKindKey) {
		this.nprodOrderKindKey = nprodOrderKindKey;
	}

	@Column(name = "NPROD_LOT_KEY", precision = 12, scale = 0)
	public Long getNprodLotKey() {
		return this.nprodLotKey;
	}

	public void setNprodLotKey(final Long nprodLotKey) {
		this.nprodLotKey = nprodLotKey;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 4, scale = 0)
	public int getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final int nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NRESERVE", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNreserve() {
		return this.nreserve;
	}

	public void setNreserve(final BigDecimal nreserve) {
		this.nreserve = nreserve;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NPERCENTAGE", precision = 3, scale = 0)
	public Integer getNpercentage() {
		return this.npercentage;
	}

	public void setNpercentage(final Integer npercentage) {
		this.npercentage = npercentage;
	}

	@Column(name = "NCOMPONENT_GROUP", precision = 3, scale = 0)
	public Integer getNcomponentGroup() {
		return this.ncomponentGroup;
	}

	public void setNcomponentGroup(final Integer ncomponentGroup) {
		this.ncomponentGroup = ncomponentGroup;
	}

	@Column(name = "NCOVER_KEY", precision = 12, scale = 0)
	public Long getNcoverKey() {
		return this.ncoverKey;
	}

	public void setNcoverKey(final Long ncoverKey) {
		this.ncoverKey = ncoverKey;
	}

	@Column(name = "NDISTRIBUTE", precision = 1, scale = 0)
	public Integer getNdistribute() {
		return this.ndistribute;
	}

	public void setNdistribute(final Integer ndistribute) {
		this.ndistribute = ndistribute;
	}

	@Column(name = "NMODULE_TYPE", precision = 1, scale = 0)
	public Integer getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(final Integer nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NPLTYPE_KEY", precision = 12, scale = 0)
	public Long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final Long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "NCOVER_PRIO", precision = 6, scale = 0)
	public Integer getNcoverPrio() {
		return this.ncoverPrio;
	}

	public void setNcoverPrio(final Integer ncoverPrio) {
		this.ncoverPrio = ncoverPrio;
	}

	@Column(name = "NPRIO", precision = 6, scale = 0)
	public Integer getNprio() {
		return this.nprio;
	}

	public void setNprio(final Integer nprio) {
		this.nprio = nprio;
	}

	@Column(name = "CPRODUCTION_TEXT", length = 50)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DEARLIEST_START", length = 7)
	public Date getDearliestStart() {
		return this.dearliestStart;
	}

	public void setDearliestStart(final Date dearliestStart) {
		this.dearliestStart = dearliestStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DALLOCATION_TIME", length = 7)
	public Date getDallocationTime() {
		return this.dallocationTime;
	}

	public void setDallocationTime(final Date dallocationTime) {
		this.dallocationTime = dallocationTime;
	}

	@Column(name = "CANCESTOR_PL", length = 12)
	public String getCancestorPl() {
		return this.cancestorPl;
	}

	public void setCancestorPl(final String cancestorPl) {
		this.cancestorPl = cancestorPl;
	}

	@Column(name = "NFLIGHT_ORIGIN", precision = 12, scale = 0)
	public Long getNflightOrigin() {
		return this.nflightOrigin;
	}

	public void setNflightOrigin(final Long nflightOrigin) {
		this.nflightOrigin = nflightOrigin;
	}

	@Column(name = "NBOX_ALLOCATION_TYPE", precision = 1, scale = 0)
	public Integer getNboxAllocationType() {
		return this.nboxAllocationType;
	}

	public void setNboxAllocationType(final Integer nboxAllocationType) {
		this.nboxAllocationType = nboxAllocationType;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPpsProdOrder")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPpsProdOrder")
	public Set<CenPpsMealLayout> getCenPpsMealLayouts() {
		return this.cenPpsMealLayouts;
	}

	public void setCenPpsMealLayouts(final Set<CenPpsMealLayout> cenPpsMealLayouts) {
		this.cenPpsMealLayouts = cenPpsMealLayouts;
	}

}
