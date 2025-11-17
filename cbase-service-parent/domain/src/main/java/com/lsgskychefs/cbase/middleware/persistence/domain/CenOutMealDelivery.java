package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 15.10.2024 19:04:31 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_MEAL_DELIVERY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MEAL_DELIVERY")
public class CenOutMealDelivery implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmealDeliveryKey;
	private CenOutDeliveryNote cenOutDeliveryNote;
	private long npackinglistIndexKey;
	private long npackinglistDetailKey;
	private String cclass;
	private String cpackinglist;
	private String ctext;
	private String cproductionText;
	private String ccustomerPl;
	private String ccustomerText;
	private String cremark;
	private BigDecimal nquantity;
	private BigDecimal nquantityReceived;
	private String cmealControlCode;
	private long ncalcId;
	private int nbillingStatus;
	private long ndetailKey;
	private int nmoduleType;
	private Long nhandlingKey;
	private Long nhandlingDetailKey;
	private String chandlingText;
	private int ncoverPrio;
	private int nprio;
	private long nclassNumber;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_MEAL_DELIVERY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_MEAL_DELIVERY", sequenceName = "SEQ_CEN_OUT_MEAL_DELIVERY", allocationSize = 1)
	@Column(name = "NMEAL_DELIVERY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmealDeliveryKey() {
		return this.nmealDeliveryKey;
	}

	public void setNmealDeliveryKey(long nmealDeliveryKey) {
		this.nmealDeliveryKey = nmealDeliveryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false),
			@JoinColumn(name = "NNUMBER", referencedColumnName = "NNUMBER", nullable = false) })
	public CenOutDeliveryNote getCenOutDeliveryNote() {
		return this.cenOutDeliveryNote;
	}

	public void setCenOutDeliveryNote(CenOutDeliveryNote cenOutDeliveryNote) {
		this.cenOutDeliveryNote = cenOutDeliveryNote;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 84)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@Column(name = "CPRODUCTION_TEXT", nullable = false, length = 84)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
	}

	@Column(name = "CREMARK", nullable = false, length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NQUANTITY_RECEIVED", precision = 12, scale = 3)
	public BigDecimal getNquantityReceived() {
		return this.nquantityReceived;
	}

	public void setNquantityReceived(BigDecimal nquantityReceived) {
		this.nquantityReceived = nquantityReceived;
	}

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NCALC_ID", nullable = false, precision = 12, scale = 0)
	public long getNcalcId() {
		return this.ncalcId;
	}

	public void setNcalcId(long ncalcId) {
		this.ncalcId = ncalcId;
	}

	@Column(name = "NBILLING_STATUS", nullable = false, precision = 1, scale = 0)
	public int getNbillingStatus() {
		return this.nbillingStatus;
	}

	public void setNbillingStatus(int nbillingStatus) {
		this.nbillingStatus = nbillingStatus;
	}

	@Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@Column(name = "NMODULE_TYPE", nullable = false, precision = 2, scale = 0)
	public int getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(int nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NHANDLING_KEY", precision = 12, scale = 0)
	public Long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(Long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@Column(name = "NHANDLING_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNhandlingDetailKey() {
		return this.nhandlingDetailKey;
	}

	public void setNhandlingDetailKey(Long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	@Column(name = "CHANDLING_TEXT", nullable = false, length = 30)
	public String getChandlingText() {
		return this.chandlingText;
	}

	public void setChandlingText(final String chandlingText) {
		this.chandlingText = chandlingText;
	}

	@Column(name = "NCOVER_PRIO", nullable = false, precision = 6, scale = 0)
	public int getNcoverPrio() {
		return this.ncoverPrio;
	}

	public void setNcoverPrio(final int ncoverPrio) {
		this.ncoverPrio = ncoverPrio;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

}


