package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.06.2016 17:23:11 by Hibernate Tools 4.3.2-SNAPSHOT

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_HANDLING_TYPES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_HANDLING_TYPES", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "CTEXT" }))
public class CenHandlingTypes implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	@JsonView(View.Simple.class)
	private long nhandlingTypeKey;
	@JsonIgnore
	private CenAirlines cenAirlines;
	@JsonView(View.Simple.class)
	private String ctext;
	@JsonView(View.Simple.class)
	private String cdescription;
	@JsonView(View.Simple.class)
	private Integer nownerId;
	@JsonView(View.Simple.class)
	private int nsingle;
	@JsonView(View.Simple.class)
	private int nmulti;
	@JsonView(View.Simple.class)
	private int nprio;
	@JsonView(View.Simple.class)
	private Integer ncountFlight;
	@JsonView(View.Simple.class)
	private Long nopcodeKey;
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenPpsCateringOrder> cenPpsCateringOrdersForNhandlingTypeKeyOld = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenPpsCateringOrder> cenPpsCateringOrdersForNhandlingTypeKey = new HashSet<>(0);

	@Id
	@Column(name = "NHANDLING_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingTypeKey() {
		return this.nhandlingTypeKey;
	}

	public void setNhandlingTypeKey(final long nhandlingTypeKey) {
		this.nhandlingTypeKey = nhandlingTypeKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CTEXT", nullable = false, length = 30)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NSINGLE", nullable = false, precision = 1, scale = 0)
	public int getNsingle() {
		return this.nsingle;
	}

	public void setNsingle(final int nsingle) {
		this.nsingle = nsingle;
	}

	@Column(name = "NMULTI", nullable = false, precision = 1, scale = 0)
	public int getNmulti() {
		return this.nmulti;
	}

	public void setNmulti(final int nmulti) {
		this.nmulti = nmulti;
	}

	@Column(name = "NPRIO", nullable = false, precision = 3, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "NCOUNT_FLIGHT", precision = 1, scale = 0)
	public Integer getNcountFlight() {
		return this.ncountFlight;
	}

	public void setNcountFlight(final Integer ncountFlight) {
		this.ncountFlight = ncountFlight;
	}

	@Column(name = "NOPCODE_KEY", precision = 12, scale = 0)
	public Long getNopcodeKey() {
		return this.nopcodeKey;
	}

	public void setNopcodeKey(final Long nopcodeKey) {
		this.nopcodeKey = nopcodeKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandlingTypesByNhandlingTypeKeyOld")
	public Set<CenPpsCateringOrder> getCenPpsCateringOrdersForNhandlingTypeKeyOld() {
		return this.cenPpsCateringOrdersForNhandlingTypeKeyOld;
	}

	public void setCenPpsCateringOrdersForNhandlingTypeKeyOld(final Set<CenPpsCateringOrder> cenPpsCateringOrdersForNhandlingTypeKeyOld) {
		this.cenPpsCateringOrdersForNhandlingTypeKeyOld = cenPpsCateringOrdersForNhandlingTypeKeyOld;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenHandlingTypesByNhandlingTypeKey")
	public Set<CenPpsCateringOrder> getCenPpsCateringOrdersForNhandlingTypeKey() {
		return this.cenPpsCateringOrdersForNhandlingTypeKey;
	}

	public void setCenPpsCateringOrdersForNhandlingTypeKey(final Set<CenPpsCateringOrder> cenPpsCateringOrdersForNhandlingTypeKey) {
		this.cenPpsCateringOrdersForNhandlingTypeKey = cenPpsCateringOrdersForNhandlingTypeKey;
	}

}
