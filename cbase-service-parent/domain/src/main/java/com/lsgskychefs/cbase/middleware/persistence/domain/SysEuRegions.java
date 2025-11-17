package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_EU_REGIONS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_EU_REGIONS", uniqueConstraints = @UniqueConstraint(columnNames = "CREGION"))
public class SysEuRegions implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long neuRegionKey;

	private SysRoles sysRoles;

	private String cregion;

	private String ccountryCode;

	private String csapUnit;

	private Integer ncompanyId;

	private Date dtimestamp;

	private int ndocResend;

	private String cdocResendpath;

	private int ndocQueue;

	private String cpathI7;

	private String cmessagetype;

	private Integer nexternal;

	private String callgdesclangs;

	private String callgtextrule;

	private Integer nallguseindustrystd;

	private Integer nallgtextrulemode;

	private Set<CenEuPictures> cenEuPictureses = new HashSet<>(0);

	private Set<CenEuFlights> cenEuFlightses = new HashSet<>(0);

	private Set<CenEuItems> cenEuItemses = new HashSet<>(0);

	@Id
	@Column(name = "NEU_REGION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuRegionKey() {
		return this.neuRegionKey;
	}

	public void setNeuRegionKey(final long neuRegionKey) {
		this.neuRegionKey = neuRegionKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROLE_ID", nullable = false)
	public SysRoles getSysRoles() {
		return this.sysRoles;
	}

	public void setSysRoles(final SysRoles sysRoles) {
		this.sysRoles = sysRoles;
	}

	@Column(name = "CREGION", unique = true, nullable = false, length = 20)
	public String getCregion() {
		return this.cregion;
	}

	public void setCregion(final String cregion) {
		this.cregion = cregion;
	}

	@Column(name = "CCOUNTRY_CODE", nullable = false, length = 5)
	public String getCcountryCode() {
		return this.ccountryCode;
	}

	public void setCcountryCode(final String ccountryCode) {
		this.ccountryCode = ccountryCode;
	}

	@Column(name = "CSAP_UNIT", length = 5)
	public String getCsapUnit() {
		return this.csapUnit;
	}

	public void setCsapUnit(final String csapUnit) {
		this.csapUnit = csapUnit;
	}

	@Column(name = "NCOMPANY_ID", precision = 5, scale = 0)
	public Integer getNcompanyId() {
		return this.ncompanyId;
	}

	public void setNcompanyId(final Integer ncompanyId) {
		this.ncompanyId = ncompanyId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NDOC_RESEND", nullable = false, precision = 1, scale = 0)
	public int getNdocResend() {
		return this.ndocResend;
	}

	public void setNdocResend(final int ndocResend) {
		this.ndocResend = ndocResend;
	}

	@Column(name = "CDOC_RESENDPATH", length = 200)
	public String getCdocResendpath() {
		return this.cdocResendpath;
	}

	public void setCdocResendpath(final String cdocResendpath) {
		this.cdocResendpath = cdocResendpath;
	}

	@Column(name = "NDOC_QUEUE", nullable = false, precision = 1, scale = 0)
	public int getNdocQueue() {
		return this.ndocQueue;
	}

	public void setNdocQueue(final int ndocQueue) {
		this.ndocQueue = ndocQueue;
	}

	@Column(name = "CPATH_I7", length = 200)
	public String getCpathI7() {
		return this.cpathI7;
	}

	public void setCpathI7(final String cpathI7) {
		this.cpathI7 = cpathI7;
	}

	@Column(name = "CMESSAGETYPE", length = 200)
	public String getCmessagetype() {
		return this.cmessagetype;
	}

	public void setCmessagetype(final String cmessagetype) {
		this.cmessagetype = cmessagetype;
	}

	@Column(name = "NEXTERNAL", precision = 1, scale = 0)
	public Integer getNexternal() {
		return this.nexternal;
	}

	public void setNexternal(final Integer nexternal) {
		this.nexternal = nexternal;
	}

	@Column(name = "CALLGDESCLANGS", length = 120)
	public String getCallgdesclangs() {
		return this.callgdesclangs;
	}

	public void setCallgdesclangs(final String callgdesclangs) {
		this.callgdesclangs = callgdesclangs;
	}

	@Column(name = "CALLGTEXTRULE", length = 120)
	public String getCallgtextrule() {
		return this.callgtextrule;
	}

	public void setCallgtextrule(final String callgtextrule) {
		this.callgtextrule = callgtextrule;
	}

	@Column(name = "NALLGUSEINDUSTRYSTD", precision = 1, scale = 0)
	public Integer getNallguseindustrystd() {
		return this.nallguseindustrystd;
	}

	public void setNallguseindustrystd(final Integer nallguseindustrystd) {
		this.nallguseindustrystd = nallguseindustrystd;
	}

	@Column(name = "NALLGTEXTRULEMODE", precision = 2, scale = 0)
	public Integer getNallgtextrulemode() {
		return this.nallgtextrulemode;
	}

	public void setNallgtextrulemode(final Integer nallgtextrulemode) {
		this.nallgtextrulemode = nallgtextrulemode;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysEuRegions")
	public Set<CenEuPictures> getCenEuPictureses() {
		return this.cenEuPictureses;
	}

	public void setCenEuPictureses(final Set<CenEuPictures> cenEuPictureses) {
		this.cenEuPictureses = cenEuPictureses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysEuRegions")
	public Set<CenEuFlights> getCenEuFlightses() {
		return this.cenEuFlightses;
	}

	public void setCenEuFlightses(final Set<CenEuFlights> cenEuFlightses) {
		this.cenEuFlightses = cenEuFlightses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysEuRegions")
	public Set<CenEuItems> getCenEuItemses() {
		return this.cenEuItemses;
	}

	public void setCenEuItemses(final Set<CenEuItems> cenEuItemses) {
		this.cenEuItemses = cenEuItemses;
	}

}
