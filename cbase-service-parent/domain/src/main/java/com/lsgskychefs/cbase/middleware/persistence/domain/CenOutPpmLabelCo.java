package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 24, 2018 3:32:21 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_LABEL_CO
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_LABEL_CO")
public class CenOutPpmLabelCo implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmLabelCoId id;
	private CenOutPpmProdLabel cenOutPpmProdLabel;
	private String cpackinglist;
	private Integer nquantity;
	private String cclass;
	private String ctext;
	private boolean hasPpmData;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nppmProdLabelKey", column = @Column(name = "NPPM_PROD_LABEL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nclassNumber", column = @Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmLabelCoId getId() {
		return this.id;
	}

	public void setId(final CenOutPpmLabelCoId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_PROD_LABEL_KEY", nullable = false, insertable = false, updatable = false)
	public CenOutPpmProdLabel getCenOutPpmProdLabel() {
		return this.cenOutPpmProdLabel;
	}

	public void setCenOutPpmProdLabel(final CenOutPpmProdLabel cenOutPpmProdLabel) {
		this.cenOutPpmProdLabel = cenOutPpmProdLabel;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NQUANTITY", precision = 6, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	/**
	 * Get hasPpmData
	 *
	 * @return the hasPpmData
	 */
	@Transient
	public boolean isHasPpmData() {
		return hasPpmData;
	}

	/**
	 * Set hasPpmData
	 * 
	 * @param hasPpmData if this content has data in {@link CenOutPpm}
	 */
	public void setHasPpmData(final boolean hasPpmData) {
		this.hasPpmData = hasPpmData;
	}

}
