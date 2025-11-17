package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.06.2016 20:40:32 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_EU_ITEMS_ALG
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EU_ITEMS_ALG")
public class CenEuItemsAlg implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenEuItemsAlgId id;
	private SysEuAllergens sysEuAllergens;
	private CenEuItems cenEuItems;
	private int nstatus;
	private Date dtimestamp;

	public CenEuItemsAlg() {
	}

	public CenEuItemsAlg(final CenEuItemsAlgId id, final SysEuAllergens sysEuAllergens, final CenEuItems cenEuItems, final int nstatus,
			final Date dtimestamp) {
		this.id = id;
		this.sysEuAllergens = sysEuAllergens;
		this.cenEuItems = cenEuItems;
		this.nstatus = nstatus;
		this.dtimestamp = dtimestamp;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "neuItemKey", column = @Column(name = "NEU_ITEM_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "neuAllgKey", column = @Column(name = "NEU_ALLG_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenEuItemsAlgId getId() {
		return this.id;
	}

	public void setId(final CenEuItemsAlgId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_ALLG_KEY", nullable = false, insertable = false, updatable = false)
	public SysEuAllergens getSysEuAllergens() {
		return this.sysEuAllergens;
	}

	public void setSysEuAllergens(final SysEuAllergens sysEuAllergens) {
		this.sysEuAllergens = sysEuAllergens;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_ITEM_KEY", nullable = false, insertable = false, updatable = false)
	public CenEuItems getCenEuItems() {
		return this.cenEuItems;
	}

	public void setCenEuItems(final CenEuItems cenEuItems) {
		this.cenEuItems = cenEuItems;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
