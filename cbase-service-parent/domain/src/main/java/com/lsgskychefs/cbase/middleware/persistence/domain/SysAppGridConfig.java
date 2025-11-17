package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 26.01.2017 12:03:44 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_APP_GRID_CONFIG
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_APP_GRID_CONFIG")
public class SysAppGridConfig implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long ngridKey;
	private String cprofile;
	private String capp;
	private String cgrid;
	private byte[] bconfig;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_APP_GRID_CONFIG")
	@SequenceGenerator(name = "SEQ_SYS_APP_GRID_CONFIG", sequenceName = "SEQ_SYS_APP_GRID_CONFIG", allocationSize = 1)
	@Column(name = "NGRID_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNgridKey() {
		return this.ngridKey;
	}

	public void setNgridKey(final long ngridKey) {
		this.ngridKey = ngridKey;
	}

	@Column(name = "CPROFILE", nullable = false, length = 40)
	public String getCprofile() {
		return this.cprofile;
	}

	public void setCprofile(final String cprofile) {
		this.cprofile = cprofile;
	}

	@Column(name = "CAPP", nullable = false, length = 40)
	public String getCapp() {
		return this.capp;
	}

	public void setCapp(final String capp) {
		this.capp = capp;
	}

	@Column(name = "CGRID", nullable = false, length = 40)
	public String getCgrid() {
		return this.cgrid;
	}

	public void setCgrid(final String cgrid) {
		this.cgrid = cgrid;
	}

	@Column(name = "BCONFIG")
	public byte[] getBconfig() {
		return this.bconfig;
	}

	public void setBconfig(final byte[] bconfig) {
		this.bconfig = bconfig;
	}

}
