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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table ROB_PRODUCT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_PRODUCT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobProduct implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nproductKey;

	private RobProductCategory robProductCategory;

	private String cname = "";

	private String cdescription = "";

	private String callergenInfo = "";

	private byte[] bpicture;

	private Set<RobProductTrans> robProductTranses = new HashSet<>(0);

	private Set<RobOrder> robOrders = new HashSet<>(0);

	private Set<RobEventProduct> robEventProducts = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_PRODUCT")
	@SequenceGenerator(name = "SEQ_ROB_PRODUCT", sequenceName = "SEQ_ROB_PRODUCT", allocationSize = 1)
	@Column(name = "NPRODUCT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNproductKey() {
		return this.nproductKey;
	}

	public void setNproductKey(final long nproductKey) {
		this.nproductKey = nproductKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRODUCT_CATEGORY_KEY", nullable = false)
	public RobProductCategory getRobProductCategory() {
		return this.robProductCategory;
	}

	public void setRobProductCategory(final RobProductCategory robProductCategory) {
		this.robProductCategory = robProductCategory;
	}

	@Column(name = "BPICTURE")
	@JsonView(View.SimpleWithReferences.class)
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robProduct")
	@JsonView(View.SimpleWithReferences.class)
	public Set<RobProductTrans> getRobProductTranses() {
		return this.robProductTranses;
	}

	public void setRobProductTranses(final Set<RobProductTrans> robProductTranses) {
		this.robProductTranses = robProductTranses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robProduct")
	@JsonIgnore
	public Set<RobOrder> getRobOrders() {
		return this.robOrders;
	}

	public void setRobOrders(final Set<RobOrder> robOrders) {
		this.robOrders = robOrders;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robProduct")
	@JsonIgnore
	public Set<RobEventProduct> getRobEventProducts() {
		return this.robEventProducts;
	}

	public void setRobEventProducts(final Set<RobEventProduct> robEventProducts) {
		this.robEventProducts = robEventProducts;
	}

	/**
	 * Get cname (from translation table)
	 *
	 * @return the cname
	 */
	@Transient
	public String getCname() {
		return cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	/**
	 * Get cdescription (from translation table)
	 *
	 * @return the cdescription
	 */
	@Transient
	public String getCdescription() {
		return cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	/**
	 * Get callergenInfo (from translation table)
	 *
	 * @return the callergenInfo
	 */
	@Transient
	public String getCallergenInfo() {
		return callergenInfo;
	}

	public void setCallergenInfo(final String callergenInfo) {
		this.callergenInfo = callergenInfo;
	}
}
