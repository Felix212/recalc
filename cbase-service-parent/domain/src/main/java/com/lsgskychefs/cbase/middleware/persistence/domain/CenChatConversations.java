package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.07.2025 17:17:56 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_CHAT_CONVERSATIONS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CHAT_CONVERSATIONS"
)
public class CenChatConversations implements DomainObject, java.io.Serializable {

	private Long nconversationKey;
	private String cconversationName;
	private String cconversationType;
	private String ccreatedBy;
	private Date dcreatedDate;
	private Date dlastMessageDate;
	private String clastMessageText;
	private Long nlastMessageByKey;
	private Integer nactive;
	private Set<CenChatParticipants> cenChatParticipantses = new HashSet<CenChatParticipants>(0);
	private Set<CenChatMessages> cenChatMessageses = new HashSet<CenChatMessages>(0);

	public CenChatConversations() {
	}

	@Id
	@SequenceGenerator(name = "cenChatConversationsSeq", sequenceName = "SEQ_CEN_CHAT_CONVERSATIONS", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cenChatConversationsSeq")
	@Column(name = "NCONVERSATION_KEY", unique = true, nullable = false, precision = 22, scale = 0)
	public Long getNconversationKey() {
		return this.nconversationKey;
	}

	public void setNconversationKey(Long nconversationKey) {
		this.nconversationKey = nconversationKey;
	}

	@Column(name = "CCONVERSATION_NAME")
	public String getCconversationName() {
		return this.cconversationName;
	}

	public void setCconversationName(String cconversationName) {
		this.cconversationName = cconversationName;
	}

	@Column(name = "CCONVERSATION_TYPE", nullable = false, length = 20)
	public String getCconversationType() {
		return this.cconversationType;
	}

	public void setCconversationType(String cconversationType) {
		this.cconversationType = cconversationType;
	}

	@Column(name = "CCREATED_BY", nullable = false, length = 50)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLAST_MESSAGE_DATE", length = 7)
	public Date getDlastMessageDate() {
		return this.dlastMessageDate;
	}

	public void setDlastMessageDate(Date dlastMessageDate) {
		this.dlastMessageDate = dlastMessageDate;
	}

	@Column(name = "CLAST_MESSAGE_TEXT", length = 1000)
	public String getClastMessageText() {
		return this.clastMessageText;
	}

	public void setClastMessageText(String clastMessageText) {
		this.clastMessageText = clastMessageText;
	}

	@Column(name = "NLAST_MESSAGE_BY_KEY", precision = 22, scale = 0)
	public Long getNlastMessageByKey() {
		return this.nlastMessageByKey;
	}

	public void setNlastMessageByKey(Long nlastMessageByKey) {
		this.nlastMessageByKey = nlastMessageByKey;
	}

	@Column(name = "NACTIVE", precision = 1, scale = 0)
	public Integer getNactive() {
		return this.nactive;
	}

	public void setNactive(Integer nactive) {
		this.nactive = nactive;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenChatConversations")
	public Set<CenChatParticipants> getCenChatParticipantses() {
		return this.cenChatParticipantses;
	}

	public void setCenChatParticipantses(Set<CenChatParticipants> cenChatParticipantses) {
		this.cenChatParticipantses = cenChatParticipantses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenChatConversations")
	public Set<CenChatMessages> getCenChatMessageses() {
		return this.cenChatMessageses;
	}

	public void setCenChatMessageses(Set<CenChatMessages> cenChatMessageses) {
		this.cenChatMessageses = cenChatMessageses;
	}

}


