package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.05.2016 09:45:22 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseLabelPrintStatus;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseLabelType;
import com.lsgskychefs.cbase.middleware.persistence.constant.RemotePrinterFunctionJobSubType;

/**
 * Entity(DomainObject) for table GTT_PARAMETER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "GTT_PARAMETER")
public class GttParameter implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nparmKey;

	private String cparmName;

	private Long nparmNumber;

	private String cparmVarchar2;

	private Date dparmDate;

	private Long nparmNumber2;

	private Long nparmNumber3;

	private Long nparmNumber4;

	private Long nparmNumber5;

	private Long nparmNumber6;

	private Long nparmNumber7;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_GTT_PARAMETER")
	@SequenceGenerator(name = "SEQ_GTT_PARAMETER", sequenceName = "SEQ_GTT_PARAMETER", allocationSize = 1)
	@Column(name = "NPARM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNparmKey() {
		return this.nparmKey;
	}

	public void setNparmKey(final long nparmKey) {
		this.nparmKey = nparmKey;
	}

	@Column(name = "CPARM_NAME", length = 30)
	public String getCparmName() {
		return this.cparmName;
	}

	public void setCparmName(final String cparmName) {
		this.cparmName = cparmName;
	}

	@Column(name = "NPARM_NUMBER", precision = 12, scale = 0)
	public Long getNparmNumber() {
		return this.nparmNumber;
	}

	public void setNparmNumber(final Long nparmNumber) {
		this.nparmNumber = nparmNumber;
	}

	@Column(name = "CPARM_VARCHAR2", length = 4000)
	public String getCparmVarchar2() {
		return this.cparmVarchar2;
	}

	public void setCparmVarchar2(final String cparmVarchar2) {
		this.cparmVarchar2 = cparmVarchar2;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPARM_DATE", length = 7)
	public Date getDparmDate() {
		return this.dparmDate;
	}

	public void setDparmDate(final Date dparmDate) {
		this.dparmDate = dparmDate;
	}

	@Column(name = "NPARM_NUMBER2", precision = 12, scale = 0)
	public Long getNparmNumber2() {
		return this.nparmNumber2;
	}

	public void setNparmNumber2(final Long nparmNumber2) {
		this.nparmNumber2 = nparmNumber2;
	}

	@Column(name = "NPARM_NUMBER3", precision = 12, scale = 0)
	public Long getNparmNumber3() {
		return this.nparmNumber3;
	}

	public void setNparmNumber3(final Long nparmNumber3) {
		this.nparmNumber3 = nparmNumber3;
	}

	@Column(name = "NPARM_NUMBER4", precision = 12, scale = 0)
	public Long getNparmNumber4() {
		return this.nparmNumber4;
	}

	public void setNparmNumber4(final Long nparmNumber4) {
		this.nparmNumber4 = nparmNumber4;
	}

	@Column(name = "NPARM_NUMBER5", precision = 12, scale = 0)
	public Long getNparmNumber5() {
		return this.nparmNumber5;
	}

	public void setNparmNumber5(final Long nparmNumber5) {
		this.nparmNumber5 = nparmNumber5;
	}

	@Column(name = "NPARM_NUMBER6", precision = 12, scale = 0)
	public Long getNparmNumber6() {
		return this.nparmNumber6;
	}

	public void setNparmNumber6(final Long nparmNumber6) {
		this.nparmNumber6 = nparmNumber6;
	}

	@Column(name = "NPARM_NUMBER7", precision = 12, scale = 0)
	public Long getNparmNumber7() {
		return this.nparmNumber7;
	}

	public void setNparmNumber7(final Long nparmNumber7) {
		this.nparmNumber7 = nparmNumber7;
	}

	@Transient
	public CbaseLabelType getLabelType() {
		return CbaseLabelType.getEnum(getNparmNumber3().intValue());
	}

	@Transient
	public RemotePrinterFunctionJobSubType getSubType() {
		final int subTypeNumber = getNparmNumber7() == null ? 0 : getNparmNumber7().intValue();
		return RemotePrinterFunctionJobSubType.getEnum(subTypeNumber);
	}

	@Transient
	public CbaseLabelPrintStatus getLabelPrintStatus() {
		final int statusNumber = getNparmNumber4() == null ? -1 : getNparmNumber4().intValue();
		return CbaseLabelPrintStatus.getEnum(statusNumber);
	}

	@Transient
	public boolean isSpmlLabel() {
		return getLabelType() == CbaseLabelType.SPML_LABEL || getLabelType() == CbaseLabelType.SPML_CO_LABEL;
	}

	@Transient
	public boolean isProdLabel() {
		return getLabelType() == CbaseLabelType.PROD_LABEL1 || getLabelType() == CbaseLabelType.PROD_LABEL2;
	}

	@Transient
	public boolean isFlightLabel() {
		return getLabelType() == CbaseLabelType.FLIGHT_LABEL;
	}
	@Transient
	public boolean isBellyLabel() {
		return isFlightLabel() && getSubType() == RemotePrinterFunctionJobSubType.FLIGHT_LABEL_BELLY;
	}
	@Transient
	public boolean isCartDiagramLabel() {
		return getLabelType() == CbaseLabelType.CART_DIAGRAM;
	}

	@Transient
	public Long getLabelTypeKey() {
		return getNparmNumber() == null ? -1L : getNparmNumber();
	}

	@Transient
	public Long getStowageKey() {
		return !isCartDiagramLabel() || getNparmNumber2() == null ? -1L : getNparmNumber2();
	}

	@Transient
	public Long getDetailKey() {
		return !isSpmlLabel() || getNparmNumber2() == null ? -1L : getNparmNumber2();
	}

	@Transient
	public Long getBatchSeq() {
		return !isProdLabel() || getNparmNumber2() == null ? -1L : getNparmNumber2();
	}

	@Transient
	public Long getResultKey() {
		return isSpmlLabel() || getNparmNumber5() == null ? -1L : getNparmNumber5();
	}

	@Transient
	public Long getSpmlQuantity() {
		return !isSpmlLabel() || getNparmNumber5() == null ? -1L : getNparmNumber5();
	}

	@Transient
	public Long getTransaction() {
		return getNparmNumber6() == null ? -1L : getNparmNumber6();
	}
}
