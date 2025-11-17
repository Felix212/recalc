package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 04.02.2016 14:09:57 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_QUEUE_FLIGHT_CALC
 *
 * @author Hibernate Tools
 */
@Entity
// use with caution. Default columns does not work
@DynamicInsert
@DynamicUpdate
@Table(name = "SYS_QUEUE_FLIGHT_CALC")
public class SysQueueFlightCalc implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long njobNr;

	private long nresultKey;

	private Date ddeparture;

	private Date dcreated;

	private Date dstartComputing;

	private Date dstopComputing;

	private Integer nstatus;

	private Integer nfunction;

	private Integer nerror;

	private String cerror;

	private String cinstance;

	private String cmodified;

	private String cuser;

	private Integer nqueuedReleaseInterface;

	private Integer nhistory;

	private Integer nstationEntry;

	private int nforecast;

	private Long njobGroup;

	private String cdescription;

	private int nsort;

	private int nprocessStatus;

	private Date dcreatedUtc;

	private int ncreatedocenginejob;

	private String csvcDatabase;

	private String csvcTerminal;

	private String csvcModule;

	private String cset;

	private String ccreatedUser;

	private String ccreatedTerminal;

	private String ccreatedModule;

	private Date dassignedUtc;

	private Date dstartUtc;

	private Date dstopUtc;

	private Integer nmzvFisnish;

	private String cpacketId;

	private Long npacketId;

	private int ndocGeneration;

	private Integer ninsertedByTrigger;

	private Long nairlineQpKey;

	private SysQueueFlightActype sysQueueFlightActype;
	@JsonIgnore
	private Set<SysQueueFlightPax> sysQueueFlightPaxes = new HashSet<>(0);
	@JsonIgnore
	private Set<SysQueueFlightMeals> sysQueueFlightMealses = new HashSet<>(0);
	@JsonIgnore
	private Set<SysQueueFlightSpml> sysQueueFlightSpmls = new HashSet<>(0);
	@JsonIgnore
	private Set<SysQueueFlightLog> sysQueueFlightLogs = new HashSet<SysQueueFlightLog>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_QUEUE_FLIGHT_CALC")
	@SequenceGenerator(name = "SEQ_SYS_QUEUE_FLIGHT_CALC", sequenceName = "SEQ_SYS_QUEUE_FLIGHT_CALC", allocationSize = 1)
	@Column(name = "NJOB_NR", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNjobNr() {
		return this.njobNr;
	}

	public void setNjobNr(final long njobNr) {
		this.njobNr = njobNr;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", nullable = false, length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_COMPUTING", length = 7)
	public Date getDstartComputing() {
		return this.dstartComputing;
	}

	public void setDstartComputing(final Date dstartComputing) {
		this.dstartComputing = dstartComputing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTOP_COMPUTING", length = 7)
	public Date getDstopComputing() {
		return this.dstopComputing;
	}

	public void setDstopComputing(final Date dstopComputing) {
		this.dstopComputing = dstopComputing;
	}

	@Column(name = "NSTATUS", precision = 6, scale = 0)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "NFUNCTION", precision = 6, scale = 0)
	public Integer getNfunction() {
		return this.nfunction;
	}

	public void setNfunction(final Integer nfunction) {
		this.nfunction = nfunction;
	}

	@Column(name = "NERROR", precision = 6, scale = 0)
	public Integer getNerror() {
		return this.nerror;
	}

	public void setNerror(final Integer nerror) {
		this.nerror = nerror;
	}

	@Column(name = "CERROR", length = 2048)
	public String getCerror() {
		return this.cerror;
	}

	public void setCerror(final String cerror) {
		this.cerror = cerror;
	}

	@Column(name = "CINSTANCE", length = 30)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "CMODIFIED", length = 40)
	public String getCmodified() {
		return this.cmodified;
	}

	public void setCmodified(final String cmodified) {
		this.cmodified = cmodified;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "NQUEUED_RELEASE_INTERFACE", precision = 1, scale = 0)
	public Integer getNqueuedReleaseInterface() {
		return this.nqueuedReleaseInterface;
	}

	public void setNqueuedReleaseInterface(final Integer nqueuedReleaseInterface) {
		this.nqueuedReleaseInterface = nqueuedReleaseInterface;
	}

	@Column(name = "NHISTORY", precision = 1, scale = 0)
	public Integer getNhistory() {
		return this.nhistory;
	}

	public void setNhistory(final Integer nhistory) {
		this.nhistory = nhistory;
	}

	@Column(name = "NSTATION_ENTRY", precision = 1, scale = 0)
	public Integer getNstationEntry() {
		return this.nstationEntry;
	}

	public void setNstationEntry(final Integer nstationEntry) {
		this.nstationEntry = nstationEntry;
	}

	@Column(name = "NFORECAST", nullable = false, precision = 1, scale = 0)
	public int getNforecast() {
		return this.nforecast;
	}

	public void setNforecast(final int nforecast) {
		this.nforecast = nforecast;
	}

	@Column(name = "NJOB_GROUP", precision = 12, scale = 0)
	public Long getNjobGroup() {
		return this.njobGroup;
	}

	public void setNjobGroup(final Long njobGroup) {
		this.njobGroup = njobGroup;
	}

	@Column(name = "CDESCRIPTION", length = 150)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSORT", nullable = false, precision = 1, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NPROCESS_STATUS", nullable = false, precision = 2, scale = 0)
	public int getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final int nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_UTC", length = 7)
	public Date getDcreatedUtc() {
		return this.dcreatedUtc;
	}

	public void setDcreatedUtc(final Date dcreatedUtc) {
		this.dcreatedUtc = dcreatedUtc;
	}

	@Column(name = "CSVC_DATABASE", nullable = false, length = 20, columnDefinition = "VARCHAR2(20) default ' '")
	public String getCsvcDatabase() {
		return this.csvcDatabase;
	}

	public void setCsvcDatabase(String csvcDatabase) {
		this.csvcDatabase = csvcDatabase;
	}

	@Column(name = "CSVC_TERMINAL", nullable = false, length = 20, columnDefinition = "VARCHAR2(20) default ' '")
	public String getCsvcTerminal() {
		return this.csvcTerminal;
	}

	public void setCsvcTerminal(String csvcTerminal) {
		this.csvcTerminal = csvcTerminal;
	}

	@Column(name = "CSVC_MODULE", nullable = false, length = 50, columnDefinition = "VARCHAR2(50) default ' '")
	public String getCsvcModule() {
		return this.csvcModule;
	}

	public void setCsvcModule(String csvcModule) {
		this.csvcModule = csvcModule;
	}

	@Column(name = "CSET", nullable = false, length = 30, columnDefinition = "VARCHAR2(30) default 'none'")
	public String getCset() {
		return this.cset;
	}

	public void setCset(String cset) {
		this.cset = cset;
	}

	@Column(name = "NCREATEDOCENGINEJOB", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNcreatedocenginejob() {
		return this.ncreatedocenginejob;
	}

	public void setNcreatedocenginejob(final int ncreatedocenginejob) {
		this.ncreatedocenginejob = ncreatedocenginejob;
	}

	@Column(name = "CCREATED_USER", length = 40)
	public String getCcreatedUser() {
		return this.ccreatedUser;
	}

	public void setCcreatedUser(String ccreatedUser) {
		this.ccreatedUser = ccreatedUser;
	}

	@Column(name = "CCREATED_TERMINAL", length = 20)
	public String getCcreatedTerminal() {
		return this.ccreatedTerminal;
	}

	public void setCcreatedTerminal(String ccreatedTerminal) {
		this.ccreatedTerminal = ccreatedTerminal;
	}

	@Column(name = "CCREATED_MODULE", length = 50)
	public String getCcreatedModule() {
		return this.ccreatedModule;
	}

	public void setCcreatedModule(String ccreatedModule) {
		this.ccreatedModule = ccreatedModule;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DASSIGNED_UTC", length = 7)
	public Date getDassignedUtc() {
		return this.dassignedUtc;
	}

	public void setDassignedUtc(Date dassignedUtc) {
		this.dassignedUtc = dassignedUtc;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_UTC", length = 7)
	public Date getDstartUtc() {
		return this.dstartUtc;
	}

	public void setDstartUtc(Date dstartUtc) {
		this.dstartUtc = dstartUtc;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTOP_UTC", length = 7)
	public Date getDstopUtc() {
		return this.dstopUtc;
	}

	public void setDstopUtc(Date dstopUtc) {
		this.dstopUtc = dstopUtc;
	}

	@Column(name = "NMZV_FISNISH", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")

	public Integer getNmzvFisnish() {
		return this.nmzvFisnish;
	}

	public void setNmzvFisnish(Integer nmzvFisnish) {
		this.nmzvFisnish = nmzvFisnish;
	}

	@Column(name = "CPACKET_ID", length = 8)
	public String getCpacketId() {
		return this.cpacketId;
	}

	public void setCpacketId(String cpacketId) {
		this.cpacketId = cpacketId;
	}

	@Column(name = "NPACKET_ID", precision = 10, scale = 0)
	public Long getNpacketId() {
		return this.npacketId;
	}

	public void setNpacketId(Long npacketId) {
		this.npacketId = npacketId;
	}

	@Column(name = "NDOC_GENERATION", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNdocGeneration() {
		return this.ndocGeneration;
	}

	public void setNdocGeneration(int ndocGeneration) {
		this.ndocGeneration = ndocGeneration;
	}

	@Column(name = "NINSERTED_BY_TRIGGER", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNinsertedByTrigger() {
		return this.ninsertedByTrigger;
	}

	public void setNinsertedByTrigger(Integer ninsertedByTrigger) {
		this.ninsertedByTrigger = ninsertedByTrigger;
	}

	@Column(name = "NAIRLINE_QP_KEY", precision = 12, scale = 0)
	public Long getNairlineQpKey() {
		return this.nairlineQpKey;
	}

	public void setNairlineQpKey(Long nairlineQpKey) {
		this.nairlineQpKey = nairlineQpKey;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "sysQueueFlightCalc")
	public SysQueueFlightActype getSysQueueFlightActype() {
		return this.sysQueueFlightActype;
	}

	public void setSysQueueFlightActype(final SysQueueFlightActype sysQueueFlightActype) {
		this.sysQueueFlightActype = sysQueueFlightActype;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueFlightCalc")
	public Set<SysQueueFlightPax> getSysQueueFlightPaxes() {
		return this.sysQueueFlightPaxes;
	}

	public void setSysQueueFlightPaxes(final Set<SysQueueFlightPax> sysQueueFlightPaxes) {
		this.sysQueueFlightPaxes = sysQueueFlightPaxes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueFlightCalc")
	public Set<SysQueueFlightMeals> getSysQueueFlightMealses() {
		return this.sysQueueFlightMealses;
	}

	public void setSysQueueFlightMealses(final Set<SysQueueFlightMeals> sysQueueFlightMealses) {
		this.sysQueueFlightMealses = sysQueueFlightMealses;
	}

	public void addSysQueueFlightMealses(final SysQueueFlightMeals sysQueueFlightMealses) {
		if (sysQueueFlightMealses != null) {
			this.sysQueueFlightMealses.add(sysQueueFlightMealses);
			sysQueueFlightMealses.setSysQueueFlightCalc(this);
		}
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueFlightCalc")
	public Set<SysQueueFlightSpml> getSysQueueFlightSpmls() {
		return this.sysQueueFlightSpmls;
	}

	public void setSysQueueFlightSpmls(final Set<SysQueueFlightSpml> sysQueueFlightSpmls) {
		this.sysQueueFlightSpmls = sysQueueFlightSpmls;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueFlightCalc")
	public Set<SysQueueFlightLog> getSysQueueFlightLogs() {
		return this.sysQueueFlightLogs;
	}

	public void setSysQueueFlightLogs(Set<SysQueueFlightLog> sysQueueFlightLogs) {
		this.sysQueueFlightLogs = sysQueueFlightLogs;
	}

}
