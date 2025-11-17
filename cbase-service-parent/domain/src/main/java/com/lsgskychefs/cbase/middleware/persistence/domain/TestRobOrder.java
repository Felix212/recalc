package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 06.08.2018 11:18:01 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table TEST_ROB_ORDER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "TEST_ROB_ORDER")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class TestRobOrder implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long norderKey;

	private String cseat;

	private String cguest;

	private Date dtimestamp;

	private Set<TestRobOrderDetail> testRobOrderDetails = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_TEST_ROB_ORDER")
	@SequenceGenerator(name = "SEQ_TEST_ROB_ORDER", sequenceName = "SEQ_TEST_ROB_ORDER", allocationSize = 1)
	@Column(name = "NORDER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNorderKey() {
		return this.norderKey;
	}

	public void setNorderKey(final long norderKey) {
		this.norderKey = norderKey;
	}

	@Column(name = "CSEAT", nullable = false, length = 4)
	public String getCseat() {
		return this.cseat;
	}

	public void setCseat(final String cseat) {
		this.cseat = cseat;
	}

	@Column(name = "CGUEST", nullable = false, length = 256)
	public String getCguest() {
		return cguest;
	}

	public void setCguest(final String cguest) {
		this.cguest = cguest;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "testRobOrder")
	@JsonView(View.SimpleWithReferences.class)
	public Set<TestRobOrderDetail> getTestRobOrderDetails() {
		return this.testRobOrderDetails;
	}

	public void setTestRobOrderDetails(final Set<TestRobOrderDetail> testRobOrderDetails) {
		this.testRobOrderDetails = testRobOrderDetails;
	}

}
