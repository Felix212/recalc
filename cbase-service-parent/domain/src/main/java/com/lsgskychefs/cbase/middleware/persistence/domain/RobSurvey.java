package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table ROB_SURVEY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_SURVEY")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobSurvey implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsurveyKey;

	private RobGuest robGuest;

	private RobOrder robOrder;

	private BigDecimal nrating;

	private String cremark;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_SURVEY")
	@SequenceGenerator(name = "SEQ_ROB_SURVEY", sequenceName = "SEQ_ROB_SURVEY", allocationSize = 1)
	@Column(name = "NSURVEY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsurveyKey() {
		return this.nsurveyKey;
	}

	public void setNsurveyKey(final long nsurveyKey) {
		this.nsurveyKey = nsurveyKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGUEST_KEY", nullable = false)
	public RobGuest getRobGuest() {
		return this.robGuest;
	}

	public void setRobGuest(final RobGuest robGuest) {
		this.robGuest = robGuest;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NORDER_KEY")
	public RobOrder getRobOrder() {
		return this.robOrder;
	}

	public void setRobOrder(final RobOrder robOrder) {
		this.robOrder = robOrder;
	}

	@Column(name = "NRATING", nullable = false, precision = 1, scale = 1)
	public BigDecimal getNrating() {
		return this.nrating;
	}

	public void setNrating(final BigDecimal nrating) {
		this.nrating = nrating;
	}

	@Column(name = "CREMARK", length = 2048)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

}
