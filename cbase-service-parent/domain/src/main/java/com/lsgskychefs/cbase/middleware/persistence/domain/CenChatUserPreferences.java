package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.07.2025 17:17:56 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_CHAT_USER_PREFERENCES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CHAT_USER_PREFERENCES"
)
public class CenChatUserPreferences implements DomainObject, java.io.Serializable {

	private Long npreferenceKey;
	private SysLogin sysLogin;
	private Integer nnotificationsEnabled;
	private Integer nsoundEnabled;
	private Date dmodifiedDate;

	public CenChatUserPreferences() {
	}

	@Id
	@SequenceGenerator(name = "cenChatUserPreferencesSeq", sequenceName = "SEQ_CEN_CHAT_USER_PREFERENCES", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cenChatUserPreferencesSeq")
	@Column(name = "NPREFERENCE_KEY", unique = true, nullable = false, precision = 22, scale = 0)
	public Long getNpreferenceKey() {
		return this.npreferenceKey;
	}

	public void setNpreferenceKey(Long npreferenceKey) {
		this.npreferenceKey = npreferenceKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@Column(name = "NNOTIFICATIONS_ENABLED", precision = 1, scale = 0)
	public Integer getNnotificationsEnabled() {
		return this.nnotificationsEnabled;
	}

	public void setNnotificationsEnabled(Integer nnotificationsEnabled) {
		this.nnotificationsEnabled = nnotificationsEnabled;
	}

	@Column(name = "NSOUND_ENABLED", precision = 1, scale = 0)
	public Integer getNsoundEnabled() {
		return this.nsoundEnabled;
	}

	public void setNsoundEnabled(Integer nsoundEnabled) {
		this.nsoundEnabled = nsoundEnabled;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DMODIFIED_DATE", length = 7)
	public Date getDmodifiedDate() {
		return this.dmodifiedDate;
	}

	public void setDmodifiedDate(Date dmodifiedDate) {
		this.dmodifiedDate = dmodifiedDate;
	}

}


