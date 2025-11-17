package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 9, 2019 4:58:58 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CH_MOVEMENT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CH_MOVEMENT")
public class CenOutPpmChMovement implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmChMovementKey;
	private long nstorageBinKey;
	private String cstowage;
	private long npackinglistIndexKey;
	private String cpackinglist;
	private String cunit;
	private long nwarehouseKey;
	private String cwarehouse;
	private BigDecimal nquantity;
	private Date dtimestamp;
	private long nstockMovementTypeKey;
	private String cmovementType;
	private Long nppmProdLabelKey;
	private Long nresultKey;
	private String ctext;
	private Long ntldNumber;
	private String ccharge;
	private String cmatnr;
	private String creason;
	private String caction;
	private Long nppmTrolleyKey;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CH_MOVEMENT")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CH_MOVEMENT", sequenceName = "SEQ_CEN_OUT_PPM_CH_MOVEMENT", allocationSize = 1)
	@Column(name = "NPPM_CH_MOVEMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmChMovementKey() {
		return this.nppmChMovementKey;
	}

	public void setNppmChMovementKey(final long nppmChMovementKey) {
		this.nppmChMovementKey = nppmChMovementKey;
	}

	@Column(name = "NSTORAGE_BIN_KEY", nullable = false, precision = 12, scale = 0)
	public long getNstorageBinKey() {
		return this.nstorageBinKey;
	}

	public void setNstorageBinKey(final long nstorageBinKey) {
		this.nstorageBinKey = nstorageBinKey;
	}

	@Column(name = "CSTOWAGE", nullable = false, length = 40)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NWAREHOUSE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNwarehouseKey() {
		return this.nwarehouseKey;
	}

	public void setNwarehouseKey(final long nwarehouseKey) {
		this.nwarehouseKey = nwarehouseKey;
	}

	@Column(name = "CWAREHOUSE", nullable = false, length = 50)
	public String getCwarehouse() {
		return this.cwarehouse;
	}

	public void setCwarehouse(final String cwarehouse) {
		this.cwarehouse = cwarehouse;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSTOCK_MOVEMENT_TYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNstockMovementTypeKey() {
		return this.nstockMovementTypeKey;
	}

	public void setNstockMovementTypeKey(final long nstockMovementTypeKey) {
		this.nstockMovementTypeKey = nstockMovementTypeKey;
	}

	@Column(name = "CMOVEMENT_TYPE", nullable = false, length = 40)
	public String getCmovementType() {
		return this.cmovementType;
	}

	public void setCmovementType(final String cmovementType) {
		this.cmovementType = cmovementType;
	}

	@Column(name = "NPPM_PROD_LABEL_KEY", precision = 12, scale = 0)
	public Long getNppmProdLabelKey() {
		return this.nppmProdLabelKey;
	}

	public void setNppmProdLabelKey(final Long nppmProdLabelKey) {
		this.nppmProdLabelKey = nppmProdLabelKey;
	}

	@Column(name = "NRESULT_KEY", precision = 12, scale = 0)
	public Long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final Long nresultKey) {
		this.nresultKey = nresultKey;
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

	@Column(name = "CREASON", length = 20)
	public String getCreason() {
		return this.creason;
	}

	public void setCreason(final String creason) {
		this.creason = creason;
	}

	@Column(name = "CACTION", length = 20)
	public String getCaction() {
		return this.caction;
	}

	public void setCaction(final String caction) {
		this.caction = caction;
	}

	@Column(name = "NPPM_TROLLEY_KEY", precision = 12, scale = 0)
	public Long getNppmTrolleyKey() {
		return this.nppmTrolleyKey;
	}

	public void setNppmTrolleyKey(final Long nppmTrolleyKey) {
		this.nppmTrolleyKey = nppmTrolleyKey;
	}

}
