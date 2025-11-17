package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20.03.2017 09:55:51 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_TROLLEY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_TROLLEY")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenOutPpmTrolley implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmTrolleyKey;

	private CenOutPpmTour cenOutPpmTour;

	private long ntrolleyId;

	private Date ddate;

	private String cunit;

	private String cgate;

	private Date dtimestamp;

	private Set<CenOutPpmTrolleyCont> cenOutPpmTrolleyConts = new HashSet<>(0);

	private Set<CenOutPpmProdLabel> cenOutPpmProdLabels = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_TROLLEY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_TROLLEY", sequenceName = "SEQ_CEN_OUT_PPM_TROLLEY", allocationSize = 1)
	@Column(name = "NPPM_TROLLEY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNppmTrolleyKey() {
		return this.nppmTrolleyKey;
	}

	public void setNppmTrolleyKey(final long nppmTrolleyKey) {
		this.nppmTrolleyKey = nppmTrolleyKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_TOUR_KEY")
	@JsonView(View.SpecialRelation.class)
	public CenOutPpmTour getCenOutPpmTour() {
		return this.cenOutPpmTour;
	}

	public void setCenOutPpmTour(final CenOutPpmTour cenOutPpmTour) {
		this.cenOutPpmTour = cenOutPpmTour;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDATE", length = 7)
	@JsonView(View.Simple.class)
	public Date getDdate() {
		return ddate;
	}

	public void setDdate(final Date ddate) {
		this.ddate = ddate;
	}

	@Column(name = "NTROLLEY_ID", nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNtrolleyId() {
		return this.ntrolleyId;
	}

	public void setNtrolleyId(final long ntrolleyId) {
		this.ntrolleyId = ntrolleyId;
	}

	@Column(name = "CUNIT", length = 5)
	@JsonView(View.Simple.class)
	public String getCunit() {
		return cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CGATE", nullable = false, length = 40, columnDefinition = "VARCHAR2(40) default ' '")
	@JsonView(View.Simple.class)
	public String getCgate() {
		return this.cgate;
	}

	public void setCgate(final String cgate) {
		this.cgate = cgate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	@JsonView(View.Simple.class)
	public Date getDtimestamp() {
		return dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmTrolley")
	@JsonIgnore
	public Set<CenOutPpmTrolleyCont> getCenOutPpmTrolleyConts() {
		return this.cenOutPpmTrolleyConts;
	}

	public void setCenOutPpmTrolleyConts(final Set<CenOutPpmTrolleyCont> cenOutPpmTrolleyConts) {
		this.cenOutPpmTrolleyConts = cenOutPpmTrolleyConts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmTrolley")
	@JsonIgnore
	public Set<CenOutPpmProdLabel> getCenOutPpmProdLabels() {
		return this.cenOutPpmProdLabels;
	}

	public void setCenOutPpmProdLabels(final Set<CenOutPpmProdLabel> cenOutPpmProdLabels) {
		this.cenOutPpmProdLabels = cenOutPpmProdLabels;
	}

}
