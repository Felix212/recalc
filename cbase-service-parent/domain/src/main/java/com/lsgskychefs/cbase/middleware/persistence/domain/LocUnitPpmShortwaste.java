package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.08.2018 13:53:39 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table LOC_UNIT_PPM_SHORTWASTE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PPM_SHORTWASTE")
public class LocUnitPpmShortwaste implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nshortagewastageKey;
	private String cunit;
	private int nkind;
	private String cswReason;

	@Id
	@Column(name = "NSHORTAGEWASTAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNshortagewastageKey() {
		return this.nshortagewastageKey;
	}

	public void setNshortagewastageKey(final long nshortagewastageKey) {
		this.nshortagewastageKey = nshortagewastageKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NKIND", nullable = false, precision = 1, scale = 0)
	public int getNkind() {
		return this.nkind;
	}

	public void setNkind(final int nkind) {
		this.nkind = nkind;
	}

	@Column(name = "CSW_REASON", nullable = false, length = 50)
	public String getCswReason() {
		return this.cswReason;
	}

	public void setCswReason(final String cswReason) {
		this.cswReason = cswReason;
	}

}
