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
 * Entity(DomainObject) for table CEN_CHAT_MESSAGE_STATUS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CHAT_MESSAGE_STATUS"
)
public class CenChatMessageStatus implements DomainObject, java.io.Serializable {

	private Long nmessageStatusKey;
	private SysLogin sysLogin;
	private CenChatMessages cenChatMessages;
	private String cstatus;
	private Date dstatusDate;

	public CenChatMessageStatus() {
	}

	@Id
	@SequenceGenerator(name = "cenChatMessageStatusSeq", sequenceName = "SEQ_CEN_CHAT_MESSAGE_STATUS", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cenChatMessageStatusSeq")
	@Column(name = "NMESSAGE_STATUS_KEY", unique = true, nullable = false, precision = 22, scale = 0)
	public Long getNmessageStatusKey() {
		return this.nmessageStatusKey;
	}

	public void setNmessageStatusKey(Long nmessageStatusKey) {
		this.nmessageStatusKey = nmessageStatusKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMESSAGE_KEY", nullable = false)
	public CenChatMessages getCenChatMessages() {
		return this.cenChatMessages;
	}

	public void setCenChatMessages(CenChatMessages cenChatMessages) {
		this.cenChatMessages = cenChatMessages;
	}

	@Column(name = "CSTATUS", nullable = false, length = 20)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTATUS_DATE", length = 7)
	public Date getDstatusDate() {
		return this.dstatusDate;
	}

	public void setDstatusDate(Date dstatusDate) {
		this.dstatusDate = dstatusDate;
	}

}


