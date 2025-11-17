package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 10, 2019 12:14:52 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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
 * Entity(DomainObject) for table LOC_PL_SUBST
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PL_SUBST")
public class LocPlSubst implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlocPlSubstKey;
	private SysPlSubstErrorcode sysPlSubstErrorcode;
	private SysPlSubstReason sysPlSubstReason;
	private CenPackinglistIndex cenPackinglistIndexByNplIndexKeyMmItem;
	private CenPackinglistIndex cenPackinglistIndexByNplIndexKeySubst;
	private CenPackinglistIndex cenPackinglistIndexByNplIndexKey;
	private String cunit;
	private int nplLevel;
	private int nplLevelSubst;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String cdepartureTimeFrom;
	private String cdepartureTimeTo;
	private String ckeyword;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cexplanation;
	private BigDecimal namount;
	private Date doriginalAvailable;
	private String caction;
	private int naisRelevant;
	private String cclass;
	private String crouting;
	private Set<LocPlSubstFlights> locPlSubstFlightses = new HashSet<>(0);

	@Id
	@Column(name = "NLOC_PL_SUBST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlocPlSubstKey() {
		return this.nlocPlSubstKey;
	}

	public void setNlocPlSubstKey(final long nlocPlSubstKey) {
		this.nlocPlSubstKey = nlocPlSubstKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPLSUBST_ERRORCODE_KEY", nullable = false)
	public SysPlSubstErrorcode getSysPlSubstErrorcode() {
		return this.sysPlSubstErrorcode;
	}

	public void setSysPlSubstErrorcode(final SysPlSubstErrorcode sysPlSubstErrorcode) {
		this.sysPlSubstErrorcode = sysPlSubstErrorcode;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NKEY_REASON", nullable = false)
	public SysPlSubstReason getSysPlSubstReason() {
		return this.sysPlSubstReason;
	}

	public void setSysPlSubstReason(final SysPlSubstReason sysPlSubstReason) {
		this.sysPlSubstReason = sysPlSubstReason;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_INDEX_KEY_MM_ITEM")
	public CenPackinglistIndex getCenPackinglistIndexByNplIndexKeyMmItem() {
		return this.cenPackinglistIndexByNplIndexKeyMmItem;
	}

	public void setCenPackinglistIndexByNplIndexKeyMmItem(final CenPackinglistIndex cenPackinglistIndexByNplIndexKeyMmItem) {
		this.cenPackinglistIndexByNplIndexKeyMmItem = cenPackinglistIndexByNplIndexKeyMmItem;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_INDEX_KEY_SUBST", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndexByNplIndexKeySubst() {
		return this.cenPackinglistIndexByNplIndexKeySubst;
	}

	public void setCenPackinglistIndexByNplIndexKeySubst(final CenPackinglistIndex cenPackinglistIndexByNplIndexKeySubst) {
		this.cenPackinglistIndexByNplIndexKeySubst = cenPackinglistIndexByNplIndexKeySubst;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndexByNplIndexKey() {
		return this.cenPackinglistIndexByNplIndexKey;
	}

	public void setCenPackinglistIndexByNplIndexKey(final CenPackinglistIndex cenPackinglistIndexByNplIndexKey) {
		this.cenPackinglistIndexByNplIndexKey = cenPackinglistIndexByNplIndexKey;
	}

	@Column(name = "CUNIT", length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NPL_LEVEL", nullable = false, precision = 2, scale = 0)
	public int getNplLevel() {
		return this.nplLevel;
	}

	public void setNplLevel(final int nplLevel) {
		this.nplLevel = nplLevel;
	}

	@Column(name = "NPL_LEVEL_SUBST", nullable = false, precision = 2, scale = 0)
	public int getNplLevelSubst() {
		return this.nplLevelSubst;
	}

	public void setNplLevelSubst(final int nplLevelSubst) {
		this.nplLevelSubst = nplLevelSubst;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CDEPARTURE_TIME_FROM", length = 5)
	public String getCdepartureTimeFrom() {
		return this.cdepartureTimeFrom;
	}

	public void setCdepartureTimeFrom(final String cdepartureTimeFrom) {
		this.cdepartureTimeFrom = cdepartureTimeFrom;
	}

	@Column(name = "CDEPARTURE_TIME_TO", length = 5)
	public String getCdepartureTimeTo() {
		return this.cdepartureTimeTo;
	}

	public void setCdepartureTimeTo(final String cdepartureTimeTo) {
		this.cdepartureTimeTo = cdepartureTimeTo;
	}

	@Column(name = "CKEYWORD", length = 256)
	public String getCkeyword() {
		return this.ckeyword;
	}

	public void setCkeyword(final String ckeyword) {
		this.ckeyword = ckeyword;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "CEXPLANATION", length = 200)
	public String getCexplanation() {
		return this.cexplanation;
	}

	public void setCexplanation(final String cexplanation) {
		this.cexplanation = cexplanation;
	}

	@Column(name = "NAMOUNT", precision = 12, scale = 3)
	public BigDecimal getNamount() {
		return this.namount;
	}

	public void setNamount(final BigDecimal namount) {
		this.namount = namount;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DORIGINAL_AVAILABLE", length = 7)
	public Date getDoriginalAvailable() {
		return this.doriginalAvailable;
	}

	public void setDoriginalAvailable(final Date doriginalAvailable) {
		this.doriginalAvailable = doriginalAvailable;
	}

	@Column(name = "CACTION", length = 200)
	public String getCaction() {
		return this.caction;
	}

	public void setCaction(final String caction) {
		this.caction = caction;
	}

	@Column(name = "NAIS_RELEVANT", nullable = false, precision = 1, scale = 0)
	public int getNaisRelevant() {
		return this.naisRelevant;
	}

	public void setNaisRelevant(final int naisRelevant) {
		this.naisRelevant = naisRelevant;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CROUTING", length = 5)
	public String getCrouting() {
		return this.crouting;
	}

	public void setCrouting(final String crouting) {
		this.crouting = crouting;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPlSubst")
	public Set<LocPlSubstFlights> getLocPlSubstFlightses() {
		return this.locPlSubstFlightses;
	}

	public void setLocPlSubstFlightses(final Set<LocPlSubstFlights> locPlSubstFlightses) {
		this.locPlSubstFlightses = locPlSubstFlightses;
	}

}
