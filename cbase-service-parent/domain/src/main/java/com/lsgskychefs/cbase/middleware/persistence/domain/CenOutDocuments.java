package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_DOCUMENTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DOCUMENTS")
public class CenOutDocuments implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutDocumentsId id;
	private CenOut cenOut;
	private String cchecksheet;
	private String clocationsheet;
	private String cspmlsheet;
	private String cdistributionerrors;
	private String cdiagramm;
	private String cflightinfo;
	private String cdocuments;
	private String ccartdiagram;
	private String ctransporterCart;
	private String ctripticket;
	private String crampBoxSheet;
	private String cdeliveryNote;
	private String ccontentSpec;
	private String cunassignedCarts;
	private String csecDistrErrors;
	private String ctruckChecksheet;
	private String callergenSheet;
	private String ccustomerReport;
	private Integer narchive;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cuser", column = @Column(name = "CUSER", nullable = false, length = 15)) })
	public CenOutDocumentsId getId() {
		return this.id;
	}

	public void setId(final CenOutDocumentsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "CCHECKSHEET", length = 80)
	public String getCchecksheet() {
		return this.cchecksheet;
	}

	public void setCchecksheet(final String cchecksheet) {
		this.cchecksheet = cchecksheet;
	}

	@Column(name = "CLOCATIONSHEET", length = 80)
	public String getClocationsheet() {
		return this.clocationsheet;
	}

	public void setClocationsheet(final String clocationsheet) {
		this.clocationsheet = clocationsheet;
	}

	@Column(name = "CSPMLSHEET", length = 80)
	public String getCspmlsheet() {
		return this.cspmlsheet;
	}

	public void setCspmlsheet(final String cspmlsheet) {
		this.cspmlsheet = cspmlsheet;
	}

	@Column(name = "CDISTRIBUTIONERRORS", length = 80)
	public String getCdistributionerrors() {
		return this.cdistributionerrors;
	}

	public void setCdistributionerrors(final String cdistributionerrors) {
		this.cdistributionerrors = cdistributionerrors;
	}

	@Column(name = "CDIAGRAMM", length = 80)
	public String getCdiagramm() {
		return this.cdiagramm;
	}

	public void setCdiagramm(final String cdiagramm) {
		this.cdiagramm = cdiagramm;
	}

	@Column(name = "CFLIGHTINFO", length = 80)
	public String getCflightinfo() {
		return this.cflightinfo;
	}

	public void setCflightinfo(final String cflightinfo) {
		this.cflightinfo = cflightinfo;
	}

	@Column(name = "CDOCUMENTS", length = 80)
	public String getCdocuments() {
		return this.cdocuments;
	}

	public void setCdocuments(final String cdocuments) {
		this.cdocuments = cdocuments;
	}

	@Column(name = "CCARTDIAGRAM", length = 80)
	public String getCcartdiagram() {
		return this.ccartdiagram;
	}

	public void setCcartdiagram(final String ccartdiagram) {
		this.ccartdiagram = ccartdiagram;
	}

	@Column(name = "CTRANSPORTER_CART", length = 80)
	public String getCtransporterCart() {
		return this.ctransporterCart;
	}

	public void setCtransporterCart(final String ctransporterCart) {
		this.ctransporterCart = ctransporterCart;
	}

	@Column(name = "CTRIPTICKET", length = 80)
	public String getCtripticket() {
		return this.ctripticket;
	}

	public void setCtripticket(final String ctripticket) {
		this.ctripticket = ctripticket;
	}

	@Column(name = "CRAMP_BOX_SHEET", length = 80)
	public String getCrampBoxSheet() {
		return this.crampBoxSheet;
	}

	public void setCrampBoxSheet(final String crampBoxSheet) {
		this.crampBoxSheet = crampBoxSheet;
	}

	@Column(name = "CDELIVERY_NOTE", length = 80)
	public String getCdeliveryNote() {
		return this.cdeliveryNote;
	}

	public void setCdeliveryNote(final String cdeliveryNote) {
		this.cdeliveryNote = cdeliveryNote;
	}

	@Column(name = "CCONTENT_SPEC", length = 80)
	public String getCcontentSpec() {
		return this.ccontentSpec;
	}

	public void setCcontentSpec(final String ccontentSpec) {
		this.ccontentSpec = ccontentSpec;
	}

	@Column(name = "CUNASSIGNED_CARTS", length = 80)
	public String getCunassignedCarts() {
		return this.cunassignedCarts;
	}

	public void setCunassignedCarts(final String cunassignedCarts) {
		this.cunassignedCarts = cunassignedCarts;
	}

	@Column(name = "CSEC_DISTR_ERRORS", length = 80)
	public String getCsecDistrErrors() {
		return this.csecDistrErrors;
	}

	public void setCsecDistrErrors(final String csecDistrErrors) {
		this.csecDistrErrors = csecDistrErrors;
	}

	@Column(name = "CTRUCK_CHECKSHEET", length = 80)
	public String getCtruckChecksheet() {
		return this.ctruckChecksheet;
	}

	public void setCtruckChecksheet(final String ctruckChecksheet) {
		this.ctruckChecksheet = ctruckChecksheet;
	}

	@Column(name = "CALLERGEN_SHEET", length = 80)
	public String getCallergenSheet() {
		return this.callergenSheet;
	}

	public void setCallergenSheet(final String callergenSheet) {
		this.callergenSheet = callergenSheet;
	}

	@Column(name = "CCUSTOMER_REPORT", length = 80)
	public String getCcustomerReport() {
		return this.ccustomerReport;
	}

	public void setCcustomerReport(final String ccustomerReport) {
		this.ccustomerReport = ccustomerReport;
	}

	@Column(name = "NARCHIVE", precision = 1, scale = 0)
	public Integer getNarchive() {
		return this.narchive;
	}

	public void setNarchive(final Integer narchive) {
		this.narchive = narchive;
	}

}
