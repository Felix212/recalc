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
 * Entity(DomainObject) for table LOC_PPS_EHB_STATION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_EHB_STATION", uniqueConstraints = @UniqueConstraint(columnNames = { "CNAME", "CUNIT" }))
public class LocPpsEhbStation implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nehbStationKey;
	private String cname;
	private String cdescription;
	private String cunit;
	private Set<LocPpsOutboundRegionVal> locPpsOutboundRegionVals = new HashSet<>(0);

	@Id
	@Column(name = "NEHB_STATION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNehbStationKey() {
		return this.nehbStationKey;
	}

	public void setNehbStationKey(final long nehbStationKey) {
		this.nehbStationKey = nehbStationKey;
	}

	@Column(name = "CNAME", nullable = false, length = 10)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", nullable = false)
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPpsEhbStation")
	public Set<LocPpsOutboundRegionVal> getLocPpsOutboundRegionVals() {
		return this.locPpsOutboundRegionVals;
	}

	public void setLocPpsOutboundRegionVals(final Set<LocPpsOutboundRegionVal> locPpsOutboundRegionVals) {
		this.locPpsOutboundRegionVals = locPpsOutboundRegionVals;
	}

}
