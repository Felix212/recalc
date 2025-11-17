package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.06.2016 17:39:47 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * Entity(DomainObject) for table SYS_QUEUE_FLIGHT_ACTYPE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_FLIGHT_ACTYPE")
public class SysQueueFlightActype implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long njobNr;
	private SysQueueFlightCalc sysQueueFlightCalc;
	private String cacowner;
	private String ctype;
	private String cgalvers;
	private String cconfiguration;
	private String cregistration;
	private Long naircraftKey;

	@Id
	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "sysQueueFlightCalc"))
	@GeneratedValue(generator = "generator")
	@Column(name = "NJOB_NR", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNjobNr() {
		return this.njobNr;
	}

	public void setNjobNr(final long njobNr) {
		this.njobNr = njobNr;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public SysQueueFlightCalc getSysQueueFlightCalc() {
		return this.sysQueueFlightCalc;
	}

	public void setSysQueueFlightCalc(final SysQueueFlightCalc sysQueueFlightCalc) {
		this.sysQueueFlightCalc = sysQueueFlightCalc;
		sysQueueFlightCalc.setSysQueueFlightActype(this);
	}

	@Column(name = "CACOWNER", length = 6)
	public String getCacowner() {
		return this.cacowner;
	}

	public void setCacowner(final String cacowner) {
		this.cacowner = cacowner;
	}

	@Column(name = "CTYPE", length = 10)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	@Column(name = "CGALVERS", length = 10)
	public String getCgalvers() {
		return this.cgalvers;
	}

	public void setCgalvers(final String cgalvers) {
		this.cgalvers = cgalvers;
	}

	@Column(name = "CCONFIGURATION", length = 20)
	public String getCconfiguration() {
		return this.cconfiguration;
	}

	public void setCconfiguration(final String cconfiguration) {
		this.cconfiguration = cconfiguration;
	}

	@Column(name = "CREGISTRATION", length = 10)
	public String getCregistration() {
		return this.cregistration;
	}

	public void setCregistration(final String cregistration) {
		this.cregistration = cregistration;
	}

	@Column(name = "NAIRCRAFT_KEY", precision = 12, scale = 0)
	public Long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final Long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

}
