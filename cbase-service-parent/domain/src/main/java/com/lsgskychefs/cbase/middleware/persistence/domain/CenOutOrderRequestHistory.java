package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 15.12.2022 09:56:11 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_ORDER_REQUEST_HISTORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_ORDER_REQUEST_HISTORY")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "order-request-history.fetchall", attributeNodes = {
				@NamedAttributeNode(value = "sysOrderRequestStatus"),
				@NamedAttributeNode(value = "cenOutOrderRequest"),
				@NamedAttributeNode(value = "sysLogin"),
				@NamedAttributeNode(value = "cenOut", subgraph = "cenout.lazy")
		}, subgraphs = {
				@NamedSubgraph(name = "cenout.lazy", attributeNodes = {
						@NamedAttributeNode(value = "cenOutComment"),
						@NamedAttributeNode(value = "cenOutText")
				})
		})
})
public class CenOutOrderRequestHistory implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhistoryKey;
	private CenOut cenOut;
	private SysLogin sysLogin;
	private SysOrderRequestStatus sysOrderRequestStatus;
	private CenOutOrderRequest cenOutOrderRequest;
	private long ntransaction;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_ORDER_REQUEST_HISTORY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_ORDER_REQUEST_HISTORY", sequenceName = "SEQ_CEN_OUT_ORDER_REQUEST_HISTORY", allocationSize = 1)
	@Column(name = "NHISTORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhistoryKey() {
		return this.nhistoryKey;
	}

	public void setNhistoryKey(long nhistoryKey) {
		this.nhistoryKey = nhistoryKey;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQUEST_KEY", nullable = false)
	public CenOutOrderRequest getCenOutOrderRequest() {
		return this.cenOutOrderRequest;
	}

	public void setCenOutOrderRequest(CenOutOrderRequest cenOutOrderRequest) {
		this.cenOutOrderRequest = cenOutOrderRequest;
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
}


