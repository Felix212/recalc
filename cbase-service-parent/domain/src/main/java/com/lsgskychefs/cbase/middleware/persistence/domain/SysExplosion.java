package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.05.2016 14:40:22 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table SYS_EXPLOSION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_EXPLOSION")
public class SysExplosion implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long njobNr;

	private long nresultKey;

	private Date ddeparture;

	private Date dcreated;

	private Date dstartComputing;

	private Date dstopComputing;

	private Integer nstatus;

	private Integer ncnx;

	private String cinstance;

	private Integer ndispo;

	private String cvalue;

	private String cmodified;

	private int nfinish = 0;

	private Date dlogtime;

	/** 1 for Flight / 2 for Buchungsbrowser. */
	private int nrequester = 1;

	private int nprocessStatus = 0;

	private Long npackinglistIndexKey;

	private Long nareaKey;

	private Long nworkstationKey;

	private String csvcDatabase = " ";

	private String csvcTerminal = " ";

	private String csvcModule = " ";

	private String ccreatedUser;

	private String ccreatedTerminal;

	private String ccreatedModule;

	private Integer nfunction;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_EXPLOSION")
	@SequenceGenerator(name = "SEQ_SYS_EXPLOSION", sequenceName = "SEQ_SYS_EXPLOSION", allocationSize = 1)
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

	@Column(name = "NCNX", precision = 1, scale = 0)
	public Integer getNcnx() {
		return this.ncnx;
	}

	public void setNcnx(final Integer ncnx) {
		this.ncnx = ncnx;
	}

	@Column(name = "CINSTANCE", length = 30)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "NDISPO", precision = 1, scale = 0)
	public Integer getNdispo() {
		return this.ndispo;
	}

	public void setNdispo(final Integer ndispo) {
		this.ndispo = ndispo;
	}

	@Column(name = "CVALUE", length = 40)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Column(name = "CMODIFIED", length = 40)
	public String getCmodified() {
		return this.cmodified;
	}

	public void setCmodified(final String cmodified) {
		this.cmodified = cmodified;
	}

	@Column(name = "NFINISH", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNfinish() {
		return this.nfinish;
	}

	public void setNfinish(final int nfinish) {
		this.nfinish = nfinish;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLOGTIME", length = 7)
	public Date getDlogtime() {
		return this.dlogtime;
	}

	public void setDlogtime(final Date dlogtime) {
		this.dlogtime = dlogtime;
	}

	@Column(name = "NREQUESTER", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 1")
	public int getNrequester() {
		return this.nrequester;
	}

	public void setNrequester(final int nrequester) {
		this.nrequester = nrequester;
	}

	@Column(name = "NPROCESS_STATUS", nullable = false, precision = 2, scale = 0, columnDefinition = "NUMBER(2) DEFAULT 0")
	public int getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final int nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 13, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NAREA_KEY", precision = 13, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 13, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "CSVC_DATABASE", nullable = false, length = 20, columnDefinition = "VARCHAR2(20) DEFAULT ' '")
	public String getCsvcDatabase() {
		return this.csvcDatabase;
	}

	public void setCsvcDatabase(final String csvcDatabase) {
		this.csvcDatabase = CbaseMiddlewareStringUtils.defaultString(csvcDatabase);
	}

	@Column(name = "CSVC_TERMINAL", nullable = false, length = 20, columnDefinition = "VARCHAR2(20) DEFAULT ' '")
	public String getCsvcTerminal() {
		return this.csvcTerminal;
	}

	public void setCsvcTerminal(final String csvcTerminal) {
		this.csvcTerminal = CbaseMiddlewareStringUtils.defaultString(csvcTerminal);
	}

	@Column(name = "CSVC_MODULE", nullable = false, length = 50, columnDefinition = "VARCHAR2(50) DEFAULT ' '")
	public String getCsvcModule() {
		return this.csvcModule;
	}

	public void setCsvcModule(final String csvcModule) {
		this.csvcModule = CbaseMiddlewareStringUtils.defaultString(csvcModule);
	}

	@Column(name = "CCREATED_USER", length = 40)
	public String getCcreatedUser() {
		return this.ccreatedUser;
	}

	public void setCcreatedUser(final String ccreatedUser) {
		this.ccreatedUser = ccreatedUser;
	}

	@Column(name = "CCREATED_TERMINAL", length = 20)
	public String getCcreatedTerminal() {
		return this.ccreatedTerminal;
	}

	public void setCcreatedTerminal(final String ccreatedTerminal) {
		this.ccreatedTerminal = ccreatedTerminal;
	}

	@Column(name = "CCREATED_MODULE", length = 50)
	public String getCcreatedModule() {
		return this.ccreatedModule;
	}

	public void setCcreatedModule(final String ccreatedModule) {
		this.ccreatedModule = ccreatedModule;
	}

	@Column(name = "NFUNCTION", precision = 2, scale = 0)
	public Integer getNfunction() {
		return this.nfunction;
	}

	public void setNfunction(final Integer nfunction) {
		this.nfunction = nfunction;
	}
}
