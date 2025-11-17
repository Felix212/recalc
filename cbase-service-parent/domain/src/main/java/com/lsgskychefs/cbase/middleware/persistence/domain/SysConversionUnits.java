package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 11, 2020 4:44:58 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_CONVERSION_UNITS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_CONVERSION_UNITS")
public class SysConversionUnits implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsysConvUnitKey;
	private String cunitSource;
	private String cunitNameSource;
	private String csourceType;
	private String ccategory;
	private String cunitTarget;
	private String cunitNameTarget;
	private BigDecimal nconversionFactor;
	private Integer ndefault;
	private Date dtimestampModification;

	@Id
	@Column(name = "NSYS_CONV_UNIT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsysConvUnitKey() {
		return this.nsysConvUnitKey;
	}

	public void setNsysConvUnitKey(final long nsysConvUnitKey) {
		this.nsysConvUnitKey = nsysConvUnitKey;
	}

	@Column(name = "CUNIT_SOURCE", nullable = false, length = 5)
	public String getCunitSource() {
		return this.cunitSource;
	}

	public void setCunitSource(final String cunitSource) {
		this.cunitSource = cunitSource;
	}

	@Column(name = "CUNIT_NAME_SOURCE", nullable = false, length = 40)
	public String getCunitNameSource() {
		return this.cunitNameSource;
	}

	public void setCunitNameSource(final String cunitNameSource) {
		this.cunitNameSource = cunitNameSource;
	}

	@Column(name = "CSOURCE_TYPE", nullable = false, length = 1)
	public String getCsourceType() {
		return this.csourceType;
	}

	public void setCsourceType(final String csourceType) {
		this.csourceType = csourceType;
	}

	@Column(name = "CCATEGORY", nullable = false, length = 1)
	public String getCcategory() {
		return this.ccategory;
	}

	public void setCcategory(final String ccategory) {
		this.ccategory = ccategory;
	}

	@Column(name = "CUNIT_TARGET", nullable = false, length = 5)
	public String getCunitTarget() {
		return this.cunitTarget;
	}

	public void setCunitTarget(final String cunitTarget) {
		this.cunitTarget = cunitTarget;
	}

	@Column(name = "CUNIT_NAME_TARGET", nullable = false, length = 40)
	public String getCunitNameTarget() {
		return this.cunitNameTarget;
	}

	public void setCunitNameTarget(final String cunitNameTarget) {
		this.cunitNameTarget = cunitNameTarget;
	}

	@Column(name = "NCONVERSION_FACTOR", nullable = false, precision = 14, scale = 8)
	public BigDecimal getNconversionFactor() {
		return this.nconversionFactor;
	}

	public void setNconversionFactor(final BigDecimal nconversionFactor) {
		this.nconversionFactor = nconversionFactor;
	}

	@Column(name = "NDEFAULT", precision = 1, scale = 0)
	public Integer getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final Integer ndefault) {
		this.ndefault = ndefault;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

}
