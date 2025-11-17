package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_QUEUE_BATCH_SUBDETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_BATCH_SUBDETAIL")
public class SysQueueBatchSubdetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private SysQueueBatchSubdetailId id;
	private SysQueueBatch sysQueueBatch;
	private SysQueueBatchDetail sysQueueBatchDetail;
	private Long nsourceKey;
	private String csourceText;
	private Date dsourceDate;
	private BigDecimal nsourceNumber;

	public SysQueueBatchSubdetail() {
	}

	public SysQueueBatchSubdetail(final SysQueueBatchSubdetailId id, final SysQueueBatch sysQueueBatch,
			final SysQueueBatchDetail sysQueueBatchDetail) {
		this.id = id;
		this.sysQueueBatch = sysQueueBatch;
		this.sysQueueBatchDetail = sysQueueBatchDetail;
	}

	public SysQueueBatchSubdetail(final SysQueueBatchSubdetailId id, final SysQueueBatch sysQueueBatch,
			final SysQueueBatchDetail sysQueueBatchDetail, final Long nsourceKey, final String csourceText, final Date dsourceDate,
			final BigDecimal nsourceNumber) {
		this.id = id;
		this.sysQueueBatch = sysQueueBatch;
		this.sysQueueBatchDetail = sysQueueBatchDetail;
		this.nsourceKey = nsourceKey;
		this.csourceText = csourceText;
		this.dsourceDate = dsourceDate;
		this.nsourceNumber = nsourceNumber;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "ndetailKey", column = @Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nlfdNr", column = @Column(name = "NLFD_NR", nullable = false, precision = 12, scale = 0)) })
	public SysQueueBatchSubdetailId getId() {
		return this.id;
	}

	public void setId(final SysQueueBatchSubdetailId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false)
	public SysQueueBatch getSysQueueBatch() {
		return this.sysQueueBatch;
	}

	public void setSysQueueBatch(final SysQueueBatch sysQueueBatch) {
		this.sysQueueBatch = sysQueueBatch;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDETAIL_KEY", nullable = false, insertable = false, updatable = false)
	public SysQueueBatchDetail getSysQueueBatchDetail() {
		return this.sysQueueBatchDetail;
	}

	public void setSysQueueBatchDetail(final SysQueueBatchDetail sysQueueBatchDetail) {
		this.sysQueueBatchDetail = sysQueueBatchDetail;
	}

	@Column(name = "NSOURCE_KEY", precision = 12, scale = 0)
	public Long getNsourceKey() {
		return this.nsourceKey;
	}

	public void setNsourceKey(final Long nsourceKey) {
		this.nsourceKey = nsourceKey;
	}

	@Column(name = "CSOURCE_TEXT")
	public String getCsourceText() {
		return this.csourceText;
	}

	public void setCsourceText(final String csourceText) {
		this.csourceText = csourceText;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSOURCE_DATE", length = 7)
	public Date getDsourceDate() {
		return this.dsourceDate;
	}

	public void setDsourceDate(final Date dsourceDate) {
		this.dsourceDate = dsourceDate;
	}

	@Column(name = "NSOURCE_NUMBER", precision = 12, scale = 5)
	public BigDecimal getNsourceNumber() {
		return this.nsourceNumber;
	}

	public void setNsourceNumber(final BigDecimal nsourceNumber) {
		this.nsourceNumber = nsourceNumber;
	}

}
