package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_UNIT_PL_RESERVE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PL_RESERVE")
public class LocUnitPlReserve implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nreserveKey;
	private LocUnitPlAreas locUnitPlAreas;
	private BigDecimal nday1;
	private BigDecimal nday2;
	private BigDecimal nday3;
	private BigDecimal nday4;
	private BigDecimal nday5;
	private BigDecimal nday6;
	private BigDecimal nday7;
	private String ctimeFrom;
	private String ctimeTo;
	private Date dvalidFrom;
	private Date dvalidTo;
	private Integer npercent;

	public LocUnitPlReserve() {
	}

	public LocUnitPlReserve(final long nreserveKey, final LocUnitPlAreas locUnitPlAreas, final BigDecimal nday1, final BigDecimal nday2,
			final BigDecimal nday3, final BigDecimal nday4, final BigDecimal nday5, final BigDecimal nday6, final BigDecimal nday7,
			final String ctimeFrom, final String ctimeTo, final Date dvalidFrom, final Date dvalidTo) {
		this.nreserveKey = nreserveKey;
		this.locUnitPlAreas = locUnitPlAreas;
		this.nday1 = nday1;
		this.nday2 = nday2;
		this.nday3 = nday3;
		this.nday4 = nday4;
		this.nday5 = nday5;
		this.nday6 = nday6;
		this.nday7 = nday7;
		this.ctimeFrom = ctimeFrom;
		this.ctimeTo = ctimeTo;
		this.dvalidFrom = dvalidFrom;
		this.dvalidTo = dvalidTo;
	}

	public LocUnitPlReserve(final long nreserveKey, final LocUnitPlAreas locUnitPlAreas, final BigDecimal nday1, final BigDecimal nday2,
			final BigDecimal nday3, final BigDecimal nday4, final BigDecimal nday5, final BigDecimal nday6, final BigDecimal nday7,
			final String ctimeFrom, final String ctimeTo, final Date dvalidFrom, final Date dvalidTo, final Integer npercent) {
		this.nreserveKey = nreserveKey;
		this.locUnitPlAreas = locUnitPlAreas;
		this.nday1 = nday1;
		this.nday2 = nday2;
		this.nday3 = nday3;
		this.nday4 = nday4;
		this.nday5 = nday5;
		this.nday6 = nday6;
		this.nday7 = nday7;
		this.ctimeFrom = ctimeFrom;
		this.ctimeTo = ctimeTo;
		this.dvalidFrom = dvalidFrom;
		this.dvalidTo = dvalidTo;
		this.npercent = npercent;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_PL_RESERVE")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_PL_RESERVE", sequenceName = "SEQ_LOC_UNIT_PL_RESERVE", allocationSize = 1)
	@Column(name = "NRESERVE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNreserveKey() {
		return this.nreserveKey;
	}

	public void setNreserveKey(final long nreserveKey) {
		this.nreserveKey = nreserveKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_AREA_KEY", nullable = false)
	public LocUnitPlAreas getLocUnitPlAreas() {
		return this.locUnitPlAreas;
	}

	public void setLocUnitPlAreas(final LocUnitPlAreas locUnitPlAreas) {
		this.locUnitPlAreas = locUnitPlAreas;
	}

	@Column(name = "NDAY1", nullable = false, precision = 6)
	public BigDecimal getNday1() {
		return this.nday1;
	}

	public void setNday1(final BigDecimal nday1) {
		this.nday1 = nday1;
	}

	@Column(name = "NDAY2", nullable = false, precision = 6)
	public BigDecimal getNday2() {
		return this.nday2;
	}

	public void setNday2(final BigDecimal nday2) {
		this.nday2 = nday2;
	}

	@Column(name = "NDAY3", nullable = false, precision = 6)
	public BigDecimal getNday3() {
		return this.nday3;
	}

	public void setNday3(final BigDecimal nday3) {
		this.nday3 = nday3;
	}

	@Column(name = "NDAY4", nullable = false, precision = 6)
	public BigDecimal getNday4() {
		return this.nday4;
	}

	public void setNday4(final BigDecimal nday4) {
		this.nday4 = nday4;
	}

	@Column(name = "NDAY5", nullable = false, precision = 6)
	public BigDecimal getNday5() {
		return this.nday5;
	}

	public void setNday5(final BigDecimal nday5) {
		this.nday5 = nday5;
	}

	@Column(name = "NDAY6", nullable = false, precision = 6)
	public BigDecimal getNday6() {
		return this.nday6;
	}

	public void setNday6(final BigDecimal nday6) {
		this.nday6 = nday6;
	}

	@Column(name = "NDAY7", nullable = false, precision = 6)
	public BigDecimal getNday7() {
		return this.nday7;
	}

	public void setNday7(final BigDecimal nday7) {
		this.nday7 = nday7;
	}

	@Column(name = "CTIME_FROM", nullable = false, length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(final String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", nullable = false, length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(final String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NPERCENT", precision = 1, scale = 0)
	public Integer getNpercent() {
		return this.npercent;
	}

	public void setNpercent(final Integer npercent) {
		this.npercent = npercent;
	}

}
