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
 * Entity(DomainObject) for table CEN_OUT_SD_COMP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SD_COMP")
public class CenOutSdComp implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nsdClKey;
	private CenOut cenOut;
	private Long ntransaction;
	private Long nrowid;
	private String ctext;
	private String cpackinglist;
	private Long nquantity;
	private String cquantity;
	private Long nlength;
	private String cdistrText;
	private String cmealControlCode;
	private String cclass;
	private Integer nclassNumber;
	private Integer nspml;
	private Long nlimit;
	private Long nremaining;
	private Integer ndontdistribute;

	public CenOutSdComp() {
	}

	public CenOutSdComp(final long nsdClKey) {
		this.nsdClKey = nsdClKey;
	}

	public CenOutSdComp(final long nsdClKey, final CenOut cenOut, final Long ntransaction, final Long nrowid, final String ctext,
			final String cpackinglist, final Long nquantity, final String cquantity, final Long nlength, final String cdistrText,
			final String cmealControlCode, final String cclass, final Integer nclassNumber, final Integer nspml, final Long nlimit,
			final Long nremaining, final Integer ndontdistribute) {
		this.nsdClKey = nsdClKey;
		this.cenOut = cenOut;
		this.ntransaction = ntransaction;
		this.nrowid = nrowid;
		this.ctext = ctext;
		this.cpackinglist = cpackinglist;
		this.nquantity = nquantity;
		this.cquantity = cquantity;
		this.nlength = nlength;
		this.cdistrText = cdistrText;
		this.cmealControlCode = cmealControlCode;
		this.cclass = cclass;
		this.nclassNumber = nclassNumber;
		this.nspml = nspml;
		this.nlimit = nlimit;
		this.nremaining = nremaining;
		this.ndontdistribute = ndontdistribute;
	}

	@Id

	@Column(name = "NSD_CL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsdClKey() {
		return this.nsdClKey;
	}

	public void setNsdClKey(final long nsdClKey) {
		this.nsdClKey = nsdClKey;
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

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CPACKINGLIST", length = 20)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NQUANTITY", precision = 12, scale = 0)
	public Long getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Long nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CQUANTITY", length = 20)
	public String getCquantity() {
		return this.cquantity;
	}

	public void setCquantity(final String cquantity) {
		this.cquantity = cquantity;
	}

	@Column(name = "NLENGTH", precision = 12, scale = 0)
	public Long getNlength() {
		return this.nlength;
	}

	public void setNlength(final Long nlength) {
		this.nlength = nlength;
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

	@Column(name = "NCLASS_NUMBER", precision = 2, scale = 0)
	public Integer getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Integer nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NSPML", precision = 1, scale = 0)
	public Integer getNspml() {
		return this.nspml;
	}

	public void setNspml(final Integer nspml) {
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

	@Column(name = "NDONTDISTRIBUTE", precision = 1, scale = 0)
	public Integer getNdontdistribute() {
		return this.ndontdistribute;
	}

	public void setNdontdistribute(final Integer ndontdistribute) {
		this.ndontdistribute = ndontdistribute;
	}

}
