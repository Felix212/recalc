package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_AIRLINES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINES", uniqueConstraints = @UniqueConstraint(columnNames = { "CAIRLINE", "CCLIENT" }))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@NamedEntityGraphs({
		@NamedEntityGraph(name = "airlines.fetchlogos", attributeNodes = {
				@NamedAttributeNode(value = "cenAirlineLogoses")
		}),
		@NamedEntityGraph(name = "airlines.deliverynote", attributeNodes = {
				@NamedAttributeNode(value = "cenAirlineDlvFlightses")
		}),
		@NamedEntityGraph(name = "airlines.classes", attributeNodes = {
				@NamedAttributeNode(value = "cenClassNames")
		}),
})
public class CenAirlines implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nairlineKey;

	@JsonView(View.Simple.class)
	private String cclient;

	@JsonView(View.Simple.class)
	private String cairline;

	@JsonView(View.Simple.class)
	private String ctext;

	@JsonView(View.Simple.class)
	private Integer nownerId;

	@JsonView(View.Simple.class)
	private Integer nuse4web;

	@JsonView(View.Simple.class)
	private Integer nscheduleImport;

	@JsonView(View.Simple.class)
	private Integer nlogo;

	@JsonView(View.Simple.class)
	private Integer nairlineType;

	@JsonView(View.Full.class)
	private Integer nbcImport;

	@JsonView(View.Full.class)
	private Integer nscheduleHeader;

	@JsonView(View.Full.class)
	private Integer nscheduleFooter;

	@JsonView(View.Simple.class)
	private Integer nregistrationCheck;

	@JsonView(View.Full.class)
	private int ncustomBbill;

	@JsonView(View.Simple.class)
	private int nuseOwnerForTraffic;

	@JsonView(View.Simple.class)
	private Integer nskyskopeVisible;

	@JsonView(View.Full.class)
	private int nusePricingDefault;

	@JsonView(View.Simple.class)
	private Long nroleId;

	@JsonView(View.Simple.class)
	private Integer nscheduleCfs;

	@JsonView(View.Full.class)
	private Integer nenableCancellationReduction;

	@JsonView(View.Full.class)
	private Integer ntimeFrameMinutesFrom;

	@JsonView(View.Full.class)
	private Integer ntimeFrameMinutesTo;

	@JsonView(View.Full.class)
	private BigDecimal nreductionFactor;

	@JsonView(View.Full.class)
	private Long nbillingCodeReduction;

	@JsonView(View.Full.class)
	private BigDecimal nreturnFactor;

	@JsonView(View.Full.class)
	private Long nbillingCodeReturn;

	@JsonView(View.Full.class)
	private Integer nrequireExactMatch4Distr;

	@JsonView(View.Full.class)
	private int nusepricingdetails;

	@JsonView(View.Full.class)
	private Integer nforceOverflowInd;

	@JsonView(View.Full.class)
	private Integer nmealsUseProdText;

	/** Flag which decides whether cregistration for flights will be checked when closing them. False (0) = check on. True (1) check off */
	@JsonView(View.Full.class)
	private boolean ntailnumberCheckoff;

	@JsonView(View.Full.class)
	private Integer nprintOverflowOnMain;

	@JsonView(View.Full.class)
	private String callgtextrule;

	@JsonView(View.Full.class)
	private Integer nallguseindustrystd;

	@JsonView(View.Full.class)
	private Integer nallgtextrulemode;

	@JsonView(View.Full.class)
	private Integer nuseimportrules;

	@JsonView(View.Full.class)
	private int ntb;

	@JsonView(View.Full.class)
	private Integer ncateringorderCheckoff;

	@JsonView(View.Full.class)
	private int ncostingProfile;

	@JsonView(View.Full.class)
	private Integer nroutingCheck;

	@JsonView(View.Full.class)
	private Long naemiNumber;

	@JsonView(View.Full.class)
	private String cmatmasCountry;

	@JsonView(View.Full.class)
	private String cmatmasDivision;

	@JsonView(View.Full.class)
	private int nflagPoFlight;

	@JsonView(View.Full.class)
	private int nflagPoValidity;

	@JsonView(View.Full.class)
	private int nuseAcOwnerForCustomer;

	@JsonView(View.Full.class)
	private int nalteaPax;

	@JsonView(View.Full.class)
	private int ndynamicMeals;

	@JsonView(View.Full.class)
	private int nvpsDdn;

	@JsonView(View.Full.class)
	private int ndeliveryApp;

	@JsonIgnore
	private Set<CenHandlingTypes> cenHandlingTypeses = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitToItemlist> locUnitToItemlists = new HashSet<>(0);

	@JsonIgnore
	private Set<CenAircraft> cenAircrafts = new HashSet<>(0);

	@JsonIgnore
	private Set<CenAirlCategories> cenAirlCategorieses = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPpsLoading> locPpsLoadings = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitTimes> locUnitTimeses = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitTimesFlight> locUnitTimesFlights = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenClassName> cenClassNames = new HashSet<>(0);

	@JsonIgnore
	private Set<CenHandling> cenHandlings = new HashSet<>(0);

	@JsonIgnore
	private Set<CenAirlineUnit> cenAirlineUnits = new HashSet<>(0);

	@JsonView(View.SpecialRelation.class)
	private Set<CenAirlineLogos> cenAirlineLogoses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenAirlineDlvFlights> cenAirlineDlvFlightses = new HashSet<>(0);

	@JsonIgnore
	private Set<CenAirlineDlvRecipient> cenAirlineDlvRecipients = new HashSet<>(0);

	@JsonIgnore
	private Set<LocUnitAirlineCutoff> locUnitAirlineCutoffs = new HashSet<>(0);

	/**
	 * Gets the nairline key.
	 *
	 * @return the nairline key
	 */
	@Id
	@Column(name = "NAIRLINE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	/**
	 * Sets the nairline key.
	 *
	 * @param nairlineKey the new nairline key
	 */
	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	/**
	 * Gets the cclient.
	 *
	 * @return the cclient
	 */
	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	/**
	 * Sets the cclient.
	 *
	 * @param cclient the new cclient
	 */
	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	/**
	 * Gets the cairline.
	 *
	 * @return the cairline
	 */
	@Column(name = "CAIRLINE", nullable = false, length = 10)
	public String getCairline() {
		return this.cairline;
	}

	/**
	 * Sets the cairline.
	 *
	 * @param cairline the new cairline
	 */
	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	/**
	 * Gets the ctext.
	 *
	 * @return the ctext
	 */
	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	/**
	 * Sets the ctext.
	 *
	 * @param ctext the new ctext
	 */
	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	/**
	 * Gets the nowner id.
	 *
	 * @return the nowner id
	 */
	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	/**
	 * Sets the nowner id.
	 *
	 * @param nownerId the new nowner id
	 */
	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	/**
	 * Gets the nuse4web.
	 *
	 * @return the nuse4web
	 */
	@Column(name = "NUSE4WEB", precision = 1, scale = 0)
	public Integer getNuse4web() {
		return this.nuse4web;
	}

	/**
	 * Sets the nuse4web.
	 *
	 * @param nuse4web the new nuse4web
	 */
	public void setNuse4web(final Integer nuse4web) {
		this.nuse4web = nuse4web;
	}

	/**
	 * Gets the nschedule import.
	 *
	 * @return the nschedule import
	 */
	@Column(name = "NSCHEDULE_IMPORT", precision = 1, scale = 0)
	public Integer getNscheduleImport() {
		return this.nscheduleImport;
	}

	/**
	 * Sets the nschedule import.
	 *
	 * @param nscheduleImport the new nschedule import
	 */
	public void setNscheduleImport(final Integer nscheduleImport) {
		this.nscheduleImport = nscheduleImport;
	}

	/**
	 * Gets the nlogo.
	 *
	 * @return the nlogo
	 */
	@Column(name = "NLOGO", precision = 3, scale = 0)
	public Integer getNlogo() {
		return this.nlogo;
	}

	/**
	 * Sets the nlogo.
	 *
	 * @param nlogo the new nlogo
	 */
	public void setNlogo(final Integer nlogo) {
		this.nlogo = nlogo;
	}

	/**
	 * Gets the nairline type.
	 *
	 * @return the nairline type
	 */
	@Column(name = "NAIRLINE_TYPE", precision = 2, scale = 0)
	public Integer getNairlineType() {
		return this.nairlineType;
	}

	/**
	 * Sets the nairline type.
	 *
	 * @param nairlineType the new nairline type
	 */
	public void setNairlineType(final Integer nairlineType) {
		this.nairlineType = nairlineType;
	}

	/**
	 * Gets the nbc import.
	 *
	 * @return the nbc import
	 */
	@Column(name = "NBC_IMPORT", precision = 1, scale = 0)
	public Integer getNbcImport() {
		return this.nbcImport;
	}

	/**
	 * Sets the nbc import.
	 *
	 * @param nbcImport the new nbc import
	 */
	public void setNbcImport(final Integer nbcImport) {
		this.nbcImport = nbcImport;
	}

	/**
	 * Gets the nschedule header.
	 *
	 * @return the nschedule header
	 */
	@Column(name = "NSCHEDULE_HEADER", precision = 1, scale = 0)
	public Integer getNscheduleHeader() {
		return this.nscheduleHeader;
	}

	/**
	 * Sets the nschedule header.
	 *
	 * @param nscheduleHeader the new nschedule header
	 */
	public void setNscheduleHeader(final Integer nscheduleHeader) {
		this.nscheduleHeader = nscheduleHeader;
	}

	/**
	 * Gets the nschedule footer.
	 *
	 * @return the nschedule footer
	 */
	@Column(name = "NSCHEDULE_FOOTER", precision = 1, scale = 0)
	public Integer getNscheduleFooter() {
		return this.nscheduleFooter;
	}

	/**
	 * Sets the nschedule footer.
	 *
	 * @param nscheduleFooter the new nschedule footer
	 */
	public void setNscheduleFooter(final Integer nscheduleFooter) {
		this.nscheduleFooter = nscheduleFooter;
	}

	/**
	 * Gets the nregistration check.
	 *
	 * @return the nregistration check
	 */
	@Column(name = "NREGISTRATION_CHECK", precision = 1, scale = 0)
	public Integer getNregistrationCheck() {
		return this.nregistrationCheck;
	}

	/**
	 * Sets the nregistration check.
	 *
	 * @param nregistrationCheck the new nregistration check
	 */
	public void setNregistrationCheck(final Integer nregistrationCheck) {
		this.nregistrationCheck = nregistrationCheck;
	}

	/**
	 * Gets the ncustom bbill.
	 *
	 * @return the ncustom bbill
	 */
	@Column(name = "NCUSTOM_BBILL", nullable = false, precision = 1, scale = 0)
	public int getNcustomBbill() {
		return this.ncustomBbill;
	}

	/**
	 * Sets the ncustom bbill.
	 *
	 * @param ncustomBbill the new ncustom bbill
	 */
	public void setNcustomBbill(final int ncustomBbill) {
		this.ncustomBbill = ncustomBbill;
	}

	/**
	 * Gets the nuse owner for traffic.
	 *
	 * @return the nuse owner for traffic
	 */
	@Column(name = "NUSE_OWNER_FOR_TRAFFIC", nullable = false, precision = 1, scale = 0)
	public int getNuseOwnerForTraffic() {
		return this.nuseOwnerForTraffic;
	}

	/**
	 * Sets the nuse owner for traffic.
	 *
	 * @param nuseOwnerForTraffic the new nuse owner for traffic
	 */
	public void setNuseOwnerForTraffic(final int nuseOwnerForTraffic) {
		this.nuseOwnerForTraffic = nuseOwnerForTraffic;
	}

	/**
	 * Gets the nskyskope visible.
	 *
	 * @return the nskyskope visible
	 */
	@Column(name = "NSKYSKOPE_VISIBLE", precision = 1, scale = 0)
	public Integer getNskyskopeVisible() {
		return this.nskyskopeVisible;
	}

	/**
	 * Sets the nskyskope visible.
	 *
	 * @param nskyskopeVisible the new nskyskope visible
	 */
	public void setNskyskopeVisible(final Integer nskyskopeVisible) {
		this.nskyskopeVisible = nskyskopeVisible;
	}

	/**
	 * Gets the nuse pricing default.
	 *
	 * @return the nuse pricing default
	 */
	@Column(name = "NUSE_PRICING_DEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNusePricingDefault() {
		return this.nusePricingDefault;
	}

	/**
	 * Sets the nuse pricing default.
	 *
	 * @param nusePricingDefault the new nuse pricing default
	 */
	public void setNusePricingDefault(final int nusePricingDefault) {
		this.nusePricingDefault = nusePricingDefault;
	}

	/**
	 * Gets the nrole id.
	 *
	 * @return the nrole id
	 */
	@Column(name = "NROLE_ID", precision = 12, scale = 0)
	public Long getNroleId() {
		return this.nroleId;
	}

	/**
	 * Sets the nrole id.
	 *
	 * @param nroleId the new nrole id
	 */
	public void setNroleId(final Long nroleId) {
		this.nroleId = nroleId;
	}

	/**
	 * Gets the nschedule cfs.
	 *
	 * @return the nschedule cfs
	 */
	@Column(name = "NSCHEDULE_CFS", precision = 1, scale = 0)
	public Integer getNscheduleCfs() {
		return this.nscheduleCfs;
	}

	/**
	 * Sets the nschedule cfs.
	 *
	 * @param nscheduleCfs the new nschedule cfs
	 */
	public void setNscheduleCfs(final Integer nscheduleCfs) {
		this.nscheduleCfs = nscheduleCfs;
	}

	/**
	 * Gets the nenable cancellation reduction.
	 *
	 * @return the nenable cancellation reduction
	 */
	@Column(name = "NENABLE_CANCELLATION_REDUCTION", precision = 1, scale = 0)
	public Integer getNenableCancellationReduction() {
		return this.nenableCancellationReduction;
	}

	/**
	 * Sets the nenable cancellation reduction.
	 *
	 * @param nenableCancellationReduction the new nenable cancellation reduction
	 */
	public void setNenableCancellationReduction(final Integer nenableCancellationReduction) {
		this.nenableCancellationReduction = nenableCancellationReduction;
	}

	/**
	 * Gets the ntime frame minutes from.
	 *
	 * @return the ntime frame minutes from
	 */
	@Column(name = "NTIME_FRAME_MINUTES_FROM", precision = 4, scale = 0)
	public Integer getNtimeFrameMinutesFrom() {
		return this.ntimeFrameMinutesFrom;
	}

	/**
	 * Sets the ntime frame minutes from.
	 *
	 * @param ntimeFrameMinutesFrom the new ntime frame minutes from
	 */
	public void setNtimeFrameMinutesFrom(final Integer ntimeFrameMinutesFrom) {
		this.ntimeFrameMinutesFrom = ntimeFrameMinutesFrom;
	}

	/**
	 * Gets the ntime frame minutes to.
	 *
	 * @return the ntime frame minutes to
	 */
	@Column(name = "NTIME_FRAME_MINUTES_TO", precision = 4, scale = 0)
	public Integer getNtimeFrameMinutesTo() {
		return this.ntimeFrameMinutesTo;
	}

	/**
	 * Sets the ntime frame minutes to.
	 *
	 * @param ntimeFrameMinutesTo the new ntime frame minutes to
	 */
	public void setNtimeFrameMinutesTo(final Integer ntimeFrameMinutesTo) {
		this.ntimeFrameMinutesTo = ntimeFrameMinutesTo;
	}

	/**
	 * Gets the nreduction factor.
	 *
	 * @return the nreduction factor
	 */
	@Column(name = "NREDUCTION_FACTOR", precision = 5, scale = 4)
	public BigDecimal getNreductionFactor() {
		return this.nreductionFactor;
	}

	/**
	 * Sets the nreduction factor.
	 *
	 * @param nreductionFactor the new nreduction factor
	 */
	public void setNreductionFactor(final BigDecimal nreductionFactor) {
		this.nreductionFactor = nreductionFactor;
	}

	/**
	 * Gets the nbilling code reduction.
	 *
	 * @return the nbilling code reduction
	 */
	@Column(name = "NBILLING_CODE_REDUCTION", precision = 12, scale = 0)
	public Long getNbillingCodeReduction() {
		return this.nbillingCodeReduction;
	}

	/**
	 * Sets the nbilling code reduction.
	 *
	 * @param nbillingCodeReduction the new nbilling code reduction
	 */
	public void setNbillingCodeReduction(final Long nbillingCodeReduction) {
		this.nbillingCodeReduction = nbillingCodeReduction;
	}

	/**
	 * Gets the nreturn factor.
	 *
	 * @return the nreturn factor
	 */
	@Column(name = "NRETURN_FACTOR", precision = 5, scale = 4)
	public BigDecimal getNreturnFactor() {
		return this.nreturnFactor;
	}

	/**
	 * Sets the nreturn factor.
	 *
	 * @param nreturnFactor the new nreturn factor
	 */
	public void setNreturnFactor(final BigDecimal nreturnFactor) {
		this.nreturnFactor = nreturnFactor;
	}

	/**
	 * Gets the nbilling code return.
	 *
	 * @return the nbilling code return
	 */
	@Column(name = "NBILLING_CODE_RETURN", precision = 12, scale = 0)
	public Long getNbillingCodeReturn() {
		return this.nbillingCodeReturn;
	}

	/**
	 * Sets the nbilling code return.
	 *
	 * @param nbillingCodeReturn the new nbilling code return
	 */
	public void setNbillingCodeReturn(final Long nbillingCodeReturn) {
		this.nbillingCodeReturn = nbillingCodeReturn;
	}

	/**
	 * Gets the nrequire exact match4 distr.
	 *
	 * @return the nrequire exact match4 distr
	 */
	@Column(name = "NREQUIRE_EXACT_MATCH_4_DISTR", precision = 1, scale = 0)
	public Integer getNrequireExactMatch4Distr() {
		return this.nrequireExactMatch4Distr;
	}

	/**
	 * Sets the nrequire exact match4 distr.
	 *
	 * @param nrequireExactMatch4Distr the new nrequire exact match4 distr
	 */
	public void setNrequireExactMatch4Distr(final Integer nrequireExactMatch4Distr) {
		this.nrequireExactMatch4Distr = nrequireExactMatch4Distr;
	}

	/**
	 * Gets the nusepricingdetails.
	 *
	 * @return the nusepricingdetails
	 */
	@Column(name = "NUSEPRICINGDETAILS", nullable = false, precision = 1, scale = 0)
	public int getNusepricingdetails() {
		return this.nusepricingdetails;
	}

	/**
	 * Sets the nusepricingdetails.
	 *
	 * @param nusepricingdetails the new nusepricingdetails
	 */
	public void setNusepricingdetails(final int nusepricingdetails) {
		this.nusepricingdetails = nusepricingdetails;
	}

	/**
	 * Gets the nforce overflow ind.
	 *
	 * @return the nforce overflow ind
	 */
	@Column(name = "NFORCE_OVERFLOW_IND", precision = 1, scale = 0)
	public Integer getNforceOverflowInd() {
		return this.nforceOverflowInd;
	}

	/**
	 * Sets the nforce overflow ind.
	 *
	 * @param nforceOverflowInd the new nforce overflow ind
	 */
	public void setNforceOverflowInd(final Integer nforceOverflowInd) {
		this.nforceOverflowInd = nforceOverflowInd;
	}

	/**
	 * Gets the nmeals use prod text.
	 *
	 * @return the nmeals use prod text
	 */
	@Column(name = "NMEALS_USE_PROD_TEXT", precision = 1, scale = 0)
	public Integer getNmealsUseProdText() {
		return this.nmealsUseProdText;
	}

	/**
	 * Sets the nmeals use prod text.
	 *
	 * @param nmealsUseProdText the new nmeals use prod text
	 */
	public void setNmealsUseProdText(final Integer nmealsUseProdText) {
		this.nmealsUseProdText = nmealsUseProdText;
	}

	/**
	 * Gets the flag witch decides wether cregistration for flights will be checked when closing them. False (0) = check on. True (1) check
	 * off.
	 *
	 * @return the flag witch decides wether cregistration for flights will be checked when closing them
	 */
	@Column(name = "NTAILNUMBER_CHECKOFF", nullable = false, precision = 1, scale = 0)
	public boolean isNtailnumberCheckoff() {
		return this.ntailnumberCheckoff;
	}

	/**
	 * Sets the flag witch decides wether cregistration for flights will be checked when closing them. False (0) = check on. True (1) check
	 * off.
	 *
	 * @param ntailnumberCheckoff the new flag witch decides wether cregistration for flights will be checked when closing them
	 */
	public void setNtailnumberCheckoff(final boolean ntailnumberCheckoff) {
		this.ntailnumberCheckoff = ntailnumberCheckoff;
	}

	/**
	 * Gets the nprint overflow on main.
	 *
	 * @return the nprint overflow on main
	 */
	@Column(name = "NPRINT_OVERFLOW_ON_MAIN", precision = 1, scale = 0)
	public Integer getNprintOverflowOnMain() {
		return this.nprintOverflowOnMain;
	}

	/**
	 * Sets the nprint overflow on main.
	 *
	 * @param nprintOverflowOnMain the new nprint overflow on main
	 */
	public void setNprintOverflowOnMain(final Integer nprintOverflowOnMain) {
		this.nprintOverflowOnMain = nprintOverflowOnMain;
	}

	/**
	 * Gets the callgtextrule.
	 *
	 * @return the callgtextrule
	 */
	@Column(name = "CALLGTEXTRULE", length = 120)
	public String getCallgtextrule() {
		return this.callgtextrule;
	}

	/**
	 * Sets the callgtextrule.
	 *
	 * @param callgtextrule the new callgtextrule
	 */
	public void setCallgtextrule(final String callgtextrule) {
		this.callgtextrule = callgtextrule;
	}

	/**
	 * Gets the nallguseindustrystd.
	 *
	 * @return the nallguseindustrystd
	 */
	@Column(name = "NALLGUSEINDUSTRYSTD", precision = 1, scale = 0)
	public Integer getNallguseindustrystd() {
		return this.nallguseindustrystd;
	}

	/**
	 * Sets the nallguseindustrystd.
	 *
	 * @param nallguseindustrystd the new nallguseindustrystd
	 */
	public void setNallguseindustrystd(final Integer nallguseindustrystd) {
		this.nallguseindustrystd = nallguseindustrystd;
	}

	/**
	 * Gets the nallgtextrulemode.
	 *
	 * @return the nallgtextrulemode
	 */
	@Column(name = "NALLGTEXTRULEMODE", precision = 2, scale = 0)
	public Integer getNallgtextrulemode() {
		return this.nallgtextrulemode;
	}

	/**
	 * Sets the nallgtextrulemode.
	 *
	 * @param nallgtextrulemode the new nallgtextrulemode
	 */
	public void setNallgtextrulemode(final Integer nallgtextrulemode) {
		this.nallgtextrulemode = nallgtextrulemode;
	}

	/**
	 * Gets the nuseimportrules.
	 *
	 * @return the nuseimportrules
	 */
	@Column(name = "NUSEIMPORTRULES", precision = 1, scale = 0)
	public Integer getNuseimportrules() {
		return this.nuseimportrules;
	}

	/**
	 * Sets the nuseimportrules.
	 *
	 * @param nuseimportrules the new nuseimportrules
	 */
	public void setNuseimportrules(final Integer nuseimportrules) {
		this.nuseimportrules = nuseimportrules;
	}

	/**
	 * Gets the ntb.
	 *
	 * @return the ntb
	 */
	@Column(name = "NTB", nullable = false, precision = 1, scale = 0)
	public int getNtb() {
		return this.ntb;
	}

	/**
	 * Sets the ntb.
	 *
	 * @param ntb the new ntb
	 */
	public void setNtb(final int ntb) {
		this.ntb = ntb;
	}

	@Column(name = "NCATERINGORDER_CHECKOFF", precision = 1, scale = 0)
	public Integer getNcateringorderCheckoff() {
		return this.ncateringorderCheckoff;
	}

	public void setNcateringorderCheckoff(final Integer ncateringorderCheckoff) {
		this.ncateringorderCheckoff = ncateringorderCheckoff;
	}

	@Column(name = "NCOSTING_PROFILE", nullable = false, precision = 1, scale = 0)
	public int getNcostingProfile() {
		return this.ncostingProfile;
	}

	public void setNcostingProfile(final int ncostingProfile) {
		this.ncostingProfile = ncostingProfile;
	}

	@Column(name = "NROUTING_CHECK", precision = 1, scale = 0)
	public Integer getNroutingCheck() {
		return this.nroutingCheck;
	}

	public void setNroutingCheck(final Integer nroutingCheck) {
		this.nroutingCheck = nroutingCheck;
	}

	@Column(name = "NAEMI_NUMBER", precision = 10, scale = 0)
	public Long getNaemiNumber() {
		return this.naemiNumber;
	}

	public void setNaemiNumber(final Long naemiNumber) {
		this.naemiNumber = naemiNumber;
	}

	@Column(name = "CMATMAS_COUNTRY", length = 10)
	public String getCmatmasCountry() {
		return this.cmatmasCountry;
	}

	public void setCmatmasCountry(final String cmatmasCountry) {
		this.cmatmasCountry = cmatmasCountry;
	}

	@Column(name = "CMATMAS_DIVISION", length = 10)
	public String getCmatmasDivision() {
		return this.cmatmasDivision;
	}

	public void setCmatmasDivision(final String cmatmasDivision) {
		this.cmatmasDivision = cmatmasDivision;
	}

	@Column(name = "NFLAG_PO_FLIGHT", nullable = false, precision = 1, scale = 0)
	public int getNflagPoFlight() {
		return this.nflagPoFlight;
	}

	public void setNflagPoFlight(final int nflagPoFlight) {
		this.nflagPoFlight = nflagPoFlight;
	}

	@Column(name = "NFLAG_PO_VALIDITY", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNflagPoValidity() {
		return this.nflagPoValidity;
	}

	public void setNflagPoValidity(final int nflagPoValidity) {
		this.nflagPoValidity = nflagPoValidity;
	}

	@Column(name = "NUSE_AC_OWNER_FOR_CUSTOMER", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNuseAcOwnerForCustomer() {
		return this.nuseAcOwnerForCustomer;
	}

	public void setNuseAcOwnerForCustomer(int nuseAcOwnerForCustomer) {
		this.nuseAcOwnerForCustomer = nuseAcOwnerForCustomer;
	}

	@Column(name = "NALTEA_PAX", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNalteaPax() {
		return this.nalteaPax;
	}

	public void setNalteaPax(int nalteaPax) {
		this.nalteaPax = nalteaPax;
	}

	@Column(name = "NDYNAMIC_MEALS", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNdynamicMeals() {
		return this.ndynamicMeals;
	}

	public void setNdynamicMeals(int ndynamicMeals) {
		this.ndynamicMeals = ndynamicMeals;
	}

	@Column(name = "NVPS_DDN", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNvpsDdn() {
		return this.nvpsDdn;
	}

	public void setNvpsDdn(int nvpsDdn) {
		this.nvpsDdn = nvpsDdn;
	}

	@Column(name = "NDELIVERY_APP", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNdeliveryApp() {
		return this.ndeliveryApp;
	}

	public void setNdeliveryApp(int ndeliveryApp) {
		this.ndeliveryApp = ndeliveryApp;
	}

	/**
	 * Gets the cen aircrafts.
	 *
	 * @return the cen aircrafts
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenAircraft> getCenAircrafts() {
		return this.cenAircrafts;
	}

	/**
	 * Sets the cen aircrafts.
	 *
	 * @param cenAircrafts the new cen aircrafts
	 */
	public void setCenAircrafts(final Set<CenAircraft> cenAircrafts) {
		this.cenAircrafts = cenAircrafts;
	}

	/**
	 * Gets the cen airl categorieses.
	 *
	 * @return the cen airl categorieses
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenAirlCategories> getCenAirlCategorieses() {
		return this.cenAirlCategorieses;
	}

	/**
	 * Sets the cen airl categorieses.
	 *
	 * @param cenAirlCategorieses the new cen airl categorieses
	 */
	public void setCenAirlCategorieses(final Set<CenAirlCategories> cenAirlCategorieses) {
		this.cenAirlCategorieses = cenAirlCategorieses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<LocPpsLoading> getLocPpsLoadings() {
		return this.locPpsLoadings;
	}

	public void setLocPpsLoadings(final Set<LocPpsLoading> locPpsLoadings) {
		this.locPpsLoadings = locPpsLoadings;
	}

	/**
	 * Gets the loc unit timeses.
	 *
	 * @return the loc unit timeses
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<LocUnitTimes> getLocUnitTimeses() {
		return this.locUnitTimeses;
	}

	/**
	 * Sets the loc unit timeses.
	 *
	 * @param locUnitTimeses the new loc unit timeses
	 */
	public void setLocUnitTimeses(final Set<LocUnitTimes> locUnitTimeses) {
		this.locUnitTimeses = locUnitTimeses;
	}

	/**
	 * Gets the loc unit times flights.
	 *
	 * @return the loc unit times flights
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<LocUnitTimesFlight> getLocUnitTimesFlights() {
		return this.locUnitTimesFlights;
	}

	/**
	 * Sets the loc unit times flights.
	 *
	 * @param locUnitTimesFlights the new loc unit times flights
	 */
	public void setLocUnitTimesFlights(final Set<LocUnitTimesFlight> locUnitTimesFlights) {
		this.locUnitTimesFlights = locUnitTimesFlights;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenHandlingTypes> getCenHandlingTypeses() {
		return this.cenHandlingTypeses;
	}

	public void setCenHandlingTypeses(final Set<CenHandlingTypes> cenHandlingTypeses) {
		this.cenHandlingTypeses = cenHandlingTypeses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<LocUnitToItemlist> getLocUnitToItemlists() {
		return this.locUnitToItemlists;
	}

	public void setLocUnitToItemlists(final Set<LocUnitToItemlist> locUnitToItemlists) {
		this.locUnitToItemlists = locUnitToItemlists;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenClassName> getCenClassNames() {
		return this.cenClassNames;
	}

	public void setCenClassNames(final Set<CenClassName> cenClassNames) {
		this.cenClassNames = cenClassNames;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenHandling> getCenHandlings() {
		return this.cenHandlings;
	}

	public void setCenHandlings(final Set<CenHandling> cenHandlings) {
		this.cenHandlings = cenHandlings;
	}

	/**
	 * Gets the cen airline units.
	 *
	 * @return the cen airline units
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenAirlineUnit> getCenAirlineUnits() {
		return this.cenAirlineUnits;
	}

	/**
	 * Sets the cen airline units.
	 *
	 * @param cenAirlineUnits the new cen airline units
	 */
	public void setCenAirlineUnits(final Set<CenAirlineUnit> cenAirlineUnits) {
		this.cenAirlineUnits = cenAirlineUnits;
	}

	/**
	 * Gets the cen airline logos.
	 *
	 * @return the cen airline logos
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenAirlineLogos> getCenAirlineLogoses() {
		return this.cenAirlineLogoses;
	}

	/**
	 * Sets the cen airline logos.
	 *
	 * @param cenAirlineLogoses the new cen airline logos
	 */
	public void setCenAirlineLogoses(Set<CenAirlineLogos> cenAirlineLogoses) {
		this.cenAirlineLogoses = cenAirlineLogoses;
	}

	/**
	 * Gets the Whitelisted Flights that will show up in the Delivery Note UK App
	 *
	 * @return List of {@link CenAirlineDlvFlights}
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenAirlineDlvFlights> getCenAirlineDlvFlightses() {
		return this.cenAirlineDlvFlightses;
	}

	/**
	 * Sets the Whitelisted Flights that will show up in the Delivery Note UK App
	 *
	 * @param cenAirlineDlvFlightses List of {@link CenAirlineDlvFlights}
	 */
	public void setCenAirlineDlvFlightses(Set<CenAirlineDlvFlights> cenAirlineDlvFlightses) {
		this.cenAirlineDlvFlightses = cenAirlineDlvFlightses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<CenAirlineDlvRecipient> getCenAirlineDlvRecipients() {
		return this.cenAirlineDlvRecipients;
	}

	public void setCenAirlineDlvRecipients(Set<CenAirlineDlvRecipient> cenAirlineDlvRecipients) {
		this.cenAirlineDlvRecipients = cenAirlineDlvRecipients;
	}

	/**
	 * Dynamic loading cut off time before departure until rules will be applied
	 *
	 * @return Lost of LocUnitAirlineCutoff rules
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlines")
	public Set<LocUnitAirlineCutoff> getLocUnitAirlineCutoffs() {
		return this.locUnitAirlineCutoffs;
	}

	public void setLocUnitAirlineCutoffs(Set<LocUnitAirlineCutoff> locUnitAirlineCutoffs) {
		this.locUnitAirlineCutoffs = locUnitAirlineCutoffs;
	}
}
