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
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_SPML_DETAIL_DELIVERY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SPML_DETAIL_DELIVERY")
public class CenOutSpmlDetailDelivery implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nspmlDetailDeliveryKey;
	private CenOutSpmlDelivery cenOutSpmlDelivery;
	private long npackinglistIndexKey;
	private long npackinglistDetailKey;
	private String cpackinglist;
	private String ctext;
	private String cproductionText;
	private String ccustomerPl;
	private String ccustomerText;
	private BigDecimal nquantity;
	private BigDecimal nquantityReceived;
	private String cmealControlCode;
	private int nbillingStatus;
	private long ndetailKey;
	private Long nhandlingKey;
	private Long nhandlingSpmlKey;
	private int nprio;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_SPML_DETAIL_DELIVERY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_SPML_DETAIL_DELIVERY", sequenceName = "SEQ_CEN_OUT_SPML_DETAIL_DELIVERY", allocationSize = 1)
	@Column(name = "NSPML_DETAIL_DELIVERY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNspmlDetailDeliveryKey() {
		return this.nspmlDetailDeliveryKey;
	}

	public void setNspmlDetailDeliveryKey(long nspmlDetailDeliveryKey) {
		this.nspmlDetailDeliveryKey = nspmlDetailDeliveryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSPML_DELIVERY_KEY", nullable = false)
	public CenOutSpmlDelivery getCenOutSpmlDelivery() {
		return this.cenOutSpmlDelivery;
	}

	public void setCenOutSpmlDelivery(CenOutSpmlDelivery cenOutSpmlDelivery) {
		this.cenOutSpmlDelivery = cenOutSpmlDelivery;
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

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", nullable = false, length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CPRODUCTION_TEXT", nullable = false, length = 80)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
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

	@Column(name = "NHANDLING_KEY", precision = 12, scale = 0)
	public Long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(Long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@Column(name = "NHANDLING_SPML_KEY", precision = 12, scale = 0)
	public Long getNhandlingSpmlKey() {
		return this.nhandlingSpmlKey;
	}

	public void setNhandlingSpmlKey(Long nhandlingSpmlKey) {
		this.nhandlingSpmlKey = nhandlingSpmlKey;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

}


