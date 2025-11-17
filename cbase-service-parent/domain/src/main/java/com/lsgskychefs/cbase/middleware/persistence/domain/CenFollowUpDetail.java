package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 11.04.2022 10:33:36 by Hibernate Tools 4.3.5.Final

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
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_FOLLOW_UP_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_FOLLOW_UP_DETAIL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class CenFollowUpDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nfollowUpDetailKey;
	@JsonView(View.SimpleWithReferences.class)
	private SysLogin sysLogin;
	@JsonIgnore
	private CenFollowUpMaster cenFollowUpMaster;
	@JsonView(View.Simple.class)
	private String cfollowUp;
	@JsonView(View.Simple.class)
	private Date dcreatedOn;
	@JsonView(View.Simple.class)
	private Date dupdatedOn;
	@JsonView(View.Simple.class)
	private String ccreatedBy;
	@JsonView(View.Simple.class)
	private String cupdatedBy;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_FOLLOW_UP_DETAIL")
	@SequenceGenerator(name = "SEQ_CEN_FOLLOW_UP_DETAIL", sequenceName = "SEQ_CEN_FOLLOW_UP_DETAIL", allocationSize = 1)
	@Column(name = "NFOLLOW_UP_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNfollowUpDetailKey() {
		return this.nfollowUpDetailKey;
	}

	public void setNfollowUpDetailKey(final long nfollowUpDetailKey) {
		this.nfollowUpDetailKey = nfollowUpDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(final SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY", nullable = false)
	public CenFollowUpMaster getCenFollowUpMaster() {
		return this.cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(final CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	@Column(name = "CFOLLOW_UP", length = 1024)
	public String getCfollowUp() {
		return this.cfollowUp;
	}

	public void setCfollowUp(final String cfollowUp) {
		this.cfollowUp = cfollowUp;
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

	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON", length = 7)
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

}


