package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_PACKAGES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_PACKAGES", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "CPACKAGE", "CVARIATION" }))
public class CenAirlinePackages implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** nairlinePackagesKey */
	private long nairlinePackagesKey;

	/** cenAirlines */
	private CenAirlines cenAirlines;

	/** cpackage */
	private String cpackage;

	/** npackageType */
	private int npackageType;

	/** cremarks */
	private String cremarks;

	/** cvariation */
	private String cvariation;

	/** npacketGroupKey */
	private Long npacketGroupKey;

	/** dtimestamp */
	private Date dtimestamp;

	/** cenPackinglistDetails */
	private Set<CenPackinglistDetail> cenPackinglistDetails = new HashSet<>(0);

	/** cenMealsPackageses */
	private Set<CenMealsPackages> cenMealsPackageses = new HashSet<>(0);

	@Id
	@Column(name = "NAIRLINE_PACKAGES_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNairlinePackagesKey() {
		return this.nairlinePackagesKey;
	}

	public void setNairlinePackagesKey(final long nairlinePackagesKey) {
		this.nairlinePackagesKey = nairlinePackagesKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CPACKAGE", nullable = false, length = 18)
	public String getCpackage() {
		return this.cpackage;
	}

	public void setCpackage(final String cpackage) {
		this.cpackage = cpackage;
	}

	@Column(name = "NPACKAGE_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNpackageType() {
		return this.npackageType;
	}

	public void setNpackageType(final int npackageType) {
		this.npackageType = npackageType;
	}

	@Column(name = "CREMARKS", length = 70)
	public String getCremarks() {
		return this.cremarks;
	}

	public void setCremarks(final String cremarks) {
		this.cremarks = cremarks;
	}

	@Column(name = "CVARIATION", length = 40)
	public String getCvariation() {
		return this.cvariation;
	}

	public void setCvariation(final String cvariation) {
		this.cvariation = cvariation;
	}

	@Column(name = "NPACKET_GROUP_KEY", precision = 12, scale = 0)
	public Long getNpacketGroupKey() {
		return this.npacketGroupKey;
	}

	public void setNpacketGroupKey(final Long npacketGroupKey) {
		this.npacketGroupKey = npacketGroupKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlinePackages")
	public Set<CenPackinglistDetail> getCenPackinglistDetails() {
		return this.cenPackinglistDetails;
	}

	public void setCenPackinglistDetails(final Set<CenPackinglistDetail> cenPackinglistDetails) {
		this.cenPackinglistDetails = cenPackinglistDetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlinePackages")
	public Set<CenMealsPackages> getCenMealsPackageses() {
		return this.cenMealsPackageses;
	}

	public void setCenMealsPackageses(final Set<CenMealsPackages> cenMealsPackageses) {
		this.cenMealsPackageses = cenMealsPackageses;
	}

}
