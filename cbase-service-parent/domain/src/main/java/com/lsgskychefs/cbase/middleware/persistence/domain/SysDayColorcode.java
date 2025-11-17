package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.06.2017 12:12:34 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_DAY_COLORCODE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_DAY_COLORCODE")
public class SysDayColorcode implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncolorcodeKey;

	@JsonIgnore
	private SysUnits sysUnits;

	private int nday;

	private String cday;

	private int nred;

	private int ngreen;

	private int nblue;

	private Long ncolorcodeMs;

	private Long ncolorcode;

	private String ccolorcodeHex;

	private String ccolorText;

	private Integer ntextcolor;

	@Id
	@Column(name = "NCOLORCODE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcolorcodeKey() {
		return this.ncolorcodeKey;
	}

	public void setNcolorcodeKey(final long ncolorcodeKey) {
		this.ncolorcodeKey = ncolorcodeKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "NDAY", unique = true, nullable = false, precision = 1, scale = 0)
	public int getNday() {
		return this.nday;
	}

	public void setNday(final int nday) {
		this.nday = nday;
	}

	@Column(name = "CDAY", nullable = false, length = 10)
	public String getCday() {
		return this.cday;
	}

	public void setCday(final String cday) {
		this.cday = cday;
	}

	@Column(name = "NRED", nullable = false, precision = 3, scale = 0)
	public int getNred() {
		return this.nred;
	}

	public void setNred(final int nred) {
		this.nred = nred;
	}

	@Column(name = "NGREEN", nullable = false, precision = 3, scale = 0)
	public int getNgreen() {
		return this.ngreen;
	}

	public void setNgreen(final int ngreen) {
		this.ngreen = ngreen;
	}

	@Column(name = "NBLUE", nullable = false, precision = 3, scale = 0)
	public int getNblue() {
		return this.nblue;
	}

	public void setNblue(final int nblue) {
		this.nblue = nblue;
	}

	@Column(name = "NCOLORCODE_MS", precision = 12, scale = 0)
	public Long getNcolorcodeMs() {
		return this.ncolorcodeMs;
	}

	public void setNcolorcodeMs(final Long ncolorcodeMs) {
		this.ncolorcodeMs = ncolorcodeMs;
	}

	@Column(name = "NCOLORCODE", precision = 12, scale = 0)
	public Long getNcolorcode() {
		return this.ncolorcode;
	}

	public void setNcolorcode(final Long ncolorcode) {
		this.ncolorcode = ncolorcode;
	}

	@Column(name = "CCOLORCODE_HEX", length = 6)
	public String getCcolorcodeHex() {
		return this.ccolorcodeHex;
	}

	public void setCcolorcodeHex(final String ccolorcodeHex) {
		this.ccolorcodeHex = ccolorcodeHex;
	}

	@Column(name = "CCOLOR_TEXT", length = 20)
	public String getCcolorText() {
		return this.ccolorText;
	}

	public void setCcolorText(final String ccolorText) {
		this.ccolorText = ccolorText;
	}

	@Column(name = "NTEXTCOLOR", precision = 1, scale = 0)
	public Integer getNtextcolor() {
		return this.ntextcolor;
	}

	public void setNtextcolor(final Integer ntextcolor) {
		this.ntextcolor = ntextcolor;
	}

}
