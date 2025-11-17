package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 06.08.2018 11:18:01 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table TEST_ROB_ORDER_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "TEST_ROB_ORDER_DETAIL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class TestRobOrderDetail implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long norderDetailKey;

	private TestRobOrder testRobOrder;

	private TestRobMeal testRobMeal;

	private String cremark;

	private Date ddeliveryTime;

	private int ndone;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_TEST_ROB_ORDER_DETAIL")
	@SequenceGenerator(name = "SEQ_TEST_ROB_ORDER_DETAIL", sequenceName = "SEQ_TEST_ROB_ORDER_DETAIL", allocationSize = 1)
	@Column(name = "NORDER_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNorderDetailKey() {
		return this.norderDetailKey;
	}

	public void setNorderDetailKey(final long norderDetailKey) {
		this.norderDetailKey = norderDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NORDER_KEY", nullable = false)
	@JsonView(View.SpecialRelation.class)
	public TestRobOrder getTestRobOrder() {
		return this.testRobOrder;
	}

	public void setTestRobOrder(final TestRobOrder testRobOrder) {
		this.testRobOrder = testRobOrder;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMEAL_KEY", nullable = false)
	public TestRobMeal getTestRobMeal() {
		return this.testRobMeal;
	}

	public void setTestRobMeal(final TestRobMeal testRobMeal) {
		this.testRobMeal = testRobMeal;
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

	@Column(name = "NDONE", nullable = false, precision = 1, scale = 0)
	public int getNdone() {
		return this.ndone;
	}

	public void setNdone(final int ndone) {
		this.ndone = ndone;
	}
}
