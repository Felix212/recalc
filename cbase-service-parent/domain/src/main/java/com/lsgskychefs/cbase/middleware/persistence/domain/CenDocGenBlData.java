package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 18, 2018 3:37:46 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_BL_DATA
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_BL_DATA")
public class CenDocGenBlData implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndocBlDataKey;
	private CenDocGenQueueBl cenDocGenQueueBl;
	private String cpackinglist;
	private String ctext;
	private String cprodtext1;
	private String cprodtext2;
	private String cquantity;
	private String cunit;
	private String ccounter;
	private String carea;
	private String cworkstation;
	private String clabelWorkstation;
	private Long nlabelTypeKey;
	private Integer nsort;
	private Integer nbelly;
	private String cdate;
	private String cday;
	private String sops;
	private String stimeFrom;
	private String stimeTo;
	private String cworkstationLong;
	private String cweekday;
	private Integer nlabelPrint;
	private String cairline;
	private String cid;
	private String ccapacity;
	private String cunitofmeasure;
	private String ctotalquantity;
	private String ccustomerPl;
	private String ccustomerText;
	private String cflights;
	private String cminKitchendatetime;
	private String cmaxKitchendatetime;
	private Long npackinglistIndexKey;
	private String cquantityVer;
	private String creserve;
	private String cprodDay;
	private String cprodDayTr;
	private String cusedbyDay;
	private String cusedbyDayTr;
	private String cresultkeys;
	private Long locUnitPlAreasNplAreaKey;
	private Long nareaKey;
	private Long nplDetailKey;
	private Long nplIndexKey;
	private Long nworkstationKey;
	private BigDecimal computeDiff;
	private BigDecimal computeProdmenge;
	private BigDecimal computeQuantity;
	private BigDecimal computeQuantityVersion;
	private BigDecimal ncompareQuantity;
	private BigDecimal nreserveUdf;
	private String cresultkeylist;

	@Id
	@Column(name = "NDOC_BL_DATA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdocBlDataKey() {
		return this.ndocBlDataKey;
	}

	public void setNdocBlDataKey(final long ndocBlDataKey) {
		this.ndocBlDataKey = ndocBlDataKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDOC_GEN_QUEUE_BL", nullable = false)
	public CenDocGenQueueBl getCenDocGenQueueBl() {
		return this.cenDocGenQueueBl;
	}

	public void setCenDocGenQueueBl(final CenDocGenQueueBl cenDocGenQueueBl) {
		this.cenDocGenQueueBl = cenDocGenQueueBl;
	}

	@Column(name = "CPACKINGLIST", length = 36)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CPRODTEXT1", length = 80)
	public String getCprodtext1() {
		return this.cprodtext1;
	}

	public void setCprodtext1(final String cprodtext1) {
		this.cprodtext1 = cprodtext1;
	}

	@Column(name = "CPRODTEXT2", length = 80)
	public String getCprodtext2() {
		return this.cprodtext2;
	}

	public void setCprodtext2(final String cprodtext2) {
		this.cprodtext2 = cprodtext2;
	}

	@Column(name = "CQUANTITY", length = 15)
	public String getCquantity() {
		return this.cquantity;
	}

	public void setCquantity(final String cquantity) {
		this.cquantity = cquantity;
	}

	@Column(name = "CUNIT", length = 10)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCOUNTER", length = 10)
	public String getCcounter() {
		return this.ccounter;
	}

	public void setCcounter(final String ccounter) {
		this.ccounter = ccounter;
	}

	@Column(name = "CAREA", length = 24)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CWORKSTATION", length = 24)
	public String getCworkstation() {
		return this.cworkstation;
	}

	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Column(name = "CLABEL_WORKSTATION", length = 24)
	public String getClabelWorkstation() {
		return this.clabelWorkstation;
	}

	public void setClabelWorkstation(final String clabelWorkstation) {
		this.clabelWorkstation = clabelWorkstation;
	}

	@Column(name = "NLABEL_TYPE_KEY", precision = 12, scale = 0)
	public Long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(final Long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "NSORT", precision = 6, scale = 0)
	public Integer getNsort() {
		return this.nsort;
	}

	public void setNsort(final Integer nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NBELLY", precision = 1, scale = 0)
	public Integer getNbelly() {
		return this.nbelly;
	}

	public void setNbelly(final Integer nbelly) {
		this.nbelly = nbelly;
	}

	@Column(name = "CDATE", length = 12)
	public String getCdate() {
		return this.cdate;
	}

	public void setCdate(final String cdate) {
		this.cdate = cdate;
	}

	@Column(name = "CDAY", length = 10)
	public String getCday() {
		return this.cday;
	}

	public void setCday(final String cday) {
		this.cday = cday;
	}

	@Column(name = "SOPS", length = 10)
	public String getSops() {
		return this.sops;
	}

	public void setSops(final String sops) {
		this.sops = sops;
	}

	@Column(name = "STIME_FROM", length = 10)
	public String getStimeFrom() {
		return this.stimeFrom;
	}

	public void setStimeFrom(final String stimeFrom) {
		this.stimeFrom = stimeFrom;
	}

	@Column(name = "STIME_TO", length = 10)
	public String getStimeTo() {
		return this.stimeTo;
	}

	public void setStimeTo(final String stimeTo) {
		this.stimeTo = stimeTo;
	}

	@Column(name = "CWORKSTATION_LONG", length = 80)
	public String getCworkstationLong() {
		return this.cworkstationLong;
	}

	public void setCworkstationLong(final String cworkstationLong) {
		this.cworkstationLong = cworkstationLong;
	}

	@Column(name = "CWEEKDAY", length = 10)
	public String getCweekday() {
		return this.cweekday;
	}

	public void setCweekday(final String cweekday) {
		this.cweekday = cweekday;
	}

	@Column(name = "NLABEL_PRINT", precision = 1, scale = 0)
	public Integer getNlabelPrint() {
		return this.nlabelPrint;
	}

	public void setNlabelPrint(final Integer nlabelPrint) {
		this.nlabelPrint = nlabelPrint;
	}

	@Column(name = "CAIRLINE", length = 10)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "CID", length = 10)
	public String getCid() {
		return this.cid;
	}

	public void setCid(final String cid) {
		this.cid = cid;
	}

	@Column(name = "CCAPACITY", length = 10)
	public String getCcapacity() {
		return this.ccapacity;
	}

	public void setCcapacity(final String ccapacity) {
		this.ccapacity = ccapacity;
	}

	@Column(name = "CUNITOFMEASURE", length = 10)
	public String getCunitofmeasure() {
		return this.cunitofmeasure;
	}

	public void setCunitofmeasure(final String cunitofmeasure) {
		this.cunitofmeasure = cunitofmeasure;
	}

	@Column(name = "CTOTALQUANTITY", length = 10)
	public String getCtotalquantity() {
		return this.ctotalquantity;
	}

	public void setCtotalquantity(final String ctotalquantity) {
		this.ctotalquantity = ctotalquantity;
	}

	@Column(name = "CCUSTOMER_PL", length = 36)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 80)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@Column(name = "CFLIGHTS", length = 4000)
	public String getCflights() {
		return this.cflights;
	}

	public void setCflights(final String cflights) {
		this.cflights = cflights;
	}

	@Column(name = "CMIN_KITCHENDATETIME", length = 18)
	public String getCminKitchendatetime() {
		return this.cminKitchendatetime;
	}

	public void setCminKitchendatetime(final String cminKitchendatetime) {
		this.cminKitchendatetime = cminKitchendatetime;
	}

	@Column(name = "CMAX_KITCHENDATETIME", length = 18)
	public String getCmaxKitchendatetime() {
		return this.cmaxKitchendatetime;
	}

	public void setCmaxKitchendatetime(final String cmaxKitchendatetime) {
		this.cmaxKitchendatetime = cmaxKitchendatetime;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CQUANTITY_VER", length = 10)
	public String getCquantityVer() {
		return this.cquantityVer;
	}

	public void setCquantityVer(final String cquantityVer) {
		this.cquantityVer = cquantityVer;
	}

	@Column(name = "CRESERVE", length = 10)
	public String getCreserve() {
		return this.creserve;
	}

	public void setCreserve(final String creserve) {
		this.creserve = creserve;
	}

	@Column(name = "CPROD_DAY", length = 14)
	public String getCprodDay() {
		return this.cprodDay;
	}

	public void setCprodDay(final String cprodDay) {
		this.cprodDay = cprodDay;
	}

	@Column(name = "CPROD_DAY_TR", length = 14)
	public String getCprodDayTr() {
		return this.cprodDayTr;
	}

	public void setCprodDayTr(final String cprodDayTr) {
		this.cprodDayTr = cprodDayTr;
	}

	@Column(name = "CUSEDBY_DAY", length = 14)
	public String getCusedbyDay() {
		return this.cusedbyDay;
	}

	public void setCusedbyDay(final String cusedbyDay) {
		this.cusedbyDay = cusedbyDay;
	}

	@Column(name = "CUSEDBY_DAY_TR", length = 14)
	public String getCusedbyDayTr() {
		return this.cusedbyDayTr;
	}

	public void setCusedbyDayTr(final String cusedbyDayTr) {
		this.cusedbyDayTr = cusedbyDayTr;
	}

	@Column(name = "CRESULTKEYS")
	public String getCresultkeys() {
		return this.cresultkeys;
	}

	public void setCresultkeys(final String cresultkeys) {
		this.cresultkeys = cresultkeys;
	}

	@Column(name = "LOC_UNIT_PL_AREAS_NPL_AREA_KEY", precision = 12, scale = 0)
	public Long getLocUnitPlAreasNplAreaKey() {
		return this.locUnitPlAreasNplAreaKey;
	}

	public void setLocUnitPlAreasNplAreaKey(final Long locUnitPlAreasNplAreaKey) {
		this.locUnitPlAreasNplAreaKey = locUnitPlAreasNplAreaKey;
	}

	@Column(name = "NAREA_KEY", precision = 12, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "NPL_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNplDetailKey() {
		return this.nplDetailKey;
	}

	public void setNplDetailKey(final Long nplDetailKey) {
		this.nplDetailKey = nplDetailKey;
	}

	@Column(name = "NPL_INDEX_KEY", precision = 12, scale = 0)
	public Long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final Long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 12, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "COMPUTE_DIFF", precision = 12, scale = 3)
	public BigDecimal getComputeDiff() {
		return this.computeDiff;
	}

	public void setComputeDiff(final BigDecimal computeDiff) {
		this.computeDiff = computeDiff;
	}

	@Column(name = "COMPUTE_PRODMENGE", precision = 12, scale = 3)
	public BigDecimal getComputeProdmenge() {
		return this.computeProdmenge;
	}

	public void setComputeProdmenge(final BigDecimal computeProdmenge) {
		this.computeProdmenge = computeProdmenge;
	}

	@Column(name = "COMPUTE_QUANTITY", precision = 12, scale = 3)
	public BigDecimal getComputeQuantity() {
		return this.computeQuantity;
	}

	public void setComputeQuantity(final BigDecimal computeQuantity) {
		this.computeQuantity = computeQuantity;
	}

	@Column(name = "COMPUTE_QUANTITY_VERSION", precision = 12, scale = 3)
	public BigDecimal getComputeQuantityVersion() {
		return this.computeQuantityVersion;
	}

	public void setComputeQuantityVersion(final BigDecimal computeQuantityVersion) {
		this.computeQuantityVersion = computeQuantityVersion;
	}

	@Column(name = "NCOMPARE_QUANTITY", precision = 12, scale = 3)
	public BigDecimal getNcompareQuantity() {
		return this.ncompareQuantity;
	}

	public void setNcompareQuantity(final BigDecimal ncompareQuantity) {
		this.ncompareQuantity = ncompareQuantity;
	}

	@Column(name = "NRESERVE_UDF", precision = 12, scale = 3)
	public BigDecimal getNreserveUdf() {
		return this.nreserveUdf;
	}

	public void setNreserveUdf(final BigDecimal nreserveUdf) {
		this.nreserveUdf = nreserveUdf;
	}

	@Column(name = "CRESULTKEYLIST", length = 4000)
	public String getCresultkeylist() {
		return this.cresultkeylist;
	}

	public void setCresultkeylist(final String cresultkeylist) {
		this.cresultkeylist = cresultkeylist;
	}

}
