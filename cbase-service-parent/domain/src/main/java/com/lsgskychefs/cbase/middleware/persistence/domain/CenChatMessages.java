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
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_CHAT_MESSAGES
 *
 * @author Hibernate Tools
 */
@NamedEntityGraphs({
	@NamedEntityGraph(
		name = "CenChatMessages.details",
		attributeNodes = {
			@NamedAttributeNode("sysLogin"),
			@NamedAttributeNode("cenChatConversations"),
			@NamedAttributeNode("cenChatMessages")
		}
	),
	@NamedEntityGraph(
		name = "CenChatMessages.detailsWithStatuses",
		attributeNodes = {
			@NamedAttributeNode("sysLogin"),
			@NamedAttributeNode("cenChatConversations"),
			@NamedAttributeNode("cenChatMessages"),
			@NamedAttributeNode("cenChatMessageStatuses")
		}
	),
	@NamedEntityGraph(
		name = "CenChatMessages.attachments",
		attributeNodes = {
			@NamedAttributeNode("cenChatAttachmentses")
		}
	)
})
@Entity
@Table(name = "CEN_CHAT_MESSAGES"
)
public class CenChatMessages implements DomainObject, java.io.Serializable {

	private Long nmessageKey;
	private SysLogin sysLogin;
	private CenChatConversations cenChatConversations;
	private CenChatMessages cenChatMessages;
	private String cmessageText;
	private Date dmessageDate;
	private String cmessageType;
	private Integer nedited;
	private Date ddeletedDate;
	private Set<CenChatMessageStatus> cenChatMessageStatuses = new HashSet<CenChatMessageStatus>(0);
	private Set<CenChatMessages> cenChatMessageses = new HashSet<CenChatMessages>(0);
	private Set<CenChatAttachments> cenChatAttachmentses = new HashSet<CenChatAttachments>(0);

	public CenChatMessages() {
	}

	@Id
	@SequenceGenerator(name = "cenChatMessagesSeq", sequenceName = "SEQ_CEN_CHAT_MESSAGES", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cenChatMessagesSeq")
	@Column(name = "NMESSAGE_KEY", unique = true, nullable = false, precision = 22, scale = 0)
	public Long getNmessageKey() {
		return this.nmessageKey;
	}

	public void setNmessageKey(Long nmessageKey) {
		this.nmessageKey = nmessageKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSENDER_ID", nullable = false)
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREPLY_TO_MESSAGE_KEY")
	public CenChatMessages getCenChatMessages() {
		return this.cenChatMessages;
	}

	public void setCenChatMessages(CenChatMessages cenChatMessages) {
		this.cenChatMessages = cenChatMessages;
	}

	@Lob
	@Column(name = "CMESSAGE_TEXT")
	public String getCmessageText() {
		return this.cmessageText;
	}

	public void setCmessageText(String cmessageText) {
		this.cmessageText = cmessageText;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DMESSAGE_DATE", length = 7)
	public Date getDmessageDate() {
		return this.dmessageDate;
	}

	public void setDmessageDate(Date dmessageDate) {
		this.dmessageDate = dmessageDate;
	}

	@Column(name = "CMESSAGE_TYPE", length = 20)
	public String getCmessageType() {
		return this.cmessageType;
	}

	public void setCmessageType(String cmessageType) {
		this.cmessageType = cmessageType;
	}

	@Column(name = "NEDITED", precision = 1, scale = 0)
	public Integer getNedited() {
		return this.nedited;
	}

	public void setNedited(Integer nedited) {
		this.nedited = nedited;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDELETED_DATE", length = 7)
	public Date getDdeletedDate() {
		return this.ddeletedDate;
	}

	public void setDdeletedDate(Date ddeletedDate) {
		this.ddeletedDate = ddeletedDate;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenChatMessages")
	public Set<CenChatMessageStatus> getCenChatMessageStatuses() {
		return this.cenChatMessageStatuses;
	}

	public void setCenChatMessageStatuses(Set<CenChatMessageStatus> cenChatMessageStatuses) {
		this.cenChatMessageStatuses = cenChatMessageStatuses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenChatMessages")
	public Set<CenChatMessages> getCenChatMessageses() {
		return this.cenChatMessageses;
	}

	public void setCenChatMessageses(Set<CenChatMessages> cenChatMessageses) {
		this.cenChatMessageses = cenChatMessageses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenChatMessages")
	public Set<CenChatAttachments> getCenChatAttachmentses() {
		return this.cenChatAttachmentses;
	}

	public void setCenChatAttachmentses(Set<CenChatAttachments> cenChatAttachmentses) {
		this.cenChatAttachmentses = cenChatAttachmentses;
	}

}


