package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 16, 2020 2:36:47 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

/**
 * Entity(DomainObject) for table PORTFOLIO_EXT_ITEM
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_EXT_ITEM")
public class PortfolioExtItem implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;
	@JsonIgnore
	private PortfolioItem portfolioItem;
	@JsonManagedReference
	private PortfolioAirlines portfolioAirlines;
	private Date dtimestamp;
	private String cuniqueIdentifier;
	private String cdescription;
	private String cairlineText;
	private byte[] bpicture;
	private String csystemName;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_PORTFOLIO_EXT_ITEM")
	@SequenceGenerator(name = "SEQ_PORTFOLIO_EXT_ITEM", sequenceName = "SEQ_PORTFOLIO_EXT_ITEM", allocationSize = 1)
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	public void setNid(final long nid) {
		this.nid = nid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NITEM_ID", nullable = false)
	public PortfolioItem getPortfolioItem() {
		return this.portfolioItem;
	}

	public void setPortfolioItem(final PortfolioItem portfolioItem) {
		this.portfolioItem = portfolioItem;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CAIRLINE_CODE", nullable = false)
	public PortfolioAirlines getPortfolioAirlines() {
		return this.portfolioAirlines;
	}

	public void setPortfolioAirlines(final PortfolioAirlines portfolioAirlines) {
		this.portfolioAirlines = portfolioAirlines;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CUNIQUE_IDENTIFIER", nullable = false, precision = 22, scale = 0)
	public String getCuniqueIdentifier() {
		return this.cuniqueIdentifier;
	}

	public void setCuniqueIdentifier(final String cuniqueIdentifier) {
		this.cuniqueIdentifier = cuniqueIdentifier;
	}

	@Column(name = "CDESCRIPTION", length = 500)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CAIRLINE_TEXT", length = 200)
	public String getCairlineText() {
		return this.cairlineText;
	}

	public void setCairlineText(final String cairlineText) {
		this.cairlineText = cairlineText;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@Column(name = "CSYSTEM_NAME", length = 500)
	public String getCsystemName() {
		return this.csystemName;
	}

	public void setCsystemName(final String csystemName) {
		this.csystemName = csystemName;
	}
}
