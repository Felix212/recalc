package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.04.2016 09:24:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.NamedQueries;

/**
 * Entity(DomainObject) for table CEN_PPS_CATERING_ORDER (Produktions-Planungs-System) <br/>
 * Flugereignise die beliefert werden(Catering).
 *
 * @author Hibernate Tools
 */
@Entity
@NamedQuery(name = NamedQueries.CEN_PPS_CATERING_ORDER_BY_CONTAINER,
		query = "SELECT cat FROM CenPpsCateringOrder cat "
				+ "JOIN cat.cenPpsContainers container "
				+ "JOIN container.locPpsProdBom prodBom "
				+ "WHERE container.ncontainerKey = :ncontainerKey "
				+ "AND cat.ddeparture BETWEEN prodBom.dvalidFrom AND prodBom.dvalidTo ")
@Table(name = "CEN_PPS_CATERING_ORDER", uniqueConstraints = @UniqueConstraint(
		columnNames = { "NRESULT_KEY_GROUP", "CAIRLINE", "NFLIGHT_NUMBER", "CSUFFIX", "DDEPARTURE", "CUNIT" }))
public class CenPpsCateringOrder implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncoKey;
	private CenAircraft cenAircraftByNaircraftKey;
	private CenAircraft cenAircraftByNaircraftKeyOld;
	private CenHandlingTypes cenHandlingTypesByNhandlingTypeKeyOld;
	private CenHandlingTypes cenHandlingTypesByNhandlingTypeKey;
	private SysPpsFlightBoxType sysPpsFlightBoxType;
	private long nresultKeyGroup;
	private String ccomment;
	private String cairline;
	private int nflightNumber;
	private String csuffix;
	private Date ddeparture;
	private String cunit;
	private Integer nacChange;
	private Date dacChange;
	private Integer nflightClosed;
	private Integer ninclGen;
	private String cloadinglist;
	private Date dcx;
	private Long nobjectStateKey;
	private Date drampTime;
	private Integer npreproduced;
	private String cconfiguration;
	private Date ddelayed;
	private String caction;
	private Date dreq;
	private int ngenPrio;
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);

	@Id
	@Column(name = "NCO_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcoKey() {
		return this.ncoKey;
	}

	public void setNcoKey(final long ncoKey) {
		this.ncoKey = ncoKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY")
	public CenAircraft getCenAircraftByNaircraftKey() {
		return this.cenAircraftByNaircraftKey;
	}

	public void setCenAircraftByNaircraftKey(final CenAircraft cenAircraftByNaircraftKey) {
		this.cenAircraftByNaircraftKey = cenAircraftByNaircraftKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY_OLD")
	public CenAircraft getCenAircraftByNaircraftKeyOld() {
		return this.cenAircraftByNaircraftKeyOld;
	}

	public void setCenAircraftByNaircraftKeyOld(final CenAircraft cenAircraftByNaircraftKeyOld) {
		this.cenAircraftByNaircraftKeyOld = cenAircraftByNaircraftKeyOld;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_TYPE_KEY_OLD")
	public CenHandlingTypes getCenHandlingTypesByNhandlingTypeKeyOld() {
		return this.cenHandlingTypesByNhandlingTypeKeyOld;
	}

	public void setCenHandlingTypesByNhandlingTypeKeyOld(final CenHandlingTypes cenHandlingTypesByNhandlingTypeKeyOld) {
		this.cenHandlingTypesByNhandlingTypeKeyOld = cenHandlingTypesByNhandlingTypeKeyOld;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_TYPE_KEY")
	public CenHandlingTypes getCenHandlingTypesByNhandlingTypeKey() {
		return this.cenHandlingTypesByNhandlingTypeKey;
	}

	public void setCenHandlingTypesByNhandlingTypeKey(final CenHandlingTypes cenHandlingTypesByNhandlingTypeKey) {
		this.cenHandlingTypesByNhandlingTypeKey = cenHandlingTypesByNhandlingTypeKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFLIGHT_BOX_TYPE_KEY")
	public SysPpsFlightBoxType getSysPpsFlightBoxType() {
		return this.sysPpsFlightBoxType;
	}

	public void setSysPpsFlightBoxType(final SysPpsFlightBoxType sysPpsFlightBoxType) {
		this.sysPpsFlightBoxType = sysPpsFlightBoxType;
	}

	@Column(name = "NRESULT_KEY_GROUP", nullable = false, precision = 12, scale = 0)
	public long getNresultKeyGroup() {
		return this.nresultKeyGroup;
	}

	public void setNresultKeyGroup(final long nresultKeyGroup) {
		this.nresultKeyGroup = nresultKeyGroup;
	}

	@Column(name = "CCOMMENT")
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAC_CHANGE", precision = 1, scale = 0)
	public Integer getNacChange() {
		return this.nacChange;
	}

	public void setNacChange(final Integer nacChange) {
		this.nacChange = nacChange;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DAC_CHANGE", length = 7)
	public Date getDacChange() {
		return this.dacChange;
	}

	public void setDacChange(final Date dacChange) {
		this.dacChange = dacChange;
	}

	@Column(name = "NFLIGHT_CLOSED", precision = 1, scale = 0)
	public Integer getNflightClosed() {
		return this.nflightClosed;
	}

	public void setNflightClosed(final Integer nflightClosed) {
		this.nflightClosed = nflightClosed;
	}

	@Column(name = "NINCL_GEN", precision = 1, scale = 0)
	public Integer getNinclGen() {
		return this.ninclGen;
	}

	public void setNinclGen(final Integer ninclGen) {
		this.ninclGen = ninclGen;
	}

	@Column(name = "CLOADINGLIST", length = 18)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCX", length = 7)
	public Date getDcx() {
		return this.dcx;
	}

	public void setDcx(final Date dcx) {
		this.dcx = dcx;
	}

	@Column(name = "NOBJECT_STATE_KEY", precision = 12, scale = 0)
	public Long getNobjectStateKey() {
		return this.nobjectStateKey;
	}

	public void setNobjectStateKey(final Long nobjectStateKey) {
		this.nobjectStateKey = nobjectStateKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DRAMP_TIME", length = 7)
	public Date getDrampTime() {
		return this.drampTime;
	}

	public void setDrampTime(final Date drampTime) {
		this.drampTime = drampTime;
	}

	@Column(name = "NPREPRODUCED", precision = 1, scale = 0)
	public Integer getNpreproduced() {
		return this.npreproduced;
	}

	public void setNpreproduced(final Integer npreproduced) {
		this.npreproduced = npreproduced;
	}

	@Column(name = "CCONFIGURATION", length = 20)
	public String getCconfiguration() {
		return this.cconfiguration;
	}

	public void setCconfiguration(final String cconfiguration) {
		this.cconfiguration = cconfiguration;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDELAYED", length = 7)
	public Date getDdelayed() {
		return this.ddelayed;
	}

	public void setDdelayed(final Date ddelayed) {
		this.ddelayed = ddelayed;
	}

	@Column(name = "CACTION", length = 20)
	public String getCaction() {
		return this.caction;
	}

	public void setCaction(final String caction) {
		this.caction = caction;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DREQ", length = 7)
	public Date getDreq() {
		return this.dreq;
	}

	public void setDreq(final Date dreq) {
		this.dreq = dreq;
	}

	@Column(name = "NGEN_PRIO", nullable = false, precision = 2, scale = 0)
	public int getNgenPrio() {
		return this.ngenPrio;
	}

	public void setNgenPrio(final int ngenPrio) {
		this.ngenPrio = ngenPrio;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPpsCateringOrder")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

}
