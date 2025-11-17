package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 1, 2025 12:03:08 PM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_MP_DESIGN_ITEMLIST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_DESIGN_ITEMLIST"
)
public class CenMpDesignItemlist implements DomainObject, java.io.Serializable {

	private CenPackinglistsId id;
	@JsonIgnore
	// FkCenPackinglistMp1
	private CenPackinglists cenPackinglists;
	// FkCenPackinglistMp2
	private CenPackinglists cenPackinglistsCopyFrom;

	private SysMpDesignItemlistStatus sysMpDesignItemlistStatus;

	private Date dupdatedDate;

	private String cupdatedBy;

	public CenMpDesignItemlist() {
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPackinglistsId getId() {
		return this.id;
	}

	public void setId(CenPackinglistsId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglistsByFkCenPackinglistMp1) {
		this.cenPackinglists = cenPackinglistsByFkCenPackinglistMp1;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NCOPIED_FROM_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NCOPIED_FROM_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglistsCopyFrom() {
		return this.cenPackinglistsCopyFrom;
	}

	public void setCenPackinglistsCopyFrom(CenPackinglists cenPackinglistsByFkCenPackinglistMp2) {
		this.cenPackinglistsCopyFrom = cenPackinglistsByFkCenPackinglistMp2;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDESIGN_ITEMLIST_STATUS_KEY")
	public SysMpDesignItemlistStatus getSysMpDesignItemlistStatus() {
		return sysMpDesignItemlistStatus;
	}

	public void setSysMpDesignItemlistStatus(SysMpDesignItemlistStatus sysMpDesignItemlistStatus) {
		this.sysMpDesignItemlistStatus = sysMpDesignItemlistStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

}


