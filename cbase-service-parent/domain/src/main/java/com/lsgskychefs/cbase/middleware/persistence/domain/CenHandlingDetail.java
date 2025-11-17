package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Jul-2024 13:38:12 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_HANDLING_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_HANDLING_DETAIL", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "NAIRCRAFT_KEY", "CLOADINGLIST",
		"NHANDLING_TYPE_KEY", "NHANDLING_KEY", "DVALID_FROM", "CTIME_FROM", "NPAX_FROM", "CREGISTRATION" }))
public class CenHandlingDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhandlingDetailKey;
	private CenHandling cenHandling;
	private CenAirlines cenAirlinesByNairlineKey;
	private CenAirlines cenAirlinesByNcustomerKey;
	private int nprio;
	private long naircraftKey;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String ctimeFrom;
	private String ctimeTo;
	private int npaxFrom;
	private int npaxTo;
	private String cloadinglist;
	private long nhandlingTypeKey;
	private Long naccountKey;
	private String cadditionalAccount;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cregistration;

	@Id
	@Column(name = "NHANDLING_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingDetailKey() {
		return this.nhandlingDetailKey;
	}

	public void setNhandlingDetailKey(long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_KEY", nullable = false)
	public CenHandling getCenHandling() {
		return this.cenHandling;
	}

	public void setCenHandling(CenHandling cenHandling) {
		this.cenHandling = cenHandling;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlinesByNairlineKey() {
		return this.cenAirlinesByNairlineKey;
	}

	public void setCenAirlinesByNairlineKey(CenAirlines cenAirlinesByNairlineKey) {
		this.cenAirlinesByNairlineKey = cenAirlinesByNairlineKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCUSTOMER_KEY")
	public CenAirlines getCenAirlinesByNcustomerKey() {
		return this.cenAirlinesByNcustomerKey;
	}

	public void setCenAirlinesByNcustomerKey(CenAirlines cenAirlinesByNcustomerKey) {
		this.cenAirlinesByNcustomerKey = cenAirlinesByNcustomerKey;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "NAIRCRAFT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(long naircraftKey) {
		this.naircraftKey = naircraftKey;
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

	@Column(name = "CTIME_FROM", nullable = false, length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", nullable = false, length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Column(name = "NPAX_FROM", nullable = false, precision = 6, scale = 0)
	public int getNpaxFrom() {
		return this.npaxFrom;
	}

	public void setNpaxFrom(int npaxFrom) {
		this.npaxFrom = npaxFrom;
	}

	@Column(name = "NPAX_TO", nullable = false, precision = 6, scale = 0)
	public int getNpaxTo() {
		return this.npaxTo;
	}

	public void setNpaxTo(int npaxTo) {
		this.npaxTo = npaxTo;
	}

	@Column(name = "CLOADINGLIST", nullable = false, length = 36)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "NHANDLING_TYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey() {
		return this.nhandlingTypeKey;
	}

	public void setNhandlingTypeKey(long nhandlingTypeKey) {
		this.nhandlingTypeKey = nhandlingTypeKey;
	}

	@Column(name = "NACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNaccountKey() {
		return this.naccountKey;
	}

	public void setNaccountKey(Long naccountKey) {
		this.naccountKey = naccountKey;
	}

	@Column(name = "CADDITIONAL_ACCOUNT", length = 18)
	public String getCadditionalAccount() {
		return this.cadditionalAccount;
	}

	public void setCadditionalAccount(String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
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

	@Column(name = "CREGISTRATION", nullable = false, length = 40)
	public String getCregistration() {
		return this.cregistration;
	}

	public void setCregistration(String cregistration) {
		this.cregistration = cregistration;
	}

}


