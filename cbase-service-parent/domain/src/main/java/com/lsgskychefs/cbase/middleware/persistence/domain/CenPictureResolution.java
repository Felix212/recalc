package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.06.2017 08:12:25 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_PICTURE_RESOLUTION
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PICTURE_RESOLUTION")
public class CenPictureResolution implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPictureResolutionId id;
	private CenPictures cenPictures;
	private Integer nheight;
	private Integer nwidth;
	private byte[] bpicture;
	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npictureIndexKey", column = @Column(name = "NPICTURE_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nresolution", column = @Column(name = "NRESOLUTION", nullable = false, precision = 2, scale = 0)) })
	public CenPictureResolutionId getId() {
		return this.id;
	}

	public void setId(final CenPictureResolutionId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPICTURE_INDEX_KEY", nullable = false, insertable = false, updatable = false)
	public CenPictures getCenPictures() {
		return this.cenPictures;
	}

	public void setCenPictures(final CenPictures cenPictures) {
		this.cenPictures = cenPictures;
	}

	@Column(name = "NHEIGHT", precision = 6, scale = 0)
	public Integer getNheight() {
		return this.nheight;
	}

	public void setNheight(final Integer nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", precision = 6, scale = 0)
	public Integer getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final Integer nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
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
