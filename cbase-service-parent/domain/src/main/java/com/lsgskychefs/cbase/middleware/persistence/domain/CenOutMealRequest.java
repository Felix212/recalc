package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 16.02.2023 12:57:47 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.math.BigDecimal;

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

/**
 * Entity(DomainObject) for table CEN_OUT_MEAL_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MEAL_REQUEST"
)
public class CenOutMealRequest implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmealRequestKey;
	private CenOutOrderRequest cenOutOrderRequest;
	private CenOutSpmlRequest cenOutSpmlRequest;
	private CenOutComponentRequest cenOutComponentRequest;
	private String cclass;
	private String cpackinglist;
	private String ctext;
	private long npackinglistIndexKey;
	private long npackinglistDetailKey;
	private String ccomment;
	private BigDecimal nquantity;
	private String cmealControlCode;
	private long ncalcId;
	private int nbillingStatus;
	private long ndetailKey;
	private int nmoduleType;
	private Long nhandlingDetailKey;
	private Long nprodCatKey;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_MEAL_REQUEST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_MEAL_REQUEST", sequenceName = "SEQ_CEN_OUT_MEAL_REQUEST", allocationSize = 1)
	@Column(name = "NMEAL_REQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmealRequestKey() {
		return this.nmealRequestKey;
	}

	public void setNmealRequestKey(long nmealRequestKey) {
		this.nmealRequestKey = nmealRequestKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQUEST_KEY", nullable = false)
	public CenOutOrderRequest getCenOutOrderRequest() {
		return this.cenOutOrderRequest;
	}

	public void setCenOutOrderRequest(CenOutOrderRequest cenOutOrderRequest) {
		this.cenOutOrderRequest = cenOutOrderRequest;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSPML_REQUEST_KEY")
	public CenOutSpmlRequest getCenOutSpmlRequest() {
		return this.cenOutSpmlRequest;
	}

	public void setCenOutSpmlRequest(CenOutSpmlRequest cenOutSpmlRequest) {
		this.cenOutSpmlRequest = cenOutSpmlRequest;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCOMPONENT_REQUEST_KEY")
	public CenOutComponentRequest getCenOutComponentRequest() {
		return this.cenOutComponentRequest;
	}

	public void setCenOutComponentRequest(CenOutComponentRequest cenOutComponentRequest) {
		this.cenOutComponentRequest = cenOutComponentRequest;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CCOMMENT", nullable = false, length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4, columnDefinition = "VARCHAR2(4) DEFAULT '1111'")
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NCALC_ID", nullable = false, precision = 12, scale = 0, columnDefinition = "NUMBER(12) DEFAULT 1")
	public long getNcalcId() {
		return this.ncalcId;
	}

	public void setNcalcId(long ncalcId) {
		this.ncalcId = ncalcId;
	}

	@Column(name = "NBILLING_STATUS", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNbillingStatus() {
		return this.nbillingStatus;
	}

	public void setNbillingStatus(int nbillingStatus) {
		this.nbillingStatus = nbillingStatus;
	}

	@Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0, columnDefinition = "NUMBER(12) DEFAULT 0")
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@Column(name = "NMODULE_TYPE", nullable = false, precision = 2, scale = 0, columnDefinition = "NUMBER(2) DEFAULT 0")
	public int getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(int nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NHANDLING_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNhandlingDetailKey() {
		return this.nhandlingDetailKey;
	}

	public void setNhandlingDetailKey(Long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	@Column(name = "NPROD_CAT_KEY", precision = 12, scale = 0)
	public Long getNprodCatKey() {
		return this.nprodCatKey;
	}

	public void setNprodCatKey(Long nprodCatKey) {
		this.nprodCatKey = nprodCatKey;
	}
}


