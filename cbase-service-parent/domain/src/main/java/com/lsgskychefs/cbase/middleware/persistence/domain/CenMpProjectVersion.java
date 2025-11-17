package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 10, 2025 3:00:23 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_MP_PROJECT_VERSION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_PROJECT_VERSION"
)
public class CenMpProjectVersion extends AuditableDomainObject {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmpProjectVersionKey;
	private CenFollowUpMaster cenFollowUpMaster;
	private CenGuestAccessToken cenGuestAccessToken;
	private CenMpProject cenMpProject;
	private long nmpStatusKey;
	private String cname;
	private long nairlineKey;
	private Date dpresentationDate;
	private Date dbomReferenceDate;
	private String cdescription;
	private long nmpTeamKey;
	private Date dproductionrangeDatefrom;
	private Date dproductionrangeDateto;
	private Long nisExploded;
	private Long nmpProjectTypeKey;
	private long nversionNumber;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_PROJECT_VERSION")
	@SequenceGenerator(name = "SEQ_CEN_MP_PROJECT_VERSION", sequenceName = "SEQ_CEN_MP_PROJECT_VERSION", allocationSize = 1)
	@Column(name = "NMP_PROJECT_VERSION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpProjectVersionKey() {
		return nmpProjectVersionKey;
	}

	public void setNmpProjectVersionKey(long nmpProjectVersionKey) {
		this.nmpProjectVersionKey = nmpProjectVersionKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_PROJECT_KEY", nullable = false)
	public CenMpProject getCenMpProject() {
		return cenMpProject;
	}

	public void setCenMpProject(CenMpProject cenMpProject) {
		this.cenMpProject = cenMpProject;
	}

	public long getNmpStatusKey() {
		return nmpStatusKey;
	}

	public void setNmpStatusKey(long nmpStatusKey) {
		this.nmpStatusKey = nmpStatusKey;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public long getNairlineKey() {
		return nairlineKey;
	}

	public void setNairlineKey(long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	public Date getDpresentationDate() {
		return dpresentationDate;
	}

	public void setDpresentationDate(Date dpresentationDate) {
		this.dpresentationDate = dpresentationDate;
	}

	public Date getDbomReferenceDate() {
		return dbomReferenceDate;
	}

	public void setDbomReferenceDate(Date dbomReferenceDate) {
		this.dbomReferenceDate = dbomReferenceDate;
	}

	public String getCdescription() {
		return cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	public long getNmpTeamKey() {
		return nmpTeamKey;
	}

	public void setNmpTeamKey(long nmpTeamKey) {
		this.nmpTeamKey = nmpTeamKey;
	}

	public Date getDproductionrangeDatefrom() {
		return dproductionrangeDatefrom;
	}

	public void setDproductionrangeDatefrom(Date dproductionrangeDatefrom) {
		this.dproductionrangeDatefrom = dproductionrangeDatefrom;
	}

	public Date getDproductionrangeDateto() {
		return dproductionrangeDateto;
	}

	public void setDproductionrangeDateto(Date dproductionrangeDateto) {
		this.dproductionrangeDateto = dproductionrangeDateto;
	}
	
	public Long getNisExploded() {
		return nisExploded;
	}

	public void setNisExploded(Long nisExploded) {
		this.nisExploded = nisExploded;
	}

	public Long getNmpProjectTypeKey() {
		return nmpProjectTypeKey;
	}

	public void setNmpProjectTypeKey(Long nmpProjectTypeKey) {
		this.nmpProjectTypeKey = nmpProjectTypeKey;
	}

	public long getNversionNumber() {
		return nversionNumber;
	}

	public void setNversionNumber(long nversionNumber) {
		this.nversionNumber = nversionNumber;
	}

	public Date getDtimestamp() {
		return dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGUEST_ACCESS_TOKEN_KEY", nullable = false)
	public CenGuestAccessToken getNguestAccessToken() {
		return this.cenGuestAccessToken;
	}

	public void setNguestAccessToken(CenGuestAccessToken cenGuestAccessToken) {
		this.cenGuestAccessToken = cenGuestAccessToken;
	}

}


