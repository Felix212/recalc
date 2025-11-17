package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.08.2016 09:42:20 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_CATERING_USEROBJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CATERING_USEROBJECT", uniqueConstraints = @UniqueConstraint(columnNames = "CCATERING_UO_NAME"))
public class CenCateringUserobject implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncateringUserobjectId;
	private SysCateringobject sysCateringobject;
	private String cclient;
	private String ccateringUoName;
	private String ccateringUoDescripton;
	private String ccreator;
	private String clastchange;
	private BigDecimal nversion;
	private String cdepartment;
	private Integer nownerId;
	private Integer nflightRelated;
	private Long nairlineKey;
	private Long ncuoCatKey;
	private Set<CenHandlingDocDetail> cenHandlingDocDetails = new HashSet<>(0);
	private Set<CenCateringUoPdf> cenCateringUoPdfs = new HashSet<>(0);

	@Id
	@Column(name = "NCATERING_USEROBJECT_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcateringUserobjectId() {
		return this.ncateringUserobjectId;
	}

	public void setNcateringUserobjectId(final long ncateringUserobjectId) {
		this.ncateringUserobjectId = ncateringUserobjectId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCATERINGOBJECT_ID", nullable = false)
	public SysCateringobject getSysCateringobject() {
		return this.sysCateringobject;
	}

	public void setSysCateringobject(final SysCateringobject sysCateringobject) {
		this.sysCateringobject = sysCateringobject;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CCATERING_UO_NAME", unique = true, nullable = false, length = 40)
	public String getCcateringUoName() {
		return this.ccateringUoName;
	}

	public void setCcateringUoName(final String ccateringUoName) {
		this.ccateringUoName = ccateringUoName;
	}

	@Column(name = "CCATERING_UO_DESCRIPTON", nullable = false, length = 100)
	public String getCcateringUoDescripton() {
		return this.ccateringUoDescripton;
	}

	public void setCcateringUoDescripton(final String ccateringUoDescripton) {
		this.ccateringUoDescripton = ccateringUoDescripton;
	}

	@Column(name = "CCREATOR", length = 50)
	public String getCcreator() {
		return this.ccreator;
	}

	public void setCcreator(final String ccreator) {
		this.ccreator = ccreator;
	}

	@Column(name = "CLASTCHANGE", length = 40)
	public String getClastchange() {
		return this.clastchange;
	}

	public void setClastchange(final String clastchange) {
		this.clastchange = clastchange;
	}

	@Column(name = "NVERSION", precision = 5)
	public BigDecimal getNversion() {
		return this.nversion;
	}

	public void setNversion(final BigDecimal nversion) {
		this.nversion = nversion;
	}

	@Column(name = "CDEPARTMENT", nullable = false, length = 10)
	public String getCdepartment() {
		return this.cdepartment;
	}

	public void setCdepartment(final String cdepartment) {
		this.cdepartment = cdepartment;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NFLIGHT_RELATED", precision = 1, scale = 0)
	public Integer getNflightRelated() {
		return this.nflightRelated;
	}

	public void setNflightRelated(final Integer nflightRelated) {
		this.nflightRelated = nflightRelated;
	}

	@Column(name = "NAIRLINE_KEY", precision = 12, scale = 0)
	public Long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final Long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "NCUO_CAT_KEY", precision = 12, scale = 0)
	public Long getNcuoCatKey() {
		return this.ncuoCatKey;
	}

	public void setNcuoCatKey(final Long ncuoCatKey) {
		this.ncuoCatKey = ncuoCatKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenCateringUserobject")
	public Set<CenCateringUoPdf> getCenCateringUoPdfs() {
		return this.cenCateringUoPdfs;
	}

	public void setCenCateringUoPdfs(final Set<CenCateringUoPdf> cenCateringUoPdfs) {
		this.cenCateringUoPdfs = cenCateringUoPdfs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenCateringUserobject")
	public Set<CenHandlingDocDetail> getCenHandlingDocDetails() {
		return this.cenHandlingDocDetails;
	}

	public void setCenHandlingDocDetails(final Set<CenHandlingDocDetail> cenHandlingDocDetails) {
		this.cenHandlingDocDetails = cenHandlingDocDetails;
	}

}
