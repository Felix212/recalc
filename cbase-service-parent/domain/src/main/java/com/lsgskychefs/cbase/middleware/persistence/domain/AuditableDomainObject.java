package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

/**
 * Creation/Update timestamp & user with Hibernate
 *
 * @author Alex Schaab - U524036
 */
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class AuditableDomainObject implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Date createdOn;

	private String createdBy;

	private Date updatedOn;

	private String updatedBy;

	/**
	 * Get createdOn
	 *
	 * @return the createdOn
	 */
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON")
	public Date getCreatedOn() {
		return createdOn;
	}

	/**
	 * set createdOn
	 *
	 * @param createdOn the createdOn to set
	 */
	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	/**
	 * Get createdBy
	 *
	 * @return the createdBy
	 */
	@CreatedBy
	@Column(name = "CCREATED_BY")
	public String getCreatedBy() {
		return createdBy;
	}

	/**
	 * set createdBy
	 *
	 * @param createdBy the createdBy to set
	 */
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	/**
	 * Get updatedOn
	 *
	 * @return the updatedOn
	 */
	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON")
	public Date getUpdatedOn() {
		return updatedOn;
	}

	/**
	 * set updatedOn
	 *
	 * @param updatedOn the updatedOn to set
	 */
	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	/**
	 * Get updatedBy
	 *
	 * @return the updatedBy
	 */
	@LastModifiedBy
	@Column(name = "CUPDATED_BY")
	public String getUpdatedBy() {
		return updatedBy;
	}

	/**
	 * set updatedBy
	 *
	 * @param updatedBy the updatedBy to set
	 */
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

}
