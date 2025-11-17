package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table ROB_PRODUCT_CATEGORY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_PRODUCT_CATEGORY")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobProductCategory implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nproductCategoryKey;

	private int nsort;

	private String ccategory;

	private Set<RobProductCategoryTrans> robProductCategoryTranses = new HashSet<>(0);

	private Set<RobProduct> robProducts = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_PRODUCT_CATEGORY")
	@SequenceGenerator(name = "SEQ_ROB_PRODUCT_CATEGORY", sequenceName = "SEQ_ROB_PRODUCT_CATEGORY", allocationSize = 1)
	@Column(name = "NPRODUCT_CATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNproductCategoryKey() {
		return this.nproductCategoryKey;
	}

	public void setNproductCategoryKey(final long nproductCategoryKey) {
		this.nproductCategoryKey = nproductCategoryKey;
	}

	@Column(name = "NSORT", nullable = false, precision = 2, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robProductCategory")
	@JsonView(View.SimpleWithReferences.class)
	public Set<RobProductCategoryTrans> getRobProductCategoryTranses() {
		return this.robProductCategoryTranses;
	}

	public void setRobProductCategoryTranses(final Set<RobProductCategoryTrans> robProductCategoryTranses) {
		this.robProductCategoryTranses = robProductCategoryTranses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robProductCategory")
	@JsonIgnore
	public Set<RobProduct> getRobProducts() {
		return this.robProducts;
	}

	public void setRobProducts(final Set<RobProduct> robProducts) {
		this.robProducts = robProducts;
	}

	/**
	 * Get ccategory (from translation table)
	 *
	 * @return the ccategory
	 */
	@Transient
	public String getCcategory() {
		return ccategory;
	}

	public void setCcategory(final String ccategory) {
		this.ccategory = ccategory;
	}
}
