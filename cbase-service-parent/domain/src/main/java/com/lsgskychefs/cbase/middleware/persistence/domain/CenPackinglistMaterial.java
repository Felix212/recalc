package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.06.2025 12:20:48 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_MATERIAL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_MATERIAL"
)
public class CenPackinglistMaterial implements DomainObject, java.io.Serializable {

	private CenPackinglistsId id;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private long nproductIndexKey;
	private long nmaterialIndexKey;
	private Long nsapKindKey;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

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

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@Column(name = "NPRODUCT_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNproductIndexKey() {
		return this.nproductIndexKey;
	}

	public void setNproductIndexKey(long nproductIndexKey) {
		this.nproductIndexKey = nproductIndexKey;
	}

	@Column(name = "NMATERIAL_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNmaterialIndexKey() {
		return this.nmaterialIndexKey;
	}

	public void setNmaterialIndexKey(long nmaterialIndexKey) {
		this.nmaterialIndexKey = nmaterialIndexKey;
	}

	@Column(name = "NSAP_KIND_KEY", precision = 12, scale = 0)
	public Long getNsapKindKey() {
		return this.nsapKindKey;
	}

	public void setNsapKindKey(Long nsapKindKey) {
		this.nsapKindKey = nsapKindKey;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

}


