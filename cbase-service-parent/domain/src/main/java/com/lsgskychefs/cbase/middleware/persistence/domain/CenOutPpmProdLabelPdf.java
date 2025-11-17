package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 11.01.2018 14:26:29 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_PROD_LABEL_PDF
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_PROD_LABEL_PDF")
public class CenOutPpmProdLabelPdf implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmProdLabelPdfId id;

	private String cname;

	private boolean nlabelTypeKeyOne;

	private byte[] bpdf;

	private boolean nprinted;

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nbatchSeq", column = @Column(name = "NBATCH_SEQ", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nlabelTypeKey", column = @Column(name = "NLABEL_TYPE_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmProdLabelPdfId getId() {
		return this.id;
	}

	public void setId(final CenOutPpmProdLabelPdfId id) {
		this.id = id;
	}

	@Column(name = "CNAME", nullable = false, length = 50)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "NLABEL_TYPE_KEY_ONE", nullable = false, precision = 1, scale = 0)
	public boolean isNlabelTypeKeyOne() {
		return this.nlabelTypeKeyOne;
	}

	public void setNlabelTypeKeyOne(final boolean nlabelTypeKeyOne) {
		this.nlabelTypeKeyOne = nlabelTypeKeyOne;
	}

	@Column(name = "BPDF")
	public byte[] getBpdf() {
		return this.bpdf;
	}

	public void setBpdf(final byte[] bpdf) {
		this.bpdf = bpdf;
	}

	@Column(name = "NPRINTED", nullable = false, precision = 1, scale = 0)
	public boolean isNprinted() {
		return nprinted;
	}

	public void setNprinted(final boolean nprinted) {
		this.nprinted = nprinted;
	}
}
