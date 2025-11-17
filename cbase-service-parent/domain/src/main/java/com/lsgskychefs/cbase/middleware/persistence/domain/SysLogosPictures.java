package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_LOGOS_PICTURES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGOS_PICTURES")
public class SysLogosPictures implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private SysLogosPicturesId id;
	private SysLogos sysLogos;
	private byte[] bpicture;

	public SysLogosPictures() {
	}

	public SysLogosPictures(final SysLogosPicturesId id, final SysLogos sysLogos) {
		this.id = id;
		this.sysLogos = sysLogos;
	}

	public SysLogosPictures(final SysLogosPicturesId id, final SysLogos sysLogos, final byte[] bpicture) {
		this.id = id;
		this.sysLogos = sysLogos;
		this.bpicture = bpicture;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nlogoKey", column = @Column(name = "NLOGO_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ncolored", column = @Column(name = "NCOLORED", nullable = false, precision = 1, scale = 0)) })
	public SysLogosPicturesId getId() {
		return this.id;
	}

	public void setId(final SysLogosPicturesId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOGO_KEY", nullable = false, insertable = false, updatable = false)
	public SysLogos getSysLogos() {
		return this.sysLogos;
	}

	public void setSysLogos(final SysLogos sysLogos) {
		this.sysLogos = sysLogos;
	}

	@Lob
	@Column(name = "BPICTURE", length = 10000000)
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

}
