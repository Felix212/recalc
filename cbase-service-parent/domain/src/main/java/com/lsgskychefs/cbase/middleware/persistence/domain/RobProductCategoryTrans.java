package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table ROB_PRODUCT_CATEGORY_TRANS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_PRODUCT_CATEGORY_TRANS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobProductCategoryTrans implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nproductCategoryTransKey;

	private RobLanguage robLanguage;

	private RobProductCategory robProductCategory;

	private String ccategory;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_PRODUCT_CATEGORY_TRANS")
	@SequenceGenerator(name = "SEQ_ROB_PRODUCT_CATEGORY_TRANS", sequenceName = "SEQ_ROB_PRODUCT_CATEGORY_TRANS", allocationSize = 1)
	@Column(name = "NPRODUCT_CATEGORY_TRANS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNproductCategoryTransKey() {
		return this.nproductCategoryTransKey;
	}

	public void setNproductCategoryTransKey(final long nproductCategoryTransKey) {
		this.nproductCategoryTransKey = nproductCategoryTransKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLANGUAGE", nullable = false)
	public RobLanguage getRobLanguage() {
		return this.robLanguage;
	}

	public void setRobLanguage(final RobLanguage robLanguage) {
		this.robLanguage = robLanguage;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRODUCT_CATEGORY_KEY", nullable = false)
	@JsonIgnore
	public RobProductCategory getRobProductCategory() {
		return this.robProductCategory;
	}

	public void setRobProductCategory(final RobProductCategory robProductCategory) {
		this.robProductCategory = robProductCategory;
	}

	@Column(name = "CCATEGORY", nullable = false, length = 256)
	public String getCcategory() {
		return this.ccategory;
	}

	public void setCcategory(final String ccategory) {
		this.ccategory = ccategory;
	}

}
