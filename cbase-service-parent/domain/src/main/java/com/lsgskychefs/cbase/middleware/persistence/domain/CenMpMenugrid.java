package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Sep 11, 2024 4:18:20 PM by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_MP_MENUGRID
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_MENUGRID")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@NamedEntityGraphs({
		@NamedEntityGraph(name = "menugrid.fetchpackinglists", attributeNodes = {
				@NamedAttributeNode(value = "cenMpProject"),
				@NamedAttributeNode(value = "cenFollowUpMaster"),
				@NamedAttributeNode(value = "sysMpMgStatus"),
				@NamedAttributeNode(value = "cenMpMenugridCycles", subgraph = "menugrid.categories")
		}, subgraphs = {
				@NamedSubgraph(name = "menugrid.categories", attributeNodes = {
						@NamedAttributeNode(value = "cenMpMenugridCategories", subgraph = "category.mppackinglist"),
				}),
				@NamedSubgraph(name = "category.mppackinglist", attributeNodes = {
						@NamedAttributeNode(value = "cenPlMpProject", subgraph = "mppackinglist.packinglist")

				}),
				@NamedSubgraph(name = "mppackinglist.packinglist", attributeNodes = {
						@NamedAttributeNode(value = "cenPackinglists", subgraph = "packinglist.details")

				}),
				@NamedSubgraph(name = "packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPackinglistInstructions"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistIf")
				})
		}),
		@NamedEntityGraph(name = "menugrid.fetchproject", attributeNodes = {
				@NamedAttributeNode(value = "cenMpProject"),
				@NamedAttributeNode(value = "cenFollowUpMaster"),
				@NamedAttributeNode(value = "sysMpMgStatus")
		})
})
public class CenMpMenugrid extends AuditableDomainObject {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmpMenugridKey;
	@JsonIgnore
	private CenMpProject cenMpProject;
	@JsonIgnore
	private CenAirlines cenAirlines;
	private CenFollowUpMaster cenFollowUpMaster;
	private String cname;
	private String cclass;
	private Integer ncycleno;
	private String cdescription;

	private Set<CenMpMenugridCycle> cenMpMenugridCycles = new HashSet<>(0);

	private SysMpMgStatus sysMpMgStatus;

	private CenMpService cenMpService;

	private Integer nserviceNumber;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_MENUGRID")
	@SequenceGenerator(name = "SEQ_CEN_MP_MENUGRID", sequenceName = "SEQ_CEN_MP_MENUGRID", allocationSize = 1)
	@Column(name = "NMP_MENUGRID_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpMenugridKey() {
		return nmpMenugridKey;
	}

	public void setNmpMenugridKey(long nmpMenugridKey) {
		this.nmpMenugridKey = nmpMenugridKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_PROJECT_KEY", nullable = false)
	public CenMpProject getCenMpProject() {
		return cenMpProject;
	}

	public void setCenMpProject(CenMpProject cenMpProject) {
		this.cenMpProject = cenMpProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCclass() {
		return cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	public Integer getNcycleno() {
		return ncycleno;
	}

	public void setNcycleno(Integer ncycleno) {
		this.ncycleno = ncycleno;
	}

	public String getCdescription() {
		return cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMpMenugrid")
	public Set<CenMpMenugridCycle> getCenMpMenugridCycles() {
		return cenMpMenugridCycles;
	}

	public void setCenMpMenugridCycles(Set<CenMpMenugridCycle> cenMpMenugridCycles) {
		this.cenMpMenugridCycles = cenMpMenugridCycles;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_MG_STATUS_KEY")
	public SysMpMgStatus getSysMpMgStatus() {
		return this.sysMpMgStatus;
	}

	public void setSysMpMgStatus(SysMpMgStatus sysMpMgStatus) {
		this.sysMpMgStatus = sysMpMgStatus;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_SERVICE_KEY")
	public CenMpService getCenMpService() {
		return this.cenMpService;
	}

	public void setCenMpService(CenMpService cenMpService) {
		this.cenMpService = cenMpService;
	}

	public Integer getNserviceNumber() {
		return nserviceNumber;
	}

	public void setNserviceNumber(Integer nserviceNumber) {
		this.nserviceNumber = nserviceNumber;
	}
}


