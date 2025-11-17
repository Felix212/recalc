package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20.09.2018 13:47:58 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_PPS_MEAL_LAYOUT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PPS_MEAL_LAYOUT")
public class CenPpsMealLayout implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPpsMealLayoutId id;
	private CenPpsProdOrder cenPpsProdOrder;
	private CenPpsContainer cenPpsContainer;
	private long nquantity;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nprodOrderKey", column = @Column(name = "NPROD_ORDER_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ncontainerKey", column = @Column(name = "NCONTAINER_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPpsMealLayoutId getId() {
		return this.id;
	}

	public void setId(final CenPpsMealLayoutId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROD_ORDER_KEY", nullable = false, insertable = false, updatable = false)
	public CenPpsProdOrder getCenPpsProdOrder() {
		return this.cenPpsProdOrder;
	}

	public void setCenPpsProdOrder(final CenPpsProdOrder cenPpsProdOrder) {
		this.cenPpsProdOrder = cenPpsProdOrder;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCONTAINER_KEY", nullable = false, insertable = false, updatable = false)
	public CenPpsContainer getCenPpsContainer() {
		return this.cenPpsContainer;
	}

	public void setCenPpsContainer(final CenPpsContainer cenPpsContainer) {
		this.cenPpsContainer = cenPpsContainer;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 0)
	public long getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final long nquantity) {
		this.nquantity = nquantity;
	}

}
