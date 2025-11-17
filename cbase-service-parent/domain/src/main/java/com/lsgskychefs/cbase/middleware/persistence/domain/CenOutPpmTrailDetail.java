package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 18, 2017 11:11:23 AM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_TRAIL_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_TRAIL_DETAIL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@NamedEntityGraph(name = "CenOutPpmTrailDetail.trail", attributeNodes = {
		@NamedAttributeNode(value = "cenOutPpmTrail")
})
public class CenOutPpmTrailDetail implements DomainObject, java.io.Serializable {
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nppmtrailDetailKey;

	@JsonView(View.SimpleWithReferences.class)
	private CenOutPpmTrail cenOutPpmTrail;

	@JsonView(View.Simple.class)
	private long ntrailKey;

	@JsonView(View.Simple.class)
	private String ctrail;

	@JsonView(View.Simple.class)
	private long ntrailpointKey;

	@JsonView(View.Simple.class)
	private String ctrailpoint;

	@JsonView(View.Simple.class)
	private int noffset;

	@JsonView(View.Simple.class)
	private int noffsetType;

	@JsonView(View.Simple.class)
	private Date dcreated;

	@JsonView(View.Simple.class)
	private int nstatus;

	@JsonView(View.Simple.class)
	private Date dplannedReadyTime;

	@JsonView(View.Simple.class)
	private Date dreadyTime;

	@JsonView(View.Simple.class)
	private Date dreadyTimeIncrease;

	@JsonView(View.Simple.class)
	private int nstatusIncrease;

	@JsonView(View.Simple.class)
	private Date dreadyTimeSw;

	@JsonView(View.Simple.class)
	private int nstatusSw;

	@JsonIgnore
	private Set<CenOutPpmPrLabDtlTp> cenOutPpmPrLabDtlTps = new HashSet<>(0);

	@Id
	@Column(name = "NPPMTRAIL_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmtrailDetailKey() {
		return this.nppmtrailDetailKey;
	}

	public void setNppmtrailDetailKey(final long nppmtrailDetailKey) {
		this.nppmtrailDetailKey = nppmtrailDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPMTRAIL_KEY", nullable = false)
	public CenOutPpmTrail getCenOutPpmTrail() {
		return this.cenOutPpmTrail;
	}

	public void setCenOutPpmTrail(final CenOutPpmTrail cenOutPpmTrail) {
		this.cenOutPpmTrail = cenOutPpmTrail;
	}

	@Column(name = "NTRAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNtrailKey() {
		return this.ntrailKey;
	}

	public void setNtrailKey(final long ntrailKey) {
		this.ntrailKey = ntrailKey;
	}

	@Column(name = "CTRAIL", nullable = false, length = 40)
	public String getCtrail() {
		return this.ctrail;
	}

	public void setCtrail(final String ctrail) {
		this.ctrail = ctrail;
	}

	@Column(name = "NTRAILPOINT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNtrailpointKey() {
		return this.ntrailpointKey;
	}

	public void setNtrailpointKey(final long ntrailpointKey) {
		this.ntrailpointKey = ntrailpointKey;
	}

	@Column(name = "CTRAILPOINT", nullable = false, length = 40)
	public String getCtrailpoint() {
		return this.ctrailpoint;
	}

	public void setCtrailpoint(final String ctrailpoint) {
		this.ctrailpoint = ctrailpoint;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 5, scale = 0)
	public int getNoffset() {
		return this.noffset;
	}

	public void setNoffset(final int noffset) {
		this.noffset = noffset;
	}

	@Column(name = "NOFFSET_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNoffsetType() {
		return this.noffsetType;
	}

	public void setNoffsetType(final int noffsetType) {
		this.noffsetType = noffsetType;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", nullable = false, length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 3, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPLANNED_READY_TIME", nullable = false, length = 7)
	public Date getDplannedReadyTime() {
		return this.dplannedReadyTime;
	}

	public void setDplannedReadyTime(final Date dplannedReadyTime) {
		this.dplannedReadyTime = dplannedReadyTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DREADY_TIME", length = 7)
	public Date getDreadyTime() {
		return this.dreadyTime;
	}

	public void setDreadyTime(final Date dreadyTime) {
		this.dreadyTime = dreadyTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DREADY_TIME_INCREASE", length = 7)
	public Date getDreadyTimeIncrease() {
		return this.dreadyTimeIncrease;
	}

	public void setDreadyTimeIncrease(final Date dreadyTimeIncrease) {
		this.dreadyTimeIncrease = dreadyTimeIncrease;
	}

	@Column(name = "NSTATUS_INCREASE", nullable = false, precision = 3, scale = 0)
	public int getNstatusIncrease() {
		return this.nstatusIncrease;
	}

	public void setNstatusIncrease(final int nstatusIncrease) {
		this.nstatusIncrease = nstatusIncrease;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DREADY_TIME_SW", length = 7)
	public Date getDreadyTimeSw() {
		return this.dreadyTimeSw;
	}

	public void setDreadyTimeSw(Date dreadyTimeSw) {
		this.dreadyTimeSw = dreadyTimeSw;
	}

	@Column(name = "NSTATUS_SW", nullable = false, precision = 3, scale = 0)
	public int getNstatusSw() {
		return this.nstatusSw;
	}

	public void setNstatusSw(int nstatusSw) {
		this.nstatusSw = nstatusSw;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmTrailDetail")
	public Set<CenOutPpmPrLabDtlTp> getCenOutPpmPrLabDtlTps() {
		return this.cenOutPpmPrLabDtlTps;
	}

	public void setCenOutPpmPrLabDtlTps(final Set<CenOutPpmPrLabDtlTp> cenOutPpmPrLabDtlTps) {
		this.cenOutPpmPrLabDtlTps = cenOutPpmPrLabDtlTps;
	}
}
