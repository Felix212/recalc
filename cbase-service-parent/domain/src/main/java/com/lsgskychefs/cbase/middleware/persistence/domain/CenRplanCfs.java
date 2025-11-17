package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Jul-2024 13:50:09 by Hibernate Tools 4.3.5.Final

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_RPLAN_CFS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_RPLAN_CFS")
public class CenRplanCfs implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncfsKey;
	private CenRoutingplanDefinition cenRoutingplanDefinition;
	private long nairlineKey;
	private int nflightNumber;
	private String csuffix;
	private long ntlcFrom;
	private long ntlcTo;
	private Date dtimestamp;
	private String cchanged;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Set<CenRplanCfsLegs> cenRplanCfsLegses = new HashSet<>(0);

	@Id
	@Column(name = "NCFS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcfsKey() {
		return this.ncfsKey;
	}

	public void setNcfsKey(long ncfsKey) {
		this.ncfsKey = ncfsKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROUTINGPLAN_INDEX")
	public CenRoutingplanDefinition getCenRoutingplanDefinition() {
		return this.cenRoutingplanDefinition;
	}

	public void setCenRoutingplanDefinition(CenRoutingplanDefinition cenRoutingplanDefinition) {
		this.cenRoutingplanDefinition = cenRoutingplanDefinition;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(String csuffix) {
		this.csuffix = csuffix;
	}

	@Column(name = "NTLC_FROM", nullable = false, precision = 12, scale = 0)
	public long getNtlcFrom() {
		return this.ntlcFrom;
	}

	public void setNtlcFrom(long ntlcFrom) {
		this.ntlcFrom = ntlcFrom;
	}

	@Column(name = "NTLC_TO", nullable = false, precision = 12, scale = 0)
	public long getNtlcTo() {
		return this.ntlcTo;
	}

	public void setNtlcTo(long ntlcTo) {
		this.ntlcTo = ntlcTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CCHANGED", length = 40)
	public String getCchanged() {
		return this.cchanged;
	}

	public void setCchanged(String cchanged) {
		this.cchanged = cchanged;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRplanCfs")
	public Set<CenRplanCfsLegs> getCenRplanCfsLegses() {
		return this.cenRplanCfsLegses;
	}

	public void setCenRplanCfsLegses(Set<CenRplanCfsLegs> cenRplanCfsLegses) {
		this.cenRplanCfsLegses = cenRplanCfsLegses;
	}

}
