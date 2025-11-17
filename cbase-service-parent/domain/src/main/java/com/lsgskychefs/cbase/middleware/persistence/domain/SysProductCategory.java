package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 12, 2019 4:50:07 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_PRODUCT_CATEGORY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PRODUCT_CATEGORY")
public class SysProductCategory implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nprodCategoryKey;
	private String csapCode;
	private String ctext;
	private String ctext1;
	private String ctext2;
	private String ctext3;
	private String ctext4;

	@Id
	@Column(name = "NPROD_CATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprodCategoryKey() {
		return this.nprodCategoryKey;
	}

	public void setNprodCategoryKey(final long nprodCategoryKey) {
		this.nprodCategoryKey = nprodCategoryKey;
	}

	@Column(name = "CSAP_CODE", nullable = false, length = 1)
	public String getCsapCode() {
		return this.csapCode;
	}

	public void setCsapCode(final String csapCode) {
		this.csapCode = csapCode;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT1", length = 40)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", length = 40)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 40)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", length = 40)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

}
