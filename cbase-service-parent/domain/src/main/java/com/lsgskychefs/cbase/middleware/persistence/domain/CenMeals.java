package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
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
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_MEALS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MEALS")
public class CenMeals implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** nhandlingMealKey */
	private long nhandlingMealKey;

	/** cenAirlineAccounts */
	private CenAirlineAccounts cenAirlineAccounts;

	/** cenHandling */
	private CenHandling cenHandling;

	/** cenRotations */
	private CenRotations cenRotations;

	/** dvalidFrom */
	private Date dvalidFrom;

	/** dvalidTo */
	private Date dvalidTo;

	/** nrotationKey */
	private long nrotationKey;

	/** nclassNumber */
	private long nclassNumber;

	/** nmoduleType */
	private int nmoduleType;

	/** nreserveQuantity */
	private int nreserveQuantity;

	/** nreserveType */
	private int nreserveType;

	/** ntopoffQuantity */
	private int ntopoffQuantity;

	/** ntopoffType */
	private int ntopoffType;

	/** nask4passenger */
	private int nask4passenger;

	/** cquestionText */
	private String cquestionText;

	/** nplanningPercent */
	private int nplanningPercent;

	/** nmopKey */
	private Long nmopKey;

	/** ncorrValidFlag */
	private Integer ncorrValidFlag;

	/** nservice */
	private int nservice;

	/** nethnic */
	private int nethnic;

	/** cupdatedBy */
	private String cupdatedBy;

	/** dupdatedDate */
	private Date dupdatedDate;

	/** cupdatedByPrev */
	private String cupdatedByPrev;

	/** dupdatedDatePrev */
	private Date dupdatedDatePrev;

	/** csapCode */
	private String csapCode;

	/** ccomment */
	private String ccomment;

	/** noldMealKey */
	private Long noldMealKey;

	/** cpresentation */
	private String cpresentation;
	
	/** cenMealsPackageses */
	private Set<CenMealsPackages> cenMealsPackageses = new HashSet<>(0);

	/** cenMealsSpmls */
	private Set<CenMealsSpml> cenMealsSpmls = new HashSet<>(0);

	/** cenMealsDetails */
	private List<CenMealsDetail> cenMealsDetails = new ArrayList<>();

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MEALS")
    @SequenceGenerator(name = "SEQ_CEN_MEALS", sequenceName = "SEQ_CEN_MEALS", allocationSize = 1)
	@Column(name = "NHANDLING_MEAL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingMealKey() {
		return this.nhandlingMealKey;
	}

	public void setNhandlingMealKey(final long nhandlingMealKey) {
		this.nhandlingMealKey = nhandlingMealKey;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDEFAULT_ACCOUNT_KEY")
	public CenAirlineAccounts getCenAirlineAccounts() {
		return this.cenAirlineAccounts;
	}
	
	public void setCenAirlineAccounts(final CenAirlineAccounts cenAirlineAccounts) {
		this.cenAirlineAccounts = cenAirlineAccounts;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_KEY", nullable = false)
	public CenHandling getCenHandling() {
		return this.cenHandling;
	}

	public void setCenHandling(final CenHandling cenHandling) {
		this.cenHandling = cenHandling;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROTATION_KEY", nullable = false)
	public CenRotations getCenRotations() {
		return this.cenRotations;
	}

	public void setCenRotations(final CenRotations cenRotations) {
		this.cenRotations = cenRotations;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NROTATION_KEY", nullable = false, precision = 12, scale = 0, insertable=false, updatable=false)
	public long getNrotationKey() {
		return this.nrotationKey;
	}

	/**
	 * @deprecated use {@link #setCenRotations()} instead
	 */
	public void setNrotationKey(final long nrotationKey) {
		this.nrotationKey = nrotationKey;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NMODULE_TYPE", nullable = false, precision = 2, scale = 0)
	public int getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(final int nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NRESERVE_QUANTITY", nullable = false, precision = 3, scale = 0)
	public int getNreserveQuantity() {
		return this.nreserveQuantity;
	}

	public void setNreserveQuantity(final int nreserveQuantity) {
		this.nreserveQuantity = nreserveQuantity;
	}

	@Column(name = "NRESERVE_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNreserveType() {
		return this.nreserveType;
	}

	public void setNreserveType(final int nreserveType) {
		this.nreserveType = nreserveType;
	}

	@Column(name = "NTOPOFF_QUANTITY", nullable = false, precision = 3, scale = 0)
	public int getNtopoffQuantity() {
		return this.ntopoffQuantity;
	}

	public void setNtopoffQuantity(final int ntopoffQuantity) {
		this.ntopoffQuantity = ntopoffQuantity;
	}

	@Column(name = "NTOPOFF_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNtopoffType() {
		return this.ntopoffType;
	}

	public void setNtopoffType(final int ntopoffType) {
		this.ntopoffType = ntopoffType;
	}

	@Column(name = "NASK4PASSENGER", nullable = false, precision = 1, scale = 0)
	public int getNask4passenger() {
		return this.nask4passenger;
	}

	public void setNask4passenger(final int nask4passenger) {
		this.nask4passenger = nask4passenger;
	}

	@Column(name = "CQUESTION_TEXT", length = 40)
	public String getCquestionText() {
		return this.cquestionText;
	}

	public void setCquestionText(final String cquestionText) {
		this.cquestionText = cquestionText;
	}

	@Column(name = "NPLANNING_PERCENT", nullable = false, precision = 3, scale = 0)
	public int getNplanningPercent() {
		return this.nplanningPercent;
	}

	public void setNplanningPercent(final int nplanningPercent) {
		this.nplanningPercent = nplanningPercent;
	}

	@Column(name = "NMOP_KEY", precision = 12, scale = 0)
	public Long getNmopKey() {
		return this.nmopKey;
	}

	public void setNmopKey(final Long nmopKey) {
		this.nmopKey = nmopKey;
	}

	@Column(name = "NCORR_VALID_FLAG", precision = 1, scale = 0)
	public Integer getNcorrValidFlag() {
		return this.ncorrValidFlag;
	}

	public void setNcorrValidFlag(final Integer ncorrValidFlag) {
		this.ncorrValidFlag = ncorrValidFlag;
	}

	@Column(name = "NSERVICE", nullable = false, precision = 1, scale = 0)
	public int getNservice() {
		return this.nservice;
	}

	public void setNservice(final int nservice) {
		this.nservice = nservice;
	}

	@Column(name = "NETHNIC", nullable = false, precision = 1, scale = 0)
	public int getNethnic() {
		return this.nethnic;
	}

	public void setNethnic(final int nethnic) {
		this.nethnic = nethnic;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "CSAP_CODE", length = 3)
	public String getCsapCode() {
		return this.csapCode;
	}

	public void setCsapCode(final String csapCode) {
		this.csapCode = csapCode;
	}

	@Column(name = "CCOMMENT", length = 80)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NOLD_MEAL_KEY", precision = 12, scale = 0)
	public Long getNoldMealKey() {
		return this.noldMealKey;
	}

	public void setNoldMealKey(final Long noldMealKey) {
		this.noldMealKey = noldMealKey;
	}

	@Column(name = "CPRESENTATION", length = 80)
	public String getCpresentation() {
		return this.cpresentation;
	}

	public void setCpresentation(final String cpresentation) {
		this.cpresentation = cpresentation;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMeals")
	public Set<CenMealsPackages> getCenMealsPackageses() {
		return this.cenMealsPackageses;
	}

	public void setCenMealsPackageses(final Set<CenMealsPackages> cenMealsPackageses) {
		this.cenMealsPackageses = cenMealsPackageses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMeals")
	public Set<CenMealsSpml> getCenMealsSpmls() {
		return this.cenMealsSpmls;
	}

	public void setCenMealsSpmls(Set<CenMealsSpml> cenMealsSpmls) {
		this.cenMealsSpmls = cenMealsSpmls;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMeals")
	@OrderBy("nprio ASC")
	public List<CenMealsDetail> getCenMealsDetails() {
		return this.cenMealsDetails;
	}

	public void setCenMealsDetails(final List<CenMealsDetail> cenMealsDetails) {
		this.cenMealsDetails = cenMealsDetails;
	}

}
