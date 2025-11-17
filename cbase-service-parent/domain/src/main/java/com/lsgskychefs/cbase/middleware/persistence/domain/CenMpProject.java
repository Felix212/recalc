package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 20, 2024 2:58:31 PM by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_MP_PROJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_PROJECT")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "mpProject.fetchpackinglists", attributeNodes = {
				@NamedAttributeNode(value = "sysMpStatus"),
				@NamedAttributeNode(value = "cenPlMpProjects", subgraph = "mpProject.packinglists")
		}, subgraphs = {
				@NamedSubgraph(name = "mpProject.packinglists", attributeNodes = {
						@NamedAttributeNode(value = "cenPackinglists", subgraph = "mpProject.packinglist.details"),
						@NamedAttributeNode(value = "cenPackinglistDetail")
				}),
				@NamedSubgraph(name = "mpProject.packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIf"),
						@NamedAttributeNode(value = "cenPackinglistMaterial"),
						@NamedAttributeNode(value = "cenMpDesignItemlist")
				})
		})
})
public class CenMpProject extends AuditableDomainObject {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmpProjectKey;
	private SysMpStatus sysMpStatus;
	private CenMpTeams cenMpTeams;
	private CenAirlines cenAirlines;
	private CenFollowUpMaster cenFollowUpMaster;
	private SysMpProjectType sysMpProjectType;
	private String cname;
	private Date dpresentationDate;
	private Date dbomReferenceDate;
	private String cdescription;
	private Date dproductionrangeDatefrom;
	private Date dproductionrangeDateto;
	private boolean nisExploded;

	@JsonIgnore
	private List<CenPlMpProject> cenPlMpProjects = new ArrayList<>(0);

	private List<CenMpMenugrid> cenMpMenuGrid = new ArrayList<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_PROJECT")
	@SequenceGenerator(name = "SEQ_CEN_MP_PROJECT", sequenceName = "SEQ_CEN_MP_PROJECT", allocationSize = 1)
	@Column(name = "NMP_PROJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpProjectKey() {
		return this.nmpProjectKey;
	}

	public void setNmpProjectKey(long nmpProjectKey) {
		this.nmpProjectKey = nmpProjectKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_STATUS_KEY", nullable = false)
	public SysMpStatus getSysMpStatus() {
		return this.sysMpStatus;
	}

	public void setSysMpStatus(SysMpStatus sysMpStatus) {
		this.sysMpStatus = sysMpStatus;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_TEAM_KEY", nullable = false)
	public CenMpTeams getCenMpTeams() {
		return this.cenMpTeams;
	}

	public void setCenMpTeams(CenMpTeams cenMpTeams) {
		this.cenMpTeams = cenMpTeams;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
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
	@JoinColumn(name = "NMP_PROJECT_TYPE_KEY")
	public SysMpProjectType getSysMpProjectType() {
		return this.sysMpProjectType;
	}

	public void setSysMpProjectType(SysMpProjectType sysMpProjectType) {
		this.sysMpProjectType = sysMpProjectType;
	}

	@Column(name = "CNAME", nullable = false, length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPRESENTATION_DATE", nullable = false, length = 7)
	public Date getDpresentationDate() {
		return this.dpresentationDate;
	}

	public void setDpresentationDate(Date dpresentationDate) {
		this.dpresentationDate = dpresentationDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DBOM_REFERENCE_DATE", nullable = false, length = 7)
	public Date getDbomReferenceDate() {
		return this.dbomReferenceDate;
	}

	public void setDbomReferenceDate(Date dbomReferenceDate) {
		this.dbomReferenceDate = dbomReferenceDate;
	}

	@Column(name = "CDESCRIPTION", length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPRODUCTIONRANGE_DATEFROM", nullable = false, length = 7)
	public Date getDproductionrangeDatefrom() {
		return this.dproductionrangeDatefrom;
	}

	public void setDproductionrangeDatefrom(Date dproductionrangeDatefrom) {
		this.dproductionrangeDatefrom = dproductionrangeDatefrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPRODUCTIONRANGE_DATETO", nullable = false, length = 7)
	public Date getDproductionrangeDateto() {
		return this.dproductionrangeDateto;
	}

	public void setDproductionrangeDateto(Date dproductionrangeDateto) {
		this.dproductionrangeDateto = dproductionrangeDateto;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMpProject")
	public List<CenPlMpProject> getCenPlMpProjects() {
		return this.cenPlMpProjects;
	}

	public void setCenPlMpProjects(List<CenPlMpProject> cenPlMpProjects) {
		this.cenPlMpProjects = cenPlMpProjects;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMpProject")
	public List<CenMpMenugrid> getCenMpMenuGrid() {
		return cenMpMenuGrid;
	}

	public void setCenMpMenuGrid(List<CenMpMenugrid> cenMpMenuGrid) {
		this.cenMpMenuGrid = cenMpMenuGrid;
	}

	public boolean isNisExploded() {
		return nisExploded;
	}

	public void setNisExploded(boolean nisExploded) {
		this.nisExploded = nisExploded;
	}

}


