package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 9, 2019 4:58:58 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_CH_STOCK
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_CH_STOCK")
public class CenOutChStock implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nchStockKey;
	@JsonIgnore
	private SysUnits sysUnits;
	@JsonIgnore
	private CenPackinglistIndex cenPackinglistIndex;
	@JsonIgnore
	private LocUnitChWarehouse locUnitChWarehouse;
	@JsonIgnore
	private LocUnitChStorageBin locUnitChStorageBin;
	private String cpackinglist;
	@JsonIgnore
	private BigDecimal nquantity;
	private Long nppmProdLabelKey;
	private String clotNumber;
	private Date dbestBefore;
	private String ctext;
	private Long nstorageBinKey;
	private Long npackinglistIndexKey;
	private String cstowage;
	private BigDecimal stockQuantity;
	private Long ntldNumber;
	private String ccharge;
	private String cmatnr;
	private Long nwarehouseKey;
	private Long nppmTrolleyKey;
	@JsonIgnore
	private Set<CenOutChStockOnHold> cenOutChStockOnHolds = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_CH_STOCK")
	@SequenceGenerator(name = "SEQ_CEN_OUT_CH_STOCK", sequenceName = "SEQ_CEN_OUT_CH_STOCK", allocationSize = 1)
	@Column(name = "NCH_STOCK_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNchStockKey() {
		return this.nchStockKey;
	}

	public void setNchStockKey(final long nchStockKey) {
		this.nchStockKey = nchStockKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(final CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWAREHOUSE_KEY", nullable = false)
	public LocUnitChWarehouse getLocUnitChWarehouse() {
		return this.locUnitChWarehouse;
	}

	public void setLocUnitChWarehouse(final LocUnitChWarehouse locUnitChWarehouse) {
		this.locUnitChWarehouse = locUnitChWarehouse;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTORAGE_BIN_KEY", nullable = false)
	public LocUnitChStorageBin getLocUnitChStorageBin() {
		return this.locUnitChStorageBin;
	}

	public void setLocUnitChStorageBin(final LocUnitChStorageBin locUnitChStorageBin) {
		this.locUnitChStorageBin = locUnitChStorageBin;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NPPM_PROD_LABEL_KEY", precision = 12, scale = 0)
	public Long getNppmProdLabelKey() {
		return this.nppmProdLabelKey;
	}

	public void setNppmProdLabelKey(final Long nppmProdLabelKey) {
		this.nppmProdLabelKey = nppmProdLabelKey;
	}

	@Column(name = "CLOT_NUMBER", length = 40)
	public String getClotNumber() {
		return this.clotNumber;
	}

	public void setClotNumber(final String clotNumber) {
		this.clotNumber = clotNumber;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DBEST_BEFORE", length = 7)
	public Date getDbestBefore() {
		return this.dbestBefore;
	}

	public void setDbestBefore(final Date dbestBefore) {
		this.dbestBefore = dbestBefore;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NTLD_NUMBER", precision = 12, scale = 0)
	public Long getNtldNumber() {
		return this.ntldNumber;
	}

	public void setNtldNumber(final Long ntldNumber) {
		this.ntldNumber = ntldNumber;
	}

	@Column(name = "CCHARGE", length = 10)
	public String getCcharge() {
		return this.ccharge;
	}

	public void setCcharge(final String ccharge) {
		this.ccharge = ccharge;
	}

	@Column(name = "CMATNR", length = 18)
	public String getCmatnr() {
		return this.cmatnr;
	}

	public void setCmatnr(final String cmatnr) {
		this.cmatnr = cmatnr;
	}

	@Column(name = "NPPM_TROLLEY_KEY", precision = 12, scale = 0)
	public Long getNppmTrolleyKey() {
		return this.nppmTrolleyKey;
	}

	public void setNppmTrolleyKey(final Long nppmTrolleyKey) {
		this.nppmTrolleyKey = nppmTrolleyKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutChStock")
	public Set<CenOutChStockOnHold> getCenOutChStockOnHolds() {
		return this.cenOutChStockOnHolds;
	}

	public void setCenOutChStockOnHolds(final Set<CenOutChStockOnHold> cenOutChStockOnHolds) {
		this.cenOutChStockOnHolds = cenOutChStockOnHolds;
	}

	@Transient
	public Long getNstorageBinKey() {
		if (locUnitChStorageBin != null) {
			nstorageBinKey = locUnitChStorageBin.getNstorageBinKey();
		}
		return nstorageBinKey;
	}

	@Transient
	public Long getNpackinglistIndexKey() {
		if (cenPackinglistIndex != null) {
			npackinglistIndexKey = cenPackinglistIndex.getNpackinglistIndexKey();
		}
		return npackinglistIndexKey;
	}

	@Transient
	public String getCstowage() {
		if (locUnitChStorageBin != null) {
			cstowage = locUnitChStorageBin.getCstowage();
		}
		return cstowage;
	}

	@Transient
	public BigDecimal getStockQuantity() {
		if (!cenOutChStockOnHolds.isEmpty()) {
			final Long quantityToReduce = cenOutChStockOnHolds
					.stream()
					.filter(c -> c.getCenOutChStock().getNchStockKey() == (this.nchStockKey))
					.mapToLong(c -> c.getNquantityOnHold().longValue()).sum();
			stockQuantity = nquantity.subtract(BigDecimal.valueOf(quantityToReduce));
		} else {
			stockQuantity = nquantity;
		}
		return stockQuantity;
	}

	@Transient
	public Long getStockQuantityOnHold() {
		if (!cenOutChStockOnHolds.isEmpty()) {
			return cenOutChStockOnHolds
					.stream()
					.filter(c -> c.getCenOutChStock().getNchStockKey() == (this.nchStockKey))
					.mapToLong(c -> c.getNquantityOnHold().longValue()).sum();
		}
		return null;
	}

	@Transient
	public Long getNwarehouseKey() {
		if (locUnitChWarehouse != null) {
			nwarehouseKey = locUnitChWarehouse.getNwarehouseKey();
		}
		return nwarehouseKey;
	}

}
