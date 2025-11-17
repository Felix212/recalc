package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13-Sep-2024 15:19:47 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_OUT_PPM_BOB_ITEM
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_BOB_ITEM")
public class CenOutPpmBobItem implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncopBobItemKey;
	private CenOutPpmBobDrawer cenOutPpmBobDrawer;
	private CenPackinglistIndex cenPackinglistIndex;
	private BigDecimal nquantity;
	private BigDecimal nquantityMd;
	private BigDecimal nquantityReturn;
	private BigDecimal nquantityDiff;
	private BigDecimal nquantityBroken;
	private Long nnavisionId;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_ITEM")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_ITEM", sequenceName = "SEQ_CEN_OUT_PPM_BOB_ITEM", allocationSize = 1)
	@Column(name = "NCOP_BOB_ITEM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcopBobItemKey() {
		return this.ncopBobItemKey;
	}

	public void setNcopBobItemKey(long ncopBobItemKey) {
		this.ncopBobItemKey = ncopBobItemKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NBOB_DRAWER_KEY", nullable = false)
	public CenOutPpmBobDrawer getCenOutPpmBobDrawer() {
		return this.cenOutPpmBobDrawer;
	}

	public void setCenOutPpmBobDrawer(CenOutPpmBobDrawer cenOutPpmBobDrawer) {
		this.cenOutPpmBobDrawer = cenOutPpmBobDrawer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 0)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NQUANTITY_MD", nullable = false, precision = 12, scale = 0)
	public BigDecimal getNquantityMd() {
		return this.nquantityMd;
	}

	public void setNquantityMd(BigDecimal nquantityMd) {
		this.nquantityMd = nquantityMd;
	}

	@Column(name = "NQUANTITY_RETURN", precision = 12, scale = 0)
	public BigDecimal getNquantityReturn() {
		return this.nquantityReturn;
	}

	public void setNquantityReturn(BigDecimal nquantityReturn) {
		this.nquantityReturn = nquantityReturn;
	}

	@Column(name = "NQUANTITY_DIFF", precision = 12, scale = 0)
	public BigDecimal getNquantityDiff() {
		return this.nquantityDiff;
	}

	public void setNquantityDiff(BigDecimal nquantityDiff) {
		this.nquantityDiff = nquantityDiff;
	}

	@Column(name = "NQUANTITY_BROKEN", precision = 12, scale = 0)
	public BigDecimal getNquantityBroken() {
		return nquantityBroken;
	}

	public void setNquantityBroken(BigDecimal nquantityBroken) {
		this.nquantityBroken = nquantityBroken;
	}

	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_ITEM_NNAVISION_ID")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_ITEM", sequenceName = "SEQ_CEN_OUT_PPM_BOB_ITEM_NNAVISION_ID", allocationSize = 1)
	@Column(name = "NNAVISION_ID", unique = true, precision = 12, scale = 0)
	public Long getNnavisionId() {
		return this.nnavisionId;
	}

	public void setNnavisionId(Long nnavisionId) {
		this.nnavisionId = nnavisionId;
	}
}


