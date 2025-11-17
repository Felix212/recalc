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
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table PORTFOLIO_VALUE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_VALUE")
public class PortfolioValue implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;

	private PortfolioAttribute portfolioAttribute;

	private String cvalue;

	private String cdescription;

	private Long nsort;

	private Set<PortfolioItem> portfolioItems = new HashSet<>(0);

	private Set<PortfolioAttribute> portfolioAttributes = new HashSet<>(0);

	@Id
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	@JsonView(View.Simple.class)
	public void setNid(final long nid) {
		this.nid = nid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NATTRIBUTE_ID", nullable = false)
	@JsonIgnore
	public PortfolioAttribute getPortfolioAttribute() {
		return this.portfolioAttribute;
	}

	@JsonView(View.SimpleWithReferences.class)
	public void setPortfolioAttribute(final PortfolioAttribute portfolioAttribute) {
		this.portfolioAttribute = portfolioAttribute;
	}

	@Column(name = "CVALUE", length = 100)
	public String getCvalue() {
		return this.cvalue;
	}

	@JsonView(View.Simple.class)
	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	@JsonView(View.Simple.class)
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

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_ITEM_VALUE", joinColumns = {
			@JoinColumn(name = "NVALUE_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NITEM_ID", nullable = false, updatable = false) })
	@JsonIgnore
	public Set<PortfolioItem> getPortfolioItems() {
		return this.portfolioItems;
	}

	@JsonView(View.SimpleWithReferences.class)
	public void setPortfolioItems(final Set<PortfolioItem> portfolioItems) {
		this.portfolioItems = portfolioItems;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_SUBATTRIBUTE", joinColumns = {
			@JoinColumn(name = "NVALUE_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NATTRIBUTE_ID", nullable = false, updatable = false) })
	@JsonIgnore
	public Set<PortfolioAttribute> getPortfolioAttributes() {
		return this.portfolioAttributes;
	}

	public void setPortfolioAttributes(final Set<PortfolioAttribute> portfolioAttributes) {
		this.portfolioAttributes = portfolioAttributes;
	}

}
