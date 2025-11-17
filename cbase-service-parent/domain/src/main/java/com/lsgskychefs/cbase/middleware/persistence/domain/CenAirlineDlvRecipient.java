package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.11.2024 11:28:24 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_DLV_RECIPIENT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_DLV_RECIPIENT")
public class CenAirlineDlvRecipient implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nairlineDlvRecipientKey;
	private CenAirlines cenAirlines;
	private String cusername;
	private String cmail;
	private Date dvalidFrom;
	private Date dvalidTo;

	@Id
	@Column(name = "NAIRLINE_DLV_RECIPIENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNairlineDlvRecipientKey() {
		return this.nairlineDlvRecipientKey;
	}

	public void setNairlineDlvRecipientKey(long nairlineDlvRecipientKey) {
		this.nairlineDlvRecipientKey = nairlineDlvRecipientKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CUSERNAME", nullable = false, length = 50)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(String cusername) {
		this.cusername = cusername;
	}

	@Column(name = "CMAIL", nullable = false, length = 250)
	public String getCmail() {
		return this.cmail;
	}

	public void setCmail(String cmail) {
		this.cmail = cmail;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

}


