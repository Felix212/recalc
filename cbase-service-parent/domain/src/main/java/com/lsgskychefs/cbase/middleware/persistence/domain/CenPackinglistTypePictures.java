package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 26.01.2024 09:54:36 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_TYPE_PICTURES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_TYPE_PICTURES"
)
public class CenPackinglistTypePictures implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long npackinglistKey;
	private CenPackinglistTypes cenPackinglistTypes;
	private CenPictures cenPictures;
	private String cupdatedBy;
	private Date dupdatedDate;

	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "cenPackinglistTypes"))
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "NPACKINGLIST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenPackinglistTypes getCenPackinglistTypes() {
		return this.cenPackinglistTypes;
	}

	public void setCenPackinglistTypes(CenPackinglistTypes cenPackinglistTypes) {
		this.cenPackinglistTypes = cenPackinglistTypes;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPICTURE_INDEX_KEY", nullable = false)
	public CenPictures getCenPictures() {
		return this.cenPictures;
	}

	public void setCenPictures(CenPictures cenPictures) {
		this.cenPictures = cenPictures;
	}

	@Column(name = "CUPDATED_BY", nullable = false, length = 40)
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

}


