package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 5, 2017 1:49:34 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.FlightChangeState;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_FLIGHTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_FLIGHTS")
public class CenOutPpmFlights implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmFlightsId id;

	private String cairline;

	private int nflightNumber;

	private String csuffix;

	private Date ddeparture;

	private String cdepartureTime;

	private String crampTime;

	private String ckitchenTime;

	private String cactype;

	private String cairlineOwner;

	private String cgalleyversion;

	private String cconfiguration;

	private int nlegNumber;

	private String cunit;

	private String cclient;

	private String ctlcFrom;

	private String ctlcTo;

	private String carrivalTime;

	private String cblockTime;

	private String ccountryFrom;

	private String ccountryTo;

	private String ctrafficArea;

	private String ctrafficAreaShort;

	private String chandlingTypeText;

	private String chandlingTypeDescription;

	private String crouting;

	private String croutingText;

	private String csortTime;

	private Date dtimestamp;

	private int nstatus;

	private int nuserModified;

	private String cdescription;

	private String cregistration;

	private String cboxFrom;

	private String cboxTo;

	private Integer nflightStatus;

	private String cheader1;

	private String cheader2;

	private String ccustomer;

	private Date dreturnDate;

	private int nfreeze;

	private String cpax;

	private String cclasses;

	private String cunitText;

	private Date dfreezeDate;

	private String cdreezeUser;

	private String cpaxAll;

	private String cclassesAll;

	private Long naircraftKey;

	private Long nhandlingTypeKey;

	private Date ddepartureTime;

	private Date drampTime;

	private Date dkitchenTime;

	private int nequipmentChecked;

	private Date dtimestampMd;

	private boolean ncsoFlightClosed;

	private int nacTimeChange;

	private Long nresultKeyGroup;

	private int nmypaStatus;

	// Custom Join!
	@JsonView(View.SpecialRelation.class)
	private CenAircraft cenAircraft;

	@JsonIgnore
	private Set<CenOutPpm> cenOutPpms = new HashSet<>(0);

	private Set<CenOutPpmTrail> cenOutPpmTrails = new HashSet<>(0);

	private Set<CenOutPpmFlightsCsost> cenOutPpmFlightsCsosts = new HashSet<>(0);

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmFlightsId getId() {
		return this.id;
	}

	public void setId(final CenOutPpmFlightsId id) {
		this.id = id;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CDEPARTURE_TIME", nullable = false, length = 5)
	public String getCdepartureTime() {
		return this.cdepartureTime;
	}

	public void setCdepartureTime(final String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
	}

	@Column(name = "CRAMP_TIME", nullable = false, length = 5)
	public String getCrampTime() {
		return this.crampTime;
	}

	public void setCrampTime(final String crampTime) {
		this.crampTime = crampTime;
	}

	@Column(name = "CKITCHEN_TIME", nullable = false, length = 5)
	public String getCkitchenTime() {
		return this.ckitchenTime;
	}

	public void setCkitchenTime(final String ckitchenTime) {
		this.ckitchenTime = ckitchenTime;
	}

	@Column(name = "CACTYPE", nullable = false, length = 10)
	public String getCactype() {
		return this.cactype;
	}

	public void setCactype(final String cactype) {
		this.cactype = cactype;
	}

	@Column(name = "CAIRLINE_OWNER", nullable = false, length = 6)
	public String getCairlineOwner() {
		return this.cairlineOwner;
	}

	public void setCairlineOwner(final String cairlineOwner) {
		this.cairlineOwner = cairlineOwner;
	}

	@Column(name = "CGALLEYVERSION", nullable = false, length = 10)
	public String getCgalleyversion() {
		return this.cgalleyversion;
	}

	public void setCgalleyversion(final String cgalleyversion) {
		this.cgalleyversion = cgalleyversion;
	}

	@Column(name = "CCONFIGURATION", length = 20)
	public String getCconfiguration() {
		return this.cconfiguration;
	}

	public void setCconfiguration(final String cconfiguration) {
		this.cconfiguration = cconfiguration;
	}

	@Column(name = "NLEG_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNlegNumber() {
		return this.nlegNumber;
	}

	public void setNlegNumber(final int nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CTLC_FROM", nullable = false, length = 3)
	public String getCtlcFrom() {
		return this.ctlcFrom;
	}

	public void setCtlcFrom(final String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	@Column(name = "CTLC_TO", nullable = false, length = 3)
	public String getCtlcTo() {
		return this.ctlcTo;
	}

	public void setCtlcTo(final String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	@Column(name = "CARRIVAL_TIME", nullable = false, length = 5)
	public String getCarrivalTime() {
		return this.carrivalTime;
	}

	public void setCarrivalTime(final String carrivalTime) {
		this.carrivalTime = carrivalTime;
	}

	@Column(name = "CBLOCK_TIME", nullable = false, length = 5)
	public String getCblockTime() {
		return this.cblockTime;
	}

	public void setCblockTime(final String cblockTime) {
		this.cblockTime = cblockTime;
	}

	@Column(name = "CCOUNTRY_FROM", nullable = false, length = 5)
	public String getCcountryFrom() {
		return this.ccountryFrom;
	}

	public void setCcountryFrom(final String ccountryFrom) {
		this.ccountryFrom = ccountryFrom;
	}

	@Column(name = "CCOUNTRY_TO", nullable = false, length = 5)
	public String getCcountryTo() {
		return this.ccountryTo;
	}

	public void setCcountryTo(final String ccountryTo) {
		this.ccountryTo = ccountryTo;
	}

	@Column(name = "CTRAFFIC_AREA", nullable = false, length = 40)
	public String getCtrafficArea() {
		return this.ctrafficArea;
	}

	public void setCtrafficArea(final String ctrafficArea) {
		this.ctrafficArea = ctrafficArea;
	}

	@Column(name = "CTRAFFIC_AREA_SHORT", nullable = false, length = 6)
	public String getCtrafficAreaShort() {
		return this.ctrafficAreaShort;
	}

	public void setCtrafficAreaShort(final String ctrafficAreaShort) {
		this.ctrafficAreaShort = ctrafficAreaShort;
	}

	@Column(name = "CHANDLING_TYPE_TEXT", nullable = false, length = 30)
	public String getChandlingTypeText() {
		return this.chandlingTypeText;
	}

	public void setChandlingTypeText(final String chandlingTypeText) {
		this.chandlingTypeText = chandlingTypeText;
	}

	@Column(name = "CHANDLING_TYPE_DESCRIPTION", nullable = false, length = 256)
	public String getChandlingTypeDescription() {
		return this.chandlingTypeDescription;
	}

	public void setChandlingTypeDescription(final String chandlingTypeDescription) {
		this.chandlingTypeDescription = chandlingTypeDescription;
	}

	@Column(name = "CROUTING", nullable = false, length = 5)
	public String getCrouting() {
		return this.crouting;
	}

	public void setCrouting(final String crouting) {
		this.crouting = crouting;
	}

	@Column(name = "CROUTING_TEXT", nullable = false, length = 15)
	public String getCroutingText() {
		return this.croutingText;
	}

	public void setCroutingText(final String croutingText) {
		this.croutingText = croutingText;
	}

	@Column(name = "CSORT_TIME", nullable = false, length = 5)
	public String getCsortTime() {
		return this.csortTime;
	}

	public void setCsortTime(final String csortTime) {
		this.csortTime = csortTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "NUSER_MODIFIED", nullable = false, precision = 2, scale = 0)
	public int getNuserModified() {
		return this.nuserModified;
	}

	public void setNuserModified(final int nuserModified) {
		this.nuserModified = nuserModified;
	}

	@Column(name = "CDESCRIPTION", length = 30)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CREGISTRATION", length = 10)
	public String getCregistration() {
		return this.cregistration;
	}

	public void setCregistration(final String cregistration) {
		this.cregistration = cregistration;
	}

	@Column(name = "CBOX_FROM", length = 10)
	public String getCboxFrom() {
		return this.cboxFrom;
	}

	public void setCboxFrom(final String cboxFrom) {
		this.cboxFrom = cboxFrom;
	}

	@Column(name = "CBOX_TO", length = 10)
	public String getCboxTo() {
		return this.cboxTo;
	}

	public void setCboxTo(final String cboxTo) {
		this.cboxTo = cboxTo;
	}

	@Column(name = "NFLIGHT_STATUS", precision = 2, scale = 0)
	public Integer getNflightStatus() {
		return this.nflightStatus;
	}

	public void setNflightStatus(final Integer nflightStatus) {
		this.nflightStatus = nflightStatus;
	}

	@Column(name = "CHEADER1", length = 40)
	public String getCheader1() {
		return this.cheader1;
	}

	public void setCheader1(final String cheader1) {
		this.cheader1 = cheader1;
	}

	@Column(name = "CHEADER2", length = 40)
	public String getCheader2() {
		return this.cheader2;
	}

	public void setCheader2(final String cheader2) {
		this.cheader2 = cheader2;
	}

	@Column(name = "CCUSTOMER", length = 6)
	public String getCcustomer() {
		return this.ccustomer;
	}

	public void setCcustomer(final String ccustomer) {
		this.ccustomer = ccustomer;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRETURN_DATE", length = 7)
	public Date getDreturnDate() {
		return this.dreturnDate;
	}

	public void setDreturnDate(final Date dreturnDate) {
		this.dreturnDate = dreturnDate;
	}

	@Column(name = "NFREEZE", nullable = false, precision = 1, scale = 0)
	public int getNfreeze() {
		return this.nfreeze;
	}

	public void setNfreeze(final int nfreeze) {
		this.nfreeze = nfreeze;
	}

	@Column(name = "CPAX", length = 40)
	public String getCpax() {
		return this.cpax;
	}

	public void setCpax(final String cpax) {
		this.cpax = cpax;
	}

	@Column(name = "CCLASSES", length = 40)
	public String getCclasses() {
		return this.cclasses;
	}

	public void setCclasses(final String cclasses) {
		this.cclasses = cclasses;
	}

	@Column(name = "CUNIT_TEXT", length = 30)
	public String getCunitText() {
		return this.cunitText;
	}

	public void setCunitText(final String cunitText) {
		this.cunitText = cunitText;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DFREEZE_DATE", length = 7)
	public Date getDfreezeDate() {
		return this.dfreezeDate;
	}

	public void setDfreezeDate(final Date dfreezeDate) {
		this.dfreezeDate = dfreezeDate;
	}

	@Column(name = "CDREEZE_USER", length = 40)
	public String getCdreezeUser() {
		return this.cdreezeUser;
	}

	public void setCdreezeUser(final String cdreezeUser) {
		this.cdreezeUser = cdreezeUser;
	}

	@Column(name = "CPAX_ALL", length = 40)
	public String getCpaxAll() {
		return this.cpaxAll;
	}

	public void setCpaxAll(final String cpaxAll) {
		this.cpaxAll = cpaxAll;
	}

	@Column(name = "CCLASSES_ALL", length = 40)
	public String getCclassesAll() {
		return this.cclassesAll;
	}

	public void setCclassesAll(final String cclassesAll) {
		this.cclassesAll = cclassesAll;
	}

	@Column(name = "NAIRCRAFT_KEY", precision = 12, scale = 0)
	public Long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final Long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@Column(name = "NHANDLING_TYPE_KEY", precision = 12, scale = 0)
	public Long getNhandlingTypeKey() {
		return this.nhandlingTypeKey;
	}

	public void setNhandlingTypeKey(final Long nhandlingTypeKey) {
		this.nhandlingTypeKey = nhandlingTypeKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE_TIME", length = 7)
	public Date getDdepartureTime() {
		return this.ddepartureTime;
	}

	public void setDdepartureTime(final Date ddepartureTime) {
		this.ddepartureTime = ddepartureTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRAMP_TIME", length = 7)
	public Date getDrampTime() {
		return this.drampTime;
	}

	public void setDrampTime(final Date drampTime) {
		this.drampTime = drampTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DKITCHEN_TIME", length = 7)
	public Date getDkitchenTime() {
		return this.dkitchenTime;
	}

	public void setDkitchenTime(final Date dkitchenTime) {
		this.dkitchenTime = dkitchenTime;
	}

	@Column(name = "NEQUIPMENT_CHECKED", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNequipmentChecked() {
		return this.nequipmentChecked;
	}

	public void setNequipmentChecked(final int nequipmentChecked) {
		this.nequipmentChecked = nequipmentChecked;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MD", length = 7)
	public Date getDtimestampMd() {
		return this.dtimestampMd;
	}

	public void setDtimestampMd(final Date dtimestampMd) {
		this.dtimestampMd = dtimestampMd;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmFlights")
	public Set<CenOutPpm> getCenOutPpms() {
		return this.cenOutPpms;
	}

	@Column(name = "NCSO_FLIGHT_CLOSED", nullable = false, precision = 1, scale = 0)
	public boolean isNcsoFlightClosed() {
		return this.ncsoFlightClosed;
	}

	public void setNcsoFlightClosed(final boolean ncsoFlightClosed) {
		this.ncsoFlightClosed = ncsoFlightClosed;
	}

	/**
	 * @return flight change state value
	 * @see FlightChangeState
	 */
	@Column(name = "NAC_TIME_CHANGE", nullable = false, precision = 1, scale = 0)
	public int getNacTimeChange() {
		return nacTimeChange;
	}

	/**
	 * @param nacTimeChange flight change state value
	 * @see FlightChangeState
	 */
	public void setNacTimeChange(final int nacTimeChange) {
		this.nacTimeChange = nacTimeChange;
	}

	@Column(name = "NRESULT_KEY_GROUP", precision = 12, scale = 0)
	public Long getNresultKeyGroup() {
		return this.nresultKeyGroup;
	}

	public void setNresultKeyGroup(final Long nresultKeyGroup) {
		this.nresultKeyGroup = nresultKeyGroup;
	}

	public void setCenOutPpms(final Set<CenOutPpm> cenOutPpms) {
		this.cenOutPpms = cenOutPpms;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmFlights")
	public Set<CenOutPpmTrail> getCenOutPpmTrails() {
		return this.cenOutPpmTrails;
	}

	public void setCenOutPpmTrails(final Set<CenOutPpmTrail> cenOutPpmTrails) {
		this.cenOutPpmTrails = cenOutPpmTrails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmFlights")
	public Set<CenOutPpmFlightsCsost> getCenOutPpmFlightsCsosts() {
		return this.cenOutPpmFlightsCsosts;
	}

	public void setCenOutPpmFlightsCsosts(final Set<CenOutPpmFlightsCsost> cenOutPpmFlightsCsosts) {
		this.cenOutPpmFlightsCsosts = cenOutPpmFlightsCsosts;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", insertable = false, updatable = false)
	public CenAircraft getCenAircraft() {
		return cenAircraft;
	}

	public void setCenAircraft(final CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
	}

	@Column(name = "NMYPA_STATUS", nullable = false, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNmypaStatus() {
		return this.nmypaStatus;
	}

	public void setNmypaStatus(int nmypaStatus) {
		this.nmypaStatus = nmypaStatus;
	}
}
