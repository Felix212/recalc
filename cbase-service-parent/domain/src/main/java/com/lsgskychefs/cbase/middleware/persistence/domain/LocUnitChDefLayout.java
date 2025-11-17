package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 28, 2019 9:57:38 AM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_CH_DEF_LAYOUT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CH_DEF_LAYOUT")
public class LocUnitChDefLayout implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlayoutKey;
	@JsonIgnore
	private LocUnitChWarehouse locUnitChWarehouse;
	private Integer ncounter;
	private String cname;
	private String cdescription;
	private Long nequipmentKey;
	private Integer nrow;
	private Integer nquantity;

	@Id
	@Column(name = "NLAYOUT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlayoutKey() {
		return this.nlayoutKey;
	}

	public void setNlayoutKey(final long nlayoutKey) {
		this.nlayoutKey = nlayoutKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWAREHOUSE_KEY", nullable = false)
	public LocUnitChWarehouse getLocUnitChWarehouse() {
		return this.locUnitChWarehouse;
	}

	public void setLocUnitChWarehouse(final LocUnitChWarehouse locUnitChWarehouse) {
		this.locUnitChWarehouse = locUnitChWarehouse;
	}

	@Column(name = "NCOUNTER", precision = 5, scale = 0)
	public Integer getNcounter() {
		return this.ncounter;
	}

	public void setNcounter(final Integer ncounter) {
		this.ncounter = ncounter;
	}

	@Column(name = "CNAME", length = 20)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 50)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NEQUIPMENT_KEY", precision = 12, scale = 0)
	public Long getNequipmentKey() {
		return this.nequipmentKey;
	}

	public void setNequipmentKey(final Long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "NROW", precision = 5, scale = 0)
	public Integer getNrow() {
		return this.nrow;
	}

	public void setNrow(final Integer nrow) {
		this.nrow = nrow;
	}

	@Column(name = "NQUANTITY", precision = 5, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

}
