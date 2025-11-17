package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_PICTURES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_PICTURES")
public class CenPackinglistPictures implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPackinglistsId id;

	private CenPackinglists cenPackinglists;

	private long npictureIndexKey;

	private String cupdatedBy;

	private Date dupdatedDate;

	private String cupdatedByPrev;

	private Date dupdatedDatePrev;

	private CenPictures cenPictures;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey",
					column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey",
					column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPackinglistsId getId() {
		return this.id;
	}

	public void setId(final CenPackinglistsId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumns({
			@JoinColumn(name = "npackinglistIndexKey", referencedColumnName = "npackinglistIndexKey", insertable = false,
					updatable = false),
			@JoinColumn(name = "npackinglistDetailKey", referencedColumnName = "npackinglistDetailKey", insertable = false,
					updatable = false) })
	// @PrimaryKeyJoinColumns({
	// @PrimaryKeyJoinColumn(name = "npackinglistIndexKey"),
	// @PrimaryKeyJoinColumn(name = "npackinglistDetailKey"),
	// })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@Column(name = "NPICTURE_INDEX_KEY", updatable = false, insertable = false, nullable = false, precision = 12, scale = 0)
	public long getNpictureIndexKey() {
		return this.npictureIndexKey;
	}

	public void setNpictureIndexKey(final long npictureIndexKey) {
		this.npictureIndexKey = npictureIndexKey;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	/** @return the {@link CenPictures} */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPICTURE_INDEX_KEY")
	public CenPictures getCenPictures() {
		return cenPictures;
	}

	/**
	 * @param cenPictures the cenPictures to set
	 */
	public void setCenPictures(final CenPictures cenPictures) {
		this.cenPictures = cenPictures;
	}

}
