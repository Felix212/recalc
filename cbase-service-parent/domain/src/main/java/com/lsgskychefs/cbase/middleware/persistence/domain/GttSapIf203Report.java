package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.06.2016 16:17:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table GTT_SAP_IF203_REPORT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "GTT_SAP_IF203_REPORT")
public class GttSapIf203Report implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsapIf203ReportKey;
	private String citem;
	private String citemText;
	private String cunit;
	private String cpackinglist;
	private String cpackinglistText;
	private BigDecimal nquantityTotal;
	private BigDecimal nquantity1;
	private BigDecimal nquantity2;
	private BigDecimal nquantity3;
	private BigDecimal nquantity4;
	private BigDecimal nquantity5;
	private BigDecimal nquantity6;
	private BigDecimal nquantity7;

	@Id
	@Column(name = "NSAP_IF203_REPORT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsapIf203ReportKey() {
		return this.nsapIf203ReportKey;
	}

	public void setNsapIf203ReportKey(final long nsapIf203ReportKey) {
		this.nsapIf203ReportKey = nsapIf203ReportKey;
	}

	@Column(name = "CITEM", length = 18)
	public String getCitem() {
		return this.citem;
	}

	public void setCitem(final String citem) {
		this.citem = citem;
	}

	@Column(name = "CITEM_TEXT", length = 80)
	public String getCitemText() {
		return this.citemText;
	}

	public void setCitemText(final String citemText) {
		this.citemText = citemText;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CPACKINGLIST_TEXT", length = 80)
	public String getCpackinglistText() {
		return this.cpackinglistText;
	}

	public void setCpackinglistText(final String cpackinglistText) {
		this.cpackinglistText = cpackinglistText;
	}

	@Column(name = "NQUANTITY_TOTAL", precision = 15, scale = 3)
	public BigDecimal getNquantityTotal() {
		return this.nquantityTotal;
	}

	public void setNquantityTotal(final BigDecimal nquantityTotal) {
		this.nquantityTotal = nquantityTotal;
	}

	@Column(name = "NQUANTITY1", precision = 15, scale = 3)
	public BigDecimal getNquantity1() {
		return this.nquantity1;
	}

	public void setNquantity1(final BigDecimal nquantity1) {
		this.nquantity1 = nquantity1;
	}

	@Column(name = "NQUANTITY2", precision = 15, scale = 3)
	public BigDecimal getNquantity2() {
		return this.nquantity2;
	}

	public void setNquantity2(final BigDecimal nquantity2) {
		this.nquantity2 = nquantity2;
	}

	@Column(name = "NQUANTITY3", precision = 15, scale = 3)
	public BigDecimal getNquantity3() {
		return this.nquantity3;
	}

	public void setNquantity3(final BigDecimal nquantity3) {
		this.nquantity3 = nquantity3;
	}

	@Column(name = "NQUANTITY4", precision = 15, scale = 3)
	public BigDecimal getNquantity4() {
		return this.nquantity4;
	}

	public void setNquantity4(final BigDecimal nquantity4) {
		this.nquantity4 = nquantity4;
	}

	@Column(name = "NQUANTITY5", precision = 15, scale = 3)
	public BigDecimal getNquantity5() {
		return this.nquantity5;
	}

	public void setNquantity5(final BigDecimal nquantity5) {
		this.nquantity5 = nquantity5;
	}

	@Column(name = "NQUANTITY6", precision = 15, scale = 3)
	public BigDecimal getNquantity6() {
		return this.nquantity6;
	}

	public void setNquantity6(final BigDecimal nquantity6) {
		this.nquantity6 = nquantity6;
	}

	@Column(name = "NQUANTITY7", precision = 15, scale = 3)
	public BigDecimal getNquantity7() {
		return this.nquantity7;
	}

	public void setNquantity7(final BigDecimal nquantity7) {
		this.nquantity7 = nquantity7;
	}

}
