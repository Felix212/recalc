package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 26.07.2016 14:35:54 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_OBJECT_EQUIPMENT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OBJECT_EQUIPMENT", uniqueConstraints = @UniqueConstraint(columnNames = { "CCLIENT", "CEQUIPMENT_NAME" }))
public class CenObjectEquipment implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nequipmentKey;

	private String cclient;

	private String cequipmentName;

	private long nequipmentWidth;

	private long nequipmentHeight;

	private int nequipmentResize;

	private Integer nownerId;

	@Id
	@Column(name = "NEQUIPMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNequipmentKey() {
		return this.nequipmentKey;
	}

	public void setNequipmentKey(final long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CEQUIPMENT_NAME", nullable = false, length = 40)
	public String getCequipmentName() {
		return this.cequipmentName;
	}

	public void setCequipmentName(final String cequipmentName) {
		this.cequipmentName = cequipmentName;
	}

	@Column(name = "NEQUIPMENT_WIDTH", nullable = false, precision = 10, scale = 0)
	public long getNequipmentWidth() {
		return this.nequipmentWidth;
	}

	public void setNequipmentWidth(final long nequipmentWidth) {
		this.nequipmentWidth = nequipmentWidth;
	}

	@Column(name = "NEQUIPMENT_HEIGHT", nullable = false, precision = 10, scale = 0)
	public long getNequipmentHeight() {
		return this.nequipmentHeight;
	}

	public void setNequipmentHeight(final long nequipmentHeight) {
		this.nequipmentHeight = nequipmentHeight;
	}

	@Column(name = "NEQUIPMENT_RESIZE", nullable = false, precision = 1, scale = 0)
	public int getNequipmentResize() {
		return this.nequipmentResize;
	}

	public void setNequipmentResize(final int nequipmentResize) {
		this.nequipmentResize = nequipmentResize;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

}
