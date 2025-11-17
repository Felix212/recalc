package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 10, 2019 12:14:52 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_PL_SUBST_FLIGHTS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PL_SUBST_FLIGHTS")
public class LocPlSubstFlights implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocPlSubstFlightsId id;
	private LocPlSubst locPlSubst;
	private String cairline;
	private Integer nflightNumber;
	private String csuffix;
	private String ctlcFrom;
	private String ctlcTo;
	private Date ddeparture;
	private String cdepartureTime;
	private String cflightKey;
	private Integer npartialSubstitution;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String csubstText;
	private BigDecimal nquantity;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nlocPlSubstKey", column = @Column(name = "NLOC_PL_SUBST_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nplIndexKey", column = @Column(name = "NPL_INDEX_KEY", nullable = false, precision = 12, scale = 0)) })
	public LocPlSubstFlightsId getId() {
		return this.id;
	}

	public void setId(final LocPlSubstFlightsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOC_PL_SUBST_KEY", nullable = false, insertable = false, updatable = false)
	public LocPlSubst getLocPlSubst() {
		return this.locPlSubst;
	}

	public void setLocPlSubst(final LocPlSubst locPlSubst) {
		this.locPlSubst = locPlSubst;
	}

	@Column(name = "CAIRLINE", length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", precision = 6, scale = 0)
	public Integer getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final Integer nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Column(name = "CTLC_FROM", length = 3)
	public String getCtlcFrom() {
		return this.ctlcFrom;
	}

	public void setCtlcFrom(final String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	@Column(name = "CTLC_TO", length = 3)
	public String getCtlcTo() {
		return this.ctlcTo;
	}

	public void setCtlcTo(final String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CDEPARTURE_TIME", length = 5)
	public String getCdepartureTime() {
		return this.cdepartureTime;
	}

	public void setCdepartureTime(final String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
	}

	@Column(name = "CFLIGHT_KEY", length = 25)
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "NPARTIAL_SUBSTITUTION", precision = 1, scale = 0)
	public Integer getNpartialSubstitution() {
		return this.npartialSubstitution;
	}

	public void setNpartialSubstitution(final Integer npartialSubstitution) {
		this.npartialSubstitution = npartialSubstitution;
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

	@Column(name = "CSUBST_TEXT", length = 80)
	public String getCsubstText() {
		return this.csubstText;
	}

	public void setCsubstText(final String csubstText) {
		this.csubstText = csubstText;
	}

	@Column(name = "NQUANTITY", precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

}
