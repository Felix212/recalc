package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 09.10.2025 10:32:07 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_QP
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_QP"
)
public class CenAirlineQp implements DomainObject, java.io.Serializable {

	private long nairlineQpKey;
	@JsonIgnore
	private CenAirlines cenAirlines;
	private String cqueryPeriod;
	private long noffset;
	private int ntlob;
	private int nistpaxe;
	private int nforecast;
	@JsonIgnore
	private Set<CenOutQp> cenOutQps = new HashSet<CenOutQp>(0);

	public CenAirlineQp() {
	}

	@Id
	@Column(name = "NAIRLINE_QP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNairlineQpKey() {
		return this.nairlineQpKey;
	}

	public void setNairlineQpKey(long nairlineQpKey) {
		this.nairlineQpKey = nairlineQpKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CQUERY_PERIOD", nullable = false, length = 30)
	public String getCqueryPeriod() {
		return this.cqueryPeriod;
	}

	public void setCqueryPeriod(String cqueryPeriod) {
		this.cqueryPeriod = cqueryPeriod;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 10, scale = 0)
	public long getNoffset() {
		return this.noffset;
	}

	public void setNoffset(long noffset) {
		this.noffset = noffset;
	}

	@Column(name = "NTLOB", nullable = false, precision = 1, scale = 0)
	public int getNtlob() {
		return this.ntlob;
	}

	public void setNtlob(int ntlob) {
		this.ntlob = ntlob;
	}

	@Column(name = "NISTPAXE", nullable = false, precision = 1, scale = 0)
	public int getNistpaxe() {
		return this.nistpaxe;
	}

	public void setNistpaxe(int nistpaxe) {
		this.nistpaxe = nistpaxe;
	}

	@Column(name = "NFORECAST", nullable = false, precision = 1, scale = 0)
	public int getNforecast() {
		return this.nforecast;
	}

	public void setNforecast(int nforecast) {
		this.nforecast = nforecast;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlineQp")
	public Set<CenOutQp> getCenOutQps() {
		return this.cenOutQps;
	}

	public void setCenOutQps(Set<CenOutQp> cenOutQps) {
		this.cenOutQps = cenOutQps;
	}

}


