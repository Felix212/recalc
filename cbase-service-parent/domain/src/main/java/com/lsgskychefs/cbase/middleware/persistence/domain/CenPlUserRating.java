package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2022 14:50:48 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
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

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PL_USER_RATING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_USER_RATING")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class CenPlUserRating implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplUserRatingKey;
	@JsonIgnore
	private CenPlRatingType cenPlRatingType;
	private Integer nrating;
	/**
	 * CLOB DB type
	 */
	private String ccomment;
	private Date dcreatedOn;
	private String ccreatedBy;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PL_USER_RATING")
	@SequenceGenerator(name = "SEQ_CEN_PL_USER_RATING", sequenceName = "SEQ_CEN_PL_USER_RATING", allocationSize = 1)
	@Column(name = "NPL_USER_RATING_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplUserRatingKey() {
		return this.nplUserRatingKey;
	}

	public void setNplUserRatingKey(final long nplUserRatingKey) {
		this.nplUserRatingKey = nplUserRatingKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_RATING_KEY", nullable = false)
	public CenPlRatingType getCenPlRatingType() {
		return this.cenPlRatingType;
	}

	public void setCenPlRatingType(final CenPlRatingType cenPlRatingType) {
		this.cenPlRatingType = cenPlRatingType;
	}

	@Column(name = "NRATING", precision = 1, scale = 0)
	public Integer getNrating() {
		return this.nrating;
	}

	public void setNrating(final Integer nrating) {
		this.nrating = nrating;
	}

	@Column(name = "CCOMMENT")
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON", length = 7)
	public Date getDcreatedOn() {
		return this.dcreatedOn;
	}

	public void setDcreatedOn(final Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	@CreatedBy
	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

}


