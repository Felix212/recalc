package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 16, 2021 3:22:02 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.sql.Blob;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SKY_MAR_IL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SKY_MAR_IL")
public class SkyMarIl implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SkyMarIlId id;

	@JsonView(View.SpecialRelation.class)
	private SkyMarIlIndex skyMarIlIndex;

	@JsonView(View.Simple.class)
	private CenAirlines cenAirlines;

	@JsonView(View.Simple.class)
	private Date dvalidFrom;

	@JsonView(View.Simple.class)
	private Date dvalidTo;

	@JsonView(View.Simple.class)
	private String ctext;

	@JsonView(View.Simple.class)
	private String ctextShort;

	@JsonView(View.Simple.class)
	private String ccustomerPl;

	@JsonView(View.Simple.class)
	private String ccustomerText;

	@JsonView(View.Simple.class)
	private BigDecimal nweight;

	@JsonView(View.Simple.class)
	private BigDecimal nquantityRecipe;

	@JsonView(View.Simple.class)
	private String cunit;

	@JsonView(View.Simple.class)
	private Long nairlineKey;

	@JsonIgnore
	private Blob binstructions;

	@JsonView(View.SimpleWithReferences.class)
	private Set<SkyMarIlDetail> skyMarIlDetails = new HashSet<>(0);

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public SkyMarIlId getId() {
		return this.id;
	}

	public void setId(final SkyMarIlId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false)
	public SkyMarIlIndex getSkyMarIlIndex() {
		return this.skyMarIlIndex;
	}

	public void setSkyMarIlIndex(final SkyMarIlIndex skyMarIlIndex) {
		this.skyMarIlIndex = skyMarIlIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlines getCenAirlines() {
		return cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
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

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT_SHORT", length = 40)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 50)
	public String getCcustomerText() {
		return ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@Column(name = "NWEIGHT", nullable = false, precision = 10, scale = 3)
	public BigDecimal getNweight() {
		return this.nweight;
	}

	public void setNweight(final BigDecimal nweight) {
		this.nweight = nweight;
	}

	@Column(name = "NQUANTITY_RECIPE", precision = 12, scale = 6)
	public BigDecimal getNquantityRecipe() {
		return this.nquantityRecipe;
	}

	public void setNquantityRecipe(final BigDecimal nquantityRecipe) {
		this.nquantityRecipe = nquantityRecipe;
	}

	@Column(name = "CUNIT", nullable = false, length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAIRLINE_KEY", precision = 12, scale = 0)
	public Long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final Long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "BINSTRUCTIONS")
	public Blob getBinstructions() {
		return this.binstructions;
	}

	public void setBinstructions(final Blob binstructions) {
		this.binstructions = binstructions;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "skyMarIl")
	public Set<SkyMarIlDetail> getSkyMarIlDetails() {
		return this.skyMarIlDetails;
	}

	public void setSkyMarIlDetails(final Set<SkyMarIlDetail> skyMarIlDetails) {
		this.skyMarIlDetails = skyMarIlDetails;
	}

}
