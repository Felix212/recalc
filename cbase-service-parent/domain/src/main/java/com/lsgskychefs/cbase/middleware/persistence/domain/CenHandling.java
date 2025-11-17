package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.08.2016 09:42:20 by Hibernate Tools 4.3.2-SNAPSHOT

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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_HANDLING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_HANDLING", uniqueConstraints = @UniqueConstraint(columnNames = { "NCUSTOMER_KEY", "NHANDLING_ID", "CTEXT",
		"NSUPPLIER_KEY" }))
public class CenHandling implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nhandlingKey;

	@JsonView(View.FullWithReferences.class)
	private CenAirlineAccounts cenAirlineAccounts;

	@JsonView(View.FullWithReferences.class)
	private CenAirlines cenAirlines;

	@JsonView(View.FullWithReferences.class)
	private CenSupplier cenSupplier;

	@JsonView(View.SimpleWithReferences.class)
	private SysHandlingId sysHandlingId;

	@JsonView(View.Simple.class)
	private String ctext;

	@JsonView(View.Simple.class)
	private String cdescription;

	@JsonView(View.Simple.class)
	private Integer nownerId;

	@JsonView(View.Simple.class)
	private Long nclassNumber;

	@JsonView(View.Simple.class)
	private int nuseCustomerPackets;

	@JsonView(View.Simple.class)
	private int ngenFlag;

	@JsonView(View.Simple.class)
	private int nuseShortPackets;

	@JsonView(View.Simple.class)
	private Integer npackExactFlag;

	@JsonView(View.Simple.class)
	private Integer npackCombFlag;

	@JsonView(View.Simple.class)
	private Integer nlosExactFlag;

	@JsonView(View.Simple.class)
	private Integer nlosCombFlag;

	@JsonView(View.Simple.class)
	private String cllPantrycode;

	@JsonView(View.Simple.class)
	private Date dvalidFrom;

	@JsonView(View.Simple.class)
	private Date dvalidTo;

	@JsonView(View.Simple.class)
	private String cfrequency;

	@JsonView(View.Simple.class)
	private Date dtimestampModification;

	@JsonView(View.FullWithReferences.class)
	private Set<CenHandlingAcdocDetail> cenHandlingAcdocDetails = new HashSet<>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenRoutingplanHandling> cenRoutingplanHandlings = new HashSet<>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenHandlingDocDetail> cenHandlingDocDetails = new HashSet<>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenMeals> cenMealses = new HashSet<>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenMealsSpml> cenMealsSpmls = new HashSet<>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenHandlingDetail> cenHandlingDetails = new HashSet<>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenMealCover> cenMealCoversForNhandlingKey = new HashSet<CenMealCover>(0);

	@JsonView(View.FullWithReferences.class)
	private Set<CenMealCover> cenMealCoversForNhandlingForeignKey = new HashSet<CenMealCover>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_HANDLING")
	@SequenceGenerator(name = "SEQ_CEN_HANDLING", sequenceName = "SEQ_CEN_HANDLING", allocationSize = 1)
	@Column(name = "NHANDLING_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(final long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NACCOUNT_KEY")
	public CenAirlineAccounts getCenAirlineAccounts() {
		return this.cenAirlineAccounts;
	}

	public void setCenAirlineAccounts(final CenAirlineAccounts cenAirlineAccounts) {
		this.cenAirlineAccounts = cenAirlineAccounts;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCUSTOMER_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
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
	@JoinColumn(name = "NHANDLING_ID", nullable = false)
	public SysHandlingId getSysHandlingId() {
		return this.sysHandlingId;
	}

	public void setSysHandlingId(final SysHandlingId sysHandlingId) {
		this.sysHandlingId = sysHandlingId;
	}

	@Column(name = "CTEXT", nullable = false, length = 30)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NUSE_CUSTOMER_PACKETS", nullable = false, precision = 1, scale = 0)
	public int getNuseCustomerPackets() {
		return this.nuseCustomerPackets;
	}

	public void setNuseCustomerPackets(final int nuseCustomerPackets) {
		this.nuseCustomerPackets = nuseCustomerPackets;
	}

	@Column(name = "NGEN_FLAG", nullable = false, precision = 1, scale = 0)
	public int getNgenFlag() {
		return this.ngenFlag;
	}

	public void setNgenFlag(final int ngenFlag) {
		this.ngenFlag = ngenFlag;
	}

	@Column(name = "NUSE_SHORT_PACKETS", nullable = false, precision = 1, scale = 0)
	public int getNuseShortPackets() {
		return this.nuseShortPackets;
	}

	public void setNuseShortPackets(final int nuseShortPackets) {
		this.nuseShortPackets = nuseShortPackets;
	}

	@Column(name = "NPACK_EXACT_FLAG", precision = 1, scale = 0)
	public Integer getNpackExactFlag() {
		return this.npackExactFlag;
	}

	public void setNpackExactFlag(final Integer npackExactFlag) {
		this.npackExactFlag = npackExactFlag;
	}

	@Column(name = "NPACK_COMB_FLAG", precision = 1, scale = 0)
	public Integer getNpackCombFlag() {
		return this.npackCombFlag;
	}

	public void setNpackCombFlag(final Integer npackCombFlag) {
		this.npackCombFlag = npackCombFlag;
	}

	@Column(name = "NLOS_EXACT_FLAG", precision = 1, scale = 0)
	public Integer getNlosExactFlag() {
		return this.nlosExactFlag;
	}

	public void setNlosExactFlag(final Integer nlosExactFlag) {
		this.nlosExactFlag = nlosExactFlag;
	}

	@Column(name = "NLOS_COMB_FLAG", precision = 1, scale = 0)
	public Integer getNlosCombFlag() {
		return this.nlosCombFlag;
	}

	public void setNlosCombFlag(final Integer nlosCombFlag) {
		this.nlosCombFlag = nlosCombFlag;
	}

	@Column(name = "CLL_PANTRYCODE", length = 10)
	public String getCllPantrycode() {
		return this.cllPantrycode;
	}

	public void setCllPantrycode(final String cllPantrycode) {
		this.cllPantrycode = cllPantrycode;
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

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandling")
	public Set<CenHandlingAcdocDetail> getCenHandlingAcdocDetails() {
		return this.cenHandlingAcdocDetails;
	}

	public void setCenHandlingAcdocDetails(final Set<CenHandlingAcdocDetail> cenHandlingAcdocDetails) {
		this.cenHandlingAcdocDetails = cenHandlingAcdocDetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandling")
	public Set<CenRoutingplanHandling> getCenRoutingplanHandlings() {
		return this.cenRoutingplanHandlings;
	}

	public void setCenRoutingplanHandlings(final Set<CenRoutingplanHandling> cenRoutingplanHandlings) {
		this.cenRoutingplanHandlings = cenRoutingplanHandlings;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandling")
	public Set<CenHandlingDocDetail> getCenHandlingDocDetails() {
		return this.cenHandlingDocDetails;
	}

	public void setCenHandlingDocDetails(final Set<CenHandlingDocDetail> cenHandlingDocDetails) {
		this.cenHandlingDocDetails = cenHandlingDocDetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandling")
	public Set<CenMeals> getCenMealses() {
		return this.cenMealses;
	}

	public void setCenMealses(final Set<CenMeals> cenMealses) {
		this.cenMealses = cenMealses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandling")
	public Set<CenMealsSpml> getCenMealsSpmls() {
		return cenMealsSpmls;
	}

	public void setCenMealsSpmls(Set<CenMealsSpml> cenMealsSpmls) {
		this.cenMealsSpmls = cenMealsSpmls;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandling")
	public Set<CenHandlingDetail> getCenHandlingDetails() {
		return this.cenHandlingDetails;
	}

	public void setCenHandlingDetails(Set<CenHandlingDetail> cenHandlingDetails) {
		this.cenHandlingDetails = cenHandlingDetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandlingByNhandlingKey")
	public Set<CenMealCover> getCenMealCoversForNhandlingKey() {
		return this.cenMealCoversForNhandlingKey;
	}

	public void setCenMealCoversForNhandlingKey(Set<CenMealCover> cenMealCoversForNhandlingKey) {
		this.cenMealCoversForNhandlingKey = cenMealCoversForNhandlingKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandlingByNhandlingForeignKey")
	public Set<CenMealCover> getCenMealCoversForNhandlingForeignKey() {
		return this.cenMealCoversForNhandlingForeignKey;
	}

	public void setCenMealCoversForNhandlingForeignKey(Set<CenMealCover> cenMealCoversForNhandlingForeignKey) {
		this.cenMealCoversForNhandlingForeignKey = cenMealCoversForNhandlingForeignKey;
	}

}
