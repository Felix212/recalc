package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.09.2019 14:11:29 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_ADD_DELIVERY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_ADD_DELIVERY")
public class CenOutAddDelivery implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndetailKey;

	private CenOut cenOut;

	private long npackinglistIndexKey;

	private long npackinglistDetailKey;

	private String cpackinglist;

	private int nonReqQuantity;

	private int nerrorQuantity;

	private String cremark;

	private long nsort;

	private Date dtimestamp;

	private Integer ntotalQuantity;

	private Integer nbilling;

	private Long ntransaction;

	private Integer ntransfer;

	private String caddOnText;

	private Integer nmiscQuantity;

	private Integer nautoprocess;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_ADD_DELIVERY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_ADD_DELIVERY", sequenceName = "SEQ_CEN_OUT_ADD_DELIVERY", allocationSize = 1)
	@Column(name = "NDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NON_REQ_QUANTITY", nullable = false, precision = 6, scale = 0)
	public int getNonReqQuantity() {
		return this.nonReqQuantity;
	}

	public void setNonReqQuantity(final int nonReqQuantity) {
		this.nonReqQuantity = nonReqQuantity;
	}

	@Column(name = "NERROR_QUANTITY", nullable = false, precision = 6, scale = 0)
	public int getNerrorQuantity() {
		return this.nerrorQuantity;
	}

	public void setNerrorQuantity(final int nerrorQuantity) {
		this.nerrorQuantity = nerrorQuantity;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NSORT", nullable = false, precision = 12, scale = 0)
	public long getNsort() {
		return this.nsort;
	}

	public void setNsort(final long nsort) {
		this.nsort = nsort;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NTOTAL_QUANTITY", precision = 6, scale = 0)
	public Integer getNtotalQuantity() {
		return this.ntotalQuantity;
	}

	public void setNtotalQuantity(final Integer ntotalQuantity) {
		this.ntotalQuantity = ntotalQuantity;
	}

	@Column(name = "NBILLING", precision = 1, scale = 0)
	public Integer getNbilling() {
		return this.nbilling;
	}

	public void setNbilling(final Integer nbilling) {
		this.nbilling = nbilling;
	}

	@Column(name = "NTRANSACTION", precision = 12, scale = 0)
	public Long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NTRANSFER", precision = 1, scale = 0)
	public Integer getNtransfer() {
		return this.ntransfer;
	}

	public void setNtransfer(final Integer ntransfer) {
		this.ntransfer = ntransfer;
	}

	@Column(name = "CADD_ON_TEXT", length = 40)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "NMISC_QUANTITY", precision = 6, scale = 0)
	public Integer getNmiscQuantity() {
		return this.nmiscQuantity;
	}

	public void setNmiscQuantity(final Integer nmiscQuantity) {
		this.nmiscQuantity = nmiscQuantity;
	}

	@Column(name = "NAUTOPROCESS", precision = 1, scale = 0)
	public Integer getNautoprocess() {
		return this.nautoprocess;
	}

	public void setNautoprocess(final Integer nautoprocess) {
		this.nautoprocess = nautoprocess;
	}

}
