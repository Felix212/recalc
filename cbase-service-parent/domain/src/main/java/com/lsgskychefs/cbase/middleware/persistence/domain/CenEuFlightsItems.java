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
import javax.validation.constraints.Size;

/**
 * Entity(DomainObject) for table CEN_EU_FLIGHTS_ITEMS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EU_FLIGHTS_ITEMS")
public class CenEuFlightsItems implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long neuFlightsItemKey;
	private CenEuFlightsDetail cenEuFlightsDetail;
	private String citem;
	private String citemText;
	private BigDecimal nquantity;
	private String cunit;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_EU_FLIGHTS_ITEMS")
	@SequenceGenerator(name = "SEQ_CEN_EU_FLIGHTS_ITEMS", sequenceName = "SEQ_CEN_EU_FLIGHTS_ITEMS", allocationSize = 1)
	@Column(name = "NEU_FLIGHTS_ITEM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuFlightsItemKey() {
		return this.neuFlightsItemKey;
	}

	public void setNeuFlightsItemKey(final long neuFlightsItemKey) {
		this.neuFlightsItemKey = neuFlightsItemKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_FLIGHTS_DETAIL_KEY", nullable = false)
	public CenEuFlightsDetail getCenEuFlightsDetail() {
		return this.cenEuFlightsDetail;
	}

	public void setCenEuFlightsDetail(final CenEuFlightsDetail cenEuFlightsDetail) {
		this.cenEuFlightsDetail = cenEuFlightsDetail;
	}

	@Column(name = "CITEM", nullable = false, length = 18)
	public String getCitem() {
		return this.citem;
	}

	public void setCitem(final String citem) {
		this.citem = citem;
	}

	@Size(max = 70)
	@Column(name = "CITEM_TEXT", nullable = false, length = 70)
	public String getCitemText() {
		return this.citemText;
	}

	public void setCitemText(final String citemText) {
		this.citemText = citemText;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CUNIT", nullable = false, length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
