package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 21.03.2019 07:16:43 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_WASTAGE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_WASTAGE")
public class CenOutPpmWastage implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmWastageKey;
	private long nresultKey;
	private String cunit;
	private Date ddeparture;
	private String cairline;
	private int nflightNumber;
	private String csuffix;
	private long npackinglistIndexKey;
	private long npackinglistDetailKey;
	private String cpackinglist;
	private String ctext;
	private BigDecimal nquantity;
	private long nshortagewastageKey;
	private String cswReason;
	private BigDecimal nfoodCost;
	private String cuser;
	private String cverificationUser;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_WASTAGE")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_WASTAGE", sequenceName = "SEQ_CEN_OUT_PPM_WASTAGE", allocationSize = 1)
	@Column(name = "NPPM_WASTAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmWastageKey() {
		return this.nppmWastageKey;
	}

	public void setNppmWastageKey(final long nppmWastageKey) {
		this.nppmWastageKey = nppmWastageKey;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", nullable = false, length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NSHORTAGEWASTAGE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNshortagewastageKey() {
		return this.nshortagewastageKey;
	}

	public void setNshortagewastageKey(final long nshortagewastageKey) {
		this.nshortagewastageKey = nshortagewastageKey;
	}

	@Column(name = "CSW_REASON", nullable = false, length = 50)
	public String getCswReason() {
		return this.cswReason;
	}

	public void setCswReason(final String cswReason) {
		this.cswReason = cswReason;
	}

	@Column(name = "NFOOD_COST", nullable = false, precision = 12, scale = 4)
	public BigDecimal getNfoodCost() {
		return this.nfoodCost;
	}

	public void setNfoodCost(final BigDecimal nfoodCost) {
		this.nfoodCost = nfoodCost;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CVERIFICATION_USER", nullable = false, length = 40)
	public String getCverificationUser() {
		return this.cverificationUser;
	}

	public void setCverificationUser(final String cverificationUser) {
		this.cverificationUser = cverificationUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
