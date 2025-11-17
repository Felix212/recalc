package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_CALCULATOR
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_CALCULATOR")
public class SysCalculator implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** ncalcId */
	private long ncalcId;

	/** ccalc */
	private String ccalc;

	/** ctext */
	private String ctext;

	/** nenablePercentage */
	private Integer nenablePercentage;

	/** nenableValue */
	private Integer nenableValue;

	/** nenable4newspaper */
	private Integer nenable4newspaper;

	/** ccalc1 */
	private String ccalc1;

	/** ccalc2 */
	private String ccalc2;

	/** ccalc3 */
	private String ccalc3;

	/** ccalc4 */
	private String ccalc4;

	/** ctext1 */
	private String ctext1;

	/** ctext2 */
	private String ctext2;

	/** ctext3 */
	private String ctext3;

	/** ctext4 */
	private String ctext4;

	/** cshortName */
	private String cshortName;

	/** nenableMaxValue */
	private Integer nenableMaxValue;

	/** nbobFlag */
	private Integer nbobFlag;

	/** nenableMinValue */
	private BigDecimal nenableMinValue;

	/** npreorder */
	private int npreorder;

	/** nmultileg */
	private int nmultileg;

	@Id
	@Column(name = "NCALC_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcalcId() {
		return this.ncalcId;
	}

	public void setNcalcId(final long ncalcId) {
		this.ncalcId = ncalcId;
	}

	@Column(name = "CCALC", nullable = false, length = 40)
	public String getCcalc() {
		return this.ccalc;
	}

	public void setCcalc(final String ccalc) {
		this.ccalc = ccalc;
	}

	@Column(name = "CTEXT", nullable = false, length = 2000)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NENABLE_PERCENTAGE", precision = 1, scale = 0)
	public Integer getNenablePercentage() {
		return this.nenablePercentage;
	}

	public void setNenablePercentage(final Integer nenablePercentage) {
		this.nenablePercentage = nenablePercentage;
	}

	@Column(name = "NENABLE_VALUE", precision = 1, scale = 0)
	public Integer getNenableValue() {
		return this.nenableValue;
	}

	public void setNenableValue(final Integer nenableValue) {
		this.nenableValue = nenableValue;
	}

	@Column(name = "NENABLE4NEWSPAPER", precision = 1, scale = 0)
	public Integer getNenable4newspaper() {
		return this.nenable4newspaper;
	}

	public void setNenable4newspaper(final Integer nenable4newspaper) {
		this.nenable4newspaper = nenable4newspaper;
	}

	@Column(name = "CCALC1", length = 40)
	public String getCcalc1() {
		return this.ccalc1;
	}

	public void setCcalc1(final String ccalc1) {
		this.ccalc1 = ccalc1;
	}

	@Column(name = "CCALC2", length = 40)
	public String getCcalc2() {
		return this.ccalc2;
	}

	public void setCcalc2(final String ccalc2) {
		this.ccalc2 = ccalc2;
	}

	@Column(name = "CCALC3", length = 40)
	public String getCcalc3() {
		return this.ccalc3;
	}

	public void setCcalc3(final String ccalc3) {
		this.ccalc3 = ccalc3;
	}

	@Column(name = "CCALC4", length = 40)
	public String getCcalc4() {
		return this.ccalc4;
	}

	public void setCcalc4(final String ccalc4) {
		this.ccalc4 = ccalc4;
	}

	@Column(name = "CTEXT1", length = 2000)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", length = 2000)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 2000)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", length = 2000)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

	@Column(name = "CSHORT_NAME", length = 10)
	public String getCshortName() {
		return this.cshortName;
	}

	public void setCshortName(final String cshortName) {
		this.cshortName = cshortName;
	}

	@Column(name = "NENABLE_MAX_VALUE", precision = 1, scale = 0)
	public Integer getNenableMaxValue() {
		return this.nenableMaxValue;
	}

	public void setNenableMaxValue(final Integer nenableMaxValue) {
		this.nenableMaxValue = nenableMaxValue;
	}

	@Column(name = "NBOB_FLAG", precision = 1, scale = 0)
	public Integer getNbobFlag() {
		return this.nbobFlag;
	}

	public void setNbobFlag(final Integer nbobFlag) {
		this.nbobFlag = nbobFlag;
	}

	@Column(name = "NENABLE_MIN_VALUE", nullable = false, precision = 22, scale = 0)
	public BigDecimal getNenableMinValue() {
		return this.nenableMinValue;
	}

	public void setNenableMinValue(final BigDecimal nenableMinValue) {
		this.nenableMinValue = nenableMinValue;
	}

	@Column(name = "NPREORDER", nullable = false, precision = 1, scale = 0)
	public int getNpreorder() {
		return this.npreorder;
	}

	public void setNpreorder(final int npreorder) {
		this.npreorder = npreorder;
	}

	@Column(name = "NMULTILEG", nullable = false, precision = 1, scale = 0)
	public int getNmultileg() {
		return this.nmultileg;
	}

	public void setNmultileg(final int nmultileg) {
		this.nmultileg = nmultileg;
	}

}
