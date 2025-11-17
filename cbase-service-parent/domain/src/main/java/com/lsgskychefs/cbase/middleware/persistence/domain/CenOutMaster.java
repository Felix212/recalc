package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_MASTER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MASTER")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "cenOutMaster.cenOut", attributeNodes = {
				@NamedAttributeNode(value = "cenOut", subgraph = "cenOutMaster.cenOut.lazy"),
				@NamedAttributeNode(value = "cenPackinglists", subgraph = "packinglist.details")
		}, subgraphs = {
				@NamedSubgraph(name = "cenOutMaster.cenOut.lazy", attributeNodes = {
						@NamedAttributeNode(value = "cenOutText"),
						@NamedAttributeNode(value = "cenOutComment"),
				}),
				@NamedSubgraph(name = "packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistIf")
				})
		})
})
public class CenOutMaster implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndetailKey;

	private long ntransaction;

	private long nresultKey;

	private int nplType;

	private long nplIndexKey;

	private long nplDetailKey;

	private int nfreqKey;

	private String cpackinglist;

	private String ctext;

	private String cunit;

	private BigDecimal nquantity;

	private int naction;

	private long nareaKey;

	private long nworkstationKey;

	private BigDecimal nreserve;

	private Long nreckoning;

	private Date dtimestamp;

	private int nstatus;

	private Long nhandlingId;

	private Long nplKindKey;

	private Long npackinglistKey;

	private Long nmasterIndexKey;

	private Integer nlevel;

	private Integer npercent;

	private Long nancestorIndexKey;

	private String cloadinglist;

	private int nmanualInput;

	private String ccustomerPl;

	private String ccustomerPlText;

	private Long naccountKey;

	private String caccount;

	private Long nsysaccountKey;

	private String ccode;

	private BigDecimal nsalesPrice;

	private BigDecimal nbillingPrice;

	private BigDecimal nremittanceprice;

	private BigDecimal ndiscount;

	private BigDecimal nportfee;

	private BigDecimal nvatValue;

	private BigDecimal ncostPrice;

	private Long nclassNumber;

	private String cclass;

	private Long nmasterDetailKey;

	private Long nancestorDetailKey;

	private Long nparamsKey1;

	private Long nparamsKey2;

	private Long nparamsKey3;

	private Long nparamsMin;

	private String csalesRel;

	private String cgoodsRecipient;

	private String cdefStorageLocation;

	private BigDecimal nvatValuePortfee;

	private Long nvatKey;

	private Long nvatKeyPortfee;

	private String cpostTypeShort;

	private String cpartUnit;

	private String cadditionalAccount;

	private BigDecimal nportion;

	private BigDecimal nquantityVersion;

	private BigDecimal nreserveVersion;

	private Integer nflagIsdefaultprice;

	private Integer nflagIsinvalidunit;

	private Long npltimeframeIndex;

	private Date dprodDate;

	private String cpackinglistXsl;

	private String ctextShort;

	private Integer npartialsubstitution;

	private Integer nserviceSequence;

	private String csapCode;

	private Long nworkscheduleIndex;

	private Long npltfFlightIndexGroup;

	private Long npltfFlightIndex;

	private String cprodCatText;

	private Integer nbatch;

	@JsonIgnore
	private CenOut cenOut;

	@JsonIgnore
	private CenPackinglists cenPackinglists;

	@Id
	// NOTE: The sequence generator has been commented out for a reason, don't use it!
	// If you need to insert new rows, use "nativeQueryProvider.getNextSeqValue(CbaseSequence.SEQ_CEN_OUT_MASTER)"
	// to get a new sequence.
	// @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_MASTER")
	// @SequenceGenerator(name = "SEQ_CEN_OUT_MASTER", sequenceName = "SEQ_CEN_OUT_MASTER", allocationSize = 1)
	@Column(name = "NDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NPL_TYPE", nullable = false, precision = 6, scale = 0)
	public int getNplType() {
		return this.nplType;
	}

	public void setNplType(final int nplType) {
		this.nplType = nplType;
	}

	@Column(name = "NPL_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "NPL_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNplDetailKey() {
		return this.nplDetailKey;
	}

	public void setNplDetailKey(final long nplDetailKey) {
		this.nplDetailKey = nplDetailKey;
	}

	@Column(name = "NFREQ_KEY", nullable = false, precision = 1, scale = 0)
	public int getNfreqKey() {
		return this.nfreqKey;
	}

	public void setNfreqKey(final int nfreqKey) {
		this.nfreqKey = nfreqKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NACTION", nullable = false, precision = 2, scale = 0)
	public int getNaction() {
		return this.naction;
	}

	public void setNaction(final int naction) {
		this.naction = naction;
	}

	@Column(name = "NAREA_KEY", nullable = false, precision = 12, scale = 0)
	public long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "NRESERVE", nullable = false, precision = 6)
	public BigDecimal getNreserve() {
		return this.nreserve;
	}

	public void setNreserve(final BigDecimal nreserve) {
		this.nreserve = nreserve;
	}

	@Column(name = "NRECKONING", precision = 12, scale = 0)
	public Long getNreckoning() {
		return this.nreckoning;
	}

	public void setNreckoning(final Long nreckoning) {
		this.nreckoning = nreckoning;
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

	@Column(name = "NHANDLING_ID", precision = 12, scale = 0)
	public Long getNhandlingId() {
		return this.nhandlingId;
	}

	public void setNhandlingId(final Long nhandlingId) {
		this.nhandlingId = nhandlingId;
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "NPACKINGLIST_KEY", precision = 12, scale = 0)
	public Long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@Column(name = "NMASTER_INDEX_KEY", precision = 12, scale = 0)
	public Long getNmasterIndexKey() {
		return this.nmasterIndexKey;
	}

	public void setNmasterIndexKey(final Long nmasterIndexKey) {
		this.nmasterIndexKey = nmasterIndexKey;
	}

	@Column(name = "NLEVEL", precision = 6, scale = 0)
	public Integer getNlevel() {
		return this.nlevel;
	}

	public void setNlevel(final Integer nlevel) {
		this.nlevel = nlevel;
	}

	@Column(name = "NPERCENT", precision = 1, scale = 0)
	public Integer getNpercent() {
		return this.npercent;
	}

	public void setNpercent(final Integer npercent) {
		this.npercent = npercent;
	}

	@Column(name = "NANCESTOR_INDEX_KEY", precision = 12, scale = 0)
	public Long getNancestorIndexKey() {
		return this.nancestorIndexKey;
	}

	public void setNancestorIndexKey(final Long nancestorIndexKey) {
		this.nancestorIndexKey = nancestorIndexKey;
	}

	@Column(name = "CLOADINGLIST", length = 18)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "NMANUAL_INPUT", nullable = false, precision = 1, scale = 0)
	public int getNmanualInput() {
		return this.nmanualInput;
	}

	public void setNmanualInput(final int nmanualInput) {
		this.nmanualInput = nmanualInput;
	}

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_PL_TEXT", length = 40)
	public String getCcustomerPlText() {
		return this.ccustomerPlText;
	}

	public void setCcustomerPlText(final String ccustomerPlText) {
		this.ccustomerPlText = ccustomerPlText;
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

	@Column(name = "NSYSACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNsysaccountKey() {
		return this.nsysaccountKey;
	}

	public void setNsysaccountKey(final Long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	@Column(name = "CCODE", length = 5)
	public String getCcode() {
		return this.ccode;
	}

	public void setCcode(final String ccode) {
		this.ccode = ccode;
	}

	@Column(name = "NSALES_PRICE", precision = 12)
	public BigDecimal getNsalesPrice() {
		return this.nsalesPrice;
	}

	public void setNsalesPrice(final BigDecimal nsalesPrice) {
		this.nsalesPrice = nsalesPrice;
	}

	@Column(name = "NBILLING_PRICE", precision = 12, scale = 4)
	public BigDecimal getNbillingPrice() {
		return this.nbillingPrice;
	}

	public void setNbillingPrice(final BigDecimal nbillingPrice) {
		this.nbillingPrice = nbillingPrice;
	}

	@Column(name = "NREMITTANCEPRICE", precision = 12)
	public BigDecimal getNremittanceprice() {
		return this.nremittanceprice;
	}

	public void setNremittanceprice(final BigDecimal nremittanceprice) {
		this.nremittanceprice = nremittanceprice;
	}

	@Column(name = "NDISCOUNT", precision = 5)
	public BigDecimal getNdiscount() {
		return this.ndiscount;
	}

	public void setNdiscount(final BigDecimal ndiscount) {
		this.ndiscount = ndiscount;
	}

	@Column(name = "NPORTFEE", precision = 5)
	public BigDecimal getNportfee() {
		return this.nportfee;
	}

	public void setNportfee(final BigDecimal nportfee) {
		this.nportfee = nportfee;
	}

	@Column(name = "NVAT_VALUE", precision = 5)
	public BigDecimal getNvatValue() {
		return this.nvatValue;
	}

	public void setNvatValue(final BigDecimal nvatValue) {
		this.nvatValue = nvatValue;
	}

	@Column(name = "NCOST_PRICE", precision = 12)
	public BigDecimal getNcostPrice() {
		return this.ncostPrice;
	}

	public void setNcostPrice(final BigDecimal ncostPrice) {
		this.ncostPrice = ncostPrice;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NMASTER_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNmasterDetailKey() {
		return this.nmasterDetailKey;
	}

	public void setNmasterDetailKey(final Long nmasterDetailKey) {
		this.nmasterDetailKey = nmasterDetailKey;
	}

	@Column(name = "NANCESTOR_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNancestorDetailKey() {
		return this.nancestorDetailKey;
	}

	public void setNancestorDetailKey(final Long nancestorDetailKey) {
		this.nancestorDetailKey = nancestorDetailKey;
	}

	@Column(name = "NPARAMS_KEY1", precision = 12, scale = 0)
	public Long getNparamsKey1() {
		return this.nparamsKey1;
	}

	public void setNparamsKey1(final Long nparamsKey1) {
		this.nparamsKey1 = nparamsKey1;
	}

	@Column(name = "NPARAMS_KEY2", precision = 12, scale = 0)
	public Long getNparamsKey2() {
		return this.nparamsKey2;
	}

	public void setNparamsKey2(final Long nparamsKey2) {
		this.nparamsKey2 = nparamsKey2;
	}

	@Column(name = "NPARAMS_KEY3", precision = 12, scale = 0)
	public Long getNparamsKey3() {
		return this.nparamsKey3;
	}

	public void setNparamsKey3(final Long nparamsKey3) {
		this.nparamsKey3 = nparamsKey3;
	}

	@Column(name = "NPARAMS_MIN", precision = 12, scale = 0)
	public Long getNparamsMin() {
		return this.nparamsMin;
	}

	public void setNparamsMin(final Long nparamsMin) {
		this.nparamsMin = nparamsMin;
	}

	@Column(name = "CSALES_REL", length = 1)
	public String getCsalesRel() {
		return this.csalesRel;
	}

	public void setCsalesRel(final String csalesRel) {
		this.csalesRel = csalesRel;
	}

	@Column(name = "CGOODS_RECIPIENT", length = 10)
	public String getCgoodsRecipient() {
		return this.cgoodsRecipient;
	}

	public void setCgoodsRecipient(final String cgoodsRecipient) {
		this.cgoodsRecipient = cgoodsRecipient;
	}

	@Column(name = "CDEF_STORAGE_LOCATION", length = 4)
	public String getCdefStorageLocation() {
		return this.cdefStorageLocation;
	}

	public void setCdefStorageLocation(final String cdefStorageLocation) {
		this.cdefStorageLocation = cdefStorageLocation;
	}

	@Column(name = "NVAT_VALUE_PORTFEE", precision = 5)
	public BigDecimal getNvatValuePortfee() {
		return this.nvatValuePortfee;
	}

	public void setNvatValuePortfee(final BigDecimal nvatValuePortfee) {
		this.nvatValuePortfee = nvatValuePortfee;
	}

	@Column(name = "NVAT_KEY", precision = 12, scale = 0)
	public Long getNvatKey() {
		return this.nvatKey;
	}

	public void setNvatKey(final Long nvatKey) {
		this.nvatKey = nvatKey;
	}

	@Column(name = "NVAT_KEY_PORTFEE", precision = 12, scale = 0)
	public Long getNvatKeyPortfee() {
		return this.nvatKeyPortfee;
	}

	public void setNvatKeyPortfee(final Long nvatKeyPortfee) {
		this.nvatKeyPortfee = nvatKeyPortfee;
	}

	@Column(name = "CPOST_TYPE_SHORT", length = 1)
	public String getCpostTypeShort() {
		return this.cpostTypeShort;
	}

	public void setCpostTypeShort(final String cpostTypeShort) {
		this.cpostTypeShort = cpostTypeShort;
	}

	@Column(name = "CPART_UNIT", length = 4)
	public String getCpartUnit() {
		return this.cpartUnit;
	}

	public void setCpartUnit(final String cpartUnit) {
		this.cpartUnit = cpartUnit;
	}

	@Column(name = "CADDITIONAL_ACCOUNT", length = 18)
	public String getCadditionalAccount() {
		return this.cadditionalAccount;
	}

	public void setCadditionalAccount(final String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
	}

	@Column(name = "NPORTION", precision = 15, scale = 6)
	public BigDecimal getNportion() {
		return this.nportion;
	}

	public void setNportion(final BigDecimal nportion) {
		this.nportion = nportion;
	}

	@Column(name = "NQUANTITY_VERSION", precision = 12, scale = 3)
	public BigDecimal getNquantityVersion() {
		return this.nquantityVersion;
	}

	public void setNquantityVersion(final BigDecimal nquantityVersion) {
		this.nquantityVersion = nquantityVersion;
	}

	@Column(name = "NRESERVE_VERSION", precision = 6)
	public BigDecimal getNreserveVersion() {
		return this.nreserveVersion;
	}

	public void setNreserveVersion(final BigDecimal nreserveVersion) {
		this.nreserveVersion = nreserveVersion;
	}

	@Column(name = "NFLAG_ISDEFAULTPRICE", precision = 1, scale = 0)
	public Integer getNflagIsdefaultprice() {
		return this.nflagIsdefaultprice;
	}

	public void setNflagIsdefaultprice(final Integer nflagIsdefaultprice) {
		this.nflagIsdefaultprice = nflagIsdefaultprice;
	}

	@Column(name = "NFLAG_ISINVALIDUNIT", precision = 1, scale = 0)
	public Integer getNflagIsinvalidunit() {
		return this.nflagIsinvalidunit;
	}

	public void setNflagIsinvalidunit(final Integer nflagIsinvalidunit) {
		this.nflagIsinvalidunit = nflagIsinvalidunit;
	}

	@Column(name = "NPLTIMEFRAME_INDEX", precision = 12, scale = 0)
	public Long getNpltimeframeIndex() {
		return this.npltimeframeIndex;
	}

	public void setNpltimeframeIndex(final Long npltimeframeIndex) {
		this.npltimeframeIndex = npltimeframeIndex;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPROD_DATE", length = 7)
	public Date getDprodDate() {
		return this.dprodDate;
	}

	public void setDprodDate(final Date dprodDate) {
		this.dprodDate = dprodDate;
	}

	@Column(name = "CPACKINGLIST_XSL", length = 18)
	public String getCpackinglistXsl() {
		return this.cpackinglistXsl;
	}

	public void setCpackinglistXsl(final String cpackinglistXsl) {
		this.cpackinglistXsl = cpackinglistXsl;
	}

	@Column(name = "CTEXT_SHORT", length = 170)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "NPARTIALSUBSTITUTION", precision = 1, scale = 0)
	public Integer getNpartialsubstitution() {
		return this.npartialsubstitution;
	}

	public void setNpartialsubstitution(final Integer npartialsubstitution) {
		this.npartialsubstitution = npartialsubstitution;
	}

	@Column(name = "NSERVICE_SEQUENCE", precision = 1, scale = 0)
	public Integer getNserviceSequence() {
		return this.nserviceSequence;
	}

	public void setNserviceSequence(final Integer nserviceSequence) {
		this.nserviceSequence = nserviceSequence;
	}

	@Column(name = "CSAP_CODE", length = 3)
	public String getCsapCode() {
		return this.csapCode;
	}

	public void setCsapCode(final String csapCode) {
		this.csapCode = csapCode;
	}

	@Column(name = "NWORKSCHEDULE_INDEX", precision = 12, scale = 0)
	public Long getNworkscheduleIndex() {
		return this.nworkscheduleIndex;
	}

	public void setNworkscheduleIndex(final Long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	@Column(name = "NPLTF_FLIGHT_INDEX_GROUP", precision = 12, scale = 0)
	public Long getNpltfFlightIndexGroup() {
		return this.npltfFlightIndexGroup;
	}

	public void setNpltfFlightIndexGroup(final Long npltfFlightIndexGroup) {
		this.npltfFlightIndexGroup = npltfFlightIndexGroup;
	}

	@Column(name = "NPLTF_FLIGHT_INDEX", precision = 12, scale = 0)
	public Long getNpltfFlightIndex() {
		return this.npltfFlightIndex;
	}

	public void setNpltfFlightIndex(final Long npltfFlightIndex) {
		this.npltfFlightIndex = npltfFlightIndex;
	}

	@Column(name = "CPROD_CAT_TEXT", length = 40)
	public String getCprodCatText() {
		return this.cprodCatText;
	}

	public void setCprodCatText(final String cprodCatText) {
		this.cprodCatText = cprodCatText;
	}

	@Column(name = "NBATCH", precision = 1, scale = 0)
	public Integer getNbatch() {
		return this.nbatch;
	}

	public void setNbatch(final Integer nbatch) {
		this.nbatch = nbatch;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPL_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", insertable = false, updatable = false),
			@JoinColumn(name = "NPL_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", insertable = false, updatable = false)
	})
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

}
