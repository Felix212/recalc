package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenOutState;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_HISTORY {@link CenOut}
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_HISTORY")
public class CenOutHistory implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private CenOutHistoryId id;

	@JsonIgnore
	private long nroutingplanIndex;

	@JsonIgnore
	private long nroutingdetailKey;

	@JsonIgnore
	private long nroutingdetailKeyCp;

	@JsonIgnore
	private long nroutingGroupKey;

	@JsonIgnore
	private long nroutingGroupKeyCp;

	@JsonIgnore
	private long nairlineKey;

	@JsonView(View.Simple.class)
	private String cairline;

	@JsonView(View.Simple.class)
	private int nflightNumber;

	@JsonView(View.Simple.class)
	private String csuffix;

	@JsonView(View.Simple.class)
	private Date ddeparture;

	@JsonView(View.Simple.class)
	private String cdepartureTime;

	@JsonView(View.Simple.class)
	private String crampTime;

	@JsonView(View.Simple.class)
	private String ckitchenTime;

	@JsonView(View.Simple.class)
	private long naircraftKey;

	@JsonView(View.Simple.class)
	private String cactype;

	@JsonView(View.Simple.class)
	private long nairlineOwnerKey;

	@JsonView(View.Simple.class)
	private String cairlineOwner;

	@JsonView(View.Simple.class)
	private String cgalleyversion;

	@JsonView(View.Simple.class)
	private String cconfiguration;

	@JsonView(View.Simple.class)
	private int nlegNumber;

	@JsonView(View.Simple.class)
	private String cunit;

	@JsonView(View.Simple.class)
	private String cclient;

	@JsonView(View.Simple.class)
	private long ntlcFrom;

	@JsonView(View.Simple.class)
	private long ntlcTo;

	@JsonView(View.Simple.class)
	private String ctlcFrom;

	@JsonView(View.Simple.class)
	private String ctlcTo;

	@JsonView(View.Simple.class)
	private String carrivalTime;

	@JsonView(View.Simple.class)
	private String cblockTime;

	@JsonView(View.Simple.class)
	private long ncustomerKey;

	@JsonView(View.Simple.class)
	private String ccountryFrom;

	@JsonView(View.Simple.class)
	private String ccountryTo;

	@JsonView(View.Simple.class)
	private String ctrafficArea;

	@JsonView(View.Simple.class)
	private String ctrafficAreaShort;

	@JsonView(View.Simple.class)
	private long nhandlingTypeKey;

	@JsonView(View.Simple.class)
	private String chandlingTypeText;

	@JsonView(View.Simple.class)
	private String chandlingTypeDescription;

	@JsonView(View.Simple.class)
	private long nroutingId;

	@JsonView(View.Simple.class)
	private String crouting;

	@JsonView(View.Simple.class)
	private String croutingText;

	@JsonView(View.Simple.class)
	private String csortTime;

	@JsonView(View.Simple.class)
	private long nparentTlcFrom;

	@JsonView(View.Simple.class)
	private Date dtimestamp;

	/** @see CenOutState */
	@JsonView(View.Simple.class)
	private int nstatus;

	@JsonView(View.Simple.class)
	private int nuserModified;

	@JsonView(View.Simple.class)
	private String cdescription;

	@JsonView(View.Simple.class)
	private Date dgenerationDate;

	@JsonView(View.Simple.class)
	private String cregistration;

	@JsonView(View.Simple.class)
	private String cboxFrom;

	@JsonView(View.Simple.class)
	private String cboxTo;

	@JsonIgnore
	private long nquery;

	@JsonIgnore
	private Date doriginalDeparture;

	@JsonView(View.Simple.class)
	private int nflightStatus;

	@JsonIgnore
	private Long naccountKey;

	@JsonIgnore
	private String caccount;

	@JsonView(View.Simple.class)
	private String cheader1;

	@JsonView(View.Simple.class)
	private String cheader2;

	@JsonIgnore
	private Integer nstatusUpdate7;

	@JsonIgnore
	private Integer nrefund;

	@JsonIgnore
	private String ccustomer;

	@JsonIgnore
	private Integer nairlineType;

	@JsonIgnore
	private Integer nlegIdent;

	@JsonIgnore
	private Integer nbulkIdent;

	@JsonIgnore
	private Integer nmanualInput;

	@JsonIgnore
	private Long nresultKeyGroup;

	@JsonIgnore
	private String coriginalTime;

	@JsonIgnore
	private Integer npostingType;

	@JsonIgnore
	private Long nbillingKey;

	@JsonIgnore
	private String ccustomerCode;

	@JsonIgnore
	private Date dreturnDate;

	@JsonIgnore
	private Integer npostingStatus;

	@JsonIgnore
	private BigDecimal nchecksum;

	@JsonIgnore
	private Integer nnewFlight;

	@JsonIgnore
	private Integer naddDelivery;

	@JsonIgnore
	private Integer ncheckAc;

	@JsonIgnore
	private Integer ncheckTopoff;

	@JsonIgnore
	private Integer ncheckTextinfo;

	@JsonIgnore
	private Integer ncheckCnxmeals;

	@JsonIgnore
	private Integer ncheckNf;

	@JsonIgnore
	private Integer ncheckItems;

	@JsonIgnore
	private Integer ncheckManual;

	@JsonIgnore
	private Integer ncheckFcError;

	@JsonIgnore
	private Integer ncheckNoMeals;

	@JsonIgnore
	private Integer ncheckNoPrice;

	@JsonIgnore
	private Integer ncheckBillingCode;

	@JsonIgnore
	private Integer ncheckNewRow;

	@JsonIgnore
	private Integer ncheckVat;

	@JsonIgnore
	private Integer nqueued;

	@JsonIgnore
	private Integer nnoBilling;

	@JsonIgnore
	private String cairlineOrig;

	@JsonIgnore
	private Integer nflightNumberOrig;

	@JsonIgnore
	private String csuffixOrig;

	@JsonIgnore
	private Date ddepartureOrig;

	@JsonIgnore
	private String cdepartureTimeOrig;

	@JsonIgnore
	private Long nsupplier;

	@JsonIgnore
	private Integer nstatusAutoBilling;

	@JsonIgnore
	private Integer nstatusRelease;

	@JsonIgnore
	private Integer nstatusAutoRelease;

	@JsonIgnore
	private Integer ncheckCosttype;

	@JsonIgnore
	private Integer ncheckTaxcode;

	@JsonIgnore
	private Integer ncheckPriceUpdate;

	@JsonIgnore
	private Date dreleaseDate;

	@JsonIgnore
	private Date ddepartureTimeUtc;

	@JsonIgnore
	private Date darrivalTimeUtc;

	@JsonIgnore
	private Date darrivalTimeLoc;

	@JsonIgnore
	private Long nacgMasterKey;

	@JsonIgnore
	private Integer nqueuedReleaseInterface;

	@JsonIgnore
	private Long nopcodeKey;

	@JsonIgnore
	private String copcode;

	@JsonIgnore
	private Integer nresetCount;

	/** changed from int to Integer because it is nullable on FI DBs due to a very old prop introduced before REMA birthday */
	@JsonIgnore
	private Integer nlclMirrorFlag;

	@JsonIgnore
	private Long ummNkey;

	@JsonIgnore
	private Long cfinalAcOwner;

	@JsonIgnore
	private String cfinalAcType;

	@JsonIgnore
	private Integer nrecalcStatus;

	@JsonIgnore
	private Date drecalcDate;

	@JsonIgnore
	private Date ddepartureTimeLoc;

	@JsonIgnore
	private BigDecimal noffsetDep;

	@JsonIgnore
	private BigDecimal noffsetArr;

	@JsonIgnore
	private Integer nnotregenerate;

	@JsonIgnore
	private String cflightKey;

	@JsonIgnore
	private Integer ncfs;

	@JsonIgnore
	private Integer nmanualPackets;

	@JsonIgnore
	private Long nacGroupKey;

	@JsonIgnore
	private Integer ncfsPackets;

	@JsonIgnore
	private Integer ndutyTransfer;

	@JsonIgnore
	private Date ddutyTransferDate;

	@JsonIgnore
	private Integer nblockRampTime;

	@JsonIgnore
	private Integer nppmLock;

	@JsonIgnore
	private Integer ncheckReduction;

	@JsonIgnore
	private Integer nlocalSub;

	@JsonIgnore
	private Long nconfigurationKey;

	@JsonIgnore
	private Integer ncheckUnitprice;

	@JsonIgnore
	private Integer nfreeze;

	@JsonIgnore
	private String cadditionalAccount;

	@JsonIgnore
	private Long nflighttypeKey;

	@JsonIgnore
	private String cflighttype;

	@JsonIgnore
	private Integer nlockLoadinglist;

	@JsonIgnore
	private Integer nhasAcChange;

	@JsonIgnore
	private Integer ntb;

	@JsonIgnore
	private Integer nwabActive;

	@JsonIgnore
	private Integer nbillingLock;

	@JsonIgnore
	private Integer ncustomsTransfer;

	@JsonIgnore
	private int ncheckMissingSalesBom;

	@JsonIgnore
	private String cpoNumber;

	@JsonIgnore
	private Integer norderSent;

	@JsonIgnore
	private String csource;

	@JsonIgnore
	private Long nresultKeyCopy;

	@JsonIgnore
	private int ncheckMissingCosting;

	@JsonIgnore
	private int ncheckMissingMatmas;

	@JsonIgnore
	private Long ndeliveryNoteNo;

	@JsonIgnore
	private Set<CenOutPaxHistory> cenOutPaxHistories = new HashSet<>(0);

	@JsonIgnore
	private CenOutChanges cenOutChanges;

	@JsonIgnore
	private Set<CenOutMealsHistory> cenOutMealsHistories = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSpmlHistory> cenOutSpmlHistories = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutHandlingHistory> cenOutHandlingHistories = new HashSet<>(0);

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

	@Column(name = "NROUTINGPLAN_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNroutingplanIndex() {
		return this.nroutingplanIndex;
	}

	public void setNroutingplanIndex(final long nroutingplanIndex) {
		this.nroutingplanIndex = nroutingplanIndex;
	}

	@Column(name = "NROUTINGDETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNroutingdetailKey() {
		return this.nroutingdetailKey;
	}

	public void setNroutingdetailKey(final long nroutingdetailKey) {
		this.nroutingdetailKey = nroutingdetailKey;
	}

	@Column(name = "NROUTINGDETAIL_KEY_CP", nullable = false, precision = 12, scale = 0)
	public long getNroutingdetailKeyCp() {
		return this.nroutingdetailKeyCp;
	}

	public void setNroutingdetailKeyCp(final long nroutingdetailKeyCp) {
		this.nroutingdetailKeyCp = nroutingdetailKeyCp;
	}

	@Column(name = "NROUTING_GROUP_KEY", nullable = false, precision = 12, scale = 0)
	public long getNroutingGroupKey() {
		return this.nroutingGroupKey;
	}

	public void setNroutingGroupKey(final long nroutingGroupKey) {
		this.nroutingGroupKey = nroutingGroupKey;
	}

	@Column(name = "NROUTING_GROUP_KEY_CP", nullable = false, precision = 12, scale = 0)
	public long getNroutingGroupKeyCp() {
		return this.nroutingGroupKeyCp;
	}

	public void setNroutingGroupKeyCp(final long nroutingGroupKeyCp) {
		this.nroutingGroupKeyCp = nroutingGroupKeyCp;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
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

	@Column(name = "NAIRCRAFT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@Column(name = "CACTYPE", nullable = false, length = 10)
	public String getCactype() {
		return this.cactype;
	}

	public void setCactype(final String cactype) {
		this.cactype = cactype;
	}

	@Column(name = "NAIRLINE_OWNER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineOwnerKey() {
		return this.nairlineOwnerKey;
	}

	public void setNairlineOwnerKey(final long nairlineOwnerKey) {
		this.nairlineOwnerKey = nairlineOwnerKey;
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

	@Column(name = "CCONFIGURATION", length = 40)
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

	@Column(name = "NTLC_FROM", nullable = false, precision = 12, scale = 0)
	public long getNtlcFrom() {
		return this.ntlcFrom;
	}

	public void setNtlcFrom(final long ntlcFrom) {
		this.ntlcFrom = ntlcFrom;
	}

	@Column(name = "NTLC_TO", nullable = false, precision = 12, scale = 0)
	public long getNtlcTo() {
		return this.ntlcTo;
	}

	public void setNtlcTo(final long ntlcTo) {
		this.ntlcTo = ntlcTo;
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

	@Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcustomerKey() {
		return this.ncustomerKey;
	}

	public void setNcustomerKey(final long ncustomerKey) {
		this.ncustomerKey = ncustomerKey;
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

	@Column(name = "NHANDLING_TYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey() {
		return this.nhandlingTypeKey;
	}

	public void setNhandlingTypeKey(final long nhandlingTypeKey) {
		this.nhandlingTypeKey = nhandlingTypeKey;
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

	@Column(name = "NROUTING_ID", nullable = false, precision = 12, scale = 0)
	public long getNroutingId() {
		return this.nroutingId;
	}

	public void setNroutingId(final long nroutingId) {
		this.nroutingId = nroutingId;
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

	@Column(name = "NPARENT_TLC_FROM", nullable = false, precision = 12, scale = 0)
	public long getNparentTlcFrom() {
		return this.nparentTlcFrom;
	}

	public void setNparentTlcFrom(final long nparentTlcFrom) {
		this.nparentTlcFrom = nparentTlcFrom;
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

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DGENERATION_DATE", nullable = false, length = 7)
	public Date getDgenerationDate() {
		return this.dgenerationDate;
	}

	public void setDgenerationDate(final Date dgenerationDate) {
		this.dgenerationDate = dgenerationDate;
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

	@Column(name = "NQUERY", nullable = false, precision = 12, scale = 0)
	public long getNquery() {
		return this.nquery;
	}

	public void setNquery(final long nquery) {
		this.nquery = nquery;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DORIGINAL_DEPARTURE", nullable = false, length = 7)
	public Date getDoriginalDeparture() {
		return this.doriginalDeparture;
	}

	public void setDoriginalDeparture(final Date doriginalDeparture) {
		this.doriginalDeparture = doriginalDeparture;
	}

	@Column(name = "NFLIGHT_STATUS", nullable = false, precision = 2, scale = 0)
	public int getNflightStatus() {
		return this.nflightStatus;
	}

	public void setNflightStatus(final int nflightStatus) {
		this.nflightStatus = nflightStatus;
	}

	@Column(name = "NACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNaccountKey() {
		return this.naccountKey;
	}

	public void setNaccountKey(final Long naccountKey) {
		this.naccountKey = naccountKey;
	}

	@Column(name = "CACCOUNT", length = 18)
	public String getCaccount() {
		return this.caccount;
	}

	public void setCaccount(final String caccount) {
		this.caccount = caccount;
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

	@Column(name = "NSTATUS_UPDATE7", precision = 1, scale = 0)
	public Integer getNstatusUpdate7() {
		return this.nstatusUpdate7;
	}

	public void setNstatusUpdate7(final Integer nstatusUpdate7) {
		this.nstatusUpdate7 = nstatusUpdate7;
	}

	@Column(name = "NREFUND", precision = 1, scale = 0)
	public Integer getNrefund() {
		return this.nrefund;
	}

	public void setNrefund(final Integer nrefund) {
		this.nrefund = nrefund;
	}

	@Column(name = "CCUSTOMER", length = 6)
	public String getCcustomer() {
		return this.ccustomer;
	}

	public void setCcustomer(final String ccustomer) {
		this.ccustomer = ccustomer;
	}

	@Column(name = "NAIRLINE_TYPE", precision = 2, scale = 0)
	public Integer getNairlineType() {
		return this.nairlineType;
	}

	public void setNairlineType(final Integer nairlineType) {
		this.nairlineType = nairlineType;
	}

	@Column(name = "NLEG_IDENT", precision = 1, scale = 0)
	public Integer getNlegIdent() {
		return this.nlegIdent;
	}

	public void setNlegIdent(final Integer nlegIdent) {
		this.nlegIdent = nlegIdent;
	}

	@Column(name = "NBULK_IDENT", precision = 1, scale = 0)
	public Integer getNbulkIdent() {
		return this.nbulkIdent;
	}

	public void setNbulkIdent(final Integer nbulkIdent) {
		this.nbulkIdent = nbulkIdent;
	}

	@Column(name = "NMANUAL_INPUT", precision = 1, scale = 0)
	public Integer getNmanualInput() {
		return this.nmanualInput;
	}

	public void setNmanualInput(final Integer nmanualInput) {
		this.nmanualInput = nmanualInput;
	}

	@Column(name = "NRESULT_KEY_GROUP", precision = 12, scale = 0)
	public Long getNresultKeyGroup() {
		return this.nresultKeyGroup;
	}

	public void setNresultKeyGroup(final Long nresultKeyGroup) {
		this.nresultKeyGroup = nresultKeyGroup;
	}

	@Column(name = "CORIGINAL_TIME", length = 5)
	public String getCoriginalTime() {
		return this.coriginalTime;
	}

	public void setCoriginalTime(final String coriginalTime) {
		this.coriginalTime = coriginalTime;
	}

	@Column(name = "NPOSTING_TYPE", precision = 1, scale = 0)
	public Integer getNpostingType() {
		return this.npostingType;
	}

	public void setNpostingType(final Integer npostingType) {
		this.npostingType = npostingType;
	}

	@Column(name = "NBILLING_KEY", precision = 12, scale = 0)
	public Long getNbillingKey() {
		return this.nbillingKey;
	}

	public void setNbillingKey(final Long nbillingKey) {
		this.nbillingKey = nbillingKey;
	}

	@Column(name = "CCUSTOMER_CODE", length = 18)
	public String getCcustomerCode() {
		return this.ccustomerCode;
	}

	public void setCcustomerCode(final String ccustomerCode) {
		this.ccustomerCode = ccustomerCode;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRETURN_DATE", length = 7)
	public Date getDreturnDate() {
		return this.dreturnDate;
	}

	public void setDreturnDate(final Date dreturnDate) {
		this.dreturnDate = dreturnDate;
	}

	@Column(name = "NPOSTING_STATUS", precision = 1, scale = 0)
	public Integer getNpostingStatus() {
		return this.npostingStatus;
	}

	public void setNpostingStatus(final Integer npostingStatus) {
		this.npostingStatus = npostingStatus;
	}

	@Column(name = "NCHECKSUM", precision = 12, scale = 3)
	public BigDecimal getNchecksum() {
		return this.nchecksum;
	}

	public void setNchecksum(final BigDecimal nchecksum) {
		this.nchecksum = nchecksum;
	}

	@Column(name = "NNEW_FLIGHT", precision = 1, scale = 0)
	public Integer getNnewFlight() {
		return this.nnewFlight;
	}

	public void setNnewFlight(final Integer nnewFlight) {
		this.nnewFlight = nnewFlight;
	}

	@Column(name = "NADD_DELIVERY", precision = 1, scale = 0)
	public Integer getNaddDelivery() {
		return this.naddDelivery;
	}

	public void setNaddDelivery(final Integer naddDelivery) {
		this.naddDelivery = naddDelivery;
	}

	@Column(name = "NCHECK_AC", precision = 4, scale = 0)
	public Integer getNcheckAc() {
		return this.ncheckAc;
	}

	public void setNcheckAc(final Integer ncheckAc) {
		this.ncheckAc = ncheckAc;
	}

	@Column(name = "NCHECK_TOPOFF", precision = 1, scale = 0)
	public Integer getNcheckTopoff() {
		return this.ncheckTopoff;
	}

	public void setNcheckTopoff(final Integer ncheckTopoff) {
		this.ncheckTopoff = ncheckTopoff;
	}

	@Column(name = "NCHECK_TEXTINFO", precision = 1, scale = 0)
	public Integer getNcheckTextinfo() {
		return this.ncheckTextinfo;
	}

	public void setNcheckTextinfo(final Integer ncheckTextinfo) {
		this.ncheckTextinfo = ncheckTextinfo;
	}

	@Column(name = "NCHECK_CNXMEALS", precision = 1, scale = 0)
	public Integer getNcheckCnxmeals() {
		return this.ncheckCnxmeals;
	}

	public void setNcheckCnxmeals(final Integer ncheckCnxmeals) {
		this.ncheckCnxmeals = ncheckCnxmeals;
	}

	@Column(name = "NCHECK_NF", precision = 1, scale = 0)
	public Integer getNcheckNf() {
		return this.ncheckNf;
	}

	public void setNcheckNf(final Integer ncheckNf) {
		this.ncheckNf = ncheckNf;
	}

	@Column(name = "NCHECK_ITEMS", precision = 1, scale = 0)
	public Integer getNcheckItems() {
		return this.ncheckItems;
	}

	public void setNcheckItems(final Integer ncheckItems) {
		this.ncheckItems = ncheckItems;
	}

	@Column(name = "NCHECK_MANUAL", precision = 1, scale = 0)
	public Integer getNcheckManual() {
		return this.ncheckManual;
	}

	public void setNcheckManual(final Integer ncheckManual) {
		this.ncheckManual = ncheckManual;
	}

	@Column(name = "NCHECK_FC_ERROR", precision = 1, scale = 0)
	public Integer getNcheckFcError() {
		return this.ncheckFcError;
	}

	public void setNcheckFcError(final Integer ncheckFcError) {
		this.ncheckFcError = ncheckFcError;
	}

	@Column(name = "NCHECK_NO_MEALS", precision = 1, scale = 0)
	public Integer getNcheckNoMeals() {
		return this.ncheckNoMeals;
	}

	public void setNcheckNoMeals(final Integer ncheckNoMeals) {
		this.ncheckNoMeals = ncheckNoMeals;
	}

	@Column(name = "NCHECK_NO_PRICE", precision = 1, scale = 0)
	public Integer getNcheckNoPrice() {
		return this.ncheckNoPrice;
	}

	public void setNcheckNoPrice(final Integer ncheckNoPrice) {
		this.ncheckNoPrice = ncheckNoPrice;
	}

	@Column(name = "NCHECK_BILLING_CODE", precision = 1, scale = 0)
	public Integer getNcheckBillingCode() {
		return this.ncheckBillingCode;
	}

	public void setNcheckBillingCode(final Integer ncheckBillingCode) {
		this.ncheckBillingCode = ncheckBillingCode;
	}

	@Column(name = "NCHECK_NEW_ROW", precision = 1, scale = 0)
	public Integer getNcheckNewRow() {
		return this.ncheckNewRow;
	}

	public void setNcheckNewRow(final Integer ncheckNewRow) {
		this.ncheckNewRow = ncheckNewRow;
	}

	@Column(name = "NCHECK_VAT", precision = 1, scale = 0)
	public Integer getNcheckVat() {
		return this.ncheckVat;
	}

	public void setNcheckVat(final Integer ncheckVat) {
		this.ncheckVat = ncheckVat;
	}

	@Column(name = "NQUEUED", precision = 1, scale = 0)
	public Integer getNqueued() {
		return this.nqueued;
	}

	public void setNqueued(final Integer nqueued) {
		this.nqueued = nqueued;
	}

	@Column(name = "NNO_BILLING", precision = 1, scale = 0)
	public Integer getNnoBilling() {
		return this.nnoBilling;
	}

	public void setNnoBilling(final Integer nnoBilling) {
		this.nnoBilling = nnoBilling;
	}

	@Column(name = "CAIRLINE_ORIG", length = 6)
	public String getCairlineOrig() {
		return this.cairlineOrig;
	}

	public void setCairlineOrig(final String cairlineOrig) {
		this.cairlineOrig = cairlineOrig;
	}

	@Column(name = "NFLIGHT_NUMBER_ORIG", precision = 6, scale = 0)
	public Integer getNflightNumberOrig() {
		return this.nflightNumberOrig;
	}

	public void setNflightNumberOrig(final Integer nflightNumberOrig) {
		this.nflightNumberOrig = nflightNumberOrig;
	}

	@Column(name = "CSUFFIX_ORIG", length = 3)
	public String getCsuffixOrig() {
		return this.csuffixOrig;
	}

	public void setCsuffixOrig(final String csuffixOrig) {
		this.csuffixOrig = csuffixOrig;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE_ORIG", length = 7)
	public Date getDdepartureOrig() {
		return this.ddepartureOrig;
	}

	public void setDdepartureOrig(final Date ddepartureOrig) {
		this.ddepartureOrig = ddepartureOrig;
	}

	@Column(name = "CDEPARTURE_TIME_ORIG", length = 5)
	public String getCdepartureTimeOrig() {
		return this.cdepartureTimeOrig;
	}

	public void setCdepartureTimeOrig(final String cdepartureTimeOrig) {
		this.cdepartureTimeOrig = cdepartureTimeOrig;
	}

	@Column(name = "NSUPPLIER", precision = 12, scale = 0)
	public Long getNsupplier() {
		return this.nsupplier;
	}

	public void setNsupplier(final Long nsupplier) {
		this.nsupplier = nsupplier;
	}

	@Column(name = "NSTATUS_AUTO_BILLING", precision = 1, scale = 0)
	public Integer getNstatusAutoBilling() {
		return this.nstatusAutoBilling;
	}

	public void setNstatusAutoBilling(final Integer nstatusAutoBilling) {
		this.nstatusAutoBilling = nstatusAutoBilling;
	}

	@Column(name = "NSTATUS_RELEASE", precision = 2, scale = 0)
	public Integer getNstatusRelease() {
		return this.nstatusRelease;
	}

	public void setNstatusRelease(final Integer nstatusRelease) {
		this.nstatusRelease = nstatusRelease;
	}

	@Column(name = "NSTATUS_AUTO_RELEASE", precision = 1, scale = 0)
	public Integer getNstatusAutoRelease() {
		return this.nstatusAutoRelease;
	}

	public void setNstatusAutoRelease(final Integer nstatusAutoRelease) {
		this.nstatusAutoRelease = nstatusAutoRelease;
	}

	@Column(name = "NCHECK_COSTTYPE", precision = 1, scale = 0)
	public Integer getNcheckCosttype() {
		return this.ncheckCosttype;
	}

	public void setNcheckCosttype(final Integer ncheckCosttype) {
		this.ncheckCosttype = ncheckCosttype;
	}

	@Column(name = "NCHECK_TAXCODE", precision = 1, scale = 0)
	public Integer getNcheckTaxcode() {
		return this.ncheckTaxcode;
	}

	public void setNcheckTaxcode(final Integer ncheckTaxcode) {
		this.ncheckTaxcode = ncheckTaxcode;
	}

	@Column(name = "NCHECK_PRICE_UPDATE", precision = 1, scale = 0)
	public Integer getNcheckPriceUpdate() {
		return this.ncheckPriceUpdate;
	}

	public void setNcheckPriceUpdate(final Integer ncheckPriceUpdate) {
		this.ncheckPriceUpdate = ncheckPriceUpdate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRELEASE_DATE", length = 7)
	public Date getDreleaseDate() {
		return this.dreleaseDate;
	}

	public void setDreleaseDate(final Date dreleaseDate) {
		this.dreleaseDate = dreleaseDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE_TIME_UTC", length = 7)
	public Date getDdepartureTimeUtc() {
		return this.ddepartureTimeUtc;
	}

	public void setDdepartureTimeUtc(final Date ddepartureTimeUtc) {
		this.ddepartureTimeUtc = ddepartureTimeUtc;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DARRIVAL_TIME_UTC", length = 7)
	public Date getDarrivalTimeUtc() {
		return this.darrivalTimeUtc;
	}

	public void setDarrivalTimeUtc(final Date darrivalTimeUtc) {
		this.darrivalTimeUtc = darrivalTimeUtc;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DARRIVAL_TIME_LOC", length = 7)
	public Date getDarrivalTimeLoc() {
		return this.darrivalTimeLoc;
	}

	public void setDarrivalTimeLoc(final Date darrivalTimeLoc) {
		this.darrivalTimeLoc = darrivalTimeLoc;
	}

	@Column(name = "NACG_MASTER_KEY", precision = 12, scale = 0)
	public Long getNacgMasterKey() {
		return this.nacgMasterKey;
	}

	public void setNacgMasterKey(final Long nacgMasterKey) {
		this.nacgMasterKey = nacgMasterKey;
	}

	@Column(name = "NQUEUED_RELEASE_INTERFACE", precision = 1, scale = 0)
	public Integer getNqueuedReleaseInterface() {
		return this.nqueuedReleaseInterface;
	}

	public void setNqueuedReleaseInterface(final Integer nqueuedReleaseInterface) {
		this.nqueuedReleaseInterface = nqueuedReleaseInterface;
	}

	@Column(name = "NOPCODE_KEY", precision = 12, scale = 0)
	public Long getNopcodeKey() {
		return this.nopcodeKey;
	}

	public void setNopcodeKey(final Long nopcodeKey) {
		this.nopcodeKey = nopcodeKey;
	}

	@Column(name = "COPCODE", length = 18)
	public String getCopcode() {
		return this.copcode;
	}

	public void setCopcode(final String copcode) {
		this.copcode = copcode;
	}

	@Column(name = "NRESET_COUNT", precision = 6, scale = 0)
	public Integer getNresetCount() {
		return this.nresetCount;
	}

	public void setNresetCount(final Integer nresetCount) {
		this.nresetCount = nresetCount;
	}

	@Column(name = "NLCL_MIRROR_FLAG", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNlclMirrorFlag() {
		return this.nlclMirrorFlag;
	}

	public void setNlclMirrorFlag(final Integer nlclMirrorFlag) {
		this.nlclMirrorFlag = nlclMirrorFlag;
	}

	@Column(name = "UMM_NKEY", precision = 12, scale = 0)
	public Long getUmmNkey() {
		return this.ummNkey;
	}

	public void setUmmNkey(final Long ummNkey) {
		this.ummNkey = ummNkey;
	}

	@Column(name = "CFINAL_AC_OWNER", precision = 12, scale = 0)
	public Long getCfinalAcOwner() {
		return this.cfinalAcOwner;
	}

	public void setCfinalAcOwner(final Long cfinalAcOwner) {
		this.cfinalAcOwner = cfinalAcOwner;
	}

	@Column(name = "CFINAL_AC_TYPE", length = 10)
	public String getCfinalAcType() {
		return this.cfinalAcType;
	}

	public void setCfinalAcType(final String cfinalAcType) {
		this.cfinalAcType = cfinalAcType;
	}

	@Column(name = "NRECALC_STATUS", precision = 2, scale = 0)
	public Integer getNrecalcStatus() {
		return this.nrecalcStatus;
	}

	public void setNrecalcStatus(final Integer nrecalcStatus) {
		this.nrecalcStatus = nrecalcStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRECALC_DATE", length = 7)
	public Date getDrecalcDate() {
		return this.drecalcDate;
	}

	public void setDrecalcDate(final Date drecalcDate) {
		this.drecalcDate = drecalcDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE_TIME_LOC", length = 7)
	public Date getDdepartureTimeLoc() {
		return this.ddepartureTimeLoc;
	}

	public void setDdepartureTimeLoc(final Date ddepartureTimeLoc) {
		this.ddepartureTimeLoc = ddepartureTimeLoc;
	}

	@Column(name = "NOFFSET_DEP", precision = 7)
	public BigDecimal getNoffsetDep() {
		return this.noffsetDep;
	}

	public void setNoffsetDep(final BigDecimal noffsetDep) {
		this.noffsetDep = noffsetDep;
	}

	@Column(name = "NOFFSET_ARR", precision = 7)
	public BigDecimal getNoffsetArr() {
		return this.noffsetArr;
	}

	public void setNoffsetArr(final BigDecimal noffsetArr) {
		this.noffsetArr = noffsetArr;
	}

	@Column(name = "NNOTREGENERATE", precision = 1, scale = 0)
	public Integer getNnotregenerate() {
		return this.nnotregenerate;
	}

	public void setNnotregenerate(final Integer nnotregenerate) {
		this.nnotregenerate = nnotregenerate;
	}

	@Column(name = "CFLIGHT_KEY", nullable = false, length = 25)
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "NCFS", precision = 1, scale = 0)
	public Integer getNcfs() {
		return this.ncfs;
	}

	public void setNcfs(final Integer ncfs) {
		this.ncfs = ncfs;
	}

	@Column(name = "NMANUAL_PACKETS", precision = 1, scale = 0)
	public Integer getNmanualPackets() {
		return this.nmanualPackets;
	}

	public void setNmanualPackets(final Integer nmanualPackets) {
		this.nmanualPackets = nmanualPackets;
	}

	@Column(name = "NAC_GROUP_KEY", precision = 12, scale = 0)
	public Long getNacGroupKey() {
		return this.nacGroupKey;
	}

	public void setNacGroupKey(final Long nacGroupKey) {
		this.nacGroupKey = nacGroupKey;
	}

	@Column(name = "NCFS_PACKETS", precision = 1, scale = 0)
	public Integer getNcfsPackets() {
		return this.ncfsPackets;
	}

	public void setNcfsPackets(final Integer ncfsPackets) {
		this.ncfsPackets = ncfsPackets;
	}

	@Column(name = "NDUTY_TRANSFER", precision = 1, scale = 0)
	public Integer getNdutyTransfer() {
		return this.ndutyTransfer;
	}

	public void setNdutyTransfer(final Integer ndutyTransfer) {
		this.ndutyTransfer = ndutyTransfer;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDUTY_TRANSFER_DATE", length = 7)
	public Date getDdutyTransferDate() {
		return this.ddutyTransferDate;
	}

	public void setDdutyTransferDate(final Date ddutyTransferDate) {
		this.ddutyTransferDate = ddutyTransferDate;
	}

	@Column(name = "NBLOCK_RAMP_TIME", precision = 1, scale = 0)
	public Integer getNblockRampTime() {
		return this.nblockRampTime;
	}

	public void setNblockRampTime(final Integer nblockRampTime) {
		this.nblockRampTime = nblockRampTime;
	}

	@Column(name = "NPPM_LOCK", precision = 1, scale = 0)
	public Integer getNppmLock() {
		return this.nppmLock;
	}

	public void setNppmLock(final Integer nppmLock) {
		this.nppmLock = nppmLock;
	}

	@Column(name = "NCHECK_REDUCTION", precision = 1, scale = 0)
	public Integer getNcheckReduction() {
		return this.ncheckReduction;
	}

	public void setNcheckReduction(final Integer ncheckReduction) {
		this.ncheckReduction = ncheckReduction;
	}

	@Column(name = "NLOCAL_SUB", precision = 1, scale = 0)
	public Integer getNlocalSub() {
		return this.nlocalSub;
	}

	public void setNlocalSub(final Integer nlocalSub) {
		this.nlocalSub = nlocalSub;
	}

	@Column(name = "NCONFIGURATION_KEY", precision = 12, scale = 0)
	public Long getNconfigurationKey() {
		return this.nconfigurationKey;
	}

	public void setNconfigurationKey(final Long nconfigurationKey) {
		this.nconfigurationKey = nconfigurationKey;
	}

	@Column(name = "NCHECK_UNITPRICE", precision = 1, scale = 0)
	public Integer getNcheckUnitprice() {
		return this.ncheckUnitprice;
	}

	public void setNcheckUnitprice(final Integer ncheckUnitprice) {
		this.ncheckUnitprice = ncheckUnitprice;
	}

	@Column(name = "NFREEZE", precision = 1, scale = 0)
	public Integer getNfreeze() {
		return this.nfreeze;
	}

	public void setNfreeze(final Integer nfreeze) {
		this.nfreeze = nfreeze;
	}

	@Column(name = "CADDITIONAL_ACCOUNT", length = 18)
	public String getCadditionalAccount() {
		return this.cadditionalAccount;
	}

	public void setCadditionalAccount(final String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
	}

	@Column(name = "NFLIGHTTYPE_KEY", precision = 12, scale = 0)
	public Long getNflighttypeKey() {
		return this.nflighttypeKey;
	}

	public void setNflighttypeKey(final Long nflighttypeKey) {
		this.nflighttypeKey = nflighttypeKey;
	}

	@Column(name = "CFLIGHTTYPE", length = 18)
	public String getCflighttype() {
		return this.cflighttype;
	}

	public void setCflighttype(final String cflighttype) {
		this.cflighttype = cflighttype;
	}

	@Column(name = "NLOCK_LOADINGLIST", precision = 1, scale = 0)
	public Integer getNlockLoadinglist() {
		return this.nlockLoadinglist;
	}

	public void setNlockLoadinglist(final Integer nlockLoadinglist) {
		this.nlockLoadinglist = nlockLoadinglist;
	}

	@Column(name = "NHAS_AC_CHANGE", precision = 1, scale = 0)
	public Integer getNhasAcChange() {
		return this.nhasAcChange;
	}

	public void setNhasAcChange(final Integer nhasAcChange) {
		this.nhasAcChange = nhasAcChange;
	}

	@Column(name = "NTB", precision = 1, scale = 0)
	public Integer getNtb() {
		return this.ntb;
	}

	public void setNtb(final Integer ntb) {
		this.ntb = ntb;
	}

	@Column(name = "NWAB_ACTIVE", precision = 1, scale = 0)
	public Integer getNwabActive() {
		return this.nwabActive;
	}

	public void setNwabActive(final Integer nwabActive) {
		this.nwabActive = nwabActive;
	}

	@Column(name = "NBILLING_LOCK", precision = 1, scale = 0)
	public Integer getNbillingLock() {
		return this.nbillingLock;
	}

	public void setNbillingLock(final Integer nbillingLock) {
		this.nbillingLock = nbillingLock;
	}

	@Column(name = "NCUSTOMS_TRANSFER", precision = 1, scale = 0)
	public Integer getNcustomsTransfer() {
		return this.ncustomsTransfer;
	}

	public void setNcustomsTransfer(final Integer ncustomsTransfer) {
		this.ncustomsTransfer = ncustomsTransfer;
	}

	@Column(name = "NCHECK_MISSING_SALES_BOM", nullable = false, precision = 1, scale = 0)
	public int getNcheckMissingSalesBom() {
		return this.ncheckMissingSalesBom;
	}

	public void setNcheckMissingSalesBom(final int ncheckMissingSalesBom) {
		this.ncheckMissingSalesBom = ncheckMissingSalesBom;
	}

	@Column(name = "CPO_NUMBER", length = 18)
	public String getCpoNumber() {
		return this.cpoNumber;
	}

	public void setCpoNumber(final String cpoNumber) {
		this.cpoNumber = cpoNumber;
	}

	@Column(name = "NORDER_SENT", precision = 1, scale = 0)
	public Integer getNorderSent() {
		return this.norderSent;
	}

	public void setNorderSent(final Integer norderSent) {
		this.norderSent = norderSent;
	}

	@Column(name = "CSOURCE", length = 10)
	public String getCsource() {
		return this.csource;
	}

	public void setCsource(final String csource) {
		this.csource = csource;
	}

	@Column(name = "NRESULT_KEY_COPY", precision = 12, scale = 0)
	public Long getNresultKeyCopy() {
		return this.nresultKeyCopy;
	}

	public void setNresultKeyCopy(final Long nresultKeyCopy) {
		this.nresultKeyCopy = nresultKeyCopy;
	}

	@Column(name = "NCHECK_MISSING_COSTING", nullable = false, precision = 1, scale = 0)
	public int getNcheckMissingCosting() {
		return this.ncheckMissingCosting;
	}

	public void setNcheckMissingCosting(final int ncheckMissingCosting) {
		this.ncheckMissingCosting = ncheckMissingCosting;
	}

	@Column(name = "NCHECK_MISSING_MATMAS", nullable = false, precision = 1, scale = 0)
	public int getNcheckMissingMatmas() {
		return this.ncheckMissingMatmas;
	}

	public void setNcheckMissingMatmas(final int ncheckMissingMatmas) {
		this.ncheckMissingMatmas = ncheckMissingMatmas;
	}

	@Column(name = "NDELIVERY_NOTE_NO", nullable = true, precision = 12, scale = 0)
	public Long getNdeliveryNoteNo() {
		return this.ndeliveryNoteNo;
	}

	public void setNdeliveryNoteNo(final Long ndeliveryNoteNo) {
		this.ndeliveryNoteNo = ndeliveryNoteNo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutHistory")
	public Set<CenOutPaxHistory> getCenOutPaxHistories() {
		return this.cenOutPaxHistories;
	}

	public void setCenOutPaxHistories(final Set<CenOutPaxHistory> cenOutPaxHistories) {
		this.cenOutPaxHistories = cenOutPaxHistories;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOutHistory")
	public CenOutChanges getCenOutChanges() {
		return this.cenOutChanges;
	}

	public void setCenOutChanges(final CenOutChanges cenOutChanges) {
		this.cenOutChanges = cenOutChanges;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutHistory")
	public Set<CenOutMealsHistory> getCenOutMealsHistories() {
		return this.cenOutMealsHistories;
	}

	public void setCenOutMealsHistories(final Set<CenOutMealsHistory> cenOutMealsHistories) {
		this.cenOutMealsHistories = cenOutMealsHistories;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutHistory")
	public Set<CenOutSpmlHistory> getCenOutSpmlHistories() {
		return this.cenOutSpmlHistories;
	}

	public void setCenOutSpmlHistories(final Set<CenOutSpmlHistory> cenOutSpmlHistories) {
		this.cenOutSpmlHistories = cenOutSpmlHistories;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutHistory")
	public Set<CenOutHandlingHistory> getCenOutHandlingHistories() {
		return this.cenOutHandlingHistories;
	}

	public void setCenOutHandlingHistories(final Set<CenOutHandlingHistory> cenOutHandlingHistories) {
		this.cenOutHandlingHistories = cenOutHandlingHistories;
	}

}
