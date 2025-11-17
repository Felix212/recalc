package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_SD_CONTENT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SD_CONTENT")
public class CenOutSdContent implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nsdContentKey;
	private CenOut cenOut;
	private Long ntransaction;
	private Long nrowid;
	private Long nsdCartKey;
	private Integer npage;
	private Long nsdDrawerKey;
	private Long ncount;
	private Long nlength;
	private String citem;
	private Long nshortage;
	private String cpackinglist;
	private String ctext;
	private String cparent;
	private Integer ncontent;
	private Integer nbold;
	private Integer ndistributed;
	private Long nleg;
	private String cdistrText;
	private String cmealControlCode;
	private String cclass;
	private Long nspml;
	private Long nlimit;
	private Long nremaining;
	private Long ndontdistribute;
	private Integer niscontent;
	private String ccontentQty;
	private Long nparentKey;

	public CenOutSdContent() {
	}

	public CenOutSdContent(final long nsdContentKey) {
		this.nsdContentKey = nsdContentKey;
	}

	public CenOutSdContent(final long nsdContentKey, final CenOut cenOut, final Long ntransaction, final Long nrowid, final Long nsdCartKey,
			final Integer npage, final Long nsdDrawerKey, final Long ncount, final Long nlength, final String citem, final Long nshortage,
			final String cpackinglist, final String ctext, final String cparent, final Integer ncontent, final Integer nbold,
			final Integer ndistributed, final Long nleg, final String cdistrText, final String cmealControlCode, final String cclass,
			final Long nspml, final Long nlimit, final Long nremaining, final Long ndontdistribute, final Integer niscontent,
			final String ccontentQty, final Long nparentKey) {
		this.nsdContentKey = nsdContentKey;
		this.cenOut = cenOut;
		this.ntransaction = ntransaction;
		this.nrowid = nrowid;
		this.nsdCartKey = nsdCartKey;
		this.npage = npage;
		this.nsdDrawerKey = nsdDrawerKey;
		this.ncount = ncount;
		this.nlength = nlength;
		this.citem = citem;
		this.nshortage = nshortage;
		this.cpackinglist = cpackinglist;
		this.ctext = ctext;
		this.cparent = cparent;
		this.ncontent = ncontent;
		this.nbold = nbold;
		this.ndistributed = ndistributed;
		this.nleg = nleg;
		this.cdistrText = cdistrText;
		this.cmealControlCode = cmealControlCode;
		this.cclass = cclass;
		this.nspml = nspml;
		this.nlimit = nlimit;
		this.nremaining = nremaining;
		this.ndontdistribute = ndontdistribute;
		this.niscontent = niscontent;
		this.ccontentQty = ccontentQty;
		this.nparentKey = nparentKey;
	}

	@Id

	@Column(name = "NSD_CONTENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsdContentKey() {
		return this.nsdContentKey;
	}

	public void setNsdContentKey(final long nsdContentKey) {
		this.nsdContentKey = nsdContentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY")
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NTRANSACTION", precision = 12, scale = 0)
	public Long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NROWID", precision = 12, scale = 0)
	public Long getNrowid() {
		return this.nrowid;
	}

	public void setNrowid(final Long nrowid) {
		this.nrowid = nrowid;
	}

	@Column(name = "NSD_CART_KEY", precision = 12, scale = 0)
	public Long getNsdCartKey() {
		return this.nsdCartKey;
	}

	public void setNsdCartKey(final Long nsdCartKey) {
		this.nsdCartKey = nsdCartKey;
	}

	@Column(name = "NPAGE", precision = 6, scale = 0)
	public Integer getNpage() {
		return this.npage;
	}

	public void setNpage(final Integer npage) {
		this.npage = npage;
	}

	@Column(name = "NSD_DRAWER_KEY", precision = 12, scale = 0)
	public Long getNsdDrawerKey() {
		return this.nsdDrawerKey;
	}

	public void setNsdDrawerKey(final Long nsdDrawerKey) {
		this.nsdDrawerKey = nsdDrawerKey;
	}

	@Column(name = "NCOUNT", precision = 12, scale = 0)
	public Long getNcount() {
		return this.ncount;
	}

	public void setNcount(final Long ncount) {
		this.ncount = ncount;
	}

	@Column(name = "NLENGTH", precision = 12, scale = 0)
	public Long getNlength() {
		return this.nlength;
	}

	public void setNlength(final Long nlength) {
		this.nlength = nlength;
	}

	@Column(name = "CITEM", length = 80)
	public String getCitem() {
		return this.citem;
	}

	public void setCitem(final String citem) {
		this.citem = citem;
	}

	@Column(name = "NSHORTAGE", precision = 12, scale = 0)
	public Long getNshortage() {
		return this.nshortage;
	}

	public void setNshortage(final Long nshortage) {
		this.nshortage = nshortage;
	}

	@Column(name = "CPACKINGLIST", length = 20)
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

	@Column(name = "CPARENT", length = 80)
	public String getCparent() {
		return this.cparent;
	}

	public void setCparent(final String cparent) {
		this.cparent = cparent;
	}

	@Column(name = "NCONTENT", precision = 1, scale = 0)
	public Integer getNcontent() {
		return this.ncontent;
	}

	public void setNcontent(final Integer ncontent) {
		this.ncontent = ncontent;
	}

	@Column(name = "NBOLD", precision = 1, scale = 0)
	public Integer getNbold() {
		return this.nbold;
	}

	public void setNbold(final Integer nbold) {
		this.nbold = nbold;
	}

	@Column(name = "NDISTRIBUTED", precision = 1, scale = 0)
	public Integer getNdistributed() {
		return this.ndistributed;
	}

	public void setNdistributed(final Integer ndistributed) {
		this.ndistributed = ndistributed;
	}

	@Column(name = "NLEG", precision = 12, scale = 0)
	public Long getNleg() {
		return this.nleg;
	}

	public void setNleg(final Long nleg) {
		this.nleg = nleg;
	}

	@Column(name = "CDISTR_TEXT", length = 80)
	public String getCdistrText() {
		return this.cdistrText;
	}

	public void setCdistrText(final String cdistrText) {
		this.cdistrText = cdistrText;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 10)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NSPML", precision = 12, scale = 0)
	public Long getNspml() {
		return this.nspml;
	}

	public void setNspml(final Long nspml) {
		this.nspml = nspml;
	}

	@Column(name = "NLIMIT", precision = 12, scale = 0)
	public Long getNlimit() {
		return this.nlimit;
	}

	public void setNlimit(final Long nlimit) {
		this.nlimit = nlimit;
	}

	@Column(name = "NREMAINING", precision = 12, scale = 0)
	public Long getNremaining() {
		return this.nremaining;
	}

	public void setNremaining(final Long nremaining) {
		this.nremaining = nremaining;
	}

	@Column(name = "NDONTDISTRIBUTE", precision = 12, scale = 0)
	public Long getNdontdistribute() {
		return this.ndontdistribute;
	}

	public void setNdontdistribute(final Long ndontdistribute) {
		this.ndontdistribute = ndontdistribute;
	}

	@Column(name = "NISCONTENT", precision = 1, scale = 0)
	public Integer getNiscontent() {
		return this.niscontent;
	}

	public void setNiscontent(final Integer niscontent) {
		this.niscontent = niscontent;
	}

	@Column(name = "CCONTENT_QTY", length = 10)
	public String getCcontentQty() {
		return this.ccontentQty;
	}

	public void setCcontentQty(final String ccontentQty) {
		this.ccontentQty = ccontentQty;
	}

	@Column(name = "NPARENT_KEY", precision = 12, scale = 0)
	public Long getNparentKey() {
		return this.nparentKey;
	}

	public void setNparentKey(final Long nparentKey) {
		this.nparentKey = nparentKey;
	}

}
