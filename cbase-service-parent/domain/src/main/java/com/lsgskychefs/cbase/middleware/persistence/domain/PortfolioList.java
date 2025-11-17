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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table PORTFOLIO_LIST
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_LIST")
public class PortfolioList implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;

	@JsonIgnore
	private PortfolioUser portfolioUser;

	private String cname;

	private String cdescription;

	private Date dtimestamp;

	private Long nsort;

	private Set<PortfolioItem> portfolioItems = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_PORTFOLIO_LIST")
	@SequenceGenerator(name = "SEQ_PORTFOLIO_LIST", sequenceName = "SEQ_PORTFOLIO_LIST", allocationSize = 1)
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	@JsonView(View.Simple.class)
	public void setNid(final long nid) {
		this.nid = nid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public PortfolioUser getPortfolioUser() {
		return this.portfolioUser;
	}

	public void setPortfolioUser(final PortfolioUser portfolioUser) {
		this.portfolioUser = portfolioUser;
	}

	@Column(name = "CNAME", length = 100)
	public String getCname() {
		return this.cname;
	}

	@JsonView(View.Simple.class)
	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	@JsonView(View.Simple.class)
	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	@JsonView(View.Simple.class)
	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_ITEM_LIST", joinColumns = {
			@JoinColumn(name = "NLIST_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NITEM_ID", nullable = false, updatable = false) })
	public Set<PortfolioItem> getPortfolioItems() {
		return this.portfolioItems;
	}

	@JsonView(View.SimpleWithReferences.class)
	public void setPortfolioItems(final Set<PortfolioItem> portfolioItems) {
		this.portfolioItems = portfolioItems;
	}

}
