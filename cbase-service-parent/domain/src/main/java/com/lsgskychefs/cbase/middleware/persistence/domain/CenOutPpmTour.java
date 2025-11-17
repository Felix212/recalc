package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20.03.2017 09:55:51 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_TOUR
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_TOUR")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@NamedEntityGraph(name = "CenOutPpmTour.allTrolleys", attributeNodes = {
		@NamedAttributeNode(value = "cenOutPpmTrolleys", subgraph = "allContents")
}, subgraphs = {
		@NamedSubgraph(name = "allContents", attributeNodes = {
				@NamedAttributeNode("cenOutPpmTrolleyConts")
		})
})
public class CenOutPpmTour implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nppmTourKey;

	@JsonView(View.Simple.class)
	private long ntourId;

	@JsonView(View.Simple.class)
	private Date dprodDate;

	@JsonView(View.Simple.class)
	private BigDecimal ntemperature;

	@JsonView(View.Simple.class)
	private Date dtimestamp;

	@JsonView(View.Simple.class)
	private String cuser;

	@JsonView(View.Simple.class)
	private String cdescription;

	@JsonView(View.Simple.class)
	private String cunit;

	@JsonView(View.Simple.class)
	private String cgate;

	@JsonView(View.Simple.class)
	private BigDecimal ntemperature2;

	@JsonView(View.Simple.class)
	private Date dtimestamp2;

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenOutPpmTrolley> cenOutPpmTrolleys = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_TOUR")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_TOUR", sequenceName = "SEQ_CEN_OUT_PPM_TOUR", allocationSize = 1)
	@Column(name = "NPPM_TOUR_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmTourKey() {
		return this.nppmTourKey;
	}

	public void setNppmTourKey(final long nppmTourKey) {
		this.nppmTourKey = nppmTourKey;
	}

	@Column(name = "NTOUR_ID", nullable = false, precision = 12, scale = 0)
	public long getNtourId() {
		return this.ntourId;
	}

	public void setNtourId(final long ntourId) {
		this.ntourId = ntourId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPROD_DATE", nullable = false, length = 7)
	public Date getDprodDate() {
		return this.dprodDate;
	}

	public void setDprodDate(final Date dprodDate) {
		this.dprodDate = dprodDate;
	}

	@Column(name = "NTEMPERATURE", precision = 12)
	public BigDecimal getNtemperature() {
		return this.ntemperature;
	}

	public void setNtemperature(final BigDecimal ntemperature) {
		this.ntemperature = ntemperature;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CDESCRIPTION", length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	public String getCunit() {
		return cunit;
	}

	@Column(name = "CUNIT", length = 5)
	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CGATE", nullable = false, length = 40, columnDefinition = "VARCHAR2(40) default ' '")
	public String getCgate() {
		return this.cgate;
	}

	public void setCgate(final String cgate) {
		this.cgate = cgate;
	}

	@Column(name = "NTEMPERATURE2", precision = 12)
	public BigDecimal getNtemperature2() {
		return this.ntemperature2;
	}

	public void setNtemperature2(final BigDecimal ntemperature2) {
		this.ntemperature2 = ntemperature2;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP2", length = 7)
	public Date getDtimestamp2() {
		return this.dtimestamp2;
	}

	public void setDtimestamp2(final Date dtimestamp2) {
		this.dtimestamp2 = dtimestamp2;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmTour")
	public Set<CenOutPpmTrolley> getCenOutPpmTrolleys() {
		return this.cenOutPpmTrolleys;
	}

	public void setCenOutPpmTrolleys(final Set<CenOutPpmTrolley> cenOutPpmTrolleys) {
		this.cenOutPpmTrolleys = cenOutPpmTrolleys;
	}

}
