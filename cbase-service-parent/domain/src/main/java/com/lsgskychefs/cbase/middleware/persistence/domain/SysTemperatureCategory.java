package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.09.2023 14:50:08 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_TEMPERATURE_CATEGORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_TEMPERATURE_CATEGORY")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysTemperatureCategory implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntemperatureCategoryKey;
	private String cdescription;
	private BigDecimal ntemperatureThreshold;
	private Long nsort;
	@JsonIgnore
	private Set<CenPlTemperatureCategory> cenPlTemperatureCategories = new HashSet<>(0);

	@Id
	@Column(name = "NTEMPERATURE_CATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtemperatureCategoryKey() {
		return this.ntemperatureCategoryKey;
	}

	public void setNtemperatureCategoryKey(long ntemperatureCategoryKey) {
		this.ntemperatureCategoryKey = ntemperatureCategoryKey;
	}

	@Column(name = "CDESCRIPTION", length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NTEMPERATURE_THRESHOLD", precision = 12, scale = 3)
	public BigDecimal getNtemperatureThreshold() {
		return this.ntemperatureThreshold;
	}

	public void setNtemperatureThreshold(BigDecimal ntemperatureThreshold) {
		this.ntemperatureThreshold = ntemperatureThreshold;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(Long nsort) {
		this.nsort = nsort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysTemperatureCategory")
	public Set<CenPlTemperatureCategory> getCenPlTemperatureCategories() {
		return this.cenPlTemperatureCategories;
	}

	public void setCenPlTemperatureCategories(Set<CenPlTemperatureCategory> cenPlTemperatureCategories) {
		this.cenPlTemperatureCategories = cenPlTemperatureCategories;
	}

}


