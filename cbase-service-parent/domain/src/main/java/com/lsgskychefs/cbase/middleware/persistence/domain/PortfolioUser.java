package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 13, 2017 3:08:45 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table PORTFOLIO_USER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_USER")
public class PortfolioUser implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;
	private Long nrole;
	private Set<PortfolioItem> portfolioItems = new HashSet<>(0);
	private Set<PortfolioList> portfolioLists = new HashSet<>(0);

	@Id
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	public void setNid(final long nid) {
		this.nid = nid;
	}

	@Column(name = "NROLE", precision = 12, scale = 0)
	public Long getNrole() {
		return this.nrole;
	}

	public void setNrole(final Long nrole) {
		this.nrole = nrole;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioUser")
	public Set<PortfolioItem> getPortfolioItems() {
		return this.portfolioItems;
	}

	public void setPortfolioItems(final Set<PortfolioItem> portfolioItems) {
		this.portfolioItems = portfolioItems;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioUser")
	public Set<PortfolioList> getPortfolioLists() {
		return this.portfolioLists;
	}

	public void setPortfolioLists(final Set<PortfolioList> portfolioLists) {
		this.portfolioLists = portfolioLists;
	}

}
