package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table ROB_EVENT_PRODUCT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_EVENT_PRODUCT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobEventProduct implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private RobEventProductId id;

	private RobProduct robProduct;

	private RobEvent robEvent;

	private int nsort;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "neventKey", column = @Column(name = "NEVENT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nproductKey", column = @Column(name = "NPRODUCT_KEY", nullable = false, precision = 12, scale = 0)) })
	public RobEventProductId getId() {
		return this.id;
	}

	public void setId(final RobEventProductId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRODUCT_KEY", nullable = false, insertable = false, updatable = false)
	public RobProduct getRobProduct() {
		return this.robProduct;
	}

	public void setRobProduct(final RobProduct robProduct) {
		this.robProduct = robProduct;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEVENT_KEY", nullable = false, insertable = false, updatable = false)
	public RobEvent getRobEvent() {
		return this.robEvent;
	}

	public void setRobEvent(final RobEvent robEvent) {
		this.robEvent = robEvent;
	}

	@Column(name = "NSORT", nullable = false, precision = 2, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

}
