package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 30.11.2021 12:18:42 by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
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

/**
 * Entity(DomainObject) for table CEN_PROJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PROJECT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
@NamedEntityGraphs({
		@NamedEntityGraph(name = "project.fetchsimple", attributeNodes = {
				@NamedAttributeNode(value = "sysProjectStatus")
		}),
		@NamedEntityGraph(name = "project.fetchpackinglists", attributeNodes = {
				@NamedAttributeNode(value = "sysProjectStatus"),
				@NamedAttributeNode(value = "cenPackinglistProjects", subgraph = "project.packinglists")
		}, subgraphs = {
				@NamedSubgraph(name = "project.packinglists", attributeNodes = {
						@NamedAttributeNode(value = "cenPackinglists", subgraph = "packinglist.details")
				}),
				@NamedSubgraph(name = "packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPackinglistInstructions"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistIf")
				})
		}),
		@NamedEntityGraph(name = "project.fetchstructures", attributeNodes = {
				@NamedAttributeNode(value = "sysProjectStatus"),
				@NamedAttributeNode(value = "cenProjectStructures")
		})
})
public class CenProject implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nprojectKey;
	private SysProjectStatus sysProjectStatus;
	private CenFollowUpMaster cenFollowUpMaster;
	private CenGuestAccessToken cenGuestAccessToken;
	private String cname;
	private String cdescription;
	private String ccomment;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;
	private Date deffectiveDate;
	@JsonIgnore
	private List<CenProjectStructure> cenProjectStructures = new ArrayList<>(0);
	@JsonIgnore
	private List<CenPackinglistProject> cenPackinglistProjects = new ArrayList<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PROJECT")
	@SequenceGenerator(name = "SEQ_CEN_PROJECT", sequenceName = "SEQ_CEN_PROJECT", allocationSize = 1)
	@Column(name = "NPROJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojectKey() {
		return this.nprojectKey;
	}

	public void setNprojectKey(final long nprojectKey) {
		this.nprojectKey = nprojectKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_STATUS_KEY", nullable = false)
	public SysProjectStatus getSysProjectStatus() {
		return this.sysProjectStatus;
	}

	public void setSysProjectStatus(final SysProjectStatus sysProjectStatus) {
		this.sysProjectStatus = sysProjectStatus;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return this.cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(final CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGUEST_ACCESS_TOKEN_KEY")
	public CenGuestAccessToken getCenGuestAccessToken() {
		return this.cenGuestAccessToken;
	}

	public void setCenGuestAccessToken(final CenGuestAccessToken cenGuestAccessToken) {
		this.cenGuestAccessToken = cenGuestAccessToken;
	}

	@Column(name = "CNAME", length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CCOMMENT", length = 1024)
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

	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON", length = 7)
	public Date getDupdatedOn() {
		return this.dupdatedOn;
	}

	public void setDupdatedOn(final Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	@LastModifiedBy
	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenProject")
	public List<CenProjectStructure> getCenProjectStructures() {
		return this.cenProjectStructures;
	}

	public void setCenProjectStructures(final List<CenProjectStructure> cenProjectStructures) {
		this.cenProjectStructures = cenProjectStructures;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenProject")
	public List<CenPackinglistProject> getCenPackinglistProjects() {
		return this.cenPackinglistProjects;
	}

	public void setCenPackinglistProjects(final List<CenPackinglistProject> cenPackinglistProjects) {
		this.cenPackinglistProjects = cenPackinglistProjects;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DEFFECTIVE_DATE", length = 7)
	public Date getDeffectiveDate() {
		return deffectiveDate;
	}

	public void setDeffectiveDate(final Date deffectiveDate) {
		this.deffectiveDate = deffectiveDate;
	}
}
