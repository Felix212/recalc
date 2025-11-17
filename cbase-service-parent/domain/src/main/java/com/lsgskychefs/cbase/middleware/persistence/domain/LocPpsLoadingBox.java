package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.06.2016 17:02:58 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table LOC_PPS_LOADING_BOX
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_LOADING_BOX", uniqueConstraints = @UniqueConstraint(columnNames = { "CLOADING_BOX", "NLOADING_KEY" }))
public class LocPpsLoadingBox implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nloadingBoxKey;
	private LocPpsLoading locPpsLoading;
	private String cloadingBox;
	private String cdescription;
	private Set<CenPpsFlightSlot> cenPpsFlightSlots = new HashSet<>(0);

	@Id
	@Column(name = "NLOADING_BOX_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadingBoxKey() {
		return this.nloadingBoxKey;
	}

	public void setNloadingBoxKey(final long nloadingBoxKey) {
		this.nloadingBoxKey = nloadingBoxKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOADING_KEY")
	public LocPpsLoading getLocPpsLoading() {
		return this.locPpsLoading;
	}

	public void setLocPpsLoading(final LocPpsLoading locPpsLoading) {
		this.locPpsLoading = locPpsLoading;
	}

	@Column(name = "CLOADING_BOX", nullable = false, length = 12)
	public String getCloadingBox() {
		return this.cloadingBox;
	}

	public void setCloadingBox(final String cloadingBox) {
		this.cloadingBox = cloadingBox;
	}

	@Column(name = "CDESCRIPTION")
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsLoadingBox")
	public Set<CenPpsFlightSlot> getCenPpsFlightSlots() {
		return this.cenPpsFlightSlots;
	}

	public void setCenPpsFlightSlots(final Set<CenPpsFlightSlot> cenPpsFlightSlots) {
		this.cenPpsFlightSlots = cenPpsFlightSlots;
	}

}
