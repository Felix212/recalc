package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.08.2016 17:41:45 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_CATERING_UO_PDF
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CATERING_UO_PDF")
public class CenCateringUoPdf implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenCateringUoPdfId id;
	private CenCateringUserobject cenCateringUserobject;
	private String ccateringUoDescripton;
	private String ccreator;
	private String clastchange;
	private BigDecimal nversion;
	private Date dvalidTo;
	private String cpdfFile;
	// Long RAW workaround cause byte[] mapping not working with the latest driver anymore
	// Since Oracle 8i, Oracle advised against using the LONG RAW datatype. Users should convert to the BLOB data type.
	private String bpdfBlob;
	private int nprintDuplex;
	private int ncopyCount;
	private Integer nuseForGalleydiagram;
	private Integer nstatusPortal;
	private Date dpublishPortal;
	private Integer nprintWithDeliverynote;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "ncateringUserobjectId",
					column = @Column(name = "NCATERING_USEROBJECT_ID", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)) })
	public CenCateringUoPdfId getId() {
		return this.id;
	}

	public void setId(final CenCateringUoPdfId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCATERING_USEROBJECT_ID", nullable = false, insertable = false, updatable = false)
	public CenCateringUserobject getCenCateringUserobject() {
		return this.cenCateringUserobject;
	}

	public void setCenCateringUserobject(final CenCateringUserobject cenCateringUserobject) {
		this.cenCateringUserobject = cenCateringUserobject;
	}

	@Column(name = "CCATERING_UO_DESCRIPTON", nullable = false, length = 100)
	public String getCcateringUoDescripton() {
		return this.ccateringUoDescripton;
	}

	public void setCcateringUoDescripton(final String ccateringUoDescripton) {
		this.ccateringUoDescripton = ccateringUoDescripton;
	}

	@Column(name = "CCREATOR", nullable = false, length = 50)
	public String getCcreator() {
		return this.ccreator;
	}

	public void setCcreator(final String ccreator) {
		this.ccreator = ccreator;
	}

	@Column(name = "CLASTCHANGE", nullable = false, length = 40)
	public String getClastchange() {
		return this.clastchange;
	}

	public void setClastchange(final String clastchange) {
		this.clastchange = clastchange;
	}

	@Column(name = "NVERSION", nullable = false, precision = 5)
	public BigDecimal getNversion() {
		return this.nversion;
	}

	public void setNversion(final BigDecimal nversion) {
		this.nversion = nversion;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CPDF_FILE", nullable = false, length = 128)
	public String getCpdfFile() {
		return this.cpdfFile;
	}

	public void setCpdfFile(final String cpdfFile) {
		this.cpdfFile = cpdfFile;
	}

	@Column(name = "BPDF_BLOB", columnDefinition = "bytea")
	public String getBpdfBlob() {
		return this.bpdfBlob;
	}

	public void setBpdfBlob(final String bpdfBlob) {
		this.bpdfBlob = bpdfBlob;
	}

	/**
	 * to transform the hexString to byte[]. ex : "205F44" => [32, 95, 68]
	 *
	 * @return as byte array
	 */
	public byte[] pdfAsByteArray() {
		byte[] val = new byte[this.bpdfBlob.length() / 2];
		for (int i = 0; i < val.length; i++) {
			int index = i * 2;
			int j = Integer.parseInt(this.bpdfBlob.substring(index, index + 2), 16);
			val[i] = (byte) j;
		}
		return val;
	}

	@Column(name = "NPRINT_DUPLEX", nullable = false, precision = 1, scale = 0)
	public int getNprintDuplex() {
		return this.nprintDuplex;
	}

	public void setNprintDuplex(final int nprintDuplex) {
		this.nprintDuplex = nprintDuplex;
	}

	@Column(name = "NCOPY_COUNT", nullable = false, precision = 2, scale = 0)
	public int getNcopyCount() {
		return this.ncopyCount;
	}

	public void setNcopyCount(final int ncopyCount) {
		this.ncopyCount = ncopyCount;
	}

	@Column(name = "NUSE_FOR_GALLEYDIAGRAM", precision = 1, scale = 0)
	public Integer getNuseForGalleydiagram() {
		return this.nuseForGalleydiagram;
	}

	public void setNuseForGalleydiagram(final Integer nuseForGalleydiagram) {
		this.nuseForGalleydiagram = nuseForGalleydiagram;
	}

	@Column(name = "NSTATUS_PORTAL", precision = 1, scale = 0)
	public Integer getNstatusPortal() {
		return this.nstatusPortal;
	}

	public void setNstatusPortal(final Integer nstatusPortal) {
		this.nstatusPortal = nstatusPortal;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPUBLISH_PORTAL", length = 7)
	public Date getDpublishPortal() {
		return this.dpublishPortal;
	}

	public void setDpublishPortal(final Date dpublishPortal) {
		this.dpublishPortal = dpublishPortal;
	}

	@Column(name = "NPRINT_WITH_DELIVERYNOTE", precision = 1, scale = 0)
	public Integer getNprintWithDeliverynote() {
		return this.nprintWithDeliverynote;
	}

	public void setNprintWithDeliverynote(final Integer nprintWithDeliverynote) {
		this.nprintWithDeliverynote = nprintWithDeliverynote;
	}

}
