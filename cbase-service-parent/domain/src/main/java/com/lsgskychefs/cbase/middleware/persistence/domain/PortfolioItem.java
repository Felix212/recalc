package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 13, 2017 3:08:45 PM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table PORTFOLIO_ITEM
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_ITEM")
public class PortfolioItem implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;
	private PortfolioUser portfolioUser;
	@JsonIgnore
	private PortfolioCategory portfolioCategory;
	private long categoryId;
	private String cname;
	private String cdescription;
	private String cuniqueIdentifier;
	private Long nstate;
	private Date dtimestamp;
	private Set<PortfolioAttachment> portfolioAttachments = new HashSet<>(0);
	private Set<PortfolioList> portfolioLists = new HashSet<>(0);
	private Set<PortfolioValue> portfolioValues = new HashSet<>(0);
	private Set<PortfolioExtItem> portfolioExtItem = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_PORTFOLIO_ITEM")
	@SequenceGenerator(name = "SEQ_PORTFOLIO_ITEM", sequenceName = "SEQ_PORTFOLIO_ITEM", allocationSize = 1)
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	public void setNid(final long nid) {
		this.nid = nid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	@JsonIgnore
	public PortfolioUser getPortfolioUser() {
		return this.portfolioUser;
	}

	public void setPortfolioUser(final PortfolioUser portfolioUser) {
		this.portfolioUser = portfolioUser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCATEGORY_ID", nullable = false)
	public PortfolioCategory getPortfolioCategory() {
		return this.portfolioCategory;
	}

	public void setPortfolioCategory(final PortfolioCategory portfolioCategory) {
		this.portfolioCategory = portfolioCategory;
	}

	@Transient
	public long getCategoryId() {
		categoryId = portfolioCategory.getNid();
		return categoryId;
	}

	@Column(name = "CNAME", length = 100)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	public String getCuniqueIdentifier() {
		return cuniqueIdentifier;
	}

	public void setCuniqueIdentifier(final String cuniqueIdentifier) {
		this.cuniqueIdentifier = cuniqueIdentifier;
	}

	@Column(name = "NSTATE", precision = 12, scale = 0)
	public Long getNstate() {
		return this.nstate;
	}

	public void setNstate(final Long nstate) {
		this.nstate = nstate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioItem")
	@OrderBy("cfilename ASC")
	@JsonIgnore
	public Set<PortfolioAttachment> getPortfolioAttachments() {
		return this.portfolioAttachments;
	}

	public void setPortfolioAttachments(final Set<PortfolioAttachment> portfolioAttachments) {
		this.portfolioAttachments = portfolioAttachments;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_ITEM_LIST", joinColumns = {
			@JoinColumn(name = "NITEM_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NLIST_ID", nullable = false, updatable = false) })
	@JsonIgnore
	public Set<PortfolioList> getPortfolioLists() {
		return this.portfolioLists;
	}

	public void setPortfolioLists(final Set<PortfolioList> portfolioLists) {
		this.portfolioLists = portfolioLists;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_ITEM_VALUE", joinColumns = {
			@JoinColumn(name = "NITEM_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NVALUE_ID", nullable = false, updatable = false) })
	public Set<PortfolioValue> getPortfolioValues() {
		return this.portfolioValues;
	}

	public void setPortfolioValues(final Set<PortfolioValue> portfolioValues) {
		this.portfolioValues = portfolioValues;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioItem")
	@JsonIgnore
	public Set<PortfolioExtItem> getPortfolioExtItem() {
		return this.portfolioExtItem;
	}

	public void setPortfolioExtItem(final Set<PortfolioExtItem> portfolioExtItems) {
		this.portfolioExtItem = portfolioExtItems;
	}

}
