package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_SD_CART
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SD_CART")
public class CenOutSdCart implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nsdCartKey;
	private CenOut cenOut;
	private Long ntransaction;
	private Long nrowid;
	private Integer nrungs;
	private Integer ncolumns;
	private Integer npage;

	public CenOutSdCart() {
	}

	public CenOutSdCart(final long nsdCartKey) {
		this.nsdCartKey = nsdCartKey;
	}

	public CenOutSdCart(final long nsdCartKey, final CenOut cenOut, final Long ntransaction, final Long nrowid, final Integer nrungs,
			final Integer ncolumns, final Integer npage) {
		this.nsdCartKey = nsdCartKey;
		this.cenOut = cenOut;
		this.ntransaction = ntransaction;
		this.nrowid = nrowid;
		this.nrungs = nrungs;
		this.ncolumns = ncolumns;
		this.npage = npage;
	}

	@Id

	@Column(name = "NSD_CART_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsdCartKey() {
		return this.nsdCartKey;
	}

	public void setNsdCartKey(final long nsdCartKey) {
		this.nsdCartKey = nsdCartKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY")
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NTRANSACTION", precision = 12, scale = 0)
	public Long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NROWID", precision = 12, scale = 0)
	public Long getNrowid() {
		return this.nrowid;
	}

	public void setNrowid(final Long nrowid) {
		this.nrowid = nrowid;
	}

	@Column(name = "NRUNGS", precision = 6, scale = 0)
	public Integer getNrungs() {
		return this.nrungs;
	}

	public void setNrungs(final Integer nrungs) {
		this.nrungs = nrungs;
	}

	@Column(name = "NCOLUMNS", precision = 6, scale = 0)
	public Integer getNcolumns() {
		return this.ncolumns;
	}

	public void setNcolumns(final Integer ncolumns) {
		this.ncolumns = ncolumns;
	}

	@Column(name = "NPAGE", precision = 6, scale = 0)
	public Integer getNpage() {
		return this.npage;
	}

	public void setNpage(final Integer npage) {
		this.npage = npage;
	}

}
