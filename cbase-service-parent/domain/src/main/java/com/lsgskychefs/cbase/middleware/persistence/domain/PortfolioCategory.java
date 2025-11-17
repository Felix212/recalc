package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 13, 2017 3:08:45 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table PORTFOLIO_CATEGORY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_CATEGORY")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class PortfolioCategory implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;

	private PortfolioCategory portfolioCategory;

	private String cname;

	private String cdescription;

	private Long nsort;

	private Set<PortfolioItem> portfolioItems = new HashSet<>(0);

	private Set<PortfolioAttribute> portfolioAttributes = new HashSet<>(0);

	private Set<PortfolioCategory> portfolioCategories = new HashSet<>(0);

	@Id
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNid() {
		return this.nid;
	}

	public void setNid(final long nid) {
		this.nid = nid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPARENT_ID")
	@JsonView(View.SimpleWithReferences.class)
	@JsonBackReference
	public PortfolioCategory getPortfolioCategory() {
		return this.portfolioCategory;
	}

	public void setPortfolioCategory(final PortfolioCategory portfolioCategory) {
		this.portfolioCategory = portfolioCategory;
	}

	@Column(name = "CNAME", length = 100)
	@JsonView(View.Simple.class)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	@JsonView(View.Simple.class)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

	@OrderBy("nstate ASC, cname ASC")
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioCategory")
	@JsonIgnore
	public Set<PortfolioItem> getPortfolioItems() {
		return this.portfolioItems;
	}

	public void setPortfolioItems(final Set<PortfolioItem> portfolioItems) {
		this.portfolioItems = portfolioItems;
	}

	@OrderBy("ckey ASC")
	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_CATEGORY_ATTRIBUTE", joinColumns = {
			@JoinColumn(name = "NCATEGORY_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NATTRIBUTE_ID", nullable = false, updatable = false) })
	public Set<PortfolioAttribute> getPortfolioAttributes() {
		return this.portfolioAttributes;
	}

	public void setPortfolioAttributes(final Set<PortfolioAttribute> portfolioAttributes) {
		this.portfolioAttributes = portfolioAttributes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioCategory")
	@OrderBy("cname ASC, nsort ASC")
	@JsonView(View.SimpleWithReferences.class)
	@JsonManagedReference
	public Set<PortfolioCategory> getPortfolioCategories() {
		return this.portfolioCategories;
	}

	public void setPortfolioCategories(final Set<PortfolioCategory> portfolioCategories) {
		this.portfolioCategories = portfolioCategories;
	}

}
