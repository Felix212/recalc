package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.11.2021 13:40:52 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_EU_ALG
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_EU_ALG")
public class CenPackinglistEuAlg implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPackinglistEuAlgId id;
	private SysEuAllergens sysEuAllergens;
	/** Back reference */
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private int nstatus;
	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "neuAllgKey", column = @Column(name = "NEU_ALLG_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "neuRegionKey", column = @Column(name = "NEU_REGION_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPackinglistEuAlgId getId() {
		return this.id;
	}

	public void setId(CenPackinglistEuAlgId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_ALLG_KEY", nullable = false, insertable = false, updatable = false)
	public SysEuAllergens getSysEuAllergens() {
		return this.sysEuAllergens;
	}

	public void setSysEuAllergens(SysEuAllergens sysEuAllergens) {
		this.sysEuAllergens = sysEuAllergens;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false, insertable = false, updatable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(int nstatus) {
		this.nstatus = nstatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
