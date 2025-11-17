package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 20, 2024 2:58:31 PM by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_MP_TEAMS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_TEAMS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenMpTeams extends AuditableDomainObject {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmpTeamKey;
	private String cname;

	private Set<CenMpWorkstationTeam> cenMpWorkstationTeams = new HashSet<>(0);

	@JsonIgnore
	private List<CenMpProject> cenMpProjects = new ArrayList<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_TEAMS")
	@SequenceGenerator(name = "SEQ_CEN_MP_TEAMS", sequenceName = "SEQ_CEN_MP_TEAMS", allocationSize = 1)
	@Column(name = "NMP_TEAM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpTeamKey() {
		return this.nmpTeamKey;
	}

	public void setNmpTeamKey(long nmpTeamKey) {
		this.nmpTeamKey = nmpTeamKey;
	}

	@Column(name = "CNAME", nullable = false, length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMpTeams")
	public Set<CenMpWorkstationTeam> getCenMpWorkstationTeams() {
		return this.cenMpWorkstationTeams;
	}

	public void setCenMpWorkstationTeams(
			Set<CenMpWorkstationTeam> cenMpWorkstationTeams) {
		this.cenMpWorkstationTeams = cenMpWorkstationTeams;
	}

}


