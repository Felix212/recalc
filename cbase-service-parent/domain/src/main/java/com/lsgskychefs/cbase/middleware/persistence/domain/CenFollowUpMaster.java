/*
 * CenFollowUpMaster
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 11.04.2022 10:33:36 by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
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

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections4.comparators.NullComparator;
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
 * Entity(DomainObject) for table CEN_FOLLOW_UP_MASTER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_FOLLOW_UP_MASTER")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class CenFollowUpMaster implements DomainObject, java.io.Serializable {

	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nfollowUpMasterKey;
	@JsonView(View.Simple.class)
	private Date dcreatedOn;
	@JsonView(View.Simple.class)
	private Date dupdatedOn;
	@JsonView(View.Simple.class)
	private String ccreatedBy;
	@JsonView(View.Simple.class)
	private String cupdatedBy;
	@JsonIgnore
	private Set<CenProject> cenProjects = new HashSet<>(0);
	@JsonIgnore
	private Set<CenCostProject> cenCostProjects = new HashSet<>(0);
	@JsonIgnore
	private Set<CenPlCostProject> cenPlCostProjects = new HashSet<>(0);
	@JsonIgnore
	private Set<CenPackinglistProject> cenPackinglistProjects = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private List<CenFollowUpDetail> cenFollowUpDetails = new ArrayList<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_FOLLOW_UP_MASTER")
	@SequenceGenerator(name = "SEQ_CEN_FOLLOW_UP_MASTER", sequenceName = "SEQ_CEN_FOLLOW_UP_MASTER", allocationSize = 1)
	@Column(name = "NFOLLOW_UP_MASTER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNfollowUpMasterKey() {
		return this.nfollowUpMasterKey;
	}

	public void setNfollowUpMasterKey(final long nfollowUpMasterKey) {
		this.nfollowUpMasterKey = nfollowUpMasterKey;
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

	@OneToMany(fetch=FetchType.LAZY, mappedBy="cenFollowUpMaster")
	public Set<CenCostProject> getCenCostProjects() {
		return this.cenCostProjects;
	}

	public void setCenCostProjects(Set<CenCostProject> cenCostProjects) {
		this.cenCostProjects = cenCostProjects;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenFollowUpMaster")
	public Set<CenProject> getCenProjects() {
		return this.cenProjects;
	}

	public void setCenProjects(final Set<CenProject> cenProjects) {
		this.cenProjects = cenProjects;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenFollowUpMaster")
	public Set<CenPackinglistProject> getCenPackinglistProjects() {
		return this.cenPackinglistProjects;
	}

	public void setCenPackinglistProjects(final Set<CenPackinglistProject> cenPackinglistProjects) {
		this.cenPackinglistProjects = cenPackinglistProjects;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenFollowUpMaster")
	public List<CenFollowUpDetail> getCenFollowUpDetails() {
		final Comparator<CenFollowUpDetail> comparator =
				new BeanComparator(CenFollowUpDetail_.dcreatedOn.getName(), new NullComparator<>(false));
		Collections.sort(this.cenFollowUpDetails, Collections.reverseOrder(comparator));
		return this.cenFollowUpDetails;
	}

	public void setCenFollowUpDetails(final List<CenFollowUpDetail> cenFollowUpDetails) {
		this.cenFollowUpDetails = cenFollowUpDetails;
	}

	@OneToMany(fetch=FetchType.LAZY, mappedBy="cenFollowUpMaster")
	public Set<CenPlCostProject> getCenPlCostProjects() {
		return this.cenPlCostProjects;
	}

	public void setCenPlCostProjects(Set<CenPlCostProject> cenPlCostProjects) {
		this.cenPlCostProjects = cenPlCostProjects;
	}
}


