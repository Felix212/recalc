package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table CEN_OUT_MD_LO (Flight event Meal-Distribution Loading). Contains all loading positions(gatering relevant,
 * container/trolley) for flight event.
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MD_LO")
public class CenOutMdLo implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMdLoId id;
	private CenOut cenOut;
	private String cstowage;
	private String cplace;
	private Integer nsortStow;
	private Integer npage;
	private Integer nxpos;
	private Integer nypos;
	private String cgalley;
	private Integer nsortGal;
	private Long nequipmentWidth;
	private Long nequipmentHeight;
	private Long nloadinglistIndexKeyLo;
	private String cpackinglist;
	private String cloadinglist;
	private String ctextPckl;
	private String cunit;
	private Long nloadinglistKey;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String cfrequency;
	private String ctimeFrom;
	private String ctimeTo;
	private String cclass;
	private String caddOnText;
	private String cactioncode;
	private Integer nbellyContainer;
	private BigDecimal nquantity;
	private Integer nlabelQuantity;
	private Long nlabelTypeKey;
	private String cmealControlCode;
	private Long nstowageKey;
	private String cfontname;
	private Integer nfontbold;
	private Integer nfontitalic;
	private Long nfontcolor;
	private Long nobjectborder;
	private Long nobjectcolor;
	private Long nobjectbackgroundcolor;
	private Integer nfontsize;
	private Integer nobjectlinewidth;
	private Long npackinglistKey;
	private String ctextShort;
	private Long ngalleyKey;
	private String ctextStow;
	private Integer nequipmentResize;
	private BigDecimal nweightStow;
	private Integer nforToCode;
	private Long ntlcKey;
	private String ctlc;
	private Long npackinglistIndexKey;
	private Long nloadinglistDetailKey;
	private Long nloadinglistIndexKeyLoi;
	private Date dtimestampModification;
	private Long npackinglistDetailKey;
	private Integer ngalleyGroup;
	private Integer ncateringLeg;
	private Integer nranking;
	private Integer nlimit;
	private Integer nrankingSpml;
	private Integer nlimitSpml;
	private Long nreckoning;
	private BigDecimal nweightPckl;
	private BigDecimal nweightGal;
	private String cclass1;
	private String cclass2;
	private String cclass3;
	private Long nplKindKey;
	private Integer nseparator;
	private String ccustomerPl;
	private String ccustomerText;
	private Long naccountKey;
	private String caccount;
	private Integer ntransporterCart;
	private String csalesRel;
	private String cdefStorageLocation;
	private String cgoodsRecipient;
	private String cclass4;
	private String cclass5;
	private String cclass6;
	private Integer ncomActioncode;
	private Integer ncomFontheight;
	private Integer ncomUsefontsize;
	private Integer ncomRowprinted;
	private String ccomClassname;
	private String ccomZustautext;
	private Integer ncomExclude;
	private String ccomQaqActioncode;
	private String ccomSicodes;
	private Long ncomHandlingKey;
	private BigDecimal ncomCalcweight;
	private Long ncomNlabelType;
	private Integer ncomNprint;
	private Integer ncomLabelprinting;
	private Integer ncomStationinstruction;
	private Long ncomNworkstationkey;
	private String ccomCworkstation;
	private Long ncomNareakey;
	private String ccomCarea;
	private String ccomCareaCode;
	private Long ncomNpltype;
	private String ccomPldetailText;
	private String ccomPldetailLabelCounter;
	private Long ncomNdistributionDetailKey;
	private Long ncomNdistributionKey;
	private Integer ncomNunitPriority;
	private String ccomCdistributedComponents;
	private Integer ncomNclassNumber;
	private Integer ncomNremove;
	private String ccomCworkstationText;
	private Integer ncomNduplicated;
	private String ccomCunitTime;
	private Integer ncomNmodified;
	private String ccomCrampbox;
	private String ccomCareaList;
	private String ccomCwsList;
	private String ccomPldetailExplosion;
	private String ccomPlToExplode;
	private Integer ncomNrowid;
	private Integer ncomNrampBoxMode;
	private String ccomCrampbox2;
	private String ccomCrtnComponents;
	private String cppsunit;
	private String cppscoldstore;
	private Long nppslotnr;
	private String cppscontainer;
	private String cppsehb;
	private String cppsbox;
	private String cppsumstau;
	private String cppsab;
	private Long nflightLabel;
	private Long napproved;
	private String ccreatedBy;
	private Date dcreatedDate;
	private String ctextLl;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction",
					column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nrecordCount",
					column = @Column(name = "NRECORD_COUNT", nullable = false, precision = 12, scale = 0)) })
	public CenOutMdLoId getId() {
		return this.id;
	}

	public void setId(final CenOutMdLoId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "CSTOWAGE", length = 5)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CPLACE", length = 3)
	public String getCplace() {
		return this.cplace;
	}

	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	@Column(name = "NSORT_STOW", precision = 6, scale = 0)
	public Integer getNsortStow() {
		return this.nsortStow;
	}

	public void setNsortStow(final Integer nsortStow) {
		this.nsortStow = nsortStow;
	}

	@Column(name = "NPAGE", precision = 2, scale = 0)
	public Integer getNpage() {
		return this.npage;
	}

	public void setNpage(final Integer npage) {
		this.npage = npage;
	}

	@Column(name = "NXPOS", precision = 7, scale = 0)
	public Integer getNxpos() {
		return this.nxpos;
	}

	public void setNxpos(final Integer nxpos) {
		this.nxpos = nxpos;
	}

	@Column(name = "NYPOS", precision = 7, scale = 0)
	public Integer getNypos() {
		return this.nypos;
	}

	public void setNypos(final Integer nypos) {
		this.nypos = nypos;
	}

	@Column(name = "CGALLEY", length = 5)
	public String getCgalley() {
		return this.cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "NSORT_GAL", precision = 6, scale = 0)
	public Integer getNsortGal() {
		return this.nsortGal;
	}

	public void setNsortGal(final Integer nsortGal) {
		this.nsortGal = nsortGal;
	}

	@Column(name = "NEQUIPMENT_WIDTH", precision = 10, scale = 0)
	public Long getNequipmentWidth() {
		return this.nequipmentWidth;
	}

	public void setNequipmentWidth(final Long nequipmentWidth) {
		this.nequipmentWidth = nequipmentWidth;
	}

	@Column(name = "NEQUIPMENT_HEIGHT", precision = 10, scale = 0)
	public Long getNequipmentHeight() {
		return this.nequipmentHeight;
	}

	public void setNequipmentHeight(final Long nequipmentHeight) {
		this.nequipmentHeight = nequipmentHeight;
	}

	@Column(name = "NLOADINGLIST_INDEX_KEY_LO", precision = 12, scale = 0)
	public Long getNloadinglistIndexKeyLo() {
		return this.nloadinglistIndexKeyLo;
	}

	public void setNloadinglistIndexKeyLo(final Long nloadinglistIndexKeyLo) {
		this.nloadinglistIndexKeyLo = nloadinglistIndexKeyLo;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CLOADINGLIST", length = 18)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "CTEXT_PCKL", length = 80)
	public String getCtextPckl() {
		return this.ctextPckl;
	}

	public void setCtextPckl(final String ctextPckl) {
		this.ctextPckl = ctextPckl;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NLOADINGLIST_KEY", precision = 12, scale = 0)
	public Long getNloadinglistKey() {
		return this.nloadinglistKey;
	}

	public void setNloadinglistKey(final Long nloadinglistKey) {
		this.nloadinglistKey = nloadinglistKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CFREQUENCY", length = 7)
	public String getCfrequency() {
		return this.cfrequency;
	}

	public void setCfrequency(final String cfrequency) {
		this.cfrequency = cfrequency;
	}

	@Column(name = "CTIME_FROM", length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(final String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(final String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Column(name = "CCLASS", length = 12)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CADD_ON_TEXT", length = 40)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "CACTIONCODE", length = 1)
	public String getCactioncode() {
		return this.cactioncode;
	}

	public void setCactioncode(final String cactioncode) {
		this.cactioncode = cactioncode;
	}

	@Column(name = "NBELLY_CONTAINER", precision = 3, scale = 0)
	public Integer getNbellyContainer() {
		return this.nbellyContainer;
	}

	public void setNbellyContainer(final Integer nbellyContainer) {
		this.nbellyContainer = nbellyContainer;
	}

	@Column(name = "NQUANTITY", precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NLABEL_QUANTITY", precision = 6, scale = 0)
	public Integer getNlabelQuantity() {
		return this.nlabelQuantity;
	}

	public void setNlabelQuantity(final Integer nlabelQuantity) {
		this.nlabelQuantity = nlabelQuantity;
	}

	@Column(name = "NLABEL_TYPE_KEY", precision = 12, scale = 0)
	public Long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(final Long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NSTOWAGE_KEY", precision = 12, scale = 0)
	public Long getNstowageKey() {
		return this.nstowageKey;
	}

	public void setNstowageKey(final Long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	@Column(name = "CFONTNAME", length = 20)
	public String getCfontname() {
		return this.cfontname;
	}

	public void setCfontname(final String cfontname) {
		this.cfontname = cfontname;
	}

	@Column(name = "NFONTBOLD", precision = 1, scale = 0)
	public Integer getNfontbold() {
		return this.nfontbold;
	}

	public void setNfontbold(final Integer nfontbold) {
		this.nfontbold = nfontbold;
	}

	@Column(name = "NFONTITALIC", precision = 1, scale = 0)
	public Integer getNfontitalic() {
		return this.nfontitalic;
	}

	public void setNfontitalic(final Integer nfontitalic) {
		this.nfontitalic = nfontitalic;
	}

	@Column(name = "NFONTCOLOR", precision = 12, scale = 0)
	public Long getNfontcolor() {
		return this.nfontcolor;
	}

	public void setNfontcolor(final Long nfontcolor) {
		this.nfontcolor = nfontcolor;
	}

	@Column(name = "NOBJECTBORDER", precision = 12, scale = 0)
	public Long getNobjectborder() {
		return this.nobjectborder;
	}

	public void setNobjectborder(final Long nobjectborder) {
		this.nobjectborder = nobjectborder;
	}

	@Column(name = "NOBJECTCOLOR", precision = 12, scale = 0)
	public Long getNobjectcolor() {
		return this.nobjectcolor;
	}

	public void setNobjectcolor(final Long nobjectcolor) {
		this.nobjectcolor = nobjectcolor;
	}

	@Column(name = "NOBJECTBACKGROUNDCOLOR", precision = 12, scale = 0)
	public Long getNobjectbackgroundcolor() {
		return this.nobjectbackgroundcolor;
	}

	public void setNobjectbackgroundcolor(final Long nobjectbackgroundcolor) {
		this.nobjectbackgroundcolor = nobjectbackgroundcolor;
	}

	@Column(name = "NFONTSIZE", precision = 2, scale = 0)
	public Integer getNfontsize() {
		return this.nfontsize;
	}

	public void setNfontsize(final Integer nfontsize) {
		this.nfontsize = nfontsize;
	}

	@Column(name = "NOBJECTLINEWIDTH", precision = 2, scale = 0)
	public Integer getNobjectlinewidth() {
		return this.nobjectlinewidth;
	}

	public void setNobjectlinewidth(final Integer nobjectlinewidth) {
		this.nobjectlinewidth = nobjectlinewidth;
	}

	@Column(name = "NPACKINGLIST_KEY", precision = 12, scale = 0)
	public Long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@Column(name = "CTEXT_SHORT", length = 80)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "NGALLEY_KEY", precision = 12, scale = 0)
	public Long getNgalleyKey() {
		return this.ngalleyKey;
	}

	public void setNgalleyKey(final Long ngalleyKey) {
		this.ngalleyKey = ngalleyKey;
	}

	@Column(name = "CTEXT_STOW", length = 40)
	public String getCtextStow() {
		return this.ctextStow;
	}

	public void setCtextStow(final String ctextStow) {
		this.ctextStow = ctextStow;
	}

	@Column(name = "NEQUIPMENT_RESIZE", precision = 1, scale = 0)
	public Integer getNequipmentResize() {
		return this.nequipmentResize;
	}

	public void setNequipmentResize(final Integer nequipmentResize) {
		this.nequipmentResize = nequipmentResize;
	}

	@Column(name = "NWEIGHT_STOW", precision = 10, scale = 3)
	public BigDecimal getNweightStow() {
		return this.nweightStow;
	}

	public void setNweightStow(final BigDecimal nweightStow) {
		this.nweightStow = nweightStow;
	}

	@Column(name = "NFOR_TO_CODE", precision = 1, scale = 0)
	public Integer getNforToCode() {
		return this.nforToCode;
	}

	public void setNforToCode(final Integer nforToCode) {
		this.nforToCode = nforToCode;
	}

	@Column(name = "NTLC_KEY", precision = 12, scale = 0)
	public Long getNtlcKey() {
		return this.ntlcKey;
	}

	public void setNtlcKey(final Long ntlcKey) {
		this.ntlcKey = ntlcKey;
	}

	@Column(name = "CTLC", length = 3)
	public String getCtlc() {
		return this.ctlc;
	}

	public void setCtlc(final String ctlc) {
		this.ctlc = ctlc;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NLOADINGLIST_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNloadinglistDetailKey() {
		return this.nloadinglistDetailKey;
	}

	public void setNloadinglistDetailKey(final Long nloadinglistDetailKey) {
		this.nloadinglistDetailKey = nloadinglistDetailKey;
	}

	@Column(name = "NLOADINGLIST_INDEX_KEY_LOI", precision = 12, scale = 0)
	public Long getNloadinglistIndexKeyLoi() {
		return this.nloadinglistIndexKeyLoi;
	}

	public void setNloadinglistIndexKeyLoi(final Long nloadinglistIndexKeyLoi) {
		this.nloadinglistIndexKeyLoi = nloadinglistIndexKeyLoi;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "NGALLEY_GROUP", precision = 3, scale = 0)
	public Integer getNgalleyGroup() {
		return this.ngalleyGroup;
	}

	public void setNgalleyGroup(final Integer ngalleyGroup) {
		this.ngalleyGroup = ngalleyGroup;
	}

	@Column(name = "NCATERING_LEG", precision = 6, scale = 0)
	public Integer getNcateringLeg() {
		return this.ncateringLeg;
	}

	public void setNcateringLeg(final Integer ncateringLeg) {
		this.ncateringLeg = ncateringLeg;
	}

	@Column(name = "NRANKING", precision = 6, scale = 0)
	public Integer getNranking() {
		return this.nranking;
	}

	public void setNranking(final Integer nranking) {
		this.nranking = nranking;
	}

	@Column(name = "NLIMIT", precision = 6, scale = 0)
	public Integer getNlimit() {
		return this.nlimit;
	}

	public void setNlimit(final Integer nlimit) {
		this.nlimit = nlimit;
	}

	@Column(name = "NRANKING_SPML", precision = 6, scale = 0)
	public Integer getNrankingSpml() {
		return this.nrankingSpml;
	}

	public void setNrankingSpml(final Integer nrankingSpml) {
		this.nrankingSpml = nrankingSpml;
	}

	@Column(name = "NLIMIT_SPML", precision = 6, scale = 0)
	public Integer getNlimitSpml() {
		return this.nlimitSpml;
	}

	public void setNlimitSpml(final Integer nlimitSpml) {
		this.nlimitSpml = nlimitSpml;
	}

	@Column(name = "NRECKONING", precision = 12, scale = 0)
	public Long getNreckoning() {
		return this.nreckoning;
	}

	public void setNreckoning(final Long nreckoning) {
		this.nreckoning = nreckoning;
	}

	@Column(name = "NWEIGHT_PCKL", precision = 10, scale = 3)
	public BigDecimal getNweightPckl() {
		return this.nweightPckl;
	}

	public void setNweightPckl(final BigDecimal nweightPckl) {
		this.nweightPckl = nweightPckl;
	}

	@Column(name = "NWEIGHT_GAL", precision = 10, scale = 3)
	public BigDecimal getNweightGal() {
		return this.nweightGal;
	}

	public void setNweightGal(final BigDecimal nweightGal) {
		this.nweightGal = nweightGal;
	}

	@Column(name = "CCLASS1", length = 5)
	public String getCclass1() {
		return this.cclass1;
	}

	public void setCclass1(final String cclass1) {
		this.cclass1 = cclass1;
	}

	@Column(name = "CCLASS2", length = 5)
	public String getCclass2() {
		return this.cclass2;
	}

	public void setCclass2(final String cclass2) {
		this.cclass2 = cclass2;
	}

	@Column(name = "CCLASS3", length = 5)
	public String getCclass3() {
		return this.cclass3;
	}

	public void setCclass3(final String cclass3) {
		this.cclass3 = cclass3;
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "NSEPARATOR", precision = 1, scale = 0)
	public Integer getNseparator() {
		return this.nseparator;
	}

	public void setNseparator(final Integer nseparator) {
		this.nseparator = nseparator;
	}

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 40)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
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

	@Column(name = "NTRANSPORTER_CART", precision = 1, scale = 0)
	public Integer getNtransporterCart() {
		return this.ntransporterCart;
	}

	public void setNtransporterCart(final Integer ntransporterCart) {
		this.ntransporterCart = ntransporterCart;
	}

	@Column(name = "CSALES_REL", length = 1)
	public String getCsalesRel() {
		return this.csalesRel;
	}

	public void setCsalesRel(final String csalesRel) {
		this.csalesRel = csalesRel;
	}

	@Column(name = "CDEF_STORAGE_LOCATION", length = 4)
	public String getCdefStorageLocation() {
		return this.cdefStorageLocation;
	}

	public void setCdefStorageLocation(final String cdefStorageLocation) {
		this.cdefStorageLocation = cdefStorageLocation;
	}

	@Column(name = "CGOODS_RECIPIENT", length = 10)
	public String getCgoodsRecipient() {
		return this.cgoodsRecipient;
	}

	public void setCgoodsRecipient(final String cgoodsRecipient) {
		this.cgoodsRecipient = cgoodsRecipient;
	}

	@Column(name = "CCLASS4", length = 5)
	public String getCclass4() {
		return this.cclass4;
	}

	public void setCclass4(final String cclass4) {
		this.cclass4 = cclass4;
	}

	@Column(name = "CCLASS5", length = 5)
	public String getCclass5() {
		return this.cclass5;
	}

	public void setCclass5(final String cclass5) {
		this.cclass5 = cclass5;
	}

	@Column(name = "CCLASS6", length = 5)
	public String getCclass6() {
		return this.cclass6;
	}

	public void setCclass6(final String cclass6) {
		this.cclass6 = cclass6;
	}

	@Column(name = "NCOM_ACTIONCODE", precision = 1, scale = 0)
	public Integer getNcomActioncode() {
		return this.ncomActioncode;
	}

	public void setNcomActioncode(final Integer ncomActioncode) {
		this.ncomActioncode = ncomActioncode;
	}

	@Column(name = "NCOM_FONTHEIGHT", precision = 6, scale = 0)
	public Integer getNcomFontheight() {
		return this.ncomFontheight;
	}

	public void setNcomFontheight(final Integer ncomFontheight) {
		this.ncomFontheight = ncomFontheight;
	}

	@Column(name = "NCOM_USEFONTSIZE", precision = 1, scale = 0)
	public Integer getNcomUsefontsize() {
		return this.ncomUsefontsize;
	}

	public void setNcomUsefontsize(final Integer ncomUsefontsize) {
		this.ncomUsefontsize = ncomUsefontsize;
	}

	@Column(name = "NCOM_ROWPRINTED", precision = 1, scale = 0)
	public Integer getNcomRowprinted() {
		return this.ncomRowprinted;
	}

	public void setNcomRowprinted(final Integer ncomRowprinted) {
		this.ncomRowprinted = ncomRowprinted;
	}

	@Column(name = "CCOM_CLASSNAME", length = 5)
	public String getCcomClassname() {
		return this.ccomClassname;
	}

	public void setCcomClassname(final String ccomClassname) {
		this.ccomClassname = ccomClassname;
	}

	@Column(name = "CCOM_ZUSTAUTEXT", length = 1000)
	public String getCcomZustautext() {
		return this.ccomZustautext;
	}

	public void setCcomZustautext(final String ccomZustautext) {
		this.ccomZustautext = ccomZustautext;
	}

	@Column(name = "NCOM_EXCLUDE", precision = 1, scale = 0)
	public Integer getNcomExclude() {
		return this.ncomExclude;
	}

	public void setNcomExclude(final Integer ncomExclude) {
		this.ncomExclude = ncomExclude;
	}

	@Column(name = "CCOM_QAQ_ACTIONCODE", length = 10)
	public String getCcomQaqActioncode() {
		return this.ccomQaqActioncode;
	}

	public void setCcomQaqActioncode(final String ccomQaqActioncode) {
		this.ccomQaqActioncode = ccomQaqActioncode;
	}

	@Column(name = "CCOM_SICODES", length = 40)
	public String getCcomSicodes() {
		return this.ccomSicodes;
	}

	public void setCcomSicodes(final String ccomSicodes) {
		this.ccomSicodes = ccomSicodes;
	}

	@Column(name = "NCOM_HANDLING_KEY", precision = 12, scale = 0)
	public Long getNcomHandlingKey() {
		return this.ncomHandlingKey;
	}

	public void setNcomHandlingKey(final Long ncomHandlingKey) {
		this.ncomHandlingKey = ncomHandlingKey;
	}

	@Column(name = "NCOM_CALCWEIGHT", precision = 10, scale = 3)
	public BigDecimal getNcomCalcweight() {
		return this.ncomCalcweight;
	}

	public void setNcomCalcweight(final BigDecimal ncomCalcweight) {
		this.ncomCalcweight = ncomCalcweight;
	}

	@Column(name = "NCOM_NLABEL_TYPE", precision = 12, scale = 0)
	public Long getNcomNlabelType() {
		return this.ncomNlabelType;
	}

	public void setNcomNlabelType(final Long ncomNlabelType) {
		this.ncomNlabelType = ncomNlabelType;
	}

	@Column(name = "NCOM_NPRINT", precision = 1, scale = 0)
	public Integer getNcomNprint() {
		return this.ncomNprint;
	}

	public void setNcomNprint(final Integer ncomNprint) {
		this.ncomNprint = ncomNprint;
	}

	@Column(name = "NCOM_LABELPRINTING", precision = 1, scale = 0)
	public Integer getNcomLabelprinting() {
		return this.ncomLabelprinting;
	}

	public void setNcomLabelprinting(final Integer ncomLabelprinting) {
		this.ncomLabelprinting = ncomLabelprinting;
	}

	@Column(name = "NCOM_STATIONINSTRUCTION", precision = 1, scale = 0)
	public Integer getNcomStationinstruction() {
		return this.ncomStationinstruction;
	}

	public void setNcomStationinstruction(final Integer ncomStationinstruction) {
		this.ncomStationinstruction = ncomStationinstruction;
	}

	@Column(name = "NCOM_NWORKSTATIONKEY", precision = 12, scale = 0)
	public Long getNcomNworkstationkey() {
		return this.ncomNworkstationkey;
	}

	public void setNcomNworkstationkey(final Long ncomNworkstationkey) {
		this.ncomNworkstationkey = ncomNworkstationkey;
	}

	@Column(name = "CCOM_CWORKSTATION", length = 40)
	public String getCcomCworkstation() {
		return this.ccomCworkstation;
	}

	public void setCcomCworkstation(final String ccomCworkstation) {
		this.ccomCworkstation = ccomCworkstation;
	}

	@Column(name = "NCOM_NAREAKEY", precision = 12, scale = 0)
	public Long getNcomNareakey() {
		return this.ncomNareakey;
	}

	public void setNcomNareakey(final Long ncomNareakey) {
		this.ncomNareakey = ncomNareakey;
	}

	@Column(name = "CCOM_CAREA", length = 40)
	public String getCcomCarea() {
		return this.ccomCarea;
	}

	public void setCcomCarea(final String ccomCarea) {
		this.ccomCarea = ccomCarea;
	}

	@Column(name = "CCOM_CAREA_CODE", length = 40)
	public String getCcomCareaCode() {
		return this.ccomCareaCode;
	}

	public void setCcomCareaCode(final String ccomCareaCode) {
		this.ccomCareaCode = ccomCareaCode;
	}

	@Column(name = "NCOM_NPLTYPE", precision = 12, scale = 0)
	public Long getNcomNpltype() {
		return this.ncomNpltype;
	}

	public void setNcomNpltype(final Long ncomNpltype) {
		this.ncomNpltype = ncomNpltype;
	}

	@Column(name = "CCOM_PLDETAIL_TEXT", length = 40)
	public String getCcomPldetailText() {
		return this.ccomPldetailText;
	}

	public void setCcomPldetailText(final String ccomPldetailText) {
		this.ccomPldetailText = ccomPldetailText;
	}

	@Column(name = "CCOM_PLDETAIL_LABEL_COUNTER", length = 40)
	public String getCcomPldetailLabelCounter() {
		return this.ccomPldetailLabelCounter;
	}

	public void setCcomPldetailLabelCounter(final String ccomPldetailLabelCounter) {
		this.ccomPldetailLabelCounter = ccomPldetailLabelCounter;
	}

	@Column(name = "NCOM_NDISTRIBUTION_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNcomNdistributionDetailKey() {
		return this.ncomNdistributionDetailKey;
	}

	public void setNcomNdistributionDetailKey(final Long ncomNdistributionDetailKey) {
		this.ncomNdistributionDetailKey = ncomNdistributionDetailKey;
	}

	@Column(name = "NCOM_NDISTRIBUTION_KEY", precision = 12, scale = 0)
	public Long getNcomNdistributionKey() {
		return this.ncomNdistributionKey;
	}

	public void setNcomNdistributionKey(final Long ncomNdistributionKey) {
		this.ncomNdistributionKey = ncomNdistributionKey;
	}

	@Column(name = "NCOM_NUNIT_PRIORITY", precision = 6, scale = 0)
	public Integer getNcomNunitPriority() {
		return this.ncomNunitPriority;
	}

	public void setNcomNunitPriority(final Integer ncomNunitPriority) {
		this.ncomNunitPriority = ncomNunitPriority;
	}

	@Column(name = "CCOM_CDISTRIBUTED_COMPONENTS", length = 500)
	public String getCcomCdistributedComponents() {
		return this.ccomCdistributedComponents;
	}

	public void setCcomCdistributedComponents(final String ccomCdistributedComponents) {
		this.ccomCdistributedComponents = ccomCdistributedComponents;
	}

	@Column(name = "NCOM_NCLASS_NUMBER", precision = 6, scale = 0)
	public Integer getNcomNclassNumber() {
		return this.ncomNclassNumber;
	}

	public void setNcomNclassNumber(final Integer ncomNclassNumber) {
		this.ncomNclassNumber = ncomNclassNumber;
	}

	@Column(name = "NCOM_NREMOVE", precision = 1, scale = 0)
	public Integer getNcomNremove() {
		return this.ncomNremove;
	}

	public void setNcomNremove(final Integer ncomNremove) {
		this.ncomNremove = ncomNremove;
	}

	@Column(name = "CCOM_CWORKSTATION_TEXT", length = 40)
	public String getCcomCworkstationText() {
		return this.ccomCworkstationText;
	}

	public void setCcomCworkstationText(final String ccomCworkstationText) {
		this.ccomCworkstationText = ccomCworkstationText;
	}

	@Column(name = "NCOM_NDUPLICATED", precision = 1, scale = 0)
	public Integer getNcomNduplicated() {
		return this.ncomNduplicated;
	}

	public void setNcomNduplicated(final Integer ncomNduplicated) {
		this.ncomNduplicated = ncomNduplicated;
	}

	@Column(name = "CCOM_CUNIT_TIME", length = 20)
	public String getCcomCunitTime() {
		return this.ccomCunitTime;
	}

	public void setCcomCunitTime(final String ccomCunitTime) {
		this.ccomCunitTime = ccomCunitTime;
	}

	@Column(name = "NCOM_NMODIFIED", precision = 2, scale = 0)
	public Integer getNcomNmodified() {
		return this.ncomNmodified;
	}

	public void setNcomNmodified(final Integer ncomNmodified) {
		this.ncomNmodified = ncomNmodified;
	}

	@Column(name = "CCOM_CRAMPBOX", length = 40)
	public String getCcomCrampbox() {
		return this.ccomCrampbox;
	}

	public void setCcomCrampbox(final String ccomCrampbox) {
		this.ccomCrampbox = ccomCrampbox;
	}

	@Column(name = "CCOM_CAREA_LIST", length = 100)
	public String getCcomCareaList() {
		return this.ccomCareaList;
	}

	public void setCcomCareaList(final String ccomCareaList) {
		this.ccomCareaList = ccomCareaList;
	}

	@Column(name = "CCOM_CWS_LIST", length = 100)
	public String getCcomCwsList() {
		return this.ccomCwsList;
	}

	public void setCcomCwsList(final String ccomCwsList) {
		this.ccomCwsList = ccomCwsList;
	}

	@Column(name = "CCOM_PLDETAIL_EXPLOSION", length = 100)
	public String getCcomPldetailExplosion() {
		return this.ccomPldetailExplosion;
	}

	public void setCcomPldetailExplosion(final String ccomPldetailExplosion) {
		this.ccomPldetailExplosion = ccomPldetailExplosion;
	}

	@Column(name = "CCOM_PL_TO_EXPLODE", length = 100)
	public String getCcomPlToExplode() {
		return this.ccomPlToExplode;
	}

	public void setCcomPlToExplode(final String ccomPlToExplode) {
		this.ccomPlToExplode = ccomPlToExplode;
	}

	@Column(name = "NCOM_NROWID", precision = 6, scale = 0)
	public Integer getNcomNrowid() {
		return this.ncomNrowid;
	}

	public void setNcomNrowid(final Integer ncomNrowid) {
		this.ncomNrowid = ncomNrowid;
	}

	@Column(name = "NCOM_NRAMP_BOX_MODE", precision = 6, scale = 0)
	public Integer getNcomNrampBoxMode() {
		return this.ncomNrampBoxMode;
	}

	public void setNcomNrampBoxMode(final Integer ncomNrampBoxMode) {
		this.ncomNrampBoxMode = ncomNrampBoxMode;
	}

	@Column(name = "CCOM_CRAMPBOX2", length = 40)
	public String getCcomCrampbox2() {
		return this.ccomCrampbox2;
	}

	public void setCcomCrampbox2(final String ccomCrampbox2) {
		this.ccomCrampbox2 = ccomCrampbox2;
	}

	@Column(name = "CCOM_CRTN_COMPONENTS", length = 250)
	public String getCcomCrtnComponents() {
		return this.ccomCrtnComponents;
	}

	public void setCcomCrtnComponents(final String ccomCrtnComponents) {
		this.ccomCrtnComponents = ccomCrtnComponents;
	}

	@Column(name = "CPPSUNIT", length = 10)
	public String getCppsunit() {
		return this.cppsunit;
	}

	public void setCppsunit(final String cppsunit) {
		this.cppsunit = cppsunit;
	}

	@Column(name = "CPPSCOLDSTORE", length = 1)
	public String getCppscoldstore() {
		return this.cppscoldstore;
	}

	public void setCppscoldstore(final String cppscoldstore) {
		this.cppscoldstore = cppscoldstore;
	}

	@Column(name = "NPPSLOTNR", precision = 12, scale = 0)
	public Long getNppslotnr() {
		return this.nppslotnr;
	}

	public void setNppslotnr(final Long nppslotnr) {
		this.nppslotnr = nppslotnr;
	}

	@Column(name = "CPPSCONTAINER", length = 30)
	public String getCppscontainer() {
		return this.cppscontainer;
	}

	public void setCppscontainer(final String cppscontainer) {
		this.cppscontainer = cppscontainer;
	}

	@Column(name = "CPPSEHB", length = 13)
	public String getCppsehb() {
		return this.cppsehb;
	}

	public void setCppsehb(final String cppsehb) {
		this.cppsehb = cppsehb;
	}

	@Column(name = "CPPSBOX", length = 14)
	public String getCppsbox() {
		return this.cppsbox;
	}

	public void setCppsbox(final String cppsbox) {
		this.cppsbox = cppsbox;
	}

	@Column(name = "CPPSUMSTAU", length = 11)
	public String getCppsumstau() {
		return this.cppsumstau;
	}

	public void setCppsumstau(final String cppsumstau) {
		this.cppsumstau = cppsumstau;
	}

	@Column(name = "CPPSAB", length = 10)
	public String getCppsab() {
		return this.cppsab;
	}

	public void setCppsab(final String cppsab) {
		this.cppsab = cppsab;
	}

	@Column(name = "NFLIGHT_LABEL", precision = 12, scale = 0)
	public Long getNflightLabel() {
		return this.nflightLabel;
	}

	public void setNflightLabel(final Long nflightLabel) {
		this.nflightLabel = nflightLabel;
	}

	@Column(name = "NAPPROVED", precision = 12, scale = 0)
	public Long getNapproved() {
		return this.napproved;
	}

	public void setNapproved(final Long napproved) {
		this.napproved = napproved;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(final Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

	@Column(name = "CTEXT_LL", length = 40)
	public String getCtextLl() {
		return this.ctextLl;
	}

	public void setCtextLl(final String ctextLl) {
		this.ctextLl = ctextLl;
	}

}
