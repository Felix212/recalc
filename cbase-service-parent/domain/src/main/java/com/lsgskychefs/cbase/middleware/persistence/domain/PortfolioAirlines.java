package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 16, 2020 2:36:47 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * Entity(DomainObject) for table PORTFOLIO_AIRLINES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_AIRLINES")
public class PortfolioAirlines implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private String cairlineCode;
	private byte[] blogo;
	@JsonBackReference
	private Set<PortfolioExtItem> portfolioExtItems = new HashSet<>(0);

	@Id
	@Column(name = "CAIRLINE_CODE", unique = true, nullable = false, length = 10)
	public String getCairlineCode() {
		return this.cairlineCode;
	}

	public void setCairlineCode(final String cairlineCode) {
		this.cairlineCode = cairlineCode;
	}

	@Column(name = "BLOGO")
	public byte[] getBlogo() {
		return this.blogo;
	}

	public void setBlogo(final byte[] blogo) {
		this.blogo = blogo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "portfolioAirlines")
	public Set<PortfolioExtItem> getPortfolioExtItems() {
		return this.portfolioExtItems;
	}

	public void setPortfolioExtItems(final Set<PortfolioExtItem> portfolioExtItems) {
		this.portfolioExtItems = portfolioExtItems;
	}

}
