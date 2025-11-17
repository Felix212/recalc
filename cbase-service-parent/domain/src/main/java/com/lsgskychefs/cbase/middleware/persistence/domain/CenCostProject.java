package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.07.2023 10:16:43 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
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

/**
 * Entity(DomainObject) for table CEN_COST_PROJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_COST_PROJECT")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "costProject.fetchpackinglists", attributeNodes = {
				@NamedAttributeNode(value = "sysCostProjectStatus"),
				@NamedAttributeNode(value = "cenPlCostProjects", subgraph = "costProject.packinglists")
		}, subgraphs = {
				@NamedSubgraph(name = "costProject.packinglists", attributeNodes = {
						@NamedAttributeNode(value = "cenPackinglists", subgraph = "costProject.packinglist.details")
				}),
				@NamedSubgraph(name = "costProject.packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistIf")
				})
		})
})
public class CenCostProject implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncostProjectKey;
	private CenAirlines cenAirlines;
	private CenFollowUpMaster cenFollowUpMaster;
	private SysCostProjectStatus sysCostProjectStatus;
	private String cname;
	private String cdescription;
	private Date ddueDate;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;
	private String ccomment;
	private Set<CenPlCostProject> cenPlCostProjects = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_COST_PROJECT")
	@SequenceGenerator(name = "SEQ_CEN_COST_PROJECT", sequenceName = "SEQ_CEN_COST_PROJECT", allocationSize = 1)
	@Column(name = "NCOST_PROJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcostProjectKey() {
		return this.ncostProjectKey;
	}

	public void setNcostProjectKey(long ncostProjectKey) {
		this.ncostProjectKey = ncostProjectKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY")
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return this.cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCOST_PROJECT_STATUS_KEY", nullable = false)
	public SysCostProjectStatus getSysCostProjectStatus() {
		return this.sysCostProjectStatus;
	}

	public void setSysCostProjectStatus(SysCostProjectStatus sysCostProjectStatus) {
		this.sysCostProjectStatus = sysCostProjectStatus;
	}

	@Column(name = "CNAME", length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDUE_DATE", length = 7)
	public Date getDdueDate() {
		return this.ddueDate;
	}

	public void setDdueDate(Date ddueDate) {
		this.ddueDate = ddueDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON", length = 7)
	public Date getDcreatedOn() {
		return this.dcreatedOn;
	}

	public void setDcreatedOn(Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON", length = 7)
	public Date getDupdatedOn() {
		return this.dupdatedOn;
	}

	public void setDupdatedOn(Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Column(name = "CCOMMENT", length = 1024)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenCostProject")
	public Set<CenPlCostProject> getCenPlCostProjects() {
		return this.cenPlCostProjects;
	}

	public void setCenPlCostProjects(Set<CenPlCostProject> cenPlCostProjects) {
		this.cenPlCostProjects = cenPlCostProjects;
	}

}


