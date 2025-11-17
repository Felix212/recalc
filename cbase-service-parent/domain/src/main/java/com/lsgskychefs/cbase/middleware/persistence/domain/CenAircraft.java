package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_AIRCRAFT
 *
 * @author Hibernate Tools
 */
@NamedEntityGraphs({
		@NamedEntityGraph(name = "cenAircraft.cenPpsAndCenAircraftConAndCenAircraftReg", attributeNodes = {
				@NamedAttributeNode(value = "cenPpsCateringOrdersForNaircraftKey"),
				@NamedAttributeNode(value = "cenAircraftConfigurationses", subgraph = "cenAircraftConfigurations.subgraph"),
				@NamedAttributeNode(value = "cenAircraftRegistrationses")
		},
				subgraphs = {
						@NamedSubgraph(name = "cenAircraftConfigurations.subgraph",
								attributeNodes = {
										@NamedAttributeNode(value = "cenClassName")
								})
				})
})
@Entity
@Table(name = "CEN_AIRCRAFT", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_OWNER_KEY", "CACTYPE", "CGALLEYVERSION" }))
public class CenAircraft implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long naircraftKey;
	@JsonIgnore
	private CenAirlines cenAirlines;
	@JsonView(View.Simple.class)
	private String cactype;
	@JsonView(View.Simple.class)
	private String cconfiguration;
	@JsonView(View.Simple.class)
	private String cgalleyversion;
	@JsonView(View.Simple.class)
	private Integer nownerId;
	@JsonView(View.Simple.class)
	private Integer nmcd;
	@JsonView(View.Simple.class)
	private Integer ndefaultActype;
	@JsonView(View.Simple.class)
	private String cactypeImport;
	@JsonView(View.Simple.class)
	private Date dtimestamp;
	@JsonView(View.Simple.class)
	private String cstatus;
	@JsonView(View.Simple.class)
	private String cactypeDescription;
	@JsonView(View.Simple.class)
	private String cupdatedBy;
	@JsonView(View.Simple.class)
	private Date dupdatedDate;
	@JsonView(View.Simple.class)
	private String cupdatedByPrev;
	@JsonView(View.Simple.class)
	private Date dupdatedDatePrev;
	@JsonView(View.Simple.class)
	private Boolean ninvalid;
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenPpsCateringOrder> cenPpsCateringOrdersForNaircraftKey = new HashSet<>(0);
	@JsonView(View.SpecialRelation.class)
	private Set<CenAircraftConfigurations> cenAircraftConfigurationses = new HashSet<>(0);
	@JsonView(View.SpecialRelation.class)
	private Set<CenAircraftRegistrations> cenAircraftRegistrationses = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenGalley> cenGalleys = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenPpsCateringOrder> cenPpsCateringOrdersForNaircraftKeyOld = new HashSet<>(0);

	@Id
	@Column(name = "NAIRCRAFT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_OWNER_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CACTYPE", nullable = false, length = 10)
	public String getCactype() {
		return this.cactype;
	}

	public void setCactype(final String cactype) {
		this.cactype = cactype;
	}

	@Column(name = "CCONFIGURATION", nullable = false, length = 20)
	public String getCconfiguration() {
		return this.cconfiguration;
	}

	public void setCconfiguration(final String cconfiguration) {
		this.cconfiguration = cconfiguration;
	}

	@Column(name = "CGALLEYVERSION", nullable = false, length = 10)
	public String getCgalleyversion() {
		return this.cgalleyversion;
	}

	public void setCgalleyversion(final String cgalleyversion) {
		this.cgalleyversion = cgalleyversion;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NMCD", precision = 1, scale = 0)
	public Integer getNmcd() {
		return this.nmcd;
	}

	public void setNmcd(final Integer nmcd) {
		this.nmcd = nmcd;
	}

	@Column(name = "NDEFAULT_ACTYPE", precision = 1, scale = 0)
	public Integer getNdefaultActype() {
		return this.ndefaultActype;
	}

	public void setNdefaultActype(final Integer ndefaultActype) {
		this.ndefaultActype = ndefaultActype;
	}

	@Column(name = "CACTYPE_IMPORT", length = 20)
	public String getCactypeImport() {
		return this.cactypeImport;
	}

	public void setCactypeImport(final String cactypeImport) {
		this.cactypeImport = cactypeImport;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CSTATUS", length = 2)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(final String cstatus) {
		this.cstatus = cstatus;
	}

	@Column(name = "CACTYPE_DESCRIPTION", length = 40)
	public String getCactypeDescription() {
		return this.cactypeDescription;
	}

	public void setCactypeDescription(final String cactypeDescription) {
		this.cactypeDescription = cactypeDescription;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "NINVALID", precision = 1)
	public Boolean getNinvalid() {
		return this.ninvalid;
	}

	public void setNinvalid(final Boolean ninvalid) {
		this.ninvalid = ninvalid;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAircraftByNaircraftKey")
	public Set<CenPpsCateringOrder> getCenPpsCateringOrdersForNaircraftKey() {
		return this.cenPpsCateringOrdersForNaircraftKey;
	}

	public void setCenPpsCateringOrdersForNaircraftKey(final Set<CenPpsCateringOrder> cenPpsCateringOrdersForNaircraftKey) {
		this.cenPpsCateringOrdersForNaircraftKey = cenPpsCateringOrdersForNaircraftKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAircraft")
	public Set<CenAircraftConfigurations> getCenAircraftConfigurationses() {
		return this.cenAircraftConfigurationses;
	}

	public void setCenAircraftConfigurationses(final Set<CenAircraftConfigurations> cenAircraftConfigurationses) {
		this.cenAircraftConfigurationses = cenAircraftConfigurationses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAircraft")
	public Set<CenAircraftRegistrations> getCenAircraftRegistrationses() {
		return this.cenAircraftRegistrationses;
	}

	public void setCenAircraftRegistrationses(final Set<CenAircraftRegistrations> cenAircraftRegistrationses) {
		this.cenAircraftRegistrationses = cenAircraftRegistrationses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAircraft")
	public Set<CenGalley> getCenGalleys() {
		return this.cenGalleys;
	}

	public void setCenGalleys(final Set<CenGalley> cenGalleys) {
		this.cenGalleys = cenGalleys;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAircraftByNaircraftKeyOld")
	public Set<CenPpsCateringOrder> getCenPpsCateringOrdersForNaircraftKeyOld() {
		return this.cenPpsCateringOrdersForNaircraftKeyOld;
	}

	public void setCenPpsCateringOrdersForNaircraftKeyOld(final Set<CenPpsCateringOrder> cenPpsCateringOrdersForNaircraftKeyOld) {
		this.cenPpsCateringOrdersForNaircraftKeyOld = cenPpsCateringOrdersForNaircraftKeyOld;
	}

}
