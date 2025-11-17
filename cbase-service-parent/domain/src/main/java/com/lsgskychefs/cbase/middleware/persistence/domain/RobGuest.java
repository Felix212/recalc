package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table ROB_GUEST
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_GUEST")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobGuest implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nguestKey;

	private String cname;

	private String cseat;

	private Set<RobSurvey> robSurveys = new HashSet<>(0);

	private Set<RobOrder> robOrders = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_GUEST")
	@SequenceGenerator(name = "SEQ_ROB_GUEST", sequenceName = "SEQ_ROB_GUEST", allocationSize = 1)
	@Column(name = "NGUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNguestKey() {
		return this.nguestKey;
	}

	public void setNguestKey(final long nguestKey) {
		this.nguestKey = nguestKey;
	}

	@Column(name = "CNAME", nullable = false, length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CSEAT", nullable = false, length = 4)
	public String getCseat() {
		return this.cseat;
	}

	public void setCseat(final String cseat) {
		this.cseat = cseat;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robGuest")
	@JsonView(View.SimpleWithReferences.class)
	public Set<RobSurvey> getRobSurveys() {
		return this.robSurveys;
	}

	public void setRobSurveys(final Set<RobSurvey> robSurveys) {
		this.robSurveys = robSurveys;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robGuest")
	@JsonView(View.SimpleWithReferences.class)
	public Set<RobOrder> getRobOrders() {
		return this.robOrders;
	}

	public void setRobOrders(final Set<RobOrder> robOrders) {
		this.robOrders = robOrders;
	}

}
