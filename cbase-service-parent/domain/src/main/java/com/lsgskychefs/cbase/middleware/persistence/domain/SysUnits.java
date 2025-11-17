package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpContextResetUserRole;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpContextRole;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpContextUser;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_UNITS
 *
 * @author Hibernate Tools
 */

@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpContextUser.PP_CONTEXT_USER, procedureName = "CONTEXT_PACKAGE."
				+ PpContextUser.PP_CONTEXT_USER, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpContextUser.P_USER_ID, type = Long.class)
		}),
		@NamedStoredProcedureQuery(name = PpContextRole.PP_CONTEXT_ROLE, procedureName = "CONTEXT_PACKAGE."
				+ PpContextRole.PP_CONTEXT_ROLE, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpContextRole.P_ROLE_ID, type = Long.class)
		}),
		@NamedStoredProcedureQuery(name = PpContextResetUserRole.PP_CONTEXT_RESET_USERROLE, procedureName = "CONTEXT_PACKAGE."
				+ PpContextResetUserRole.PP_CONTEXT_RESET_USERROLE)

})
@NamedEntityGraphs({
		@NamedEntityGraph(name = "sysUnit.sysThreeLetterCodes", attributeNodes = {
				@NamedAttributeNode(value = "sysThreeLetterCodes"),
		}),
		@NamedEntityGraph(name = "sysUnit.outstation", attributeNodes = {
				@NamedAttributeNode(value = "sysThreeLetterCodes"),
				@NamedAttributeNode(value = "cenSupplier"),
				@NamedAttributeNode(value = "sysUnitsCaterer", subgraph = "sysUnit.outstation.details")
		}, subgraphs = {
				@NamedSubgraph(name = "sysUnit.outstation.details", attributeNodes = {
						@NamedAttributeNode(value = "locUnitCatererDocumentUploads")
				})
		})
})

@Entity
@Table(name = "SYS_UNITS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysUnits implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private String cunit;

	@JsonView(View.SimpleWithReferences.class)
	private CenSupplier cenSupplier;

	@JsonView(View.SimpleWithReferences.class)
	private SysThreeLetterCodes sysThreeLetterCodes;

	@JsonView(View.Simple.class)
	private String ctext;

	@JsonView(View.Simple.class)
	private String cclient;

	@JsonView(View.Simple.class)
	private Integer nlanguage;

	private String camosUnit;

	private String ccobisUnit;

	@JsonView(View.Simple.class)
	private String cregion;

	private String cinstance;

	private Integer ncosting;

	private String cexportClient;

	private String cexportUnit;

	private Integer namos24hSpml;

	private Integer namos24hPax;

	private Integer namos6hPax;

	private Integer nimportCis;

	private int nlclFlag;

	private int npps;

	private String chealthmark1;

	private String chealthmark2;

	private String chealthmark3;

	private Integer nordersFlag;

	private Date dordersValidFrom;

	private int nkpiRelevant;

	private int nabfahrbarkeitscheck;

	private long ntlcKey;

	private Integer nnonSky;

	private Integer ndefaultPlLanguage;

	private boolean nploUnit;

	@JsonIgnore
	private SysUnitsCaterer sysUnitsCaterer;

	@JsonIgnore
	private Set<LocPpsProdBom> locPpsProdBoms = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitSetup> locUnitSetups = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitToCategories> locUnitToCategorieses = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitCheckpt> locUnitCheckpts = new HashSet<>(0);

	@JsonIgnore
	private Set<CenRoutingplanHandling> cenRoutingplanHandlings = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitFloorplan> locUnitFloorplans = new HashSet<>(0);

	@JsonIgnore
	private Set<CenAirlineUnit> cenAirlineUnits = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPloBreak> locPloBreaks = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPloShift> locPloShifts = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPloItemlist> locPloItemlists = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPloWoDef> locPloWoDefs = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitReportSchedule> locUnitReportSchedules = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPreprodPlArea> locPreprodPlAreas = new HashSet<>(0);

	@JsonIgnore
	private Set<CenPlTemperatureCategory> cenPlTemperatureCategories = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitAirlineCutoff> locUnitAirlineCutoffs = new HashSet<>(0);

	@Id
	@Column(name = "CUNIT", unique = true, nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSUPPLIER_KEY")
	public CenSupplier getCenSupplier() {
		return this.cenSupplier;
	}

	public void setCenSupplier(final CenSupplier cenSupplier) {
		this.cenSupplier = cenSupplier;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTLC_KEY", nullable = false)
	public SysThreeLetterCodes getSysThreeLetterCodes() {
		return this.sysThreeLetterCodes;
	}

	public void setSysThreeLetterCodes(final SysThreeLetterCodes sysThreeLetterCodes) {
		this.sysThreeLetterCodes = sysThreeLetterCodes;
		ntlcKey = sysThreeLetterCodes.getNtlcKey();
	}

	@Column(name = "CTEXT", nullable = false, length = 30)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NLANGUAGE", precision = 1, scale = 0)
	public Integer getNlanguage() {
		return this.nlanguage;
	}

	public void setNlanguage(final Integer nlanguage) {
		this.nlanguage = nlanguage;
	}

	@Column(name = "CAMOS_UNIT", length = 30)
	public String getCamosUnit() {
		return this.camosUnit;
	}

	public void setCamosUnit(final String camosUnit) {
		this.camosUnit = camosUnit;
	}

	@Column(name = "CCOBIS_UNIT", length = 3)
	public String getCcobisUnit() {
		return this.ccobisUnit;
	}

	public void setCcobisUnit(final String ccobisUnit) {
		this.ccobisUnit = ccobisUnit;
	}

	@Column(name = "CREGION", length = 30)
	public String getCregion() {
		return this.cregion;
	}

	public void setCregion(final String cregion) {
		this.cregion = cregion;
	}

	@Column(name = "CINSTANCE", length = 10)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "NCOSTING", precision = 1, scale = 0)
	public Integer getNcosting() {
		return this.ncosting;
	}

	public void setNcosting(final Integer ncosting) {
		this.ncosting = ncosting;
	}

	@Column(name = "CEXPORT_CLIENT", length = 18)
	public String getCexportClient() {
		return this.cexportClient;
	}

	public void setCexportClient(final String cexportClient) {
		this.cexportClient = cexportClient;
	}

	@Column(name = "CEXPORT_UNIT", length = 18)
	public String getCexportUnit() {
		return this.cexportUnit;
	}

	public void setCexportUnit(final String cexportUnit) {
		this.cexportUnit = cexportUnit;
	}

	@Column(name = "NAMOS_24H_SPML", precision = 1, scale = 0)
	public Integer getNamos24hSpml() {
		return this.namos24hSpml;
	}

	public void setNamos24hSpml(final Integer namos24hSpml) {
		this.namos24hSpml = namos24hSpml;
	}

	@Column(name = "NAMOS_24H_PAX", precision = 1, scale = 0)
	public Integer getNamos24hPax() {
		return this.namos24hPax;
	}

	public void setNamos24hPax(final Integer namos24hPax) {
		this.namos24hPax = namos24hPax;
	}

	@Column(name = "NAMOS_6H_PAX", precision = 1, scale = 0)
	public Integer getNamos6hPax() {
		return this.namos6hPax;
	}

	public void setNamos6hPax(final Integer namos6hPax) {
		this.namos6hPax = namos6hPax;
	}

	@Column(name = "NIMPORT_CIS", precision = 1, scale = 0)
	public Integer getNimportCis() {
		return this.nimportCis;
	}

	public void setNimportCis(final Integer nimportCis) {
		this.nimportCis = nimportCis;
	}

	@Column(name = "NLCL_FLAG", nullable = false, precision = 1, scale = 0)
	public int getNlclFlag() {
		return this.nlclFlag;
	}

	public void setNlclFlag(final int nlclFlag) {
		this.nlclFlag = nlclFlag;
	}

	@Column(name = "NPPS", nullable = false, precision = 1, scale = 0)
	public int getNpps() {
		return this.npps;
	}

	public void setNpps(final int npps) {
		this.npps = npps;
	}

	@Column(name = "CHEALTHMARK1", length = 10)
	public String getChealthmark1() {
		return this.chealthmark1;
	}

	public void setChealthmark1(final String chealthmark1) {
		this.chealthmark1 = chealthmark1;
	}

	@Column(name = "CHEALTHMARK2", length = 10)
	public String getChealthmark2() {
		return this.chealthmark2;
	}

	public void setChealthmark2(final String chealthmark2) {
		this.chealthmark2 = chealthmark2;
	}

	@Column(name = "CHEALTHMARK3", length = 10)
	public String getChealthmark3() {
		return this.chealthmark3;
	}

	public void setChealthmark3(final String chealthmark3) {
		this.chealthmark3 = chealthmark3;
	}

	@Column(name = "NORDERS_FLAG", precision = 1, scale = 0)
	public Integer getNordersFlag() {
		return this.nordersFlag;
	}

	public void setNordersFlag(final Integer nordersFlag) {
		this.nordersFlag = nordersFlag;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DORDERS_VALID_FROM", length = 7)
	public Date getDordersValidFrom() {
		return this.dordersValidFrom;
	}

	public void setDordersValidFrom(final Date dordersValidFrom) {
		this.dordersValidFrom = dordersValidFrom;
	}

	@Column(name = "NKPI_RELEVANT", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNkpiRelevant() {
		return this.nkpiRelevant;
	}

	public void setNkpiRelevant(final int nkpiRelevant) {
		this.nkpiRelevant = nkpiRelevant;
	}

	@Column(name = "NABFAHRBARKEITSCHECK", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNabfahrbarkeitscheck() {
		return this.nabfahrbarkeitscheck;
	}

	public void setNabfahrbarkeitscheck(final int nabfahrbarkeitscheck) {
		this.nabfahrbarkeitscheck = nabfahrbarkeitscheck;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocPpsProdBom> getLocPpsProdBoms() {
		return this.locPpsProdBoms;
	}

	public void setLocPpsProdBoms(final Set<LocPpsProdBom> locPpsProdBoms) {
		this.locPpsProdBoms = locPpsProdBoms;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocUnitSetup> getLocUnitSetups() {
		return this.locUnitSetups;
	}

	public void setLocUnitSetups(final Set<LocUnitSetup> locUnitSetups) {
		this.locUnitSetups = locUnitSetups;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocUnitToCategories> getLocUnitToCategorieses() {
		return this.locUnitToCategorieses;
	}

	public void setLocUnitToCategorieses(final Set<LocUnitToCategories> locUnitToCategorieses) {
		this.locUnitToCategorieses = locUnitToCategorieses;
	}

	/**
	 * Get ntlcKey
	 *
	 * @return the ntlcKey
	 */
	@Column(name = "NTLC_KEY", nullable = false, insertable = false, updatable = false)
	public long getNtlcKey() {
		return ntlcKey;
	}

	/**
	 * set ntlcKey
	 *
	 * @param ntlcKey the ntlcKey to set
	 */
	public void setNtlcKey(final long ntlcKey) {
		this.ntlcKey = ntlcKey;
	}

	/**
	 * Get nnonSky
	 *
	 * @return the nnonSky
	 */
	@Column(name = "NNON_SKY", precision = 1, scale = 0)
	public Integer getNnonSky() {
		return this.nnonSky;
	}

	/**
	 * set nnonSky
	 *
	 * @param nnonSky the nnonSky to set
	 */
	public void setNnonSky(final Integer nnonSky) {
		this.nnonSky = nnonSky;
	}

	/**
	 * Get ndefaultPlLanguage
	 *
	 * @return the ndefaultPlLanguage
	 */
	@Column(name = "NDEFAULT_PL_LANGUAGE", precision = 2, scale = 0)
	public Integer getNdefaultPlLanguage() {
		return ndefaultPlLanguage;
	}

	/**
	 * set ndefaultPlLanguage
	 *
	 * @param ndefaultPlLanguage the ndefaultPlLanguage to set
	 */
	public void setNdefaultPlLanguage(final Integer ndefaultPlLanguage) {
		this.ndefaultPlLanguage = ndefaultPlLanguage;
	}

	/**
	 * @return the nploUnit
	 */
	@Column(name = "NPLO_UNIT", nullable = false, precision = 1, scale = 0)
	public boolean isNploUnit() {
		return nploUnit;
	}

	/**
	 * @param nploUnit the nploUnit to set
	 */
	public void setNploUnit(final boolean nploUnit) {
		this.nploUnit = nploUnit;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public SysUnitsCaterer getSysUnitsCaterer() {
		return this.sysUnitsCaterer;
	}

	public void setSysUnitsCaterer(SysUnitsCaterer sysUnitsCaterer) {
		this.sysUnitsCaterer = sysUnitsCaterer;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocUnitCheckpt> getLocUnitCheckpts() {
		return this.locUnitCheckpts;
	}

	public void setLocUnitCheckpts(final Set<LocUnitCheckpt> locUnitCheckpts) {
		this.locUnitCheckpts = locUnitCheckpts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<CenRoutingplanHandling> getCenRoutingplanHandlings() {
		return this.cenRoutingplanHandlings;
	}

	public void setCenRoutingplanHandlings(final Set<CenRoutingplanHandling> cenRoutingplanHandlings) {
		this.cenRoutingplanHandlings = cenRoutingplanHandlings;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocUnitFloorplan> getLocUnitFloorplans() {
		return this.locUnitFloorplans;
	}

	public void setLocUnitFloorplans(final Set<LocUnitFloorplan> locUnitFloorplans) {
		this.locUnitFloorplans = locUnitFloorplans;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<CenAirlineUnit> getCenAirlineUnits() {
		return this.cenAirlineUnits;
	}

	public void setCenAirlineUnits(final Set<CenAirlineUnit> cenAirlineUnits) {
		this.cenAirlineUnits = cenAirlineUnits;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocPloBreak> getLocPloBreaks() {
		return this.locPloBreaks;
	}

	public void setLocPloBreaks(final Set<LocPloBreak> locPloBreaks) {
		this.locPloBreaks = locPloBreaks;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocPloShift> getLocPloShifts() {
		return this.locPloShifts;
	}

	public void setLocPloShifts(final Set<LocPloShift> locPloShifts) {
		this.locPloShifts = locPloShifts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocPloItemlist> getLocPloItemlists() {
		return this.locPloItemlists;
	}

	public void setLocPloItemlists(final Set<LocPloItemlist> locPloItemlists) {
		this.locPloItemlists = locPloItemlists;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocPloWoDef> getLocPloWoDefs() {
		return this.locPloWoDefs;
	}

	public void setLocPloWoDefs(final Set<LocPloWoDef> locPloWoDefs) {
		this.locPloWoDefs = locPloWoDefs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocUnitReportSchedule> getLocUnitReportSchedules() {
		return this.locUnitReportSchedules;
	}

	public void setLocUnitReportSchedules(final Set<LocUnitReportSchedule> locUnitReportSchedules) {
		this.locUnitReportSchedules = locUnitReportSchedules;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocPreprodPlArea> getLocPreprodPlAreas() {
		return this.locPreprodPlAreas;
	}

	public void setLocPreprodPlAreas(Set<LocPreprodPlArea> locPreprodPlAreas) {
		this.locPreprodPlAreas = locPreprodPlAreas;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<CenPlTemperatureCategory> getCenPlTemperatureCategories() {
		return this.cenPlTemperatureCategories;
	}

	public void setCenPlTemperatureCategories(Set<CenPlTemperatureCategory> cenPlTemperatureCategories) {
		this.cenPlTemperatureCategories = cenPlTemperatureCategories;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnits")
	public Set<LocUnitAirlineCutoff> getLocUnitAirlineCutoffs() {
		return this.locUnitAirlineCutoffs;
	}

	public void setLocUnitAirlineCutoffs(Set<LocUnitAirlineCutoff> locUnitAirlineCutoffs) {
		this.locUnitAirlineCutoffs = locUnitAirlineCutoffs;
	}

}
