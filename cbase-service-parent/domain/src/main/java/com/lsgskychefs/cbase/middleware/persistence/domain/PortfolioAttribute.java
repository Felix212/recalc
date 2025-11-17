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
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table PORTFOLIO_ATTRIBUTE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_ATTRIBUTE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class PortfolioAttribute implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;
	private String ckey;
	private String cdescription;
	private Integer ntype;
	private Integer nmultiselectable;
	private Long nsort;
	private long isConditionalAttribute;
	private Set<PortfolioCategory> portfolioCategories = new HashSet<>(0);
	private Set<PortfolioValue> portfolioValues = new HashSet<>(0);
	private Set<PortfolioValue> showTogetherWith = new HashSet<>(0);

	@Id
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	public void setNid(final long nid) {
		this.nid = nid;
	}

	@Column(name = "CKEY", length = 100)
	public String getCkey() {
		return this.ckey;
	}

	public void setCkey(final String ckey) {
		this.ckey = ckey;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NTYPE", precision = 2, scale = 0)
	public Integer getNtype() {
		return this.ntype;
	}

	public void setNtype(final Integer ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NMULTISELECTABLE", precision = 1, scale = 0)
	public Integer getNmultiselectable() {
		return this.nmultiselectable;
	}

	public void setNmultiselectable(final Integer nmultiselectable) {
		this.nmultiselectable = nmultiselectable;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_CATEGORY_ATTRIBUTE", joinColumns = {
			@JoinColumn(name = "NATTRIBUTE_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NCATEGORY_ID", nullable = false, updatable = false) })
	@JsonBackReference
	public Set<PortfolioCategory> getPortfolioCategories() {
		return this.portfolioCategories;
	}

	public void setPortfolioCategories(final Set<PortfolioCategory> portfolioCategories) {
		this.portfolioCategories = portfolioCategories;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PORTFOLIO_SUBATTRIBUTE", joinColumns = {
			@JoinColumn(name = "NATTRIBUTE_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NVALUE_ID", nullable = false, updatable = false) })
	public Set<PortfolioValue> getShowTogetherWith() {
		return this.showTogetherWith;
	}

	public void setShowTogetherWith(final Set<PortfolioValue> showTogetherWith) {
		this.showTogetherWith = showTogetherWith;
	}

	@OrderBy("cvalue ASC")
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioAttribute")
	public Set<PortfolioValue> getPortfolioValues() {
		return this.portfolioValues;
	}

	public void setPortfolioValues(final Set<PortfolioValue> portfolioValues) {
		this.portfolioValues = portfolioValues;
	}

	@Transient
	public long getIsConditionalAttribute() {
		isConditionalAttribute = 0;
		if (!this.getPortfolioValues().isEmpty()) {
			for (final PortfolioValue value : this.getPortfolioValues()) {
				if (!value.getPortfolioAttributes().isEmpty()) {
					isConditionalAttribute = 1;
					return isConditionalAttribute;
				}
			}
		}
		return isConditionalAttribute;
	}

}
