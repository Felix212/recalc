package com.lsgskychefs.cbase.middleware.persistence.domain;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_REQUEST_OUT_PAX
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REQUEST_OUT_PAX")
public class CenRequestOutPax
		implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	private CenRequestOutPaxId id;
	private CenRequestOut cenRequestOut;
	private String cclass;
	private int nfunction;
	private int npax;
	private String ccomment;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "njobNr", column = @Column(name = "NJOB_NR", nullable = false, precision = 12)),
			@AttributeOverride(name = "nclassNumber", column = @Column(name = "NCLASS_NUMBER", nullable = false, precision = 6)) })
	public CenRequestOutPaxId getId() {
		return this.id;
	}

	public void setId(final CenRequestOutPaxId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "NJOB_NR", nullable = false, insertable = false, updatable = false)
	public CenRequestOut getCenRequestOut() {
		return this.cenRequestOut;
	}

	public void setCenRequestOut(final CenRequestOut cenRequestOut) {
		this.cenRequestOut = cenRequestOut;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NFUNCTION", nullable = false, precision = 1)
	public int getNfunction() {
		return this.nfunction;
	}

	public void setNfunction(final int nfunction) {
		this.nfunction = nfunction;
	}

	@Column(name = "NPAX", nullable = false, precision = 4)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(final int npax) {
		this.npax = npax;
	}

	@Column(name = "CCOMMENT", length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

}
