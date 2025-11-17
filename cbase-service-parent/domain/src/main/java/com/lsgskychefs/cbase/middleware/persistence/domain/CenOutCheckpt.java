package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.OneToMany;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PfUpdateCheckptRelevance;
import com.lsgskychefs.cbase.middleware.persistence.constant.CheckpointState;

/**
 * Entity(DomainObject) for table CEN_OUT_CHECKPT
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQuery(name = PfUpdateCheckptRelevance.PF_UPDATE_CHECKPT_RELEVANCE,
		procedureName = PfUpdateCheckptRelevance.PF_UPDATE_CHECKPT_RELEVANCE,
		parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfUpdateCheckptRelevance.AN_CHECKPOINT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfUpdateCheckptRelevance.AC_UNIT, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfUpdateCheckptRelevance.AD_DATE_FROM, type = Date.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfUpdateCheckptRelevance.AD_DATE_TO, type = Date.class)
		})
@Entity
@Table(name = "CEN_OUT_CHECKPT")
public class CenOutCheckpt implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutCheckptId id;
	@JsonIgnore
	private CenOut cenOut;
	@JsonIgnore
	private LocUnitCheckpt locUnitCheckpt;
	private long ntransaction;
	private String cunit;
	private int ncheckpointSort;
	private String ccheckpoint;
	private String ctext;
	private int nworkstationsactiveflag;
	private Date ddepartureTime;
	private Date dkitchenTime;
	private Date drampTime;
	private int ntimetype;
	private long ntimeoffset;
	private Date dcheckptTargetTime;
	private Date dcheckptAlertTime;
	/** @see CheckpointState */
	private int ncheckptState;
	private Date dcheckptRealTime;
	private String cuser;
	private String cremark;
	private int ntotalStowages;
	private int nintimeStowages;
	private int nalertStowages;
	private int ntoolateStowages;
	private Set<CenOutCheckptStowage> cenOutCheckptStowages = new HashSet<>(0);
	private Date dstowagesTime;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ncheckpointKey",
					column = @Column(name = "NCHECKPOINT_KEY", nullable = false, precision = 12, scale = 0))
	})
	public CenOutCheckptId getId() {
		return this.id;
	}

	public void setId(final CenOutCheckptId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCHECKPOINT_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitCheckpt getLocUnitCheckpt() {
		return this.locUnitCheckpt;
	}

	public void setLocUnitCheckpt(final LocUnitCheckpt locUnitCheckpt) {
		this.locUnitCheckpt = locUnitCheckpt;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NCHECKPOINT_SORT", nullable = false, precision = 5, scale = 0)
	public int getNcheckpointSort() {
		return this.ncheckpointSort;
	}

	public void setNcheckpointSort(final int ncheckpointSort) {
		this.ncheckpointSort = ncheckpointSort;
	}

	@Column(name = "CCHECKPOINT", nullable = false, length = 12)
	public String getCcheckpoint() {
		return this.ccheckpoint;
	}

	public void setCcheckpoint(final String ccheckpoint) {
		this.ccheckpoint = ccheckpoint;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NWORKSTATIONSACTIVEFLAG", nullable = false, precision = 1, scale = 0)
	public int getNworkstationsactiveflag() {
		return this.nworkstationsactiveflag;
	}

	public void setNworkstationsactiveflag(final int nworkstationsactiveflag) {
		this.nworkstationsactiveflag = nworkstationsactiveflag;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE_TIME", nullable = false, length = 7)
	public Date getDdepartureTime() {
		return this.ddepartureTime;
	}

	public void setDdepartureTime(final Date ddepartureTime) {
		this.ddepartureTime = ddepartureTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DKITCHEN_TIME", nullable = false, length = 7)
	public Date getDkitchenTime() {
		return this.dkitchenTime;
	}

	public void setDkitchenTime(final Date dkitchenTime) {
		this.dkitchenTime = dkitchenTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRAMP_TIME", nullable = false, length = 7)
	public Date getDrampTime() {
		return this.drampTime;
	}

	public void setDrampTime(final Date drampTime) {
		this.drampTime = drampTime;
	}

	@Column(name = "NTIMETYPE", nullable = false, precision = 1, scale = 0)
	public int getNtimetype() {
		return this.ntimetype;
	}

	public void setNtimetype(final int ntimetype) {
		this.ntimetype = ntimetype;
	}

	@Column(name = "NTIMEOFFSET", nullable = false, precision = 12, scale = 0)
	public long getNtimeoffset() {
		return this.ntimeoffset;
	}

	public void setNtimeoffset(final long ntimeoffset) {
		this.ntimeoffset = ntimeoffset;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCHECKPT_TARGET_TIME", nullable = false, length = 7)
	public Date getDcheckptTargetTime() {
		return this.dcheckptTargetTime;
	}

	public void setDcheckptTargetTime(final Date dcheckptTargetTime) {
		this.dcheckptTargetTime = dcheckptTargetTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCHECKPT_ALERT_TIME", nullable = false, length = 7)
	public Date getDcheckptAlertTime() {
		return this.dcheckptAlertTime;
	}

	public void setDcheckptAlertTime(final Date dcheckptAlertTime) {
		this.dcheckptAlertTime = dcheckptAlertTime;
	}

	/**
	 * @return checkpoint state value
	 * @see CheckpointState
	 */
	@Column(name = "NCHECKPT_STATE", nullable = false, precision = 3, scale = 0, columnDefinition = "number(3) default 0")
	public int getNcheckptState() {
		return this.ncheckptState;
	}

	/**
	 * @param ncheckptState checkpoint state value
	 * @see CheckpointState
	 */
	public void setNcheckptState(final int ncheckptState) {
		this.ncheckptState = ncheckptState;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCHECKPT_REAL_TIME", length = 7)
	public Date getDcheckptRealTime() {
		return this.dcheckptRealTime;
	}

	public void setDcheckptRealTime(final Date dcheckptRealTime) {
		this.dcheckptRealTime = dcheckptRealTime;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CREMARK", length = 256)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NTOTAL_STOWAGES", precision = 4, scale = 0, columnDefinition = "number(4) default 0")
	public int getNtotalStowages() {
		return this.ntotalStowages;
	}

	public void setNtotalStowages(int ntotalStowages) {
		this.ntotalStowages = ntotalStowages;
	}

	@Column(name = "NINTIME_STOWAGES", precision = 4, scale = 0, columnDefinition = "number(4) default 0")
	public int getNintimeStowages() {
		return this.nintimeStowages;
	}

	public void setNintimeStowages(int nintimeStowages) {
		this.nintimeStowages = nintimeStowages;
	}

	@Column(name = "NALERT_STOWAGES", precision = 4, scale = 0, columnDefinition = "number(4) default 0")
	public int getNalertStowages() {
		return this.nalertStowages;
	}

	public void setNalertStowages(int nalertStowages) {
		this.nalertStowages = nalertStowages;
	}

	@Column(name = "NTOOLATE_STOWAGES", precision = 4, scale = 0, columnDefinition = "number(4) default 0")
	public int getNtoolateStowages() {
		return this.ntoolateStowages;
	}

	public void setNtoolateStowages(int ntoolateStowages) {
		this.ntoolateStowages = ntoolateStowages;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutCheckpt")
	public Set<CenOutCheckptStowage> getCenOutCheckptStowages() {
		return this.cenOutCheckptStowages;
	}

	public void setCenOutCheckptStowages(Set<CenOutCheckptStowage> cenOutCheckptStowages) {
		this.cenOutCheckptStowages = cenOutCheckptStowages;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTOWAGES_TIME", length = 7)
	public Date getDstowagesTime() {
		return dstowagesTime;
	}

	public void setDstowagesTime(Date dstowagesTime) {
		this.dstowagesTime = dstowagesTime;
	}

	/** {@inheritDoc} */
	@Override
	public String toString() {
		return ReflectionToStringBuilder.toStringExclude(this, new String[] { "cenOut", "locUnitCheckpt" });
	}

}
