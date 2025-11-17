package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.09.2022 08:47:20 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PL_RATING_TOTAL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_RATING_TOTAL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenPlRatingTotal implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPackinglistsId id;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	/** simple average of all CenPlRatingType */
	private BigDecimal ntotalRating;
	/** max ratings of one type in CenPlRatingType */
	private Long ntotalNumber;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPackinglistsId getId() {
		return this.id;
	}

	public void setId(final CenPackinglistsId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
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

}


