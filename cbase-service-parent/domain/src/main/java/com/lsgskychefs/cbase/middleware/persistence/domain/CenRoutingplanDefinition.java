package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19-Jul-2024 13:38:12 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_ROUTINGPLAN_DEFINITION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_ROUTINGPLAN_DEFINITION")
public class CenRoutingplanDefinition implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nroutingplanIndex;
	private String cclient;
	private String ctext;
	private String cdescription;
	private long nairlineKey;
	private Date dvalidFrom;
	private Date dvalidTo;
	private Integer nownerId;
	private Integer ncharter;
	private int ncfs;
	private int ncfsPacketclass;
	private Integer ncfsWithoutFlightplan;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Set<CenRoutingplan> cenRoutingplans = new HashSet<>(0);

	@Id
	@Column(name = "NROUTINGPLAN_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNroutingplanIndex() {
		return this.nroutingplanIndex;
	}

	public void setNroutingplanIndex(long nroutingplanIndex) {
		this.nroutingplanIndex = nroutingplanIndex;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NCHARTER", precision = 1, scale = 0)
	public Integer getNcharter() {
		return this.ncharter;
	}

	public void setNcharter(Integer ncharter) {
		this.ncharter = ncharter;
	}

	@Column(name = "NCFS", nullable = false, precision = 1, scale = 0)
	public int getNcfs() {
		return this.ncfs;
	}

	public void setNcfs(int ncfs) {
		this.ncfs = ncfs;
	}

	@Column(name = "NCFS_PACKETCLASS", nullable = false, precision = 1, scale = 0)
	public int getNcfsPacketclass() {
		return this.ncfsPacketclass;
	}

	public void setNcfsPacketclass(int ncfsPacketclass) {
		this.ncfsPacketclass = ncfsPacketclass;
	}

	@Column(name = "NCFS_WITHOUT_FLIGHTPLAN", precision = 1, scale = 0)
	public Integer getNcfsWithoutFlightplan() {
		return this.ncfsWithoutFlightplan;
	}

	public void setNcfsWithoutFlightplan(Integer ncfsWithoutFlightplan) {
		this.ncfsWithoutFlightplan = ncfsWithoutFlightplan;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRoutingplanDefinition")
	public Set<CenRoutingplan> getCenRoutingplans() {
		return this.cenRoutingplans;
	}

	public void setCenRoutingplans(Set<CenRoutingplan> cenRoutingplans) {
		this.cenRoutingplans = cenRoutingplans;
	}

}
