package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 30.11.2021 12:18:42 by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PROJECT_STRUCTURE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PROJECT_STRUCTURE")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "structure.fetchall", attributeNodes = {
				@NamedAttributeNode(value = "cenPackinglistProjects", subgraph = "structure.packinglists")
		}, subgraphs = {
				@NamedSubgraph(name = "structure.packinglists", attributeNodes = {
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
		})
})
public class CenProjectStructure implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nprojectStructureKey;
	@JsonIgnore
	private CenProject cenProject;
	private String cname;
	private String cdescription;
	private Long nsort;
	private List<CenPackinglistProject> cenPackinglistProjects = new ArrayList<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PROJECT_STRUCTURE")
	@SequenceGenerator(name = "SEQ_CEN_PROJECT_STRUCTURE", sequenceName = "SEQ_CEN_PROJECT_STRUCTURE", allocationSize = 1)
	@Column(name = "NPROJECT_STRUCTURE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojectStructureKey() {
		return this.nprojectStructureKey;
	}

	public void setNprojectStructureKey(final long nprojectStructureKey) {
		this.nprojectStructureKey = nprojectStructureKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_KEY")
	public CenProject getCenProject() {
		return this.cenProject;
	}

	public void setCenProject(final CenProject cenProject) {
		this.cenProject = cenProject;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenProjectStructure")
	public List<CenPackinglistProject> getCenPackinglistProjects() {
		return this.cenPackinglistProjects;
	}

	public void setCenPackinglistProjects(final List<CenPackinglistProject> cenPackinglistProjects) {
		this.cenPackinglistProjects = cenPackinglistProjects;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

}
