package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table LOC_UNIT_AREAS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_AREAS", uniqueConstraints = { @UniqueConstraint(columnNames = { "CAREA", "CUNIT", "CCLIENT" }),
		@UniqueConstraint(columnNames = { "CCLIENT", "CUNIT", "CTEXT" }) })
public class LocUnitAreas implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nareaKey;

	@JsonIgnore
	private String cunit;

	@JsonIgnore
	private String cclient;

	private String carea;

	@JsonIgnore
	private String sorga;

	@JsonIgnore
	private String sphone;

	private String ctext;

	private String cdescription;

	@JsonIgnore
	private String cinstance;

	@JsonIgnore
	private Integer nboxAllocationType;

	@JsonIgnore
	private Integer nearliestStartDelta;

	@JsonIgnore
	private Integer nlatestEndDelta;

	@JsonIgnore
	private Long noutboundRegionKey;

	@JsonIgnore
	private Integer nplanShiftOffset1;

	@JsonIgnore
	private Integer nplanShiftOffset2;

	@JsonIgnore
	private Set<LocUnitPlAreas> locUnitPlAreases = new HashSet<>(0);

	private Set<LocUnitWorkstation> locUnitWorkstations = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPreprodPlArea> locPreprodPlAreas = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_AREAS")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_AREAS", sequenceName = "SEQ_LOC_UNIT_AREAS", allocationSize = 1)
	@Column(name = "NAREA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNareaKey() {
		return this.nareaKey;
	}

	@JsonView(View.Simple.class)
	public void setNareaKey(final long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CAREA", nullable = false, length = 12)
	public String getCarea() {
		return this.carea;
	}

	@JsonView(View.Simple.class)
	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "SORGA", length = 12)
	public String getSorga() {
		return this.sorga;
	}

	public void setSorga(final String sorga) {
		this.sorga = sorga;
	}

	@Column(name = "SPHONE", length = 20)
	public String getSphone() {
		return this.sphone;
	}

	public void setSphone(final String sphone) {
		this.sphone = sphone;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	@JsonView(View.Simple.class)
	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	@JsonView(View.Simple.class)
	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CINSTANCE", length = 10)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "NBOX_ALLOCATION_TYPE", precision = 1, scale = 0)
	public Integer getNboxAllocationType() {
		return this.nboxAllocationType;
	}

	public void setNboxAllocationType(final Integer nboxAllocationType) {
		this.nboxAllocationType = nboxAllocationType;
	}

	@Column(name = "NEARLIEST_START_DELTA", precision = 4, scale = 0)
	public Integer getNearliestStartDelta() {
		return this.nearliestStartDelta;
	}

	public void setNearliestStartDelta(final Integer nearliestStartDelta) {
		this.nearliestStartDelta = nearliestStartDelta;
	}

	@Column(name = "NLATEST_END_DELTA", precision = 4, scale = 0)
	public Integer getNlatestEndDelta() {
		return this.nlatestEndDelta;
	}

	public void setNlatestEndDelta(final Integer nlatestEndDelta) {
		this.nlatestEndDelta = nlatestEndDelta;
	}

	@Column(name = "NOUTBOUND_REGION_KEY", precision = 12, scale = 0)
	public Long getNoutboundRegionKey() {
		return this.noutboundRegionKey;
	}

	public void setNoutboundRegionKey(final Long noutboundRegionKey) {
		this.noutboundRegionKey = noutboundRegionKey;
	}

	@Column(name = "NPLAN_SHIFT_OFFSET1", precision = 3, scale = 0)
	public Integer getNplanShiftOffset1() {
		return nplanShiftOffset1;
	}

	public void setNplanShiftOffset1(Integer nplanShiftOffset1) {
		this.nplanShiftOffset1 = nplanShiftOffset1;
	}

	@Column(name = "NPLAN_SHIFT_OFFSET2", precision = 3, scale = 0)
	public Integer getNplanShiftOffset2() {
		return nplanShiftOffset2;
	}

	public void setNplanShiftOffset2(Integer nplanShiftOffset2) {
		this.nplanShiftOffset2 = nplanShiftOffset2;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitAreas")
	public Set<LocUnitPlAreas> getLocUnitPlAreases() {
		return this.locUnitPlAreases;
	}

	public void setLocUnitPlAreases(final Set<LocUnitPlAreas> locUnitPlAreases) {
		this.locUnitPlAreases = locUnitPlAreases;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitAreas")
	public Set<LocUnitWorkstation> getLocUnitWorkstations() {
		return this.locUnitWorkstations;
	}

	@JsonView(View.SimpleWithReferences.class)
	public void setLocUnitWorkstations(final Set<LocUnitWorkstation> locUnitWorkstations) {
		this.locUnitWorkstations = locUnitWorkstations;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitAreas")
	public Set<LocPreprodPlArea> getLocPreprodPlAreas() {
		return this.locPreprodPlAreas;
	}

	public void setLocPreprodPlAreas(Set<LocPreprodPlArea> locPreprodPlAreas) {
		this.locPreprodPlAreas = locPreprodPlAreas;
	}

}
