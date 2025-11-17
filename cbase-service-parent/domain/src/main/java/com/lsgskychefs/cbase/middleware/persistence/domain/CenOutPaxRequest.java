package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 03.01.2023 14:13:55 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_OUT_PAX_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PAX_REQUEST"
)
public class CenOutPaxRequest implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npaxRequestKey;
	private CenOutOrderRequest cenOutOrderRequest;
	private String cclass;
	private int npax;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PAX_REQUEST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PAX_REQUEST", sequenceName = "SEQ_CEN_OUT_PAX_REQUEST", allocationSize = 1)
	@Column(name = "NPAX_REQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpaxRequestKey() {
		return this.npaxRequestKey;
	}

	public void setNpaxRequestKey(long npaxRequestKey) {
		this.npaxRequestKey = npaxRequestKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQUEST_KEY", nullable = false)
	public CenOutOrderRequest getCenOutOrderRequest() {
		return this.cenOutOrderRequest;
	}

	public void setCenOutOrderRequest(CenOutOrderRequest cenOutOrderRequest) {
		this.cenOutOrderRequest = cenOutOrderRequest;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NPAX", nullable = false, precision = 4, scale = 0)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(int npax) {
		this.npax = npax;
	}

}


