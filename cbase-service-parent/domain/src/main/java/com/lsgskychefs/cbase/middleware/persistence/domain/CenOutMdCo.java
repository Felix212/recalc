package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_MD_CO (Flight event Meal-Distribution-Content). Meals on container/trolley.
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MD_CO")
public class CenOutMdCo implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMdCoId id;
	private CenOutMd cenOutMd;
	private Integer nspml;
	private Integer nquantity;
	private String cpackinglist;
	private String ctext;
	private String cremark;
	private Integer nheight;
	private Integer nwidth;
	private Long npltypeKey;
	private String cplType;
	private String cclass;
	private String cmealControlCode;
	private Long nclassNumber;
	private Long nplDistributionKey;
	private String ccreatedBy;
	private Date dcreatedDate;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "narrayCount", column = @Column(name = "NARRAY_COUNT", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nrecordCount",
					column = @Column(name = "NRECORD_COUNT", nullable = false, precision = 12, scale = 0)) })
	public CenOutMdCoId getId() {
		return this.id;
	}

	public void setId(final CenOutMdCoId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false, insertable = false,
					updatable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false, insertable = false,
					updatable = false),
			@JoinColumn(name = "NARRAY_COUNT", referencedColumnName = "NARRAY_COUNT", nullable = false, insertable = false,
					updatable = false) })
	public CenOutMd getCenOutMd() {
		return this.cenOutMd;
	}

	public void setCenOutMd(final CenOutMd cenOutMd) {
		this.cenOutMd = cenOutMd;
	}

	@Column(name = "NSPML", precision = 12, scale = 0)
	public Integer getNspml() {
		return this.nspml;
	}

	public void setNspml(final Integer nspml) {
		this.nspml = nspml;
	}

	@Column(name = "NQUANTITY", precision = 6, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NHEIGHT", precision = 6, scale = 0)
	public Integer getNheight() {
		return this.nheight;
	}

	public void setNheight(final Integer nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", precision = 6, scale = 0)
	public Integer getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final Integer nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NPLTYPE_KEY", precision = 12, scale = 0)
	public Long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final Long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "CPL_TYPE", length = 20)
	public String getCplType() {
		return this.cplType;
	}

	public void setCplType(final String cplType) {
		this.cplType = cplType;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 10)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NPL_DISTRIBUTION_KEY", precision = 12, scale = 0)
	public Long getNplDistributionKey() {
		return this.nplDistributionKey;
	}

	public void setNplDistributionKey(final Long nplDistributionKey) {
		this.nplDistributionKey = nplDistributionKey;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(final Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

}
