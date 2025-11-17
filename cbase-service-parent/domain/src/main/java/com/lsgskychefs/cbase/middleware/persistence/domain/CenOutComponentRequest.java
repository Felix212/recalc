package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 16.02.2023 12:57:47 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_OUT_COMPONENT_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_COMPONENT_REQUEST"
)
public class CenOutComponentRequest implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long ncomponentRequestKey;
	private CenOutOrderRequest cenOutOrderRequest;
	private long nhandlingKey;
	private String cclass;
	private String ctext;
	private String ccomment;
	private String cmealControlCode;
	private int nmoduleType;
	private Set<CenOutMealRequest> cenOutMealRequests = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_COMPONENT_REQUEST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_COMPONENT_REQUEST", sequenceName = "SEQ_CEN_OUT_COMPONENT_REQUEST", allocationSize = 1)
	@Column(name = "NCOMPONENT_REQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcomponentRequestKey() {
		return this.ncomponentRequestKey;
	}

	public void setNcomponentRequestKey(long ncomponentRequestKey) {
		this.ncomponentRequestKey = ncomponentRequestKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQUEST_KEY", nullable = false)
	public CenOutOrderRequest getCenOutOrderRequest() {
		return this.cenOutOrderRequest;
	}

	public void setCenOutOrderRequest(CenOutOrderRequest cenOutOrderRequest) {
		this.cenOutOrderRequest = cenOutOrderRequest;
	}

	@Column(name = "NHANDLING_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CTEXT", nullable = false, length = 30)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CCOMMENT", nullable = false, length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NMODULE_TYPE", nullable = false, precision = 2, scale = 0)
	public int getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(int nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutComponentRequest")
	public Set<CenOutMealRequest> getCenOutMealRequests() {
		return this.cenOutMealRequests;
	}

	public void setCenOutMealRequests(Set<CenOutMealRequest> cenOutMealRequests) {
		this.cenOutMealRequests = cenOutMealRequests;
	}
}


