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
 * Entity(DomainObject) for table CEN_OUT_SD_DRAWER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SD_DRAWER")
public class CenOutSdDrawer implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nsdDrawerKey;
	private CenOut cenOut;
	private Long ntransaction;
	private Long nrowid;
	private Long nsdCartKey;
	private Integer ntype;
	private Integer ncolumn;
	private Integer nrung;
	private Integer nwidth;
	private Integer nheight;
	private Integer nempty;

	public CenOutSdDrawer() {
	}

	public CenOutSdDrawer(final long nsdDrawerKey) {
		this.nsdDrawerKey = nsdDrawerKey;
	}

	public CenOutSdDrawer(final long nsdDrawerKey, final CenOut cenOut, final Long ntransaction, final Long nrowid, final Long nsdCartKey,
			final Integer ntype, final Integer ncolumn, final Integer nrung, final Integer nwidth, final Integer nheight,
			final Integer nempty) {
		this.nsdDrawerKey = nsdDrawerKey;
		this.cenOut = cenOut;
		this.ntransaction = ntransaction;
		this.nrowid = nrowid;
		this.nsdCartKey = nsdCartKey;
		this.ntype = ntype;
		this.ncolumn = ncolumn;
		this.nrung = nrung;
		this.nwidth = nwidth;
		this.nheight = nheight;
		this.nempty = nempty;
	}

	@Id

	@Column(name = "NSD_DRAWER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsdDrawerKey() {
		return this.nsdDrawerKey;
	}

	public void setNsdDrawerKey(final long nsdDrawerKey) {
		this.nsdDrawerKey = nsdDrawerKey;
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

	@Column(name = "NSD_CART_KEY", precision = 12, scale = 0)
	public Long getNsdCartKey() {
		return this.nsdCartKey;
	}

	public void setNsdCartKey(final Long nsdCartKey) {
		this.nsdCartKey = nsdCartKey;
	}

	@Column(name = "NTYPE", precision = 2, scale = 0)
	public Integer getNtype() {
		return this.ntype;
	}

	public void setNtype(final Integer ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NCOLUMN", precision = 1, scale = 0)
	public Integer getNcolumn() {
		return this.ncolumn;
	}

	public void setNcolumn(final Integer ncolumn) {
		this.ncolumn = ncolumn;
	}

	@Column(name = "NRUNG", precision = 2, scale = 0)
	public Integer getNrung() {
		return this.nrung;
	}

	public void setNrung(final Integer nrung) {
		this.nrung = nrung;
	}

	@Column(name = "NWIDTH", precision = 1, scale = 0)
	public Integer getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final Integer nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NHEIGHT", precision = 2, scale = 0)
	public Integer getNheight() {
		return this.nheight;
	}

	public void setNheight(final Integer nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NEMPTY", precision = 1, scale = 0)
	public Integer getNempty() {
		return this.nempty;
	}

	public void setNempty(final Integer nempty) {
		this.nempty = nempty;
	}

}
