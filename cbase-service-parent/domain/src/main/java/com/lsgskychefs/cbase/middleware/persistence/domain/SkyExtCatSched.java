package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "SKY_EXT_CAT_SCHED")
public class SkyExtCatSched implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SKY_EXT_CAT_SCHED")
	@SequenceGenerator(name = "SEQ_SKY_EXT_CAT_SCHED", sequenceName = "SEQ_SKY_EXT_CAT_SCHED", allocationSize = 1)
	@Column(name = "NEXT_CAT_KEY", nullable = false)
	private Long id;

	@NotNull
	@Column(name = "NCAT_KEY", nullable = false)
	private Long ncatKey;

	@NotNull
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "NSTATUS", nullable = false)
	private SkyExtCatStatus nstatus;

	@NotNull
	@Column(name = "NCAT_GROUP_KEY", nullable = false)
	private Long ncatGroupKey;

	@Size(max = 6)
	@NotNull
	@Column(name = "CAIRLINE", nullable = false, length = 6)
	private String cairline;

	@NotNull
	@Column(name = "NFLIGHT_NUMBER", nullable = false)
	private Integer nflightNumber;

	@Size(max = 3)
	@NotNull
	@Column(name = "CSUFFIX", nullable = false, length = 3)
	private String csuffix;

	@NotNull
	@Column(name = "DDEPARTURE", nullable = false)
	private Date ddeparture;

	@Size(max = 5)
	@NotNull
	@Column(name = "CDEPARTURE_TIME", nullable = false, length = 5)
	private String cdepartureTime;

	@Size(max = 6)
	@Column(name = "CAIRLINE_OWNER", length = 6)
	private String cairlineOwner;

	@Size(max = 10)
	@NotNull
	@Column(name = "CACTYPE", nullable = false, length = 10)
	private String cactype;

	@Size(max = 10)
	@Column(name = "CGALLEYVERSION", length = 10)
	private String cgalleyversion;

	@Size(max = 20)
	@Column(name = "CCONFIGURATION", length = 20)
	private String cconfiguration;

	@NotNull
	@Column(name = "NLEG_NUMBER", nullable = false)
	private Integer nlegNumber;

	@Size(max = 4)
	@NotNull
	@Column(name = "CUNIT", nullable = false, length = 4)
	private String cunit;

	@Size(max = 3)
	@NotNull
	@Column(name = "CTLC_FROM", nullable = false, length = 3)
	private String ctlcFrom;

	@Size(max = 3)
	@NotNull
	@Column(name = "CTLC_TO", nullable = false, length = 3)
	private String ctlcTo;

	@Size(max = 30)
	@Column(name = "CHANDLING_TYPE_TEXT", length = 30)
	private String chandlingTypeText;

	@Size(max = 3)
	@Column(name = "CROUTING", length = 3)
	private String crouting;

	@NotNull
	@Column(name = "DTIMESTAMP", nullable = false)
	private Date dtimestamp;

	@Size(max = 40)
	@NotNull
	@Column(name = "CCHANGED", nullable = false, length = 40)
	private String cchanged;

	@NotNull
	@Column(name = "NOFFSET_DAYS", nullable = false)
	private Short noffsetDays;

	@Size(max = 5)
	@Column(name = "CSORT_TIME", length = 5)
	private String csortTime;

	@Size(max = 4)
	@Column(name = "CBORDINGSTATION", length = 4)
	private String cbordingstation;

	@Size(max = 25)
	@NotNull
	@Column(name = "CFLIGHT_KEY", nullable = false, length = 25)
	private String cflightKey;

	@Column(name = "NCATERER_ID")
	private Long ncatererId;

	@Size(max = 40)
	@Column(name = "CCATERER", length = 40)
	private String ccaterer;

	@Size(max = 11)
	@Column(name = "CREGISTRATION", length = 11)
	private String cregistration;

	@Size(max = 10)
	@Column(name = "CBOX_FROM", length = 10)
	private String cboxFrom;

	@Size(max = 10)
	@Column(name = "CBOX_TO", length = 10)
	private String cboxTo;

	@NotNull
	@Column(name = "NDELIVERY_NOTE_NO", nullable = false)
	private Long ndeliveryNoteNo;

	@Size(max = 20)
	@Column(name = "CFLIGHT_ID", length = 20)
	private String cflightId;

	@Column(name = "DFLIGHT_DATE_UTC")
	private Date dflightDateUtc;

	@Column(name = "DFLIGHT_DATE_LOC")
	private Date dflightDateLoc;

	@Column(name = "DDEPARTURE_UTC")
	private Date ddepartureUtc;

	@Size(max = 10)
	@Column(name = "CDEP_COUNTRY", length = 10)
	private String cdepCountry;

	@Column(name = "DARRIVAL_UTC")
	private Date darrivalUtc;

	@Column(name = "DARRIVAL_LOC")
	private Date darrivalLoc;

	@Size(max = 10)
	@Column(name = "CARR_COUNTRY", length = 10)
	private String carrCountry;

	@Size(max = 10)
	@Column(name = "CSUBFLEETTYPE", length = 10)
	private String csubfleettype;

	@Size(max = 3)
	@Column(name = "CSERVICE_TYPE_CODE", length = 3)
	private String cserviceTypeCode;

	@Size(max = 40)
	@Column(name = "CSTATUS", length = 40)
	private String cstatus;

	@Size(max = 40)
	@Column(name = "CACTION", length = 40)
	private String caction;

	@Column(name = "NEXPIRES_ON")
	private Long nexpiresOn;

	@Column(name = "DUPDATE_TIME_UTC")
	private Date dupdateTimeUtc;

	@Column(name = "DDEPARTURE_LOC")
	private Date ddepartureLoc;

	@Size(max = 20)
	@NotNull
	@Column(name = "CFLIGHT_ID_MASTER", nullable = false, length = 20)
	private String cflightIdMaster;

	@NotNull
	@Column(name = "DFLIGHT_DATE_UTC_MASTER", nullable = false)
	private Date dflightDateUtcMaster;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
	    @JoinColumn(name = "CAIRLINE", referencedColumnName = "CAIRLINE", insertable = false, updatable = false),
	    @JoinColumn(name = "NFLIGHT_NUMBER", referencedColumnName = "NFLIGHT_NUMBER", insertable = false, updatable = false)
	})
	private CenBobFlightSeal flightSeal;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getNcatKey() {
		return ncatKey;
	}

	public void setNcatKey(Long ncatKey) {
		this.ncatKey = ncatKey;
	}

	public SkyExtCatStatus getNstatus() {
		return nstatus;
	}

	public void setNstatus(SkyExtCatStatus nstatus) {
		this.nstatus = nstatus;
	}

	public Long getNcatGroupKey() {
		return ncatGroupKey;
	}

	public void setNcatGroupKey(Long ncatGroupKey) {
		this.ncatGroupKey = ncatGroupKey;
	}

	public String getCairline() {
		return cairline;
	}

	public void setCairline(String cairline) {
		this.cairline = cairline;
	}

	public Integer getNflightNumber() {
		return nflightNumber;
	}

	public void setNflightNumber(Integer nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	public String getCsuffix() {
		return csuffix;
	}

	public void setCsuffix(String csuffix) {
		this.csuffix = csuffix;
	}

	public Date getDdeparture() {
		return ddeparture;
	}

	public void setDdeparture(Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	public String getCdepartureTime() {
		return cdepartureTime;
	}

	public void setCdepartureTime(String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
	}

	public String getCairlineOwner() {
		return cairlineOwner;
	}

	public void setCairlineOwner(String cairlineOwner) {
		this.cairlineOwner = cairlineOwner;
	}

	public String getCactype() {
		return cactype;
	}

	public void setCactype(String cactype) {
		this.cactype = cactype;
	}

	public String getCgalleyversion() {
		return cgalleyversion;
	}

	public void setCgalleyversion(String cgalleyversion) {
		this.cgalleyversion = cgalleyversion;
	}

	public String getCconfiguration() {
		return cconfiguration;
	}

	public void setCconfiguration(String cconfiguration) {
		this.cconfiguration = cconfiguration;
	}

	public Integer getNlegNumber() {
		return nlegNumber;
	}

	public void setNlegNumber(Integer nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	public String getCunit() {
		return cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	public String getCtlcFrom() {
		return ctlcFrom;
	}

	public void setCtlcFrom(String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	public String getCtlcTo() {
		return ctlcTo;
	}

	public void setCtlcTo(String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	public String getChandlingTypeText() {
		return chandlingTypeText;
	}

	public void setChandlingTypeText(String chandlingTypeText) {
		this.chandlingTypeText = chandlingTypeText;
	}

	public String getCrouting() {
		return crouting;
	}

	public void setCrouting(String crouting) {
		this.crouting = crouting;
	}

	public Date getDtimestamp() {
		return dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	public String getCchanged() {
		return cchanged;
	}

	public void setCchanged(String cchanged) {
		this.cchanged = cchanged;
	}

	public Short getNoffsetDays() {
		return noffsetDays;
	}

	public void setNoffsetDays(Short noffsetDays) {
		this.noffsetDays = noffsetDays;
	}

	public String getCsortTime() {
		return csortTime;
	}

	public void setCsortTime(String csortTime) {
		this.csortTime = csortTime;
	}

	public String getCbordingstation() {
		return cbordingstation;
	}

	public void setCbordingstation(String cbordingstation) {
		this.cbordingstation = cbordingstation;
	}

	public String getCflightKey() {
		return cflightKey;
	}

	public void setCflightKey(String cflightKey) {
		this.cflightKey = cflightKey;
	}

	public Long getNcatererId() {
		return ncatererId;
	}

	public void setNcatererId(Long ncatererId) {
		this.ncatererId = ncatererId;
	}

	public String getCcaterer() {
		return ccaterer;
	}

	public void setCcaterer(String ccaterer) {
		this.ccaterer = ccaterer;
	}

	public String getCregistration() {
		return cregistration;
	}

	public void setCregistration(String cregistration) {
		this.cregistration = cregistration;
	}

	public String getCboxFrom() {
		return cboxFrom;
	}

	public void setCboxFrom(String cboxFrom) {
		this.cboxFrom = cboxFrom;
	}

	public String getCboxTo() {
		return cboxTo;
	}

	public void setCboxTo(String cboxTo) {
		this.cboxTo = cboxTo;
	}

	public Long getNdeliveryNoteNo() {
		return ndeliveryNoteNo;
	}

	public void setNdeliveryNoteNo(Long ndeliveryNoteNo) {
		this.ndeliveryNoteNo = ndeliveryNoteNo;
	}

	public String getCflightId() {
		return cflightId;
	}

	public void setCflightId(String cflightId) {
		this.cflightId = cflightId;
	}

	public Date getDflightDateUtc() {
		return dflightDateUtc;
	}

	public void setDflightDateUtc(Date dflightDateUtc) {
		this.dflightDateUtc = dflightDateUtc;
	}

	public Date getDflightDateLoc() {
		return dflightDateLoc;
	}

	public void setDflightDateLoc(Date dflightDateLoc) {
		this.dflightDateLoc = dflightDateLoc;
	}

	public Date getDdepartureUtc() {
		return ddepartureUtc;
	}

	public void setDdepartureUtc(Date ddepartureUtc) {
		this.ddepartureUtc = ddepartureUtc;
	}

	public String getCdepCountry() {
		return cdepCountry;
	}

	public void setCdepCountry(String cdepCountry) {
		this.cdepCountry = cdepCountry;
	}

	public Date getDarrivalUtc() {
		return darrivalUtc;
	}

	public void setDarrivalUtc(Date darrivalUtc) {
		this.darrivalUtc = darrivalUtc;
	}

	public Date getDarrivalLoc() {
		return darrivalLoc;
	}

	public void setDarrivalLoc(Date darrivalLoc) {
		this.darrivalLoc = darrivalLoc;
	}

	public String getCarrCountry() {
		return carrCountry;
	}

	public void setCarrCountry(String carrCountry) {
		this.carrCountry = carrCountry;
	}

	public String getCsubfleettype() {
		return csubfleettype;
	}

	public void setCsubfleettype(String csubfleettype) {
		this.csubfleettype = csubfleettype;
	}

	public String getCserviceTypeCode() {
		return cserviceTypeCode;
	}

	public void setCserviceTypeCode(String cserviceTypeCode) {
		this.cserviceTypeCode = cserviceTypeCode;
	}

	public String getCstatus() {
		return cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

	public String getCaction() {
		return caction;
	}

	public void setCaction(String caction) {
		this.caction = caction;
	}

	public Long getNexpiresOn() {
		return nexpiresOn;
	}

	public void setNexpiresOn(Long nexpiresOn) {
		this.nexpiresOn = nexpiresOn;
	}

	public Date getDupdateTimeUtc() {
		return dupdateTimeUtc;
	}

	public void setDupdateTimeUtc(Date dupdateTimeUtc) {
		this.dupdateTimeUtc = dupdateTimeUtc;
	}

	public Date getDdepartureLoc() {
		return ddepartureLoc;
	}

	public void setDdepartureLoc(Date ddepartureLoc) {
		this.ddepartureLoc = ddepartureLoc;
	}

	public String getCflightIdMaster() {
		return cflightIdMaster;
	}

	public void setCflightIdMaster(String cflightIdMaster) {
		this.cflightIdMaster = cflightIdMaster;
	}

	public Date getDflightDateUtcMaster() {
		return dflightDateUtcMaster;
	}

	public void setDflightDateUtcMaster(Date dflightDateUtcMaster) {
		this.dflightDateUtcMaster = dflightDateUtcMaster;
	}

	public CenBobFlightSeal getFlightSeal() {
	    return flightSeal;
	}

	public void setFlightSeal(CenBobFlightSeal flightSeal) {
	    this.flightSeal = flightSeal;
	}

}
