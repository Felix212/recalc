package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Jul-2024 13:50:09 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_RPLAN_CFS_LEGS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_RPLAN_CFS_LEGS")
public class CenRplanCfsLegs implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncfsLegKey;
	private CenRplanCfs cenRplanCfs;
	private long ncfsGroupKey;
	private long ncustomerKey;
	private long nairlineKey;
	private int nflightNumber;
	private String csuffix;
	private int nlegNumber;
	private int nlegIdent;
	private long nroutingId;
	private long ntlcFrom;
	private long ntlcTo;
	private String cunit;
	private int nfreq1;
	private int nfreq2;
	private int nfreq3;
	private int nfreq4;
	private int nfreq5;
	private int nfreq6;
	private int nfreq7;
	private long nhandlingTypeKey1;
	private long nhandlingTypeKey2;
	private long nhandlingTypeKey3;
	private long nhandlingTypeKey4;
	private long nhandlingTypeKey5;
	private long nhandlingTypeKey6;
	private long nhandlingTypeKey7;
	private int nequal;
	private int ndummy;
	private Date dtimestamp;
	private String cchanged;
	private String cvariationKey;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cadditional;
	private Long naccountKey;

	@Id
	@Column(name = "NCFS_LEG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcfsLegKey() {
		return this.ncfsLegKey;
	}

	public void setNcfsLegKey(long ncfsLegKey) {
		this.ncfsLegKey = ncfsLegKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCFS_KEY", nullable = false)
	public CenRplanCfs getCenRplanCfs() {
		return this.cenRplanCfs;
	}

	public void setCenRplanCfs(CenRplanCfs cenRplanCfs) {
		this.cenRplanCfs = cenRplanCfs;
	}

	@Column(name = "NCFS_GROUP_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcfsGroupKey() {
		return this.ncfsGroupKey;
	}

	public void setNcfsGroupKey(long ncfsGroupKey) {
		this.ncfsGroupKey = ncfsGroupKey;
	}

	@Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcustomerKey() {
		return this.ncustomerKey;
	}

	public void setNcustomerKey(long ncustomerKey) {
		this.ncustomerKey = ncustomerKey;
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

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
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

	@Column(name = "NHANDLING_TYPE_KEY1", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey1() {
		return this.nhandlingTypeKey1;
	}

	public void setNhandlingTypeKey1(long nhandlingTypeKey1) {
		this.nhandlingTypeKey1 = nhandlingTypeKey1;
	}

	@Column(name = "NHANDLING_TYPE_KEY2", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey2() {
		return this.nhandlingTypeKey2;
	}

	public void setNhandlingTypeKey2(long nhandlingTypeKey2) {
		this.nhandlingTypeKey2 = nhandlingTypeKey2;
	}

	@Column(name = "NHANDLING_TYPE_KEY3", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey3() {
		return this.nhandlingTypeKey3;
	}

	public void setNhandlingTypeKey3(long nhandlingTypeKey3) {
		this.nhandlingTypeKey3 = nhandlingTypeKey3;
	}

	@Column(name = "NHANDLING_TYPE_KEY4", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey4() {
		return this.nhandlingTypeKey4;
	}

	public void setNhandlingTypeKey4(long nhandlingTypeKey4) {
		this.nhandlingTypeKey4 = nhandlingTypeKey4;
	}

	@Column(name = "NHANDLING_TYPE_KEY5", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey5() {
		return this.nhandlingTypeKey5;
	}

	public void setNhandlingTypeKey5(long nhandlingTypeKey5) {
		this.nhandlingTypeKey5 = nhandlingTypeKey5;
	}

	@Column(name = "NHANDLING_TYPE_KEY6", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey6() {
		return this.nhandlingTypeKey6;
	}

	public void setNhandlingTypeKey6(long nhandlingTypeKey6) {
		this.nhandlingTypeKey6 = nhandlingTypeKey6;
	}

	@Column(name = "NHANDLING_TYPE_KEY7", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey7() {
		return this.nhandlingTypeKey7;
	}

	public void setNhandlingTypeKey7(long nhandlingTypeKey7) {
		this.nhandlingTypeKey7 = nhandlingTypeKey7;
	}

	@Column(name = "NEQUAL", nullable = false, precision = 1, scale = 0)
	public int getNequal() {
		return this.nequal;
	}

	public void setNequal(int nequal) {
		this.nequal = nequal;
	}

	@Column(name = "NDUMMY", nullable = false, precision = 1, scale = 0)
	public int getNdummy() {
		return this.ndummy;
	}

	public void setNdummy(int ndummy) {
		this.ndummy = ndummy;
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

	@Column(name = "CVARIATION_KEY", length = 256)
	public String getCvariationKey() {
		return this.cvariationKey;
	}

	public void setCvariationKey(String cvariationKey) {
		this.cvariationKey = cvariationKey;
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
