package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.RobOrderStatus;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table ROB_ORDER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_ORDER")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobOrder implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long norderKey;

	private RobProduct robProduct;

	private RobGuest robGuest;

	private int norderGroup;

	private String cremark;

	private Date ddeliveryTime;

	private RobOrderStatus nstatus;

	private Date dtimestamp;

	private Set<RobSurvey> robSurveys = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ROB_ORDER")
	@SequenceGenerator(name = "SEQ_ROB_ORDER", sequenceName = "SEQ_ROB_ORDER", allocationSize = 1)
	@Column(name = "NORDER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNorderKey() {
		return this.norderKey;
	}

	public void setNorderKey(final long norderKey) {
		this.norderKey = norderKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRODUCT_KEY", nullable = false)
	public RobProduct getRobProduct() {
		return this.robProduct;
	}

	public void setRobProduct(final RobProduct robProduct) {
		this.robProduct = robProduct;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGUEST_KEY", nullable = false)
	@JsonView(View.SpecialRelation.class)
	public RobGuest getRobGuest() {
		return this.robGuest;
	}

	public void setRobGuest(final RobGuest robGuest) {
		this.robGuest = robGuest;
	}

	@Column(name = "NORDER_GROUP", nullable = false, precision = 2, scale = 0)
	public int getNorderGroup() {
		return this.norderGroup;
	}

	public void setNorderGroup(final int norderGroup) {
		this.norderGroup = norderGroup;
	}

	@Column(name = "CREMARK", length = 2048)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDELIVERY_TIME", length = 7)
	public Date getDdeliveryTime() {
		return this.ddeliveryTime;
	}

	public void setDdeliveryTime(final Date ddeliveryTime) {
		this.ddeliveryTime = ddeliveryTime;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 1, scale = 0)
	public RobOrderStatus getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final RobOrderStatus nstatus) {
		this.nstatus = nstatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robOrder")
	public Set<RobSurvey> getRobSurveys() {
		return this.robSurveys;
	}

	public void setRobSurveys(final Set<RobSurvey> robSurveys) {
		this.robSurveys = robSurveys;
	}

}
