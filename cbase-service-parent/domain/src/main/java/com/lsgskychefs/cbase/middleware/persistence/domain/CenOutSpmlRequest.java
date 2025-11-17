package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13.12.2022 14:30:50 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.math.BigDecimal;
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
 * Entity(DomainObject) for table CEN_OUT_SPML_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SPML_REQUEST"
)
public class CenOutSpmlRequest implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nspmlRequestKey;
	private CenOutOrderRequest cenOutOrderRequest;
	private long nspmlKey;
	private String cclass;
	private String cspml;
	private String ccomment;
	private String cname;
	private BigDecimal nquantity;
	private long nmasterKey;

	private Set<CenOutMealRequest> cenOutMealRequests = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_SPML_REQUEST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_SPML_REQUEST", sequenceName = "SEQ_CEN_OUT_SPML_REQUEST", allocationSize = 1)
	@Column(name = "NSPML_REQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNspmlRequestKey() {
		return this.nspmlRequestKey;
	}

	public void setNspmlRequestKey(long nspmlRequestKey) {
		this.nspmlRequestKey = nspmlRequestKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQUEST_KEY", nullable = false)
	public CenOutOrderRequest getCenOutOrderRequest() {
		return this.cenOutOrderRequest;
	}

	public void setCenOutOrderRequest(CenOutOrderRequest cenOutOrderRequest) {
		this.cenOutOrderRequest = cenOutOrderRequest;
	}

	@Column(name = "NSPML_KEY", nullable = false, precision = 12, scale = 0)
	public long getNspmlKey() {
		return this.nspmlKey;
	}

	public void setNspmlKey(long nspmlKey) {
		this.nspmlKey = nspmlKey;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CSPML", nullable = false, length = 10)
	public String getCspml() {
		return this.cspml;
	}

	public void setCspml(String cspml) {
		this.cspml = cspml;
	}

	@Column(name = "CCOMMENT", nullable = false, length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NMASTER_KEY", nullable = false, precision = 12, scale = 0, columnDefinition = "NUMBER(12) DEFAULT 0")
	public long getNmasterKey() {
		return this.nmasterKey;
	}

	public void setNmasterKey(long nmasterKey) {
		this.nmasterKey = nmasterKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutSpmlRequest")
	public Set<CenOutMealRequest> getCenOutMealRequests() {
		return this.cenOutMealRequests;
	}

	public void setCenOutMealRequests(Set<CenOutMealRequest> cenOutMealRequests) {
		this.cenOutMealRequests = cenOutMealRequests;
	}

}


