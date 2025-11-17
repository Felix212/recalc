package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.06.2016 20:40:32 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_EU_ITEMS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EU_ITEMS")
public class CenEuItems implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long neuItemKey;
	private SysEuRegions sysEuRegions;
	private String citem;
	private String ctext;
	private String ctextLoc;
	private int nalgRelv;
	private int nalgAppr;
	private Date dtimestamp;
	private String citemExt;
	private Set<CenEuItemsAlg> cenEuItemsAlgs = new HashSet<>(0);

	public CenEuItems() {
	}

	public CenEuItems(final long neuItemKey, final SysEuRegions sysEuRegions, final String citem, final String ctext, final int nalgRelv,
			final int nalgAppr) {
		this.neuItemKey = neuItemKey;
		this.sysEuRegions = sysEuRegions;
		this.citem = citem;
		this.ctext = ctext;
		this.nalgRelv = nalgRelv;
		this.nalgAppr = nalgAppr;
	}

	public CenEuItems(final long neuItemKey, final SysEuRegions sysEuRegions, final String citem, final String ctext, final String ctextLoc,
			final int nalgRelv, final int nalgAppr, final Date dtimestamp, final String citemExt, final Set<CenEuItemsAlg> cenEuItemsAlgs) {
		this.neuItemKey = neuItemKey;
		this.sysEuRegions = sysEuRegions;
		this.citem = citem;
		this.ctext = ctext;
		this.ctextLoc = ctextLoc;
		this.nalgRelv = nalgRelv;
		this.nalgAppr = nalgAppr;
		this.dtimestamp = dtimestamp;
		this.citemExt = citemExt;
		this.cenEuItemsAlgs = cenEuItemsAlgs;
	}

	@Id

	@Column(name = "NEU_ITEM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuItemKey() {
		return this.neuItemKey;
	}

	public void setNeuItemKey(final long neuItemKey) {
		this.neuItemKey = neuItemKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_REGION_KEY", nullable = false)
	public SysEuRegions getSysEuRegions() {
		return this.sysEuRegions;
	}

	public void setSysEuRegions(final SysEuRegions sysEuRegions) {
		this.sysEuRegions = sysEuRegions;
	}

	@Column(name = "CITEM", nullable = false, length = 18)
	public String getCitem() {
		return this.citem;
	}

	public void setCitem(final String citem) {
		this.citem = citem;
	}

	@Column(name = "CTEXT", nullable = false, length = 50)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT_LOC", length = 50)
	public String getCtextLoc() {
		return this.ctextLoc;
	}

	public void setCtextLoc(final String ctextLoc) {
		this.ctextLoc = ctextLoc;
	}

	@Column(name = "NALG_RELV", nullable = false, precision = 1, scale = 0)
	public int getNalgRelv() {
		return this.nalgRelv;
	}

	public void setNalgRelv(final int nalgRelv) {
		this.nalgRelv = nalgRelv;
	}

	@Column(name = "NALG_APPR", nullable = false, precision = 2, scale = 0)
	public int getNalgAppr() {
		return this.nalgAppr;
	}

	public void setNalgAppr(final int nalgAppr) {
		this.nalgAppr = nalgAppr;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CITEM_EXT", length = 18)
	public String getCitemExt() {
		return this.citemExt;
	}

	public void setCitemExt(final String citemExt) {
		this.citemExt = citemExt;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenEuItems")
	public Set<CenEuItemsAlg> getCenEuItemsAlgs() {
		return this.cenEuItemsAlgs;
	}

	public void setCenEuItemsAlgs(final Set<CenEuItemsAlg> cenEuItemsAlgs) {
		this.cenEuItemsAlgs = cenEuItemsAlgs;
	}

}
