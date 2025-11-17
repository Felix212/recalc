package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PfArchiveFlight;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenOutState;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT(flight event)
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQuery(name = PfArchiveFlight.PF_ARCHIVE_FLIGHT, procedureName = "CBASE_LOG."
		+ PfArchiveFlight.PF_ARCHIVE_FLIGHT, parameters = {
		@StoredProcedureParameter(mode = ParameterMode.IN, name = PfArchiveFlight.P_NRESULT_KEY, type = Long.class),
		@StoredProcedureParameter(mode = ParameterMode.IN, name = PfArchiveFlight.P_TRANSAKTION_KEY, type = Long.class),
		@StoredProcedureParameter(mode = ParameterMode.INOUT, name = PfArchiveFlight.NRETURN, type = Long.class)
})
@NamedEntityGraphs({
		@NamedEntityGraph(name = "cenOut.commentAndText", attributeNodes = {
				@NamedAttributeNode(value = "cenOutText"),
				@NamedAttributeNode(value = "cenOutComment")
		}),
		@NamedEntityGraph(name = "cenOut.paxAndCommentAndText", attributeNodes = {
				@NamedAttributeNode(value = "cenOutText"),
				@NamedAttributeNode(value = "cenOutComment"),
				@NamedAttributeNode(value = "cenOutPaxes"),
		}),
		@NamedEntityGraph(name = "cenOut.paxAndCommentAndTextAndDeliveryNotes", attributeNodes = {
				@NamedAttributeNode(value = "cenOutText"),
				@NamedAttributeNode(value = "cenOutComment"),
				@NamedAttributeNode(value = "cenOutPaxes"),
				@NamedAttributeNode(value = "cenOutDeliveryNotes")
		}),
		@NamedEntityGraph(name = "cenOut.paxAndCommentAndTextAndDeliveryNoteRequests", attributeNodes = {
				@NamedAttributeNode(value = "cenOutText"),
				@NamedAttributeNode(value = "cenOutComment"),
				@NamedAttributeNode(value = "cenOutPaxes"),
				@NamedAttributeNode(value = "cenOutDeliveryNotes"),
				@NamedAttributeNode(value = "cenOutDeliveryRequests", subgraph = "cenOut.packinglist.details")
		}, subgraphs = {
				@NamedSubgraph(name = "cenOut.packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "cenPackinglists", subgraph = "cenOut.packinglist.index")
				}),
				@NamedSubgraph(name = "cenOut.packinglist.index", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIf"),
						@NamedAttributeNode(value = "cenPackinglistMaterial"),
						@NamedAttributeNode(value = "cenMpDesignItemlist")
				})
		})
})

@Entity
@Table(name = "CEN_OUT", uniqueConstraints = @UniqueConstraint(columnNames = {
		"NAIRLINE_KEY", "NFLIGHT_NUMBER", "CSUFFIX", "DDEPARTURE", "NLEG_NUMBER", "CUNIT", "CTLC_FROM", "CTLC_TO", "DRETURN_DATE" }))
public class CenOut implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nresultKey;

	@JsonView(View.Simple.class)
	private long ntransaction;

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

	/** airline owner */
	@JsonView(View.Simple.class)
	private String cairlineOwner;

	@JsonView(View.Simple.class)
	private String cgalleyversion;

	@JsonView(View.Simple.class)
	private String cconfiguration;

	@JsonView(View.Simple.class)
	/** The leg(aircraft trip from take-off to landing) number of current flight event. */
	private int nlegNumber;

	@JsonIgnore
	private String cunit;

	@JsonIgnore
	private String cclient;

	@JsonIgnore
	private long ntlcFrom;

	@JsonIgnore
	private long ntlcTo;

	@JsonView(View.Simple.class)
	private String ctlcFrom;

	@JsonView(View.Simple.class)
	private String ctlcTo;

	@JsonIgnore
	private String carrivalTime;

	@JsonIgnore
	private String cblockTime;

	@JsonIgnore
	private long ncustomerKey;

	@JsonIgnore
	private String ccountryFrom;

	@JsonIgnore
	private String ccountryTo;

	@JsonIgnore
	private String ctrafficArea;

	@JsonIgnore
	private String ctrafficAreaShort;

	@JsonIgnore
	private long nhandlingTypeKey;

	@JsonIgnore
	private String chandlingTypeText;

	@JsonIgnore
	private String chandlingTypeDescription;

	@JsonIgnore
	private long nroutingId;

	@JsonView(View.Simple.class)
	private String crouting;

	@JsonIgnore
	private String croutingText;

	@JsonIgnore
	private String csortTime;

	@JsonIgnore
	private long nparentTlcFrom;

	@JsonIgnore
	private Date dtimestamp;

	@JsonView(View.Simple.class)
	/** @see CenOutState */
	private int nstatus;

	@JsonIgnore
	private int nuserModified;

	@JsonIgnore
	private String cdescription;

	@JsonIgnore
	private Date dgenerationDate;

	/** TAIL-Number (Ship-Number) real aircraft number) */
	@JsonView(View.Simple.class)
	private String cregistration;

	@JsonIgnore
	private String cboxFrom;

	@JsonIgnore
	private String cboxTo;

	@JsonIgnore
	private Long nquery;

	@JsonIgnore
	private Date doriginalDeparture;

	@JsonIgnore
	private Integer nflightStatus;

	@JsonIgnore
	private Long naccountKey;

	@JsonIgnore
	private String caccount;

	@JsonIgnore
	private String cheader1;

	@JsonIgnore
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
	private Long nresultKeyGroup;

	@JsonIgnore
	private Integer nmanualInput;

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
	private Integer nstatusRelease;

	@JsonIgnore
	private Integer nstatusAutoRelease;

	@JsonIgnore
	private Integer nstatusAutoBilling;

	@JsonIgnore
	private Long nsupplier;

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

	@JsonView(View.Simple.class)
	private Date darrivalTimeUtc;

	@JsonView(View.Simple.class)
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

	@JsonIgnore
	private int nlclMirrorFlag;

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
	private int nnotregenerate;

	@JsonView(View.Simple.class)
	private String cflightKey;

	@JsonIgnore
	private int ncfs;

	@JsonIgnore
	private int nmanualPackets;

	@JsonIgnore
	private Long nacGroupKey;

	@JsonIgnore
	private int ncfsPackets;

	@JsonIgnore
	private int ndutyTransfer;

	@JsonIgnore
	private Date ddutyTransferDate;

	@JsonIgnore
	private int nblockRampTime;

	@JsonIgnore
	private int nppmLock;

	@JsonIgnore
	private Integer ncheckReduction;

	@JsonIgnore
	private Integer nlocalSub;

	@JsonIgnore
	private Long nconfigurationKey;

	@JsonIgnore
	private int ncheckUnitprice;

	@JsonIgnore
	private int nfreeze;

	@JsonIgnore
	private String cadditionalAccount;

	@JsonIgnore
	private Long nflighttypeKey;

	@JsonIgnore
	private String cflighttype;

	@JsonIgnore
	private int nlockLoadinglist;

	@JsonIgnore
	private int nhasAcChange;

	@JsonIgnore
	private int ntb;

	@JsonIgnore
	private int nwabActive;

	@JsonIgnore
	private Integer nbillingLock;

	@JsonIgnore
	private Integer ncustomsTransfer;

	@JsonIgnore
	private Integer ncheckNoCo;

	@JsonIgnore
	private int ncheckMissingSalesBom;

	@JsonIgnore
	private String cpoNumber;

	@JsonIgnore
	private int norderSent;

	@JsonIgnore
	private String csource;

	@JsonIgnore
	private Set<CenOutMdLo> cenOutMdLos = new HashSet<>(0);

	@JsonIgnore
	private CenOutComment cenOutComment;

	@JsonIgnore
	private Set<CenOutPax> cenOutPaxes = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSd> cenOutSds = new HashSet<>(0);

	@JsonIgnore
	private Set<CenDocGenQueue> cenDocGenQueues = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutCheckpt> cenOutCheckpts = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutLabels> cenOutLabelses = new HashSet<>(0);

	@JsonIgnore
	private CenOutText cenOutText;

	@JsonIgnore
	private Set<CenOutHandling> cenOutHandlings = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutMdBlob> cenOutMdBlobs = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSdComp> cenOutSdComps = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutCartdiagrams> cenOutCartdiagramses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutDocuments> cenOutDocumentses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutMeals> cenOutMealses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutMdDe> cenOutMdDes = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutAddDelivery> cenOutAddDeliveries = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutPackets> cenOutPacketses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutMd> cenOutMds = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSdDrawer> cenOutSdDrawers = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSdMessage> cenOutSdMessages = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutLos> cenOutLoses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSdCart> cenOutSdCarts = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutDeliveryNote> cenOutDeliveryNotes = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSpml> cenOutSpmls = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutSdContent> cenOutSdContents = new HashSet<>(0);

	@JsonIgnore
	private Set<SysLogin> sysLogins = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutCsoShown> cenOutCsoShowns = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutDeliveryRequest> cenOutDeliveryRequests = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutDocumentUpload> cenOutDocumentUploads = new HashSet<>(0);

	@Id
	// NOTE: The sequence generator has been commented out for a reason, don't use it!
	// If you need to insert new rows, use "nativeQueryProvider.getNextSeqValue(CbaseSequence.SEQ_CEN_OUT)"
	// to get a new sequence.
	// @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT")
	// @SequenceGenerator(name = "SEQ_CEN_OUT", sequenceName = "SEQ_CEN_OUT", allocationSize = 1)
	@Column(name = "NRESULT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
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

	/**
	 * @return status value
	 * @see CenOutState
	 */
	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	/**
	 * @param nstatus status value
	 * @see CenOutState
	 */
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
	@Column(name = "DGENERATION_DATE", length = 7)
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

	@Column(name = "NQUERY", precision = 12, scale = 0)
	public Long getNquery() {
		return this.nquery;
	}

	public void setNquery(final Long nquery) {
		this.nquery = nquery;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DORIGINAL_DEPARTURE", length = 7)
	public Date getDoriginalDeparture() {
		return this.doriginalDeparture;
	}

	public void setDoriginalDeparture(final Date doriginalDeparture) {
		this.doriginalDeparture = doriginalDeparture;
	}

	@Column(name = "NFLIGHT_STATUS", precision = 2, scale = 0)
	public Integer getNflightStatus() {
		return this.nflightStatus;
	}

	public void setNflightStatus(final Integer nflightStatus) {
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

	@Column(name = "NRESULT_KEY_GROUP", precision = 12, scale = 0)
	public Long getNresultKeyGroup() {
		return this.nresultKeyGroup;
	}

	public void setNresultKeyGroup(final Long nresultKeyGroup) {
		this.nresultKeyGroup = nresultKeyGroup;
	}

	@Column(name = "NMANUAL_INPUT", precision = 1, scale = 0)
	public Integer getNmanualInput() {
		return this.nmanualInput;
	}

	public void setNmanualInput(final Integer nmanualInput) {
		this.nmanualInput = nmanualInput;
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

	@Column(name = "NSTATUS_AUTO_BILLING", precision = 1, scale = 0)
	public Integer getNstatusAutoBilling() {
		return this.nstatusAutoBilling;
	}

	public void setNstatusAutoBilling(final Integer nstatusAutoBilling) {
		this.nstatusAutoBilling = nstatusAutoBilling;
	}

	@Column(name = "NSUPPLIER", precision = 12, scale = 0)
	public Long getNsupplier() {
		return this.nsupplier;
	}

	public void setNsupplier(final Long nsupplier) {
		this.nsupplier = nsupplier;
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
	public int getNlclMirrorFlag() {
		return this.nlclMirrorFlag;
	}

	public void setNlclMirrorFlag(final int nlclMirrorFlag) {
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

	@Column(name = "NRECALC_STATUS", precision = 2, scale = 0, columnDefinition = "NUMBER(2) DEFAULT 0")
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

	@Column(name = "NNOTREGENERATE", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNnotregenerate() {
		return this.nnotregenerate;
	}

	public void setNnotregenerate(final int nnotregenerate) {
		this.nnotregenerate = nnotregenerate;
	}

	@Column(name = "CFLIGHT_KEY", nullable = false, length = 25, columnDefinition = "VARCHAR2(25) DEFAULT ' '")
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "NCFS", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNcfs() {
		return this.ncfs;
	}

	public void setNcfs(final int ncfs) {
		this.ncfs = ncfs;
	}

	@Column(name = "NMANUAL_PACKETS", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNmanualPackets() {
		return this.nmanualPackets;
	}

	public void setNmanualPackets(final int nmanualPackets) {
		this.nmanualPackets = nmanualPackets;
	}

	@Column(name = "NAC_GROUP_KEY", precision = 12, scale = 0)
	public Long getNacGroupKey() {
		return this.nacGroupKey;
	}

	public void setNacGroupKey(final Long nacGroupKey) {
		this.nacGroupKey = nacGroupKey;
	}

	@Column(name = "NCFS_PACKETS", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNcfsPackets() {
		return this.ncfsPackets;
	}

	public void setNcfsPackets(final int ncfsPackets) {
		this.ncfsPackets = ncfsPackets;
	}

	@Column(name = "NDUTY_TRANSFER", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNdutyTransfer() {
		return this.ndutyTransfer;
	}

	public void setNdutyTransfer(final int ndutyTransfer) {
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

	@Column(name = "NBLOCK_RAMP_TIME", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNblockRampTime() {
		return this.nblockRampTime;
	}

	public void setNblockRampTime(final int nblockRampTime) {
		this.nblockRampTime = nblockRampTime;
	}

	@Column(name = "NPPM_LOCK", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNppmLock() {
		return this.nppmLock;
	}

	public void setNppmLock(final int nppmLock) {
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

	@Column(name = "NCHECK_UNITPRICE", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNcheckUnitprice() {
		return this.ncheckUnitprice;
	}

	public void setNcheckUnitprice(final int ncheckUnitprice) {
		this.ncheckUnitprice = ncheckUnitprice;
	}

	@Column(name = "NFREEZE", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNfreeze() {
		return this.nfreeze;
	}

	public void setNfreeze(final int nfreeze) {
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

	@Column(name = "NLOCK_LOADINGLIST", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNlockLoadinglist() {
		return this.nlockLoadinglist;
	}

	public void setNlockLoadinglist(final int nlockLoadinglist) {
		this.nlockLoadinglist = nlockLoadinglist;
	}

	@Column(name = "NHAS_AC_CHANGE", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNhasAcChange() {
		return this.nhasAcChange;
	}

	public void setNhasAcChange(final int nhasAcChange) {
		this.nhasAcChange = nhasAcChange;
	}

	@Column(name = "NTB", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNtb() {
		return this.ntb;
	}

	public void setNtb(final int ntb) {
		this.ntb = ntb;
	}

	@Column(name = "NWAB_ACTIVE", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNwabActive() {
		return this.nwabActive;
	}

	public void setNwabActive(final int nwabActive) {
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

	@Column(name = "NCHECK_NO_CO", precision = 1, scale = 0)
	public Integer getNcheckNoCo() {
		return this.ncheckNoCo;
	}

	public void setNcheckNoCo(final Integer ncheckNoCo) {
		this.ncheckNoCo = ncheckNoCo;
	}

	@Column(name = "NCHECK_MISSING_SALES_BOM", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
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

	@Column(name = "NORDER_SENT", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNorderSent() {
		return this.norderSent;
	}

	public void setNorderSent(final int norderSent) {
		this.norderSent = norderSent;
	}

	@Column(name = "CSOURCE", length = 10, columnDefinition = "VARCHAR2(10) DEFAULT ' '")
	public String getCsource() {
		return this.csource;
	}

	public void setCsource(final String csource) {
		this.csource = csource;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutMdLo> getCenOutMdLos() {
		return this.cenOutMdLos;
	}

	public void setCenOutMdLos(final Set<CenOutMdLo> cenOutMdLos) {
		this.cenOutMdLos = cenOutMdLos;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOut", cascade = CascadeType.ALL)
	public CenOutComment getCenOutComment() {
		return this.cenOutComment;
	}

	public void setCenOutComment(final CenOutComment cenOutComment) {
		this.cenOutComment = cenOutComment;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutPax> getCenOutPaxes() {
		return this.cenOutPaxes;
	}

	public void setCenOutPaxes(final Set<CenOutPax> cenOutPaxes) {
		this.cenOutPaxes = cenOutPaxes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSd> getCenOutSds() {
		return this.cenOutSds;
	}

	public void setCenOutSds(final Set<CenOutSd> cenOutSds) {
		this.cenOutSds = cenOutSds;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenDocGenQueue> getCenDocGenQueues() {
		return this.cenDocGenQueues;
	}

	public void setCenDocGenQueues(final Set<CenDocGenQueue> cenDocGenQueues) {
		this.cenDocGenQueues = cenDocGenQueues;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutCheckpt> getCenOutCheckpts() {
		return this.cenOutCheckpts;
	}

	public void setCenOutCheckpts(final Set<CenOutCheckpt> cenOutCheckpts) {
		this.cenOutCheckpts = cenOutCheckpts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutLabels> getCenOutLabelses() {
		return this.cenOutLabelses;
	}

	public void setCenOutLabelses(final Set<CenOutLabels> cenOutLabelses) {
		this.cenOutLabelses = cenOutLabelses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutHandling> getCenOutHandlings() {
		return this.cenOutHandlings;
	}

	public void setCenOutHandlings(final Set<CenOutHandling> cenOutHandlings) {
		this.cenOutHandlings = cenOutHandlings;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutMdBlob> getCenOutMdBlobs() {
		return this.cenOutMdBlobs;
	}

	public void setCenOutMdBlobs(final Set<CenOutMdBlob> cenOutMdBlobs) {
		this.cenOutMdBlobs = cenOutMdBlobs;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public CenOutText getCenOutText() {
		return this.cenOutText;
	}

	public void setCenOutText(final CenOutText cenOutText) {
		this.cenOutText = cenOutText;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSdComp> getCenOutSdComps() {
		return this.cenOutSdComps;
	}

	public void setCenOutSdComps(final Set<CenOutSdComp> cenOutSdComps) {
		this.cenOutSdComps = cenOutSdComps;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutCartdiagrams> getCenOutCartdiagramses() {
		return this.cenOutCartdiagramses;
	}

	public void setCenOutCartdiagramses(final Set<CenOutCartdiagrams> cenOutCartdiagramses) {
		this.cenOutCartdiagramses = cenOutCartdiagramses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutDocuments> getCenOutDocumentses() {
		return this.cenOutDocumentses;
	}

	public void setCenOutDocumentses(final Set<CenOutDocuments> cenOutDocumentses) {
		this.cenOutDocumentses = cenOutDocumentses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutMeals> getCenOutMealses() {
		return this.cenOutMealses;
	}

	public void setCenOutMealses(final Set<CenOutMeals> cenOutMealses) {
		this.cenOutMealses = cenOutMealses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutMdDe> getCenOutMdDes() {
		return this.cenOutMdDes;
	}

	public void setCenOutMdDes(final Set<CenOutMdDe> cenOutMdDes) {
		this.cenOutMdDes = cenOutMdDes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutAddDelivery> getCenOutAddDeliveries() {
		return this.cenOutAddDeliveries;
	}

	public void setCenOutAddDeliveries(final Set<CenOutAddDelivery> cenOutAddDeliveries) {
		this.cenOutAddDeliveries = cenOutAddDeliveries;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutPackets> getCenOutPacketses() {
		return this.cenOutPacketses;
	}

	public void setCenOutPacketses(final Set<CenOutPackets> cenOutPacketses) {
		this.cenOutPacketses = cenOutPacketses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutMd> getCenOutMds() {
		return this.cenOutMds;
	}

	public void setCenOutMds(final Set<CenOutMd> cenOutMds) {
		this.cenOutMds = cenOutMds;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSdDrawer> getCenOutSdDrawers() {
		return this.cenOutSdDrawers;
	}

	public void setCenOutSdDrawers(final Set<CenOutSdDrawer> cenOutSdDrawers) {
		this.cenOutSdDrawers = cenOutSdDrawers;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSdMessage> getCenOutSdMessages() {
		return this.cenOutSdMessages;
	}

	public void setCenOutSdMessages(final Set<CenOutSdMessage> cenOutSdMessages) {
		this.cenOutSdMessages = cenOutSdMessages;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutLos> getCenOutLoses() {
		return this.cenOutLoses;
	}

	public void setCenOutLoses(final Set<CenOutLos> cenOutLoses) {
		this.cenOutLoses = cenOutLoses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSdCart> getCenOutSdCarts() {
		return this.cenOutSdCarts;
	}

	public void setCenOutSdCarts(final Set<CenOutSdCart> cenOutSdCarts) {
		this.cenOutSdCarts = cenOutSdCarts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutDeliveryNote> getCenOutDeliveryNotes() {
		return this.cenOutDeliveryNotes;
	}

	public void setCenOutDeliveryNotes(final Set<CenOutDeliveryNote> cenOutDeliveryNotes) {
		this.cenOutDeliveryNotes = cenOutDeliveryNotes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSpml> getCenOutSpmls() {
		return this.cenOutSpmls;
	}

	public void setCenOutSpmls(final Set<CenOutSpml> cenOutSpmls) {
		this.cenOutSpmls = cenOutSpmls;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutSdContent> getCenOutSdContents() {
		return this.cenOutSdContents;
	}

	public void setCenOutSdContents(final Set<CenOutSdContent> cenOutSdContents) {
		this.cenOutSdContents = cenOutSdContents;
	}

	/**
	 * Checks if the given corresponds to the current status.
	 *
	 * @param status for check
	 * @return {@code true} if current state corresponds to given status, otherwise {@code false}
	 */
	public boolean isNstatus(final CenOutState status) {
		return getNstatus() == status.getStateValue();

	}

	/**
	 * Helper to return a formatted flight text.
	 *
	 * @param isIncludeUnit flag to include the unit {@code true} or exclude it {@code false}
	 * @return formatted flight text
	 */
	public String calcFlightText(final boolean isIncludeUnit) {
		if (isIncludeUnit) {
			return String.format("%s %03d%s %tF %s-%s %s", getCairline(), getNflightNumber(), getCsuffix().trim(),
					getDdeparture(), getCtlcFrom(), getCtlcTo(), getCunit());
		} else {
			return String.format("%s %03d%s %tF %s-%s", getCairline(), getNflightNumber(), getCsuffix().trim(),
					getDdeparture(), getCtlcFrom(), getCtlcTo());
		}
	}

	public String calcFlightText() {
		return calcFlightText(true);
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "CEN_OUT_FAVORIT", joinColumns = {
			@JoinColumn(name = "NRESULT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
			@JoinColumn(name = "NUSER_ID", nullable = false, updatable = false) })
	public Set<SysLogin> getSysLogins() {
		return this.sysLogins;
	}

	public void setSysLogins(final Set<SysLogin> sysLogins) {
		this.sysLogins = sysLogins;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutCsoShown> getCenOutCsoShowns() {
		return this.cenOutCsoShowns;
	}

	public void setCenOutCsoShowns(final Set<CenOutCsoShown> cenOutCsoShowns) {
		this.cenOutCsoShowns = cenOutCsoShowns;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutDeliveryRequest> getCenOutDeliveryRequests() {
		return this.cenOutDeliveryRequests;
	}

	public void setCenOutDeliveryRequests(Set<CenOutDeliveryRequest> cenOutDeliveryRequests) {
		this.cenOutDeliveryRequests = cenOutDeliveryRequests;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOut")
	public Set<CenOutDocumentUpload> getCenOutDocumentUploads() {
		return this.cenOutDocumentUploads;
	}

	public void setCenOutDocumentUploads(Set<CenOutDocumentUpload> cenOutDocumentUploads) {
		this.cenOutDocumentUploads = cenOutDocumentUploads;
	}
}
