package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.06.2016 17:02:58 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_PPS_FLIGHT_SLOT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PPS_FLIGHT_SLOT", uniqueConstraints = @UniqueConstraint(columnNames = { "NFLIGHT_SLOT_KEY", "NCO_KEY" }))
public class CenPpsFlightSlot implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nflightSlotKey;
	private SysPpsObjectState sysPpsObjectState;
	private LocPpsOutboundRegion locPpsOutboundRegion;
	private LocPpsLoadingBox locPpsLoadingBox;
	private CenPpsCateringOrder cenPpsCateringOrder;
	private long nslotBoxMapStatusKey;
	private long noutboundRegionKindKey;
	private BigDecimal nlength;
	private Long nboxFrom;
	private Integer nntws;
	private Integer ninitialized;
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);

	@Id
	@Column(name = "NFLIGHT_SLOT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNflightSlotKey() {
		return this.nflightSlotKey;
	}

	public void setNflightSlotKey(final long nflightSlotKey) {
		this.nflightSlotKey = nflightSlotKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NOBJECT_STATE_KEY")
	public SysPpsObjectState getSysPpsObjectState() {
		return this.sysPpsObjectState;
	}

	public void setSysPpsObjectState(final SysPpsObjectState sysPpsObjectState) {
		this.sysPpsObjectState = sysPpsObjectState;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NOUTBOUND_REGION_KEY")
	public LocPpsOutboundRegion getLocPpsOutboundRegion() {
		return this.locPpsOutboundRegion;
	}

	public void setLocPpsOutboundRegion(final LocPpsOutboundRegion locPpsOutboundRegion) {
		this.locPpsOutboundRegion = locPpsOutboundRegion;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOADING_BOX_KEY")
	public LocPpsLoadingBox getLocPpsLoadingBox() {
		return this.locPpsLoadingBox;
	}

	public void setLocPpsLoadingBox(final LocPpsLoadingBox locPpsLoadingBox) {
		this.locPpsLoadingBox = locPpsLoadingBox;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCO_KEY", nullable = false)
	public CenPpsCateringOrder getCenPpsCateringOrder() {
		return this.cenPpsCateringOrder;
	}

	public void setCenPpsCateringOrder(final CenPpsCateringOrder cenPpsCateringOrder) {
		this.cenPpsCateringOrder = cenPpsCateringOrder;
	}

	@Column(name = "NSLOT_BOX_MAP_STATUS_KEY", nullable = false, precision = 12, scale = 0)
	public long getNslotBoxMapStatusKey() {
		return this.nslotBoxMapStatusKey;
	}

	public void setNslotBoxMapStatusKey(final long nslotBoxMapStatusKey) {
		this.nslotBoxMapStatusKey = nslotBoxMapStatusKey;
	}

	@Column(name = "NOUTBOUND_REGION_KIND_KEY", nullable = false, precision = 12, scale = 0)
	public long getNoutboundRegionKindKey() {
		return this.noutboundRegionKindKey;
	}

	public void setNoutboundRegionKindKey(final long noutboundRegionKindKey) {
		this.noutboundRegionKindKey = noutboundRegionKindKey;
	}

	@Column(name = "NLENGTH", precision = 8, scale = 3)
	public BigDecimal getNlength() {
		return this.nlength;
	}

	public void setNlength(final BigDecimal nlength) {
		this.nlength = nlength;
	}

	@Column(name = "NBOX_FROM", precision = 12, scale = 0)
	public Long getNboxFrom() {
		return this.nboxFrom;
	}

	public void setNboxFrom(final Long nboxFrom) {
		this.nboxFrom = nboxFrom;
	}

	@Column(name = "NNTWS", precision = 4, scale = 0)
	public Integer getNntws() {
		return this.nntws;
	}

	public void setNntws(final Integer nntws) {
		this.nntws = nntws;
	}

	@Column(name = "NINITIALIZED", precision = 1, scale = 0)
	public Integer getNinitialized() {
		return this.ninitialized;
	}

	public void setNinitialized(final Integer ninitialized) {
		this.ninitialized = ninitialized;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPpsFlightSlot")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

}
