package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 22, 2019 11:22:23 AM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_CH_STOCK_ON_HOLD
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_CH_STOCK_ON_HOLD")
public class CenOutChStockOnHold implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nchStockOnHoldKey;
	@JsonIgnore
	private CenOutChStock cenOutChStock;
	private String cpackinglist;
	private Long nppmProdLabelKey;
	private BigDecimal nquantityOnHold;
	private String cuser;
	private Date dtimestamp;
	@JsonIgnore
	private String csessionid;
	private Long nppmTrolleyKey;

	@Id
	@Column(name = "NCH_STOCK_ON_HOLD_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNchStockOnHoldKey() {
		return this.nchStockOnHoldKey;
	}

	public void setNchStockOnHoldKey(final long nchStockOnHoldKey) {
		this.nchStockOnHoldKey = nchStockOnHoldKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCH_STOCK_KEY", nullable = false)
	public CenOutChStock getCenOutChStock() {
		return this.cenOutChStock;
	}

	public void setCenOutChStock(final CenOutChStock cenOutChStock) {
		this.cenOutChStock = cenOutChStock;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NPPM_PROD_LABEL_KEY", precision = 12, scale = 0)
	public Long getNppmProdLabelKey() {
		return this.nppmProdLabelKey;
	}

	public void setNppmProdLabelKey(final Long nppmProdLabelKey) {
		this.nppmProdLabelKey = nppmProdLabelKey;
	}

	@Column(name = "NQUANTITY_ON_HOLD", precision = 15, scale = 3)
	public BigDecimal getNquantityOnHold() {
		return this.nquantityOnHold;
	}

	public void setNquantityOnHold(final BigDecimal nquantityOnHold) {
		this.nquantityOnHold = nquantityOnHold;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CSESSIONID", nullable = false, length = 40)
	public String getCsessionid() {
		return this.csessionid;
	}

	public void setCsessionid(final String csessionid) {
		this.csessionid = csessionid;
	}

	@Column(name = "NPPM_TROLLEY_KEY", precision = 12, scale = 0)
	public Long getNppmTrolleyKey() {
		return this.nppmTrolleyKey;
	}

	public void setNppmTrolleyKey(final Long nppmTrolleyKey) {
		this.nppmTrolleyKey = nppmTrolleyKey;
	}

}
