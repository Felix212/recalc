package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Jul-2024 13:38:12 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_ROUTINGPLAN
 *
 * @author Hibernate Tools
 */
@NamedEntityGraph(
		name = "CenRoutingplan.withRefs",
		attributeNodes = {
				@NamedAttributeNode("cenAirlines"),
				@NamedAttributeNode("cenRoutingplanDefinition"),
				@NamedAttributeNode("sysThreeLetterCodesByNtlcFrom"),
				@NamedAttributeNode("sysThreeLetterCodesByNtlcTo"),
				@NamedAttributeNode("sysUnits")
		}
)
@Entity
@Table(name = "CEN_ROUTINGPLAN")
public class CenRoutingplan implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nroutingdetailKey;
	private CenAirlines cenAirlines;
	private CenRoutingplanDefinition cenRoutingplanDefinition;
	private SysThreeLetterCodes sysThreeLetterCodesByNtlcFrom;
	private SysThreeLetterCodes sysThreeLetterCodesByNtlcTo;
	private SysUnits sysUnits;
	private long nroutingGroupKey;
	private long ncustomerKey;
	private int nflightNumber;
	private String csuffix;
	private int nlegNumber;
	private int nlegIdent;
	private long nroutingId;
	private Date dvalidFrom;
	private Date dvalidTo;
	private int nfreq1;
	private int nfreq2;
	private int nfreq3;
	private int nfreq4;
	private int nfreq5;
	private int nfreq6;
	private int nfreq7;
	private long nhandlingTypeKey;
	private long nsort;
	private Integer ndefault;
	private Integer naddiFlag;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cadditional;
	private Long naccountKey;

	@Id
	@Column(name = "NROUTINGDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNroutingdetailKey() {
		return this.nroutingdetailKey;
	}

	public void setNroutingdetailKey(long nroutingdetailKey) {
		this.nroutingdetailKey = nroutingdetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROUTINGPLAN_INDEX", nullable = false)
	public CenRoutingplanDefinition getCenRoutingplanDefinition() {
		return this.cenRoutingplanDefinition;
	}

	public void setCenRoutingplanDefinition(CenRoutingplanDefinition cenRoutingplanDefinition) {
		this.cenRoutingplanDefinition = cenRoutingplanDefinition;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_FROM", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodesByNtlcFrom() {
		return this.sysThreeLetterCodesByNtlcFrom;
	}

	public void setSysThreeLetterCodesByNtlcFrom(SysThreeLetterCodes sysThreeLetterCodesByNtlcFrom) {
		this.sysThreeLetterCodesByNtlcFrom = sysThreeLetterCodesByNtlcFrom;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_TO", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodesByNtlcTo() {
		return this.sysThreeLetterCodesByNtlcTo;
	}

	public void setSysThreeLetterCodesByNtlcTo(SysThreeLetterCodes sysThreeLetterCodesByNtlcTo) {
		this.sysThreeLetterCodesByNtlcTo = sysThreeLetterCodesByNtlcTo;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "NROUTING_GROUP_KEY", nullable = false, precision = 12, scale = 0)
	public long getNroutingGroupKey() {
		return this.nroutingGroupKey;
	}

	public void setNroutingGroupKey(long nroutingGroupKey) {
		this.nroutingGroupKey = nroutingGroupKey;
	}

	@Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcustomerKey() {
		return this.ncustomerKey;
	}

	public void setNcustomerKey(long ncustomerKey) {
		this.ncustomerKey = ncustomerKey;
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

	@Column(name = "NLEG_NUMBER", nullable = false, precision = 3, scale = 0)
	public int getNlegNumber() {
		return this.nlegNumber;
	}

	public void setNlegNumber(int nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	@Column(name = "NLEG_IDENT", nullable = false, precision = 1, scale = 0)
	public int getNlegIdent() {
		return this.nlegIdent;
	}

	public void setNlegIdent(int nlegIdent) {
		this.nlegIdent = nlegIdent;
	}

	@Column(name = "NROUTING_ID", nullable = false, precision = 12, scale = 0)
	public long getNroutingId() {
		return this.nroutingId;
	}

	public void setNroutingId(long nroutingId) {
		this.nroutingId = nroutingId;
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

	@Column(name = "NFREQ1", nullable = false, precision = 1, scale = 0)
	public int getNfreq1() {
		return this.nfreq1;
	}

	public void setNfreq1(int nfreq1) {
		this.nfreq1 = nfreq1;
	}

	@Column(name = "NFREQ2", nullable = false, precision = 1, scale = 0)
	public int getNfreq2() {
		return this.nfreq2;
	}

	public void setNfreq2(int nfreq2) {
		this.nfreq2 = nfreq2;
	}

	@Column(name = "NFREQ3", nullable = false, precision = 1, scale = 0)
	public int getNfreq3() {
		return this.nfreq3;
	}

	public void setNfreq3(int nfreq3) {
		this.nfreq3 = nfreq3;
	}

	@Column(name = "NFREQ4", nullable = false, precision = 1, scale = 0)
	public int getNfreq4() {
		return this.nfreq4;
	}

	public void setNfreq4(int nfreq4) {
		this.nfreq4 = nfreq4;
	}

	@Column(name = "NFREQ5", nullable = false, precision = 1, scale = 0)
	public int getNfreq5() {
		return this.nfreq5;
	}

	public void setNfreq5(int nfreq5) {
		this.nfreq5 = nfreq5;
	}

	@Column(name = "NFREQ6", nullable = false, precision = 1, scale = 0)
	public int getNfreq6() {
		return this.nfreq6;
	}

	public void setNfreq6(int nfreq6) {
		this.nfreq6 = nfreq6;
	}

	@Column(name = "NFREQ7", nullable = false, precision = 1, scale = 0)
	public int getNfreq7() {
		return this.nfreq7;
	}

	public void setNfreq7(int nfreq7) {
		this.nfreq7 = nfreq7;
	}

	@Column(name = "NHANDLING_TYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey() {
		return this.nhandlingTypeKey;
	}

	public void setNhandlingTypeKey(long nhandlingTypeKey) {
		this.nhandlingTypeKey = nhandlingTypeKey;
	}

	@Column(name = "NSORT", nullable = false, precision = 12, scale = 0)
	public long getNsort() {
		return this.nsort;
	}

	public void setNsort(long nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NDEFAULT", precision = 1, scale = 0)
	public Integer getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(Integer ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NADDI_FLAG", precision = 1, scale = 0)
	public Integer getNaddiFlag() {
		return this.naddiFlag;
	}

	public void setNaddiFlag(Integer naddiFlag) {
		this.naddiFlag = naddiFlag;
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

	@Column(name = "CADDITIONAL", length = 80)
	public String getCadditional() {
		return this.cadditional;
	}

	public void setCadditional(String cadditional) {
		this.cadditional = cadditional;
	}

	@Column(name = "NACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNaccountKey() {
		return this.naccountKey;
	}

	public void setNaccountKey(Long naccountKey) {
		this.naccountKey = naccountKey;
	}

}
