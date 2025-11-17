package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jun 27, 2019 5:39:03 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_PL_SUBST_REASON
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PL_SUBST_REASON")
public class SysPlSubstReason implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long pkey;
	private String csort;
	private String ctext;
	private String ctext1;
	private String ctext2;
	private String ctext3;
	private String ctext4;
	private String cclient;
	private int nactive;

	@Id
	@Column(name = "PKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getPkey() {
		return this.pkey;
	}

	public void setPkey(final long pkey) {
		this.pkey = pkey;
	}

	@Column(name = "CSORT", nullable = false, length = 2)
	public String getCsort() {
		return this.csort;
	}

	public void setCsort(final String csort) {
		this.csort = csort;
	}

	@Column(name = "CTEXT", nullable = false, length = 82)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT1", nullable = false, length = 82)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", nullable = false, length = 82)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", nullable = false, length = 82)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", nullable = false, length = 82)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NACTIVE", nullable = false, precision = 1, scale = 0)
	public int getNactive() {
		return this.nactive;
	}

	public void setNactive(final int nactive) {
		this.nactive = nactive;
	}

}
