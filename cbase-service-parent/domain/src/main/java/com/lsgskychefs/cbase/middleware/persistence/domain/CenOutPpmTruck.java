package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.08.2018 07:28:57 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_TRUCK
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_TRUCK", uniqueConstraints = @UniqueConstraint(columnNames = { "NRESULT_KEY", "NGALLEY_GROUP" }))
public class CenOutPpmTruck implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmtruckKey;
	private long nresultKey;
	private int ngalleyGroup;
	private String ctruck;
	private Date dcheckStart;
	private Date dcheckStop;
	private String ccheckUser;
	private Date dloadStart;
	private Date dloadStop;
	private String cloadUser;
	private boolean nclosed;
	private BigDecimal nclosedTemp;
	private Date dclosedTime;
	private String cclosedUser;
	private String ccomment;
	@JsonIgnore
	private Set<CenOutPpm> cenOutPpms = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_TRUCK")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_TRUCK", sequenceName = "SEQ_CEN_OUT_PPM_TRUCK", allocationSize = 1)
	@Column(name = "NPPMTRUCK_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmtruckKey() {
		return this.nppmtruckKey;
	}

	public void setNppmtruckKey(final long nppmtruckKey) {
		this.nppmtruckKey = nppmtruckKey;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NGALLEY_GROUP", nullable = false, precision = 3, scale = 0)
	public int getNgalleyGroup() {
		return this.ngalleyGroup;
	}

	public void setNgalleyGroup(final int ngalleyGroup) {
		this.ngalleyGroup = ngalleyGroup;
	}

	@Column(name = "CTRUCK", length = 30)
	public String getCtruck() {
		return this.ctruck;
	}

	public void setCtruck(final String ctruck) {
		this.ctruck = ctruck;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCHECK_START", length = 7)
	public Date getDcheckStart() {
		return this.dcheckStart;
	}

	public void setDcheckStart(final Date dcheckStart) {
		this.dcheckStart = dcheckStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCHECK_STOP", length = 7)
	public Date getDcheckStop() {
		return this.dcheckStop;
	}

	public void setDcheckStop(final Date dcheckStop) {
		this.dcheckStop = dcheckStop;
	}

	@Column(name = "CCHECK_USER", length = 40)
	public String getCcheckUser() {
		return this.ccheckUser;
	}

	public void setCcheckUser(final String ccheckUser) {
		this.ccheckUser = ccheckUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLOAD_START", length = 7)
	public Date getDloadStart() {
		return this.dloadStart;
	}

	public void setDloadStart(final Date dloadStart) {
		this.dloadStart = dloadStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLOAD_STOP", length = 7)
	public Date getDloadStop() {
		return this.dloadStop;
	}

	public void setDloadStop(final Date dloadStop) {
		this.dloadStop = dloadStop;
	}

	@Column(name = "CLOAD_USER", length = 40)
	public String getCloadUser() {
		return this.cloadUser;
	}

	public void setCloadUser(final String cloadUser) {
		this.cloadUser = cloadUser;
	}

	@Column(name = "NCLOSED", nullable = false, precision = 1, scale = 0)
	public boolean isNclosed() {
		return this.nclosed;
	}

	public void setNclosed(final boolean nclosed) {
		this.nclosed = nclosed;
	}

	@Column(name = "NCLOSED_TEMP", precision = 12)
	public BigDecimal getNclosedTemp() {
		return this.nclosedTemp;
	}

	public void setNclosedTemp(final BigDecimal nclosedTemp) {
		this.nclosedTemp = nclosedTemp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCLOSED_TIME", length = 7)
	public Date getDclosedTime() {
		return this.dclosedTime;
	}

	public void setDclosedTime(final Date dclosedTime) {
		this.dclosedTime = dclosedTime;
	}

	@Column(name = "CCLOSED_USER", length = 40)
	public String getCclosedUser() {
		return this.cclosedUser;
	}

	public void setCclosedUser(final String cclosedUser) {
		this.cclosedUser = cclosedUser;
	}

	@Column(name = "CCOMMENT", length = 256)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmTruck")
	public Set<CenOutPpm> getCenOutPpms() {
		return this.cenOutPpms;
	}

	public void setCenOutPpms(final Set<CenOutPpm> cenOutPpms) {
		this.cenOutPpms = cenOutPpms;
	}

}
