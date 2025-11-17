package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.01.2021 15:33:18 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_LOADINGLIST_INDEX
 *
 * @author Hibernate Tools
 */
@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "CEN_LOADINGLIST_INDEX", uniqueConstraints = @UniqueConstraint(columnNames = { "CCLIENT", "CLOADINGLIST", "DVALID_FROM",
		"DVALID_TO" }))
@NamedEntityGraph(name = "loadinglist.details", attributeNodes = {
		@NamedAttributeNode(value = "cenLoadinglistses", subgraph = "loadinglists.packinglist"),
}, subgraphs = {
		@NamedSubgraph(name = "loadinglists.packinglist", attributeNodes = {
				@NamedAttributeNode(value = "cenPackinglistIndex"),
				@NamedAttributeNode(value = "cenLoadinglistsDynloads")
		})
})
public class CenLoadinglistIndex implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nloadinglistIndexKey;
	@JsonIgnore
	private CenAircraft cenAircraft;
	private String cclient;
	private String cloadinglist;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String ctext;
	private long nloadinglistKey;
	private String cbasicLoadinglist;
	private Integer nownerId;
	private Integer nreleaseNumber;
	private Integer nflightNumber;
	private String cloadingAt;
	private Date dtimestampModification;
	private String croutingInfo;
	private Date dtimestampImport;
	private Long ncustomerKey;
	private Long nsysaccountKey;
	private String cllnr;
	private String cdistance;
	private Long nloadinglistStateKey;
	private String cservice1;
	private String cservice2;
	private String cservice3;
	private String crouting1;
	private String crouting2;
	private String crouting3;
	private String ctextShort;
	private String cunit;
	private String crevLevel;
	private String cprocessingStatus;
	private String cllUsage;
	private String cuser;
	private String cinfo;
	private String cfertart;
	private String cchangeNo;
	private String clevelOfService;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cbelart;
	private String coldLoadinglist;
	private String ccomments;
	private String ccompleteUser;
	private Date dcompleteDate;
	private boolean nleg1;
	private boolean nleg2;
	private boolean nleg3;
	private boolean nleg4;
	@JsonIgnore
	private Set<CenLoadinglists> cenLoadinglistses = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_LOADINGLIST_INDEX")
	@SequenceGenerator(name = "SEQ_CEN_LOADINGLIST_INDEX", sequenceName = "SEQ_CEN_LOADINGLIST_INDEX", allocationSize = 1)
	@Column(name = "NLOADINGLIST_INDEX_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadinglistIndexKey() {
		return this.nloadinglistIndexKey;
	}

	public void setNloadinglistIndexKey(long nloadinglistIndexKey) {
		this.nloadinglistIndexKey = nloadinglistIndexKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", nullable = false)
	public CenAircraft getCenAircraft() {
		return this.cenAircraft;
	}

	public void setCenAircraft(CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CLOADINGLIST", nullable = false, length = 18)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(String cloadinglist) {
		this.cloadinglist = cloadinglist;
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

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NLOADINGLIST_KEY", nullable = false, precision = 12, scale = 0)
	public long getNloadinglistKey() {
		return this.nloadinglistKey;
	}

	public void setNloadinglistKey(long nloadinglistKey) {
		this.nloadinglistKey = nloadinglistKey;
	}

	@Column(name = "CBASIC_LOADINGLIST", length = 18)
	public String getCbasicLoadinglist() {
		return this.cbasicLoadinglist;
	}

	public void setCbasicLoadinglist(String cbasicLoadinglist) {
		this.cbasicLoadinglist = cbasicLoadinglist;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NRELEASE_NUMBER", precision = 6, scale = 0)
	public Integer getNreleaseNumber() {
		return this.nreleaseNumber;
	}

	public void setNreleaseNumber(Integer nreleaseNumber) {
		this.nreleaseNumber = nreleaseNumber;
	}

	@Column(name = "NFLIGHT_NUMBER", precision = 6, scale = 0)
	public Integer getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(Integer nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CLOADING_AT", length = 3)
	public String getCloadingAt() {
		return this.cloadingAt;
	}

	public void setCloadingAt(String cloadingAt) {
		this.cloadingAt = cloadingAt;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "CROUTING_INFO", length = 40)
	public String getCroutingInfo() {
		return this.croutingInfo;
	}

	public void setCroutingInfo(String croutingInfo) {
		this.croutingInfo = croutingInfo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_IMPORT", length = 7)
	public Date getDtimestampImport() {
		return this.dtimestampImport;
	}

	public void setDtimestampImport(Date dtimestampImport) {
		this.dtimestampImport = dtimestampImport;
	}

	@Column(name = "NCUSTOMER_KEY", precision = 12, scale = 0)
	public Long getNcustomerKey() {
		return this.ncustomerKey;
	}

	public void setNcustomerKey(Long ncustomerKey) {
		this.ncustomerKey = ncustomerKey;
	}

	@Column(name = "NSYSACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNsysaccountKey() {
		return this.nsysaccountKey;
	}

	public void setNsysaccountKey(Long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	@Column(name = "CLLNR", length = 3)
	public String getCllnr() {
		return this.cllnr;
	}

	public void setCllnr(String cllnr) {
		this.cllnr = cllnr;
	}

	@Column(name = "CDISTANCE", length = 15)
	public String getCdistance() {
		return this.cdistance;
	}

	public void setCdistance(String cdistance) {
		this.cdistance = cdistance;
	}

	@Column(name = "NLOADINGLIST_STATE_KEY", precision = 13, scale = 0)
	public Long getNloadinglistStateKey() {
		return this.nloadinglistStateKey;
	}

	public void setNloadinglistStateKey(Long nloadinglistStateKey) {
		this.nloadinglistStateKey = nloadinglistStateKey;
	}

	@Column(name = "CSERVICE1", length = 3)
	public String getCservice1() {
		return this.cservice1;
	}

	public void setCservice1(String cservice1) {
		this.cservice1 = cservice1;
	}

	@Column(name = "CSERVICE2", length = 3)
	public String getCservice2() {
		return this.cservice2;
	}

	public void setCservice2(String cservice2) {
		this.cservice2 = cservice2;
	}

	@Column(name = "CSERVICE3", length = 3)
	public String getCservice3() {
		return this.cservice3;
	}

	public void setCservice3(String cservice3) {
		this.cservice3 = cservice3;
	}

	@Column(name = "CROUTING1", length = 1)
	public String getCrouting1() {
		return this.crouting1;
	}

	public void setCrouting1(String crouting1) {
		this.crouting1 = crouting1;
	}

	@Column(name = "CROUTING2", length = 1)
	public String getCrouting2() {
		return this.crouting2;
	}

	public void setCrouting2(String crouting2) {
		this.crouting2 = crouting2;
	}

	@Column(name = "CROUTING3", length = 1)
	public String getCrouting3() {
		return this.crouting3;
	}

	public void setCrouting3(String crouting3) {
		this.crouting3 = crouting3;
	}

	@Column(name = "CTEXT_SHORT", length = 40)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CREV_LEVEL", length = 2)
	public String getCrevLevel() {
		return this.crevLevel;
	}

	public void setCrevLevel(String crevLevel) {
		this.crevLevel = crevLevel;
	}

	@Column(name = "CPROCESSING_STATUS", length = 1)
	public String getCprocessingStatus() {
		return this.cprocessingStatus;
	}

	public void setCprocessingStatus(String cprocessingStatus) {
		this.cprocessingStatus = cprocessingStatus;
	}

	@Column(name = "CLL_USAGE", length = 1)
	public String getCllUsage() {
		return this.cllUsage;
	}

	public void setCllUsage(String cllUsage) {
		this.cllUsage = cllUsage;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CINFO", length = 1320)
	public String getCinfo() {
		return this.cinfo;
	}

	public void setCinfo(String cinfo) {
		this.cinfo = cinfo;
	}

	@Column(name = "CFERTART", length = 1)
	public String getCfertart() {
		return this.cfertart;
	}

	public void setCfertart(String cfertart) {
		this.cfertart = cfertart;
	}

	@Column(name = "CCHANGE_NO", length = 12)
	public String getCchangeNo() {
		return this.cchangeNo;
	}

	public void setCchangeNo(String cchangeNo) {
		this.cchangeNo = cchangeNo;
	}

	@Column(name = "CLEVEL_OF_SERVICE", length = 40)
	public String getClevelOfService() {
		return this.clevelOfService;
	}

	public void setClevelOfService(String clevelOfService) {
		this.clevelOfService = clevelOfService;
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

	@Column(name = "CBELART", length = 4)
	public String getCbelart() {
		return this.cbelart;
	}

	public void setCbelart(String cbelart) {
		this.cbelart = cbelart;
	}

	@Column(name = "COLD_LOADINGLIST", length = 18)
	public String getColdLoadinglist() {
		return this.coldLoadinglist;
	}

	public void setColdLoadinglist(String coldLoadinglist) {
		this.coldLoadinglist = coldLoadinglist;
	}

	@Column(name = "CCOMMENTS", length = 512)
	public String getCcomments() {
		return this.ccomments;
	}

	public void setCcomments(String ccomments) {
		this.ccomments = ccomments;
	}

	@Column(name = "CCOMPLETE_USER", length = 40)
	public String getCcompleteUser() {
		return this.ccompleteUser;
	}

	public void setCcompleteUser(String ccompleteUser) {
		this.ccompleteUser = ccompleteUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCOMPLETE_DATE", length = 7)
	public Date getDcompleteDate() {
		return this.dcompleteDate;
	}

	public void setDcompleteDate(Date dcompleteDate) {
		this.dcompleteDate = dcompleteDate;
	}

	@Column(name = "NLEG1", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public boolean getNleg1() {
		return this.nleg1;
	}

	public void setNleg1(boolean nleg1) {
		this.nleg1 = nleg1;
	}

	@Column(name = "NLEG2", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public boolean getNleg2() {
		return this.nleg2;
	}

	public void setNleg2(boolean nleg2) {
		this.nleg2 = nleg2;
	}

	@Column(name = "NLEG3", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public boolean getNleg3() {
		return this.nleg3;
	}

	public void setNleg3(boolean nleg3) {
		this.nleg3 = nleg3;
	}

	@Column(name = "NLEG4", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public boolean getNleg4() {
		return this.nleg4;
	}

	public void setNleg4(boolean nleg4) {
		this.nleg4 = nleg4;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLoadinglistIndex")
	public Set<CenLoadinglists> getCenLoadinglistses() {
		return this.cenLoadinglistses;
	}

	public void setCenLoadinglistses(Set<CenLoadinglists> cenLoadinglistses) {
		this.cenLoadinglistses = cenLoadinglistses;
	}

}
