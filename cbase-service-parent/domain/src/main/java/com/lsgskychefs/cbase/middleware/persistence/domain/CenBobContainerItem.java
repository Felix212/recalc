package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14-Aug-2024 13:31:12 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_BOB_CONTAINER_ITEM
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_BOB_CONTAINER_ITEM")
public class CenBobContainerItem implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbobContainerItemKey;
	private CenBobContainer cenBobContainer;
	private CenPackinglistIndex cenPackinglistIndex;
	private BigDecimal nquantity;
	private String ccreatedBy;
	private Date dcreatedDate;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_BOB_CONTAINER_ITEM")
	@SequenceGenerator(name = "SEQ_CEN_BOB_CONTAINER_ITEM", sequenceName = "SEQ_CEN_BOB_CONTAINER_ITEM", allocationSize = 1)
	@Column(name = "NBOB_CONTAINER_ITEM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbobContainerItemKey() {
		return this.nbobContainerItemKey;
	}

	public void setNbobContainerItemKey(long nbobContainerItemKey) {
		this.nbobContainerItemKey = nbobContainerItemKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NBOB_CONTAINER_KEY", nullable = false)
	public CenBobContainer getCenBobContainer() {
		return this.cenBobContainer;
	}

	public void setCenBobContainer(CenBobContainer cenBobContainer) {
		this.cenBobContainer = cenBobContainer;
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

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

}


