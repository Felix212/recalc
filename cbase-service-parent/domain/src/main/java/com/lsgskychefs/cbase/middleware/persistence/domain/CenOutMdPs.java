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
 * Entity(DomainObject) for table CEN_OUT_MD_PS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MD_PS")
public class CenOutMdPs implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMdPsId id;
	private CenOutMd cenOutMd;
	private Long nplDistributionKey;
	private Long npackinglistIndexKey;
	private Long npackinglistDetailKey;
	private Long npltypeKey;
	private String cmealControlCode;
	private Long nheight;
	private Long nwidth;
	private Integer nquantity;
	private String cpackinglist;
	private Long ndistributionDetailKey;
	private String ctext;
	private Integer nlimit;
	private Integer nlimitSpml;
	private Integer nrestHeight;
	private Integer nrestWidth;
	private String cmealControlCode2;
	private Integer ndisable2ndDistribution;
	private String ccreatedBy;
	private Date dcreatedDate;
	private String cmealControlCode3;
	private String cmealControlCode4;
	private String cmealControlCode5;
	private String cmealControlCode6;
	private String cmealControlCode7;
	private String cmealControlCode8;
	private String cmealControlCode9;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "narrayCount", column = @Column(name = "NARRAY_COUNT", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nrecordCount",
					column = @Column(name = "NRECORD_COUNT", nullable = false, precision = 12, scale = 0)) })
	public CenOutMdPsId getId() {
		return this.id;
	}

	public void setId(final CenOutMdPsId id) {
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

	@Column(name = "NPL_DISTRIBUTION_KEY", precision = 12, scale = 0)
	public Long getNplDistributionKey() {
		return this.nplDistributionKey;
	}

	public void setNplDistributionKey(final Long nplDistributionKey) {
		this.nplDistributionKey = nplDistributionKey;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "NPLTYPE_KEY", precision = 12, scale = 0)
	public Long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final Long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 5)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NHEIGHT", precision = 12, scale = 0)
	public Long getNheight() {
		return this.nheight;
	}

	public void setNheight(final Long nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", precision = 12, scale = 0)
	public Long getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final Long nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NQUANTITY", precision = 6, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CPACKINGLIST", length = 30)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NDISTRIBUTION_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNdistributionDetailKey() {
		return this.ndistributionDetailKey;
	}

	public void setNdistributionDetailKey(final Long ndistributionDetailKey) {
		this.ndistributionDetailKey = ndistributionDetailKey;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NLIMIT", precision = 6, scale = 0)
	public Integer getNlimit() {
		return this.nlimit;
	}

	public void setNlimit(final Integer nlimit) {
		this.nlimit = nlimit;
	}

	@Column(name = "NLIMIT_SPML", precision = 6, scale = 0)
	public Integer getNlimitSpml() {
		return this.nlimitSpml;
	}

	public void setNlimitSpml(final Integer nlimitSpml) {
		this.nlimitSpml = nlimitSpml;
	}

	@Column(name = "NREST_HEIGHT", precision = 6, scale = 0)
	public Integer getNrestHeight() {
		return this.nrestHeight;
	}

	public void setNrestHeight(final Integer nrestHeight) {
		this.nrestHeight = nrestHeight;
	}

	@Column(name = "NREST_WIDTH", precision = 6, scale = 0)
	public Integer getNrestWidth() {
		return this.nrestWidth;
	}

	public void setNrestWidth(final Integer nrestWidth) {
		this.nrestWidth = nrestWidth;
	}

	@Column(name = "CMEAL_CONTROL_CODE2", length = 4)
	public String getCmealControlCode2() {
		return this.cmealControlCode2;
	}

	public void setCmealControlCode2(final String cmealControlCode2) {
		this.cmealControlCode2 = cmealControlCode2;
	}

	@Column(name = "NDISABLE_2ND_DISTRIBUTION", precision = 1, scale = 0)
	public Integer getNdisable2ndDistribution() {
		return this.ndisable2ndDistribution;
	}

	public void setNdisable2ndDistribution(final Integer ndisable2ndDistribution) {
		this.ndisable2ndDistribution = ndisable2ndDistribution;
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

	@Column(name = "CMEAL_CONTROL_CODE3", length = 4)
	public String getCmealControlCode3() {
		return this.cmealControlCode3;
	}

	public void setCmealControlCode3(final String cmealControlCode3) {
		this.cmealControlCode3 = cmealControlCode3;
	}

	@Column(name = "CMEAL_CONTROL_CODE4", length = 4)
	public String getCmealControlCode4() {
		return this.cmealControlCode4;
	}

	public void setCmealControlCode4(final String cmealControlCode4) {
		this.cmealControlCode4 = cmealControlCode4;
	}

	@Column(name = "CMEAL_CONTROL_CODE5", length = 4)
	public String getCmealControlCode5() {
		return this.cmealControlCode5;
	}

	public void setCmealControlCode5(final String cmealControlCode5) {
		this.cmealControlCode5 = cmealControlCode5;
	}

	@Column(name = "CMEAL_CONTROL_CODE6", length = 4)
	public String getCmealControlCode6() {
		return this.cmealControlCode6;
	}

	public void setCmealControlCode6(final String cmealControlCode6) {
		this.cmealControlCode6 = cmealControlCode6;
	}

	@Column(name = "CMEAL_CONTROL_CODE7", length = 4)
	public String getCmealControlCode7() {
		return this.cmealControlCode7;
	}

	public void setCmealControlCode7(final String cmealControlCode7) {
		this.cmealControlCode7 = cmealControlCode7;
	}

	@Column(name = "CMEAL_CONTROL_CODE8", length = 4)
	public String getCmealControlCode8() {
		return this.cmealControlCode8;
	}

	public void setCmealControlCode8(final String cmealControlCode8) {
		this.cmealControlCode8 = cmealControlCode8;
	}

	@Column(name = "CMEAL_CONTROL_CODE9", length = 4)
	public String getCmealControlCode9() {
		return this.cmealControlCode9;
	}

	public void setCmealControlCode9(final String cmealControlCode9) {
		this.cmealControlCode9 = cmealControlCode9;
	}

}
