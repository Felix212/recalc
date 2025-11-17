package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 06.08.2018 11:18:01 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table TEST_ROB_MEAL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "TEST_ROB_MEAL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class TestRobMeal implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmealKey;

	private String ctext;

	private String cdescription;

	private String callergenInfo;

	private byte[] bpicture;

	private Set<TestRobOrderDetail> testRobOrderDetails = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_TEST_ROB_MEAL")
	@SequenceGenerator(name = "SEQ_TEST_ROB_MEAL", sequenceName = "SEQ_TEST_ROB_MEAL", allocationSize = 1)
	@Column(name = "NMEAL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmealKey() {
		return this.nmealKey;
	}

	public void setNmealKey(final long nmealKey) {
		this.nmealKey = nmealKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 256)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 2048)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CALLERGEN_INFO", length = 2048)
	public String getCallergenInfo() {
		return this.callergenInfo;
	}

	public void setCallergenInfo(final String callergenInfo) {
		this.callergenInfo = callergenInfo;
	}

	@Column(name = "BPICTURE")
	@JsonView(View.Full.class)
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "testRobMeal")
	@JsonIgnore
	public Set<TestRobOrderDetail> getTestRobOrderDetails() {
		return this.testRobOrderDetails;
	}

	public void setTestRobOrderDetails(final Set<TestRobOrderDetail> testRobOrderDetails) {
		this.testRobOrderDetails = testRobOrderDetails;
	}

}
