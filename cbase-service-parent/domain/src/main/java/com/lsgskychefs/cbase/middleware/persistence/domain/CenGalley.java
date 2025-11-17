/*
 * Copyright (c) 2015-2023 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.06.2016 15:25:59 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_GALLEY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_GALLEY", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRCRAFT_KEY", "CGALLEY" }))
public class CenGalley implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ngalleyKey;
	@JsonIgnore
	private CenAircraft cenAircraft;
	private String cgalley;
	private String ctext;
	private int nsort;
	private BigDecimal nweight;
	private Integer ngalleyGroup;
	private Date dtimestamp;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cgalleyGroup;
	private String caddInformation;
	private BigDecimal nmaxWeight;
	private String cmaxWeightUnit;
	private Set<CenStowage> cenStowages = new HashSet<>(0);
	private Set<CenDiagramExtra> cenDiagramExtras = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_GALLEY")
	@SequenceGenerator(name = "SEQ_CEN_GALLEY", sequenceName = "SEQ_CEN_GALLEY", allocationSize = 1)
	@Column(name = "NGALLEY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNgalleyKey() {
		return this.ngalleyKey;
	}

	public void setNgalleyKey(final long ngalleyKey) {
		this.ngalleyKey = ngalleyKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", nullable = false)
	public CenAircraft getCenAircraft() {
		return this.cenAircraft;
	}

	public void setCenAircraft(final CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
	}

	@Column(name = "CGALLEY", nullable = false, length = 5)
	public String getCgalley() {
		return this.cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NWEIGHT", nullable = false, precision = 10, scale = 3)
	public BigDecimal getNweight() {
		return this.nweight;
	}

	public void setNweight(final BigDecimal nweight) {
		this.nweight = nweight;
	}

	@Column(name = "NGALLEY_GROUP", precision = 3, scale = 0)
	public Integer getNgalleyGroup() {
		return this.ngalleyGroup;
	}

	public void setNgalleyGroup(final Integer ngalleyGroup) {
		this.ngalleyGroup = ngalleyGroup;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
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

	@Column(name = "CGALLEY_GROUP", length = 20)
	public String getCgalleyGroup() {
		return this.cgalleyGroup;
	}

	public void setCgalleyGroup(final String cgalleyGroup) {
		this.cgalleyGroup = cgalleyGroup;
	}

	@Column(name = "CADD_INFORMATION", length = 100)
	public String getCaddInformation() {
		return this.caddInformation;
	}

	public void setCaddInformation(String caddInformation) {
		this.caddInformation = caddInformation;
	}

	@Column(name = "NMAX_WEIGHT", precision = 10, scale = 3)
	public BigDecimal getNmaxWeight() {
		return this.nmaxWeight;
	}

	public void setNmaxWeight(BigDecimal nmaxWeight) {
		this.nmaxWeight = nmaxWeight;
	}

	@Column(name = "CMAX_WEIGHT_UNIT", length = 3)
	public String getCmaxWeightUnit() {
		return this.cmaxWeightUnit;
	}

	public void setCmaxWeightUnit(String cmaxWeightUnit) {
		this.cmaxWeightUnit = cmaxWeightUnit;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenGalley")
	public Set<CenStowage> getCenStowages() {
		return this.cenStowages;
	}

	public void setCenStowages(final Set<CenStowage> cenStowages) {
		this.cenStowages = cenStowages;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenGalley")
	public Set<CenDiagramExtra> getCenDiagramExtras() {
		return this.cenDiagramExtras;
	}

	public void setCenDiagramExtras(final Set<CenDiagramExtra> cenDiagramExtras) {
		this.cenDiagramExtras = cenDiagramExtras;
	}

}
