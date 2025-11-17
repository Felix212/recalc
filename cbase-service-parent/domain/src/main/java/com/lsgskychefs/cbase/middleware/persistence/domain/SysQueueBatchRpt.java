package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table SYS_QUEUE_BATCH_RPT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_BATCH_RPT")
public class SysQueueBatchRpt implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndetailKey;
	private SysQueueBatch sysQueueBatch;
	private String cparameter;
	private String cdatatype;
	private String cvalue;
	private Date dvalue;
	private Long nvalue;
	private Long narrayCount;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_QUEUE_BATCH_RPT")
	@SequenceGenerator(name = "SEQ_SYS_QUEUE_BATCH_RPT", sequenceName = "SEQ_SYS_QUEUE_BATCH_RPT", allocationSize = 1)
	@Column(name = "NDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false)
	public SysQueueBatch getSysQueueBatch() {
		return this.sysQueueBatch;
	}

	public void setSysQueueBatch(final SysQueueBatch sysQueueBatch) {
		this.sysQueueBatch = sysQueueBatch;
	}

	@Column(name = "CPARAMETER", nullable = false, length = 40)
	public String getCparameter() {
		return this.cparameter;
	}

	public void setCparameter(final String cparameter) {
		this.cparameter = cparameter;
	}

	@Column(name = "CDATATYPE", nullable = false, length = 40)
	public String getCdatatype() {
		return this.cdatatype;
	}

	public void setCdatatype(final String cdatatype) {
		this.cdatatype = cdatatype;
	}

	@Column(name = "CVALUE", length = 256)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALUE", length = 7)
	public Date getDvalue() {
		return this.dvalue;
	}

	public void setDvalue(final Date dvalue) {
		this.dvalue = dvalue;
	}

	@Column(name = "NVALUE", precision = 12, scale = 0)
	public Long getNvalue() {
		return this.nvalue;
	}

	public void setNvalue(final Long nvalue) {
		this.nvalue = nvalue;
	}

	@Column(name = "NARRAY_COUNT", precision = 12, scale = 0)
	public Long getNarrayCount() {
		return this.narrayCount;
	}

	public void setNarrayCount(final Long narrayCount) {
		this.narrayCount = narrayCount;
	}

}
