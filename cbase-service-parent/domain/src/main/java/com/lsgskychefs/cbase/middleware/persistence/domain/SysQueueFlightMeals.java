package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 04.02.2016 14:09:57 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table SYS_QUEUE_FLIGHT_MEALS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_FLIGHT_MEALS")
public class SysQueueFlightMeals implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysQueueFlightMealsId id;
	private SysQueueFlightCalc sysQueueFlightCalc;
	private Long nclassNumber;
	private String cclass;
	private Integer nmoduleType;
	private Long npackinglistIndexKey;
	private Integer npostingType;
	private Integer nbillingStatus;
	private Long ncalcId;
	private BigDecimal nquantity;
	private Integer nmanualInput;
	private Integer nmanualProcessing;
	private Date dtimestamp;
	private Integer nstatus;
	private Integer ncontrolling;
	private Integer ninputFromTopOff;
	private BigDecimal nquantityMis;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "njobNr", column = @Column(name = "NJOB_NR", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ndetailKey", column = @Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public SysQueueFlightMealsId getId() {
		return this.id;
	}

	public void setId(final SysQueueFlightMealsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false, insertable = false, updatable = false)
	public SysQueueFlightCalc getSysQueueFlightCalc() {
		return this.sysQueueFlightCalc;
	}

	public void setSysQueueFlightCalc(final SysQueueFlightCalc sysQueueFlightCalc) {
		this.sysQueueFlightCalc = sysQueueFlightCalc;
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

	@Column(name = "NMODULE_TYPE", precision = 2, scale = 0)
	public Integer getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(final Integer nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPOSTING_TYPE", precision = 1, scale = 0)
	public Integer getNpostingType() {
		return this.npostingType;
	}

	public void setNpostingType(final Integer npostingType) {
		this.npostingType = npostingType;
	}

	@Column(name = "NBILLING_STATUS", precision = 1, scale = 0)
	public Integer getNbillingStatus() {
		return this.nbillingStatus;
	}

	public void setNbillingStatus(final Integer nbillingStatus) {
		this.nbillingStatus = nbillingStatus;
	}

	@Column(name = "NCALC_ID", precision = 12, scale = 0)
	public Long getNcalcId() {
		return this.ncalcId;
	}

	public void setNcalcId(final Long ncalcId) {
		this.ncalcId = ncalcId;
	}

	@Column(name = "NQUANTITY", precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NMANUAL_INPUT", precision = 1, scale = 0)
	public Integer getNmanualInput() {
		return this.nmanualInput;
	}

	public void setNmanualInput(final Integer nmanualInput) {
		this.nmanualInput = nmanualInput;
	}

	@Column(name = "NMANUAL_PROCESSING", precision = 1, scale = 0)
	public Integer getNmanualProcessing() {
		return this.nmanualProcessing;
	}

	public void setNmanualProcessing(final Integer nmanualProcessing) {
		this.nmanualProcessing = nmanualProcessing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSTATUS", precision = 2, scale = 0)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "NCONTROLLING", precision = 1, scale = 0)
	public Integer getNcontrolling() {
		return this.ncontrolling;
	}

	public void setNcontrolling(final Integer ncontrolling) {
		this.ncontrolling = ncontrolling;
	}

	@Column(name = "NINPUT_FROM_TOP_OFF", precision = 1, scale = 0)
	public Integer getNinputFromTopOff() {
		return this.ninputFromTopOff;
	}

	public void setNinputFromTopOff(final Integer ninputFromTopOff) {
		this.ninputFromTopOff = ninputFromTopOff;
	}

	@Column(name = "NQUANTITY_MIS", precision = 12, scale = 3)
	public BigDecimal getNquantityMis() {
		return this.nquantityMis;
	}

	public void setNquantityMis(final BigDecimal nquantityMis) {
		this.nquantityMis = nquantityMis;
	}

}
