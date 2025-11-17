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
 * Entity(DomainObject) for table ROB_PRODUCT_TRANS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_PRODUCT_TRANS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobProductTrans implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nproductTransKey;

	private RobLanguage robLanguage;

	private RobProduct robProduct;

	private String cname;

	private String cdescription;

	private String callergenInfo;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_PRODUCT_TRANS")
	@SequenceGenerator(name = "SEQ_ROB_PRODUCT_TRANS", sequenceName = "SEQ_ROB_PRODUCT_TRANS", allocationSize = 1)
	@Column(name = "NPRODUCT_TRANS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNproductTransKey() {
		return this.nproductTransKey;
	}

	public void setNproductTransKey(final long nproductTransKey) {
		this.nproductTransKey = nproductTransKey;
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
	@JoinColumn(name = "NPRODUCT_KEY", nullable = false)
	@JsonIgnore
	public RobProduct getRobProduct() {
		return this.robProduct;
	}

	public void setRobProduct(final RobProduct robProduct) {
		this.robProduct = robProduct;
	}

	@Column(name = "CNAME", nullable = false, length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 2048)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CALLERGEN_INFO", length = 2048)
	public String getCallergenInfo() {
		return this.callergenInfo;
	}

	public void setCallergenInfo(final String callergenInfo) {
		this.callergenInfo = callergenInfo;
	}

}
