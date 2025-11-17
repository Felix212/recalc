package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_LOGOS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGOS")
public class SysLogos implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nlogoKey;
	private String cname;
	private String ccolorLogo;
	private String cblackLogo;
	private Set<SysLogosPictures> sysLogosPictureses = new HashSet<>(0);

	public SysLogos() {
	}

	public SysLogos(final long nlogoKey, final String cname, final String ccolorLogo, final String cblackLogo) {
		this.nlogoKey = nlogoKey;
		this.cname = cname;
		this.ccolorLogo = ccolorLogo;
		this.cblackLogo = cblackLogo;
	}

	public SysLogos(final long nlogoKey, final String cname, final String ccolorLogo, final String cblackLogo,
			final Set<SysLogosPictures> sysLogosPictureses) {
		this.nlogoKey = nlogoKey;
		this.cname = cname;
		this.ccolorLogo = ccolorLogo;
		this.cblackLogo = cblackLogo;
		this.sysLogosPictureses = sysLogosPictureses;
	}

	@Id

	@Column(name = "NLOGO_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlogoKey() {
		return this.nlogoKey;
	}

	public void setNlogoKey(final long nlogoKey) {
		this.nlogoKey = nlogoKey;
	}

	@Column(name = "CNAME", nullable = false, length = 20)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CCOLOR_LOGO", nullable = false, length = 128)
	public String getCcolorLogo() {
		return this.ccolorLogo;
	}

	public void setCcolorLogo(final String ccolorLogo) {
		this.ccolorLogo = ccolorLogo;
	}

	@Column(name = "CBLACK_LOGO", nullable = false, length = 128)
	public String getCblackLogo() {
		return this.cblackLogo;
	}

	public void setCblackLogo(final String cblackLogo) {
		this.cblackLogo = cblackLogo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLogos")
	public Set<SysLogosPictures> getSysLogosPictureses() {
		return this.sysLogosPictureses;
	}

	public void setSysLogosPictureses(final Set<SysLogosPictures> sysLogosPictureses) {
		this.sysLogosPictureses = sysLogosPictureses;
	}

}
