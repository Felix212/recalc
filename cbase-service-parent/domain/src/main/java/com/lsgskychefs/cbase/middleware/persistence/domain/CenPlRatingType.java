package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2022 14:50:48 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_RATING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_RATING_TYPE",
		uniqueConstraints = @UniqueConstraint(columnNames = { "NPACKINGLIST_INDEX_KEY", "NPACKINGLIST_DETAIL_KEY", "NRATING_TYPE_KEY" }))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenPlRatingType implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npackinglistRatingKey;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private SysPlRatingType sysPlRatingType;
	private BigDecimal ntotalRating;
	private Long ntotalNumber;
	private Set<CenPlUserRating> cenPlUserRatings = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PL_RATING_TYPE")
	@SequenceGenerator(name = "SEQ_CEN_PL_RATING_TYPE", sequenceName = "SEQ_CEN_PL_RATING_TYPE", allocationSize = 1)
	@Column(name = "NPACKINGLIST_RATING_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistRatingKey() {
		return this.npackinglistRatingKey;
	}

	public void setNpackinglistRatingKey(final long npackinglistRatingKey) {
		this.npackinglistRatingKey = npackinglistRatingKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRATING_TYPE_KEY", nullable = false)
	public SysPlRatingType getSysPlRatingType() {
		return this.sysPlRatingType;
	}

	public void setSysPlRatingType(final SysPlRatingType sysPlRatingType) {
		this.sysPlRatingType = sysPlRatingType;
	}

	@Column(name = "NTOTAL_RATING", precision = 1)
	public BigDecimal getNtotalRating() {
		return this.ntotalRating;
	}

	public void setNtotalRating(final BigDecimal ntotalRating) {
		this.ntotalRating = ntotalRating;
	}

	@Column(name = "NTOTAL_NUMBER", precision = 12, scale = 0)
	public Long getNtotalNumber() {
		return this.ntotalNumber;
	}

	public void setNtotalNumber(final Long ntotalNumber) {
		this.ntotalNumber = ntotalNumber;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPlRatingType")
	public Set<CenPlUserRating> getCenPlUserRatings() {
		return this.cenPlUserRatings;
	}

	public void setCenPlUserRatings(final Set<CenPlUserRating> cenPlUserRatings) {
		this.cenPlUserRatings = cenPlUserRatings;
	}

}


