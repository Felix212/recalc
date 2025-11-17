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
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_CHAT_PARTICIPANTS
 *
 * @author Hibernate Tools
 */
@NamedEntityGraph(
	name = "CenChatParticipants.user",
	attributeNodes = {
		@NamedAttributeNode("sysLogin")
	}
)
@Entity
@Table(name = "CEN_CHAT_PARTICIPANTS"
)
public class CenChatParticipants implements DomainObject, java.io.Serializable {

	private Long nparticipantKey;
	private SysLogin sysLogin;
	private CenChatConversations cenChatConversations;
	private Date djoinedDate;
	private Date dleftDate;
	private String crole;
	private Integer nactive;

	public CenChatParticipants() {
	}

	@Id
	@SequenceGenerator(name = "cenChatParticipantsSeq", sequenceName = "SEQ_CEN_CHAT_PARTICIPANTS", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cenChatParticipantsSeq")
	@Column(name = "NPARTICIPANT_KEY", unique = true, nullable = false, precision = 22, scale = 0)
	public Long getNparticipantKey() {
		return this.nparticipantKey;
	}

	public void setNparticipantKey(Long nparticipantKey) {
		this.nparticipantKey = nparticipantKey;
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
	@JoinColumn(name = "NCONVERSATION_KEY", nullable = false)
	public CenChatConversations getCenChatConversations() {
		return this.cenChatConversations;
	}

	public void setCenChatConversations(CenChatConversations cenChatConversations) {
		this.cenChatConversations = cenChatConversations;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOINED_DATE", length = 7)
	public Date getDjoinedDate() {
		return this.djoinedDate;
	}

	public void setDjoinedDate(Date djoinedDate) {
		this.djoinedDate = djoinedDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLEFT_DATE", length = 7)
	public Date getDleftDate() {
		return this.dleftDate;
	}

	public void setDleftDate(Date dleftDate) {
		this.dleftDate = dleftDate;
	}

	@Column(name = "CROLE", length = 20)
	public String getCrole() {
		return this.crole;
	}

	public void setCrole(String crole) {
		this.crole = crole;
	}

	@Column(name = "NACTIVE", precision = 1, scale = 0)
	public Integer getNactive() {
		return this.nactive;
	}

	public void setNactive(Integer nactive) {
		this.nactive = nactive;
	}

}


