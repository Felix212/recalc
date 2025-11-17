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
 * Entity(DomainObject) for table LOC_PPS_LOADING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_LOADING", uniqueConstraints = @UniqueConstraint(columnNames = { "CLOADING", "NAIRLINE_KEY", "CUNIT" }))
public class LocPpsLoading implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nloadingKey;
	private CenAirlines cenAirlines;
	private String cloading;
	private String cdescription;
	private String cunit;
	private Set<LocPpsLoadingBox> locPpsLoadingBoxes = new HashSet<>(0);

	@Id
	@Column(name = "NLOADING_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadingKey() {
		return this.nloadingKey;
	}

	public void setNloadingKey(final long nloadingKey) {
		this.nloadingKey = nloadingKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY")
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CLOADING", nullable = false, length = 12)
	public String getCloading() {
		return this.cloading;
	}

	public void setCloading(final String cloading) {
		this.cloading = cloading;
	}

	@Column(name = "CDESCRIPTION")
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsLoading")
	public Set<LocPpsLoadingBox> getLocPpsLoadingBoxes() {
		return this.locPpsLoadingBoxes;
	}

	public void setLocPpsLoadingBoxes(final Set<LocPpsLoadingBox> locPpsLoadingBoxes) {
		this.locPpsLoadingBoxes = locPpsLoadingBoxes;
	}

}
