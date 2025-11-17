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
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_EU_PICTURES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EU_PICTURES")
public class CenEuPictures implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenEuPicturesId id;
	private SysEuRegions sysEuRegions;
	private Date dvalidTo;
	private byte[] bpicture;
	private String cpictureName;
	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "neuRegionKey",
					column = @Column(name = "NEU_REGION_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cpackinglist", column = @Column(name = "CPACKINGLIST", nullable = false, length = 18)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)) })
	public CenEuPicturesId getId() {
		return this.id;
	}

	public void setId(final CenEuPicturesId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_REGION_KEY", nullable = false, insertable = false, updatable = false)
	public SysEuRegions getSysEuRegions() {
		return this.sysEuRegions;
	}

	public void setSysEuRegions(final SysEuRegions sysEuRegions) {
		this.sysEuRegions = sysEuRegions;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@Column(name = "CPICTURE_NAME", length = 100)
	public String getCpictureName() {
		return this.cpictureName;
	}

	public void setCpictureName(final String cpictureName) {
		this.cpictureName = cpictureName;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
