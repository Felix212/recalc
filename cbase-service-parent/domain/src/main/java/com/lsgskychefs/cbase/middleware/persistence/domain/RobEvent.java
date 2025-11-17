package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table ROB_EVENT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_EVENT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobEvent implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long neventKey;

	private String cname;

	private String cdescription;

	private Date dstart;

	private boolean ndefault;

	private boolean nsurveyActive;

	private String cflightAirline;

	private Integer nflightNumber;

	private String cflightSuffix;

	private Date dflightDeparture;

	private Integer nflightDuration;

	private Set<RobEventProduct> robEventProducts = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_EVENT")
	@SequenceGenerator(name = "SEQ_ROB_EVENT", sequenceName = "SEQ_ROB_EVENT", allocationSize = 1)
	@Column(name = "NEVENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeventKey() {
		return this.neventKey;
	}

	public void setNeventKey(final long neventKey) {
		this.neventKey = neventKey;
	}

	@Column(name = "CNAME", nullable = false, length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 2048)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART", length = 7)
	public Date getDstart() {
		return this.dstart;
	}

	public void setDstart(final Date dstart) {
		this.dstart = dstart;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public boolean isNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final boolean ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NSURVEY_ACTIVE", nullable = false, precision = 1, scale = 0)
	public boolean isNsurveyActive() {
		return this.nsurveyActive;
	}

	public void setNsurveyActive(final boolean nsurveyActive) {
		this.nsurveyActive = nsurveyActive;
	}

	@Column(name = "CFLIGHT_AIRLINE", length = 6)
	public String getCflightAirline() {
		return this.cflightAirline;
	}

	public void setCflightAirline(final String cflightAirline) {
		this.cflightAirline = cflightAirline;
	}

	@Column(name = "NFLIGHT_NUMBER", precision = 6, scale = 0)
	public Integer getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final Integer nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CFLIGHT_SUFFIX", length = 3)
	public String getCflightSuffix() {
		return this.cflightSuffix;
	}

	public void setCflightSuffix(final String cflightSuffix) {
		this.cflightSuffix = cflightSuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DFLIGHT_DEPARTURE", length = 7)
	public Date getDflightDeparture() {
		return this.dflightDeparture;
	}

	public void setDflightDeparture(final Date dflightDeparture) {
		this.dflightDeparture = dflightDeparture;
	}

	@Column(name = "NFLIGHT_DURATION", precision = 4, scale = 0)
	public Integer getNflightDuration() {
		return this.nflightDuration;
	}

	public void setNflightDuration(final Integer nflightDuration) {
		this.nflightDuration = nflightDuration;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robEvent")
	@JsonIgnore
	public Set<RobEventProduct> getRobEventProducts() {
		return this.robEventProducts;
	}

	public void setRobEventProducts(final Set<RobEventProduct> robEventProducts) {
		this.robEventProducts = robEventProducts;
	}
}
