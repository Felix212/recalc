package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 25.01.2017 14:45:03 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.OneToMany;
import javax.persistence.ParameterMode;
import javax.persistence.SequenceGenerator;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PfCalcDuration;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpGetPpmSched;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpPlanShift;

;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_SCHED
 * 
 * @author Hibernate Tools
 */
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpGetPpmSched.PP_GET_PPM_SCHED, procedureName = "CBASE_PPM."
				+ PpGetPpmSched.PP_GET_PPM_SCHED, parameters = {
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetPpmSched.P_PROD_DATE, type = Date.class),
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetPpmSched.P_WORKSCHEDULE_INDEX, type = Long.class),
						@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpGetPpmSched.P_PPM_SCHED_KEY, type = Long.class)
				}),
		@NamedStoredProcedureQuery(name = PpPlanShift.PP_PLAN_SHIFT, procedureName = "CBASE_PPM."
				+ PpPlanShift.PP_PLAN_SHIFT, parameters = {
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpPlanShift.P_PROD_DATE, type = Date.class),
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpPlanShift.P_WORKSCHEDULE_INDEX, type = Long.class),
						@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpPlanShift.P_RET_VALUE, type = Long.class)
				}),
		@NamedStoredProcedureQuery(name = PfCalcDuration.PF_CALC_DURATION, procedureName = "CBASE_PPM."
				+ PfCalcDuration.PF_CALC_DURATION, parameters = {
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PfCalcDuration.P_BATCH_SEQ, type = Long.class),
						@StoredProcedureParameter(mode = ParameterMode.OUT, name = PfCalcDuration.P_RET_DURATION, type = Long.class)
				})
})

@Entity
@Table(name = "CEN_OUT_PPM_SCHED")
public class CenOutPpmSched implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmSchedKey;

	private String cclient;

	private String cunit;

	private Date dprodDate;

	private long nworkscheduleIndex;

	private String carea;

	private String careaText;

	private String careaDesc;

	private String cws;

	private String cwsText;

	private String csched;

	private String cschedDesc;

	private String ctimefrom;

	private String ctimeto;

	private Integer noffset;

	private Integer nsort;

	private boolean nuseEmpCount;

	private Long nempCount;

	private Date dtimefrom;

	private Date dtimeto;

	private Date dtimestampPlanShift;

	private Long nworkstationKey;

	private Long nareaKey;

	private boolean nactive;

	private boolean nopen;

	private String cuser1;

	private String cuser2;

	private String cuser3;

	private boolean nfineplanned;

	@JsonIgnore
	private Set<CenOutPpm> cenOutPpms = new HashSet<>(0);

	private Set<CenOutPpmSchedBreak> cenOutPpmSchedBreaks = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_SCHED")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_SCHED", sequenceName = "SEQ_CEN_OUT_PPM_SCHED", allocationSize = 1)
	@Column(name = "NPPM_SCHED_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmSchedKey() {
		return this.nppmSchedKey;
	}

	public void setNppmSchedKey(final long nppmSchedKey) {
		this.nppmSchedKey = nppmSchedKey;
	}

	@Column(name = "CCLIENT", length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CUNIT", length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPROD_DATE", nullable = false, length = 7)
	public Date getDprodDate() {
		return this.dprodDate;
	}

	public void setDprodDate(final Date dprodDate) {
		this.dprodDate = dprodDate;
	}

	@Column(name = "NWORKSCHEDULE_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNworkscheduleIndex() {
		return this.nworkscheduleIndex;
	}

	public void setNworkscheduleIndex(final long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	@Column(name = "CAREA", nullable = false, length = 12)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CAREA_TEXT", nullable = false, length = 40)
	public String getCareaText() {
		return this.careaText;
	}

	public void setCareaText(final String careaText) {
		this.careaText = careaText;
	}

	@Column(name = "CAREA_DESC", length = 256)
	public String getCareaDesc() {
		return this.careaDesc;
	}

	public void setCareaDesc(final String careaDesc) {
		this.careaDesc = careaDesc;
	}

	@Column(name = "CWS", nullable = false, length = 12)
	public String getCws() {
		return this.cws;
	}

	public void setCws(final String cws) {
		this.cws = cws;
	}

	@Column(name = "CWS_TEXT", nullable = false, length = 40)
	public String getCwsText() {
		return this.cwsText;
	}

	public void setCwsText(final String cwsText) {
		this.cwsText = cwsText;
	}

	@Column(name = "CSCHED", nullable = false, length = 40)
	public String getCsched() {
		return this.csched;
	}

	public void setCsched(final String csched) {
		this.csched = csched;
	}

	@Column(name = "CSCHED_DESC", length = 40)
	public String getCschedDesc() {
		return this.cschedDesc;
	}

	public void setCschedDesc(final String cschedDesc) {
		this.cschedDesc = cschedDesc;
	}

	@Column(name = "CTIMEFROM", length = 5)
	public String getCtimefrom() {
		return this.ctimefrom;
	}

	public void setCtimefrom(final String ctimefrom) {
		this.ctimefrom = ctimefrom;
	}

	@Column(name = "CTIMETO", length = 5)
	public String getCtimeto() {
		return this.ctimeto;
	}

	public void setCtimeto(final String ctimeto) {
		this.ctimeto = ctimeto;
	}

	@Column(name = "NOFFSET", precision = 3, scale = 0)
	public Integer getNoffset() {
		return this.noffset;
	}

	public void setNoffset(final Integer noffset) {
		this.noffset = noffset;
	}

	@Column(name = "NSORT", precision = 6, scale = 0)
	public Integer getNsort() {
		return this.nsort;
	}

	public void setNsort(final Integer nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NUSE_EMP_COUNT", precision = 1, scale = 0)
	public boolean isNuseEmpCount() {
		return this.nuseEmpCount;
	}

	public void setNuseEmpCount(final boolean nuseEmpCount) {
		this.nuseEmpCount = nuseEmpCount;
	}

	@Column(name = "NEMP_COUNT", precision = 12, scale = 0)
	public Long getNempCount() {
		return this.nempCount;
	}

	public void setNempCount(final Long nempCount) {
		this.nempCount = nempCount;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMEFROM", length = 7)
	public Date getDtimefrom() {
		return this.dtimefrom;
	}

	public void setDtimefrom(final Date dtimefrom) {
		this.dtimefrom = dtimefrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMETO", length = 7)
	public Date getDtimeto() {
		return this.dtimeto;
	}

	public void setDtimeto(final Date dtimeto) {
		this.dtimeto = dtimeto;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_PLAN_SHIFT", length = 7)
	public Date getDtimestampPlanShift() {
		return this.dtimestampPlanShift;
	}

	public void setDtimestampPlanShift(final Date dtimestampPlanShift) {
		this.dtimestampPlanShift = dtimestampPlanShift;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 12, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "NAREA_KEY", precision = 12, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmSched")
	public Set<CenOutPpm> getCenOutPpms() {
		return this.cenOutPpms;
	}

	public void setCenOutPpms(final Set<CenOutPpm> cenOutPpms) {
		this.cenOutPpms = cenOutPpms;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmSched")
	public Set<CenOutPpmSchedBreak> getCenOutPpmSchedBreaks() {
		return this.cenOutPpmSchedBreaks;
	}

	public void setCenOutPpmSchedBreaks(final Set<CenOutPpmSchedBreak> cenOutPpmSchedBreaks) {
		this.cenOutPpmSchedBreaks = cenOutPpmSchedBreaks;
	}

	@Column(name = "NACTIVE", precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public boolean isNactive() {
		return nactive;
	}

	public void setNactive(final boolean nactive) {
		this.nactive = nactive;
	}

	@Column(name = "NOPEN", precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public boolean isNopen() {
		return nopen;
	}

	public void setNopen(final boolean nopen) {
		this.nopen = nopen;
	}

	/**
	 * @return the cuser1
	 */
	@Column(name = "CUSER1", length = 40)
	public String getCuser1() {
		return cuser1;
	}

	/**
	 * @param cuser1 the cuser1 to set
	 */
	public void setCuser1(final String cuser1) {
		this.cuser1 = cuser1;
	}

	/**
	 * @return the cuser2
	 */
	@Column(name = "CUSER2", length = 40)
	public String getCuser2() {
		return cuser2;
	}

	/**
	 * @param cuser2 the cuser2 to set
	 */
	public void setCuser2(final String cuser2) {
		this.cuser2 = cuser2;
	}

	/**
	 * @return the cuser3
	 */
	@Column(name = "CUSER3", length = 40)
	public String getCuser3() {
		return cuser3;
	}

	/**
	 * @param cuser3 the cuser3 to set
	 */
	public void setCuser3(final String cuser3) {
		this.cuser3 = cuser3;
	}

	@Column(name = "NFINEPLANNED", precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public Boolean getNfineplanned() {
		return nfineplanned;
	}

	public void setNfineplanned(final Boolean nfineplanned) {
		this.nfineplanned = nfineplanned;
	}

}
