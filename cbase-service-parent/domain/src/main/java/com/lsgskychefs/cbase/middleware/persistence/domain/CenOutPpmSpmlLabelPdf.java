package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 15, 2018 11:42:38 AM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_SPML_LABEL_PDF
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_SPML_LABEL_PDF")
public class CenOutPpmSpmlLabelPdf implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npdfKey;

	private long nbatchSeq;

	private long nlabelTypeKey;

	private String cname;

	private byte[] bpdf;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_SPML_LABEL_PDF")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_SPML_LABEL_PDF", sequenceName = "SEQ_CEN_OUT_PPM_SPML_LABEL_PDF", allocationSize = 1)
	@Column(name = "NPDF_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpdfKey() {
		return this.npdfKey;
	}

	public void setNpdfKey(final long npdfKey) {
		this.npdfKey = npdfKey;
	}

	@Column(name = "NBATCH_SEQ", nullable = false, precision = 12, scale = 0)
	public long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Column(name = "NLABEL_TYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(final long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "CNAME", nullable = false, length = 50)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "BPDF")
	public byte[] getBpdf() {
		return this.bpdf;
	}

	public void setBpdf(final byte[] bpdf) {
		this.bpdf = bpdf;
	}

}
