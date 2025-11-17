package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 9, 2019 4:58:58 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_STOCK_MOVEMENT_TYPE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_STOCK_MOVEMENT_TYPE")
public class SysStockMovementType implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nstockMovementTypeKey;
	private String cmovementType;
	private String cdescription;

	@Id
	@Column(name = "NSTOCK_MOVEMENT_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
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

	@Column(name = "CDESCRIPTION", length = 80)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

}
