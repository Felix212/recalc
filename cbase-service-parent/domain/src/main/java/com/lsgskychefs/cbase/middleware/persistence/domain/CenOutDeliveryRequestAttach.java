package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.06.2025 11:03:44 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_DELIVERY_REQUEST_ATTACH
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DELIVERY_REQUEST_ATTACH"
)
public class CenOutDeliveryRequestAttach implements DomainObject, java.io.Serializable {

	private long nattachmentId;
	@JsonIgnore
	private CenOutDeliveryRequest cenOutDeliveryRequest;
	@JsonIgnore
	private byte[] bbinary;
	private String cdescription;
	private String cfilename;
	private String ctype;
	private Date dtimestamp;
	private Long nsort;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_DELIVERY_REQUEST_ATTACH")
	@SequenceGenerator(name = "SEQ_CEN_OUT_DELIVERY_REQUEST_ATTACH", sequenceName = "SEQ_CEN_OUT_DELIVERY_REQUEST_ATTACH", allocationSize = 1)
	@Column(name = "NATTACHMENT_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNattachmentId() {
		return this.nattachmentId;
	}

	public void setNattachmentId(long nattachmentId) {
		this.nattachmentId = nattachmentId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDELIVERY_REQUEST_KEY", nullable = false)
	public CenOutDeliveryRequest getCenOutDeliveryRequest() {
		return this.cenOutDeliveryRequest;
	}

	public void setCenOutDeliveryRequest(CenOutDeliveryRequest cenOutDeliveryRequest) {
		this.cenOutDeliveryRequest = cenOutDeliveryRequest;
	}

	@Lob
	@Column(name = "BBINARY")
	public byte[] getBbinary() {
		return this.bbinary;
	}

	public void setBbinary(byte[] bbinary) {
		this.bbinary = bbinary;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CFILENAME", length = 1000)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(String cfilename) {
		this.cfilename = cfilename;
	}

	@Column(name = "CTYPE", length = 100)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(Long nsort) {
		this.nsort = nsort;
	}

}


