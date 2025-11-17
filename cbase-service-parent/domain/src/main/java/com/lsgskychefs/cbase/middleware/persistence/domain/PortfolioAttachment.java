package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 13, 2017 3:08:45 PM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table PORTFOLIO_ATTACHMENT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "PORTFOLIO_ATTACHMENT")
public class PortfolioAttachment implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nid;
	private PortfolioItem portfolioItem;
	private byte[] bbinary;
	private String cdescription;
	private String cfilename;
	private String ctype;
	private Long nsort;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_PORTFOLIO_ATTACHMENT")
	@SequenceGenerator(name = "SEQ_PORTFOLIO_ATTACHMENT", sequenceName = "SEQ_PORTFOLIO_ATTACHMENT", allocationSize = 1)
	@Column(name = "NID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNid() {
		return this.nid;
	}

	public void setNid(final long nid) {
		this.nid = nid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NITEM_ID", nullable = false)
	@JsonIgnore
	public PortfolioItem getPortfolioItem() {
		return this.portfolioItem;
	}

	public void setPortfolioItem(final PortfolioItem portfolioItem) {
		this.portfolioItem = portfolioItem;
	}

	@Column(name = "BBINARY")
	public byte[] getBbinary() {
		return this.bbinary;
	}

	public void setBbinary(final byte[] bbinary) {
		this.bbinary = bbinary;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CFILENAME", length = 1000)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(final String cfilename) {
		this.cfilename = cfilename;
	}

	@Column(name = "CTYPE", length = 100)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
