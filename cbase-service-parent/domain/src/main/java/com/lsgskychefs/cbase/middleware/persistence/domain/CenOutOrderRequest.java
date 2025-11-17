package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 15.12.2022 09:56:11 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_ORDER_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_ORDER_REQUEST"
)
public class CenOutOrderRequest implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nrequestKey;
	private CenOut cenOut;
	private SysLogin sysLogin;
	private SysOrderRequestStatus sysOrderRequestStatus;
	private long ntransaction;
	private Date dtimestamp;
	private Set<CenOutOrderRequestHistory> cenOutOrderRequestHistories = new HashSet<>(0);
	private Set<CenOutMealRequest> cenOutMealRequests = new HashSet<>(0);
	private Set<CenOutSpmlRequest> cenOutSpmlRequests = new HashSet<>(0);
	private Set<CenOutComponentRequest> cenOutComponentRequests = new HashSet<>(0);
	private Set<CenOutPaxRequest> cenOutPaxRequests = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_ORDER_REQUEST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_ORDER_REQUEST", sequenceName = "SEQ_CEN_OUT_ORDER_REQUEST", allocationSize = 1)
	@Column(name = "NREQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNrequestKey() {
		return this.nrequestKey;
	}

	public void setNrequestKey(long nrequestKey) {
		this.nrequestKey = nrequestKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQUEST_STATUS", nullable = false)
	public SysOrderRequestStatus getSysOrderRequestStatus() {
		return this.sysOrderRequestStatus;
	}

	public void setSysOrderRequestStatus(SysOrderRequestStatus sysOrderRequestStatus) {
		this.sysOrderRequestStatus = sysOrderRequestStatus;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutOrderRequest")
	public Set<CenOutOrderRequestHistory> getCenOutOrderRequestHistories() {
		return this.cenOutOrderRequestHistories;
	}

	public void setCenOutOrderRequestHistories(Set<CenOutOrderRequestHistory> cenOutOrderRequestHistories) {
		this.cenOutOrderRequestHistories = cenOutOrderRequestHistories;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutOrderRequest")
	public Set<CenOutMealRequest> getCenOutMealRequests() {
		return this.cenOutMealRequests;
	}

	public void setCenOutMealRequests(Set<CenOutMealRequest> cenOutMealRequests) {
		this.cenOutMealRequests = cenOutMealRequests;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutOrderRequest")
	public Set<CenOutSpmlRequest> getCenOutSpmlRequests() {
		return this.cenOutSpmlRequests;
	}

	public void setCenOutSpmlRequests(Set<CenOutSpmlRequest> cenOutSpmlRequests) {
		this.cenOutSpmlRequests = cenOutSpmlRequests;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutOrderRequest")
	public Set<CenOutComponentRequest> getCenOutComponentRequests() {
		return this.cenOutComponentRequests;
	}

	public void setCenOutComponentRequests(Set<CenOutComponentRequest> cenOutComponentRequests) {
		this.cenOutComponentRequests = cenOutComponentRequests;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutOrderRequest")
	public Set<CenOutPaxRequest> getCenOutPaxRequests() {
		return this.cenOutPaxRequests;
	}

	public void setCenOutPaxRequests(Set<CenOutPaxRequest> cenOutPaxRequests) {
		this.cenOutPaxRequests = cenOutPaxRequests;
	}
}


