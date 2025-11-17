package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;

/**
 * Entity(DomainObject) for table CEN_OUT_CHANGES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_CHANGES")
public class CenOutChanges implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutHistoryId id;

	private CenOutHistory cenOutHistory;

	private Set<CenOutChangesRead> cenOutChangesReads = new HashSet<>(0);

	private int nflight;

	private int ndateTime;

	private int nregistration;

	private int nrampbox;

	private int naircrafttype;

	private int nhandling;

	private int nversion;

	private int npassenger;

	private int nmeal;

	private int nspml;

	private int nextra;

	private int ntextinfo;

	private int nnewspaper;

	private int nflightStatus;

	private int nchangeNoMeals;

	private int nchangeNoExtra;

	private int nchangeNoNews;

	private int nstatus;

	private String choursBefore;

	private Date dtimestamp;

	private int nmealBilling;

	private int nspmlBilling;

	private int nextraBilling;

	private Integer nnewFlight;

	private String cusername;

	private String cipaddress;

	private Integer naddDelivery;

	private int nloading;

	private int naircraftNotFound;

	private int nregistrationNotFound;

	private int nspmlNotValid;

	private Long nairlineQpKey;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)) })
	public CenOutHistoryId getId() {
		return this.id;
	}

	public void setId(final CenOutHistoryId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenOutHistory getCenOutHistory() {
		return this.cenOutHistory;
	}

	public void setCenOutHistory(final CenOutHistory cenOutHistory) {
		this.cenOutHistory = cenOutHistory;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutChanges")
	public Set<CenOutChangesRead> getCenOutChangesReads() {
		return this.cenOutChangesReads;
	}

	public void setCenOutChangesReads(final Set<CenOutChangesRead> cenOutChangesReads) {
		this.cenOutChangesReads = cenOutChangesReads;
	}

	@Column(name = "NFLIGHT", nullable = false, precision = 1, scale = 0)
	public int getNflight() {
		return this.nflight;
	}

	public void setNflight(final int nflight) {
		this.nflight = nflight;
	}

	@Column(name = "NDATE_TIME", nullable = false, precision = 1, scale = 0)
	public int getNdateTime() {
		return this.ndateTime;
	}

	public void setNdateTime(final int ndateTime) {
		this.ndateTime = ndateTime;
	}

	@Column(name = "NREGISTRATION", nullable = false, precision = 1, scale = 0)
	public int getNregistration() {
		return this.nregistration;
	}

	public void setNregistration(final int nregistration) {
		this.nregistration = nregistration;
	}

	@Column(name = "NRAMPBOX", nullable = false, precision = 1, scale = 0)
	public int getNrampbox() {
		return this.nrampbox;
	}

	public void setNrampbox(final int nrampbox) {
		this.nrampbox = nrampbox;
	}

	@Column(name = "NAIRCRAFTTYPE", nullable = false, precision = 1, scale = 0)
	public int getNaircrafttype() {
		return this.naircrafttype;
	}

	public void setNaircrafttype(final int naircrafttype) {
		this.naircrafttype = naircrafttype;
	}

	@Column(name = "NHANDLING", nullable = false, precision = 1, scale = 0)
	public int getNhandling() {
		return this.nhandling;
	}

	public void setNhandling(final int nhandling) {
		this.nhandling = nhandling;
	}

	@Column(name = "NVERSION", nullable = false, precision = 1, scale = 0)
	public int getNversion() {
		return this.nversion;
	}

	public void setNversion(final int nversion) {
		this.nversion = nversion;
	}

	@Column(name = "NPASSENGER", nullable = false, precision = 1, scale = 0)
	public int getNpassenger() {
		return this.npassenger;
	}

	public void setNpassenger(final int npassenger) {
		this.npassenger = npassenger;
	}

	@Column(name = "NMEAL", nullable = false, precision = 1, scale = 0)
	public int getNmeal() {
		return this.nmeal;
	}

	public void setNmeal(final int nmeal) {
		this.nmeal = nmeal;
	}

	@Column(name = "NSPML", nullable = false, precision = 1, scale = 0)
	public int getNspml() {
		return this.nspml;
	}

	public void setNspml(final int nspml) {
		this.nspml = nspml;
	}

	@Column(name = "NEXTRA", nullable = false, precision = 1, scale = 0)
	public int getNextra() {
		return this.nextra;
	}

	public void setNextra(final int nextra) {
		this.nextra = nextra;
	}

	@Column(name = "NTEXTINFO", nullable = false, precision = 1, scale = 0)
	public int getNtextinfo() {
		return this.ntextinfo;
	}

	public void setNtextinfo(final int ntextinfo) {
		this.ntextinfo = ntextinfo;
	}

	@Column(name = "NNEWSPAPER", nullable = false, precision = 1, scale = 0)
	public int getNnewspaper() {
		return this.nnewspaper;
	}

	public void setNnewspaper(final int nnewspaper) {
		this.nnewspaper = nnewspaper;
	}

	@Column(name = "NFLIGHT_STATUS", nullable = false, precision = 1, scale = 0)
	public int getNflightStatus() {
		return this.nflightStatus;
	}

	public void setNflightStatus(final int nflightStatus) {
		this.nflightStatus = nflightStatus;
	}

	@Column(name = "NCHANGE_NO_MEALS", nullable = false, precision = 1, scale = 0)
	public int getNchangeNoMeals() {
		return this.nchangeNoMeals;
	}

	public void setNchangeNoMeals(final int nchangeNoMeals) {
		this.nchangeNoMeals = nchangeNoMeals;
	}

	@Column(name = "NCHANGE_NO_EXTRA", nullable = false, precision = 1, scale = 0)
	public int getNchangeNoExtra() {
		return this.nchangeNoExtra;
	}

	public void setNchangeNoExtra(final int nchangeNoExtra) {
		this.nchangeNoExtra = nchangeNoExtra;
	}

	@Column(name = "NCHANGE_NO_NEWS", nullable = false, precision = 1, scale = 0)
	public int getNchangeNoNews() {
		return this.nchangeNoNews;
	}

	public void setNchangeNoNews(final int nchangeNoNews) {
		this.nchangeNoNews = nchangeNoNews;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CHOURS_BEFORE", nullable = false, length = 5)
	public String getChoursBefore() {
		return this.choursBefore;
	}

	public void setChoursBefore(final String choursBefore) {
		this.choursBefore = choursBefore;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NMEAL_BILLING", nullable = false, precision = 1, scale = 0)
	public int getNmealBilling() {
		return this.nmealBilling;
	}

	public void setNmealBilling(final int nmealBilling) {
		this.nmealBilling = nmealBilling;
	}

	@Column(name = "NSPML_BILLING", nullable = false, precision = 1, scale = 0)
	public int getNspmlBilling() {
		return this.nspmlBilling;
	}

	public void setNspmlBilling(final int nspmlBilling) {
		this.nspmlBilling = nspmlBilling;
	}

	@Column(name = "NEXTRA_BILLING", nullable = false, precision = 1, scale = 0)
	public int getNextraBilling() {
		return this.nextraBilling;
	}

	public void setNextraBilling(final int nextraBilling) {
		this.nextraBilling = nextraBilling;
	}

	@Column(name = "NNEW_FLIGHT", precision = 1, scale = 0)
	public Integer getNnewFlight() {
		return this.nnewFlight;
	}

	public void setNnewFlight(final Integer nnewFlight) {
		this.nnewFlight = nnewFlight;
	}

	@Column(name = "CUSERNAME", nullable = false, length = 40)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(final String cusername) {
		this.cusername = cusername;
	}

	@Size(max = 50)
	@Column(name = "CIPADDRESS", nullable = false, length = 50)
	public String getCipaddress() {
		return this.cipaddress;
	}

	public void setCipaddress(final String cipaddress) {
		this.cipaddress = cipaddress;
	}

	@Column(name = "NADD_DELIVERY", precision = 1, scale = 0)
	public Integer getNaddDelivery() {
		return this.naddDelivery;
	}

	public void setNaddDelivery(final Integer naddDelivery) {
		this.naddDelivery = naddDelivery;
	}

	@Column(name = "NLOADING", precision = 1, scale = 0)
	public int getNloading() {
		return this.nloading;
	}

	public void setNloading(final int nloading) {
		this.nloading = nloading;
	}

	@Column(name = "NAIRCRAFT_NOT_FOUND", nullable = false, precision = 1, scale = 0)
	public int getNaircraftNotFound() {
		return this.naircraftNotFound;
	}

	public void setNaircraftNotFound(int naircraftNotFound) {
		this.naircraftNotFound = naircraftNotFound;
	}

	@Column(name = "NREGISTRATION_NOT_FOUND", nullable = false, precision = 1, scale = 0)
	public int getNregistrationNotFound() {
		return this.nregistrationNotFound;
	}

	public void setNregistrationNotFound(int nregistrationNotFound) {
		this.nregistrationNotFound = nregistrationNotFound;
	}

	@Column(name = "NSPML_NOT_VALID", nullable = false, precision = 1, scale = 0)
	public int getNspmlNotValid() {
		return this.nspmlNotValid;
	}

	public void setNspmlNotValid(int nspmlNotValid) {
		this.nspmlNotValid = nspmlNotValid;
	}

	@Column(name = "NAIRLINE_QP_KEY", precision = 12, scale = 0)
	public Long getNairlineQpKey() {
		return this.nairlineQpKey;
	}

	public void setNairlineQpKey(Long nairlineQpKey) {
		this.nairlineQpKey = nairlineQpKey;
	}
}
