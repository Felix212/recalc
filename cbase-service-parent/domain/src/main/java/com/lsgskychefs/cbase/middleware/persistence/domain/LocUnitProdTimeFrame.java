package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_PROD_TIME_FRAME
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PROD_TIME_FRAME")
public class LocUnitProdTimeFrame implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nprodtimeframeIndex;
	@JsonIgnore
	private LocUnitPpmValidities locUnitPpmValidities;
	private String cunit;
	private long nairlineKey;
	private String ctimeframe;
	private String ctimefrom;
	private String ctimeto;
	@JsonIgnore
	private Set<LocPlTimeFrame> locPlTimeFrames = new HashSet<>(0);

	public LocUnitProdTimeFrame() {
	}

	public LocUnitProdTimeFrame(final long nprodtimeframeIndex, final LocUnitPpmValidities locUnitPpmValidities, final String cunit,
			final long nairlineKey, final String ctimeframe, final String ctimefrom, final String ctimeto) {
		this.nprodtimeframeIndex = nprodtimeframeIndex;
		this.locUnitPpmValidities = locUnitPpmValidities;
		this.cunit = cunit;
		this.nairlineKey = nairlineKey;
		this.ctimeframe = ctimeframe;
		this.ctimefrom = ctimefrom;
		this.ctimeto = ctimeto;
	}

	public LocUnitProdTimeFrame(final long nprodtimeframeIndex, final LocUnitPpmValidities locUnitPpmValidities, final String cunit,
			final long nairlineKey, final String ctimeframe, final String ctimefrom, final String ctimeto,
			final Set<LocPlTimeFrame> locPlTimeFrames) {
		this.nprodtimeframeIndex = nprodtimeframeIndex;
		this.locUnitPpmValidities = locUnitPpmValidities;
		this.cunit = cunit;
		this.nairlineKey = nairlineKey;
		this.ctimeframe = ctimeframe;
		this.ctimefrom = ctimefrom;
		this.ctimeto = ctimeto;
		this.locPlTimeFrames = locPlTimeFrames;
	}

	@Id

	@Column(name = "NPRODTIMEFRAME_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprodtimeframeIndex() {
		return this.nprodtimeframeIndex;
	}

	public void setNprodtimeframeIndex(final long nprodtimeframeIndex) {
		this.nprodtimeframeIndex = nprodtimeframeIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NVALID_INDEX", nullable = false)
	public LocUnitPpmValidities getLocUnitPpmValidities() {
		return this.locUnitPpmValidities;
	}

	public void setLocUnitPpmValidities(final LocUnitPpmValidities locUnitPpmValidities) {
		this.locUnitPpmValidities = locUnitPpmValidities;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CTIMEFRAME", nullable = false, length = 40)
	public String getCtimeframe() {
		return this.ctimeframe;
	}

	public void setCtimeframe(final String ctimeframe) {
		this.ctimeframe = ctimeframe;
	}

	@Column(name = "CTIMEFROM", nullable = false, length = 5)
	public String getCtimefrom() {
		return this.ctimefrom;
	}

	public void setCtimefrom(final String ctimefrom) {
		this.ctimefrom = ctimefrom;
	}

	@Column(name = "CTIMETO", nullable = false, length = 5)
	public String getCtimeto() {
		return this.ctimeto;
	}

	public void setCtimeto(final String ctimeto) {
		this.ctimeto = ctimeto;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitProdTimeFrame")
	public Set<LocPlTimeFrame> getLocPlTimeFrames() {
		return this.locPlTimeFrames;
	}

	public void setLocPlTimeFrames(final Set<LocPlTimeFrame> locPlTimeFrames) {
		this.locPlTimeFrames = locPlTimeFrames;
	}

}
