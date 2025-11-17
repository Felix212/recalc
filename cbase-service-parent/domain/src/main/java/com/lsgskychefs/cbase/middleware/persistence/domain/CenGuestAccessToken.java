package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 19, 2023 5:17:38 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_GUEST_ACCESS_TOKEN
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_GUEST_ACCESS_TOKEN")
@EntityListeners(AuditingEntityListener.class)
public class CenGuestAccessToken implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nguestAccessTokenKey;
	private String ctoken;
	private Date dvalidFrom;
	private Date dvalidTo;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;
	private String cdescription;
	@JsonIgnore
	private Set<CenProject> cenProjects = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_GUEST_ACCESS_TOKEN")
	@SequenceGenerator(name = "SEQ_CEN_GUEST_ACCESS_TOKEN", sequenceName = "SEQ_CEN_GUEST_ACCESS_TOKEN", allocationSize = 1)
	@Column(name = "NGUEST_ACCESS_TOKEN_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNguestAccessTokenKey() {
		return this.nguestAccessTokenKey;
	}

	public void setNguestAccessTokenKey(long nguestAccessTokenKey) {
		this.nguestAccessTokenKey = nguestAccessTokenKey;
	}

	@Column(name = "CTOKEN", nullable = false, length = 256)
	public String getCtoken() {
		return this.ctoken;
	}

	public void setCtoken(String ctoken) {
		this.ctoken = ctoken;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@CreatedDate
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON")
	public Date getDcreatedOn() {
		return this.dcreatedOn;
	}

	public void setDcreatedOn(final Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	@LastModifiedDate
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON")
	public Date getDupdatedOn() {
		return this.dupdatedOn;
	}

	public void setDupdatedOn(final Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	@CreatedBy
	@Column(name = "CCREATED_BY", length = 256)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@LastModifiedBy
	@Column(name = "CUPDATED_BY", length = 256)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	public String getCdescription() {
		return cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenGuestAccessToken")
	public Set<CenProject> getCenProjects() {
		return this.cenProjects;
	}

	public void setCenProjects(Set<CenProject> cenProjects) {
		this.cenProjects = cenProjects;
	}

}


