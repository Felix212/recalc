package com.lsgskychefs.cbase.middleware.persistence.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "CEN_BOB_FLIGHT_SEALS")
public class CenBobFlightSeal implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_BOB_FLIGHT_SEALS")
	@SequenceGenerator(name = "SEQ_CEN_BOB_FLIGHT_SEALS", sequenceName = "SEQ_CEN_BOB_FLIGHT_SEALS", allocationSize = 1)
	@Column(name = "NBOB_FLIGHT_SEAL_KEY", nullable = false)
	private Long id;

	@Size(max = 6)
	@NotNull
	@Column(name = "CAIRLINE", nullable = false, length = 6)
	private String cairline;

	@NotNull
	@Column(name = "NFLIGHT_NUMBER", nullable = false)
	private Integer nflightNumber;

	@Size(max = 3)
	@NotNull
	@Column(name = "CTLC_FROM", nullable = false, length = 3)
	private String ctlcFrom;

	@Size(max = 3)
	@NotNull
	@Column(name = "CTLC_TO", nullable = false, length = 3)
	private String ctlcTo;

	@NotNull
	@Column(name = "NACTIVE1", nullable = false, columnDefinition = "number(1) default 1")
	private Boolean nactive1 = false;

	@NotNull
	@Column(name = "NRESERVE1", nullable = false, columnDefinition = "number(2) default 0")
	private Integer nreserve1;

	@NotNull
	@Column(name = "NACTIVE2", nullable = false, columnDefinition = "number(1) default 1")
	private Boolean nactive2 = false;

	@NotNull
	@Column(name = "NRESERVE2", nullable = false, columnDefinition = "number(2) default 0")
	private Integer nreserve2;

	@NotNull
	@Column(name = "NACTIVE3", nullable = false, columnDefinition = "number(1) default 1")
	private Boolean nactive3 = false;

	@NotNull
	@Column(name = "NRESERVE3", nullable = false, columnDefinition = "number(2) default 0")
	private Integer nreserve3;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCairline() {
		return cairline;
	}

	public void setCairline(String cairline) {
		this.cairline = cairline;
	}

	public Integer getNflightNumber() {
		return nflightNumber;
	}

	public void setNflightNumber(Integer nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	public String getCtlcFrom() {
		return ctlcFrom;
	}

	public void setCtlcFrom(String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	public String getCtlcTo() {
		return ctlcTo;
	}

	public void setCtlcTo(String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	public Boolean getNactive1() {
		return nactive1;
	}

	public void setNactive1(Boolean nactive1) {
		this.nactive1 = nactive1;
	}

	public Integer getNreserve1() {
		return nreserve1;
	}

	public void setNreserve1(Integer nreserve1) {
		this.nreserve1 = nreserve1;
	}

	public Boolean getNactive2() {
		return nactive2;
	}

	public void setNactive2(Boolean nactive2) {
		this.nactive2 = nactive2;
	}

	public Integer getNreserve2() {
		return nreserve2;
	}

	public void setNreserve2(Integer nreserve2) {
		this.nreserve2 = nreserve2;
	}

	public Boolean getNactive3() {
		return nactive3;
	}

	public void setNactive3(Boolean nactive3) {
		this.nactive3 = nactive3;
	}

	public Integer getNreserve3() {
		return nreserve3;
	}

	public void setNreserve3(Integer nreserve3) {
		this.nreserve3 = nreserve3;
	}

}
