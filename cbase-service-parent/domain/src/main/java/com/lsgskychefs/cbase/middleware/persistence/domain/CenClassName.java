package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.06.2016 15:04:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_CLASS_NAME
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CLASS_NAME")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenClassName implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenClassNameId id;
	@JsonIgnore
	private CenAirlines cenAirlines;
	private String cclassName;
	private long nclassNumber;
	private Integer nownerId;
	private int nbookingClass;
	private Integer nclassHost;
	private String cclassHost;
	private String cclassReturn;
	private String cclassUpgrade;
	private int noverrideConfig;
	@JsonIgnore
	private Set<CenAircraftConfigurations> cenAircraftConfigurationses = new HashSet<>(0);

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cclass", column = @Column(name = "CCLASS", nullable = false, length = 10)) })
	public CenClassNameId getId() {
		return this.id;
	}

	public void setId(final CenClassNameId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CCLASS_NAME", nullable = false, length = 30)
	public String getCclassName() {
		return this.cclassName;
	}

	public void setCclassName(final String cclassName) {
		this.cclassName = cclassName;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NBOOKING_CLASS", nullable = false, precision = 1, scale = 0)
	public int getNbookingClass() {
		return this.nbookingClass;
	}

	public void setNbookingClass(final int nbookingClass) {
		this.nbookingClass = nbookingClass;
	}

	@Column(name = "NCLASS_HOST", precision = 2, scale = 0)
	public Integer getNclassHost() {
		return this.nclassHost;
	}

	public void setNclassHost(final Integer nclassHost) {
		this.nclassHost = nclassHost;
	}

	@Column(name = "CCLASS_HOST", length = 10)
	public String getCclassHost() {
		return this.cclassHost;
	}

	public void setCclassHost(final String cclassHost) {
		this.cclassHost = cclassHost;
	}

	@Column(name = "CCLASS_RETURN", length = 10)
	public String getCclassReturn() {
		return this.cclassReturn;
	}

	public void setCclassReturn(final String cclassReturn) {
		this.cclassReturn = cclassReturn;
	}

	@Column(name = "CCLASS_UPGRADE", length = 10)
	public String getCclassUpgrade() {
		return this.cclassUpgrade;
	}

	public void setCclassUpgrade(final String cclassUpgrade) {
		this.cclassUpgrade = cclassUpgrade;
	}

	@Column(name = "NOVERRIDE_CONFIG", nullable = false, precision = 1, scale = 0)
	public int getNoverrideConfig() {
		return this.noverrideConfig;
	}

	public void setNoverrideConfig(final int noverrideConfig) {
		this.noverrideConfig = noverrideConfig;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenClassName")
	public Set<CenAircraftConfigurations> getCenAircraftConfigurationses() {
		return this.cenAircraftConfigurationses;
	}

	public void setCenAircraftConfigurationses(final Set<CenAircraftConfigurations> cenAircraftConfigurationses) {
		this.cenAircraftConfigurationses = cenAircraftConfigurationses;
	}

}
