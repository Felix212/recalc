package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 05.07.2016 12:57:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_ROUTING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_ROUTING")
public class CenRouting implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nroutingId;
	private String cclient;
	private String crouting;
	private String croutingText;
	private Set<LocUnitTimes> locUnitTimeses = new HashSet<>(0);

	@Id
	@Column(name = "NROUTING_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNroutingId() {
		return this.nroutingId;
	}

	public void setNroutingId(final long nroutingId) {
		this.nroutingId = nroutingId;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CROUTING", nullable = false, length = 5)
	public String getCrouting() {
		return this.crouting;
	}

	public void setCrouting(final String crouting) {
		this.crouting = crouting;
	}

	@Column(name = "CROUTING_TEXT", nullable = false, length = 15)
	public String getCroutingText() {
		return this.croutingText;
	}

	public void setCroutingText(final String croutingText) {
		this.croutingText = croutingText;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRouting")
	public Set<LocUnitTimes> getLocUnitTimeses() {
		return this.locUnitTimeses;
	}

	public void setLocUnitTimeses(final Set<LocUnitTimes> locUnitTimeses) {
		this.locUnitTimeses = locUnitTimeses;
	}

}
