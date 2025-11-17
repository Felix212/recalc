package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.06.2016 16:13:25 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_PPS_OUTBOUND_REGION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_OUTBOUND_REGION", uniqueConstraints = @UniqueConstraint(columnNames = { "CNAME", "CUNIT" }))
public class LocPpsOutboundRegion implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long noutboundRegionKey;
	private Long nboxAvailabilityKey;
	private long noutboundRegionTypeKey;
	private String cname;
	private Integer ntotalLength;
	private String cunit;
	private Set<LocPpsOutboundRegionVal> locPpsOutboundRegionVals = new HashSet<>(0);
	private Set<CenPpsFlightSlot> cenPpsFlightSlots = new HashSet<>(0);
	private Set<LocPpsBoxSegment> locPpsBoxSegments = new HashSet<>(0);

	@Id
	@Column(name = "NOUTBOUND_REGION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNoutboundRegionKey() {
		return this.noutboundRegionKey;
	}

	public void setNoutboundRegionKey(final long noutboundRegionKey) {
		this.noutboundRegionKey = noutboundRegionKey;
	}

	@Column(name = "NBOX_AVAILABILITY_KEY", precision = 12, scale = 0)
	public Long getNboxAvailabilityKey() {
		return this.nboxAvailabilityKey;
	}

	public void setNboxAvailabilityKey(final Long nboxAvailabilityKey) {
		this.nboxAvailabilityKey = nboxAvailabilityKey;
	}

	@Column(name = "NOUTBOUND_REGION_TYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNoutboundRegionTypeKey() {
		return this.noutboundRegionTypeKey;
	}

	public void setNoutboundRegionTypeKey(final long noutboundRegionTypeKey) {
		this.noutboundRegionTypeKey = noutboundRegionTypeKey;
	}

	@Column(name = "CNAME", length = 18)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "NTOTAL_LENGTH", precision = 5, scale = 0)
	public Integer getNtotalLength() {
		return this.ntotalLength;
	}

	public void setNtotalLength(final Integer ntotalLength) {
		this.ntotalLength = ntotalLength;
	}

	@Column(name = "CUNIT", length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsOutboundRegion")
	public Set<LocPpsOutboundRegionVal> getLocPpsOutboundRegionVals() {
		return this.locPpsOutboundRegionVals;
	}

	public void setLocPpsOutboundRegionVals(final Set<LocPpsOutboundRegionVal> locPpsOutboundRegionVals) {
		this.locPpsOutboundRegionVals = locPpsOutboundRegionVals;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsOutboundRegion")
	public Set<CenPpsFlightSlot> getCenPpsFlightSlots() {
		return this.cenPpsFlightSlots;
	}

	public void setCenPpsFlightSlots(final Set<CenPpsFlightSlot> cenPpsFlightSlots) {
		this.cenPpsFlightSlots = cenPpsFlightSlots;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsOutboundRegion")
	public Set<LocPpsBoxSegment> getLocPpsBoxSegments() {
		return this.locPpsBoxSegments;
	}

	public void setLocPpsBoxSegments(final Set<LocPpsBoxSegment> locPpsBoxSegments) {
		this.locPpsBoxSegments = locPpsBoxSegments;
	}

}
