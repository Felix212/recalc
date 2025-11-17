package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.math.BigDecimal;

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
 * Entity(DomainObject) for table CEN_REQUEST_SPML
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REQUEST_SPML")
public class CenRequestSpml
		implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	private long nreqSpmlKey;
	private CenRequestFlight cenRequestFlight;
	private int nclassNumber;
	private String cclass;
	private String cspml;
	private String cname;
	private String caddText;
	private BigDecimal nquantity;
	private String ccomment;
	private String cstatus;

	public CenRequestSpml() {
	}

	public CenRequestSpml(final long nreqSpmlKey, final CenRequestFlight cenRequestFlight, final int nclassNumber,
			final String cclass, final String cspml, final BigDecimal nquantity) {
		this.nreqSpmlKey = nreqSpmlKey;
		this.cenRequestFlight = cenRequestFlight;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.cspml = cspml;
		this.nquantity = nquantity;
	}

	public CenRequestSpml(final long nreqSpmlKey, final CenRequestFlight cenRequestFlight, final int nclassNumber,
			final String cclass, final String cspml, final String cname, final String caddText,
			final BigDecimal nquantity, final String ccomment, final String cstatus) {
		this.nreqSpmlKey = nreqSpmlKey;
		this.cenRequestFlight = cenRequestFlight;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.cspml = cspml;
		this.cname = cname;
		this.caddText = caddText;
		this.nquantity = nquantity;
		this.ccomment = ccomment;
		this.cstatus = cstatus;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_REQUEST_SPML")
	@SequenceGenerator(name = "SEQ_CEN_REQUEST_SPML", sequenceName = "SEQ_CEN_REQUEST_SPML", allocationSize = 1)
	@Column(name = "NREQ_SPML_KEY", unique = true, nullable = false, precision = 12)
	public long getNreqSpmlKey() {
		return this.nreqSpmlKey;
	}

	public void setNreqSpmlKey(final long nreqSpmlKey) {
		this.nreqSpmlKey = nreqSpmlKey;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "NREQ_FLIGHT_KEY", nullable = false)
	public CenRequestFlight getCenRequestFlight() {
		return this.cenRequestFlight;
	}

	public void setCenRequestFlight(final CenRequestFlight cenRequestFlight) {
		this.cenRequestFlight = cenRequestFlight;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 6)
	public int getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final int nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CSPML", nullable = false, length = 10)
	public String getCspml() {
		return this.cspml;
	}

	public void setCspml(final String cspml) {
		this.cspml = cspml;
	}

	@Column(name = "CNAME", length = 80)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CADD_TEXT", length = 80)
	public String getCaddText() {
		return this.caddText;
	}

	public void setCaddText(final String caddText) {
		this.caddText = caddText;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CCOMMENT", length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "CSTATUS", length = 10)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(final String cstatus) {
		this.cstatus = cstatus;
	}

}
