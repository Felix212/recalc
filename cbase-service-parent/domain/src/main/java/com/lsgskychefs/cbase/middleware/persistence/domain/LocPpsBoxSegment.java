package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.06.2016 16:13:25 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
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
 * Entity(DomainObject) for table LOC_PPS_BOX_SEGMENT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_BOX_SEGMENT", uniqueConstraints = @UniqueConstraint(columnNames = { "NOUTBOUND_REGION_KEY", "CNAME" }))
public class LocPpsBoxSegment implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nboxSegmentKey;
	private LocPpsOutboundRegion locPpsOutboundRegion;
	private String cname;
	private int nsegmentFrom;
	private int nsegmentLength;
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);

	@Id
	@Column(name = "NBOX_SEGMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNboxSegmentKey() {
		return this.nboxSegmentKey;
	}

	public void setNboxSegmentKey(final long nboxSegmentKey) {
		this.nboxSegmentKey = nboxSegmentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NOUTBOUND_REGION_KEY")
	public LocPpsOutboundRegion getLocPpsOutboundRegion() {
		return this.locPpsOutboundRegion;
	}

	public void setLocPpsOutboundRegion(final LocPpsOutboundRegion locPpsOutboundRegion) {
		this.locPpsOutboundRegion = locPpsOutboundRegion;
	}

	@Column(name = "CNAME", nullable = false, length = 2)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "NSEGMENT_FROM", nullable = false, precision = 5, scale = 0)
	public int getNsegmentFrom() {
		return this.nsegmentFrom;
	}

	public void setNsegmentFrom(final int nsegmentFrom) {
		this.nsegmentFrom = nsegmentFrom;
	}

	@Column(name = "NSEGMENT_LENGTH", nullable = false, precision = 5, scale = 0)
	public int getNsegmentLength() {
		return this.nsegmentLength;
	}

	public void setNsegmentLength(final int nsegmentLength) {
		this.nsegmentLength = nsegmentLength;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsBoxSegment")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

}
