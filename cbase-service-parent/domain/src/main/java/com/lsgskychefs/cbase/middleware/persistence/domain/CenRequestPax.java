package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Entity(DomainObject) for table CEN_REQUEST_PAX
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REQUEST_PAX")
public class CenRequestPax
		implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(CenRequestPax.class);

	private long nreqPaxKey;
	private CenRequestFlight cenRequestFlight;
	private int nclassNumber;
	private String cclass;
	private int nversion;
	private int npax;
	private int nexpected;
	private int npad;
	private int nchd;
	private int npaxSpml;
	private String ccomment;
	private BigDecimal nfcPax;
	private BigDecimal nfcMargin;
	private String cfcModel;
	private Integer nfcSpml;
	private BigDecimal nfcPaxRaw;

	public CenRequestPax() {
	}

	public CenRequestPax(final long nreqPaxKey, final CenRequestFlight cenRequestFlight, final int nclassNumber,
			final String cclass, final int nversion, final int npax, final int nexpected, final int npad,
			final int nchd, final int npaxSpml) {
		this.nreqPaxKey = nreqPaxKey;
		this.cenRequestFlight = cenRequestFlight;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.nversion = nversion;
		this.npax = npax;
		this.nexpected = nexpected;
		this.npad = npad;
		this.nchd = nchd;
		this.npaxSpml = npaxSpml;
	}

	public CenRequestPax(final long nreqPaxKey, final CenRequestFlight cenRequestFlight, final int nclassNumber,
			final String cclass, final int nversion, final int npax, final int nexpected, final int npad,
			final int nchd, final int npaxSpml, final String ccomment, final BigDecimal nfcPax,
			final BigDecimal nfcMargin, final String cfcModel, final Integer nfcSpml, final BigDecimal nfcPaxRaw) {
		this.nreqPaxKey = nreqPaxKey;
		this.cenRequestFlight = cenRequestFlight;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.nversion = nversion;
		this.npax = npax;
		this.nexpected = nexpected;
		this.npad = npad;
		this.nchd = nchd;
		this.npaxSpml = npaxSpml;
		this.ccomment = ccomment;
		this.nfcPax = nfcPax;
		this.nfcMargin = nfcMargin;
		this.cfcModel = cfcModel;
		this.nfcSpml = nfcSpml;
		this.nfcPaxRaw = nfcPaxRaw;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_REQUEST_PAX")
	@SequenceGenerator(name = "SEQ_CEN_REQUEST_PAX", sequenceName = "SEQ_CEN_REQUEST_PAX", allocationSize = 1)
	@Column(name = "NREQ_PAX_KEY", unique = true, nullable = false, precision = 12)
	public long getNreqPaxKey() {
		return this.nreqPaxKey;
	}

	public void setNreqPaxKey(final long nreqPaxKey) {
		this.nreqPaxKey = nreqPaxKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQ_FLIGHT_KEY", nullable = false)
	public CenRequestFlight getCenRequestFlight() {
		return this.cenRequestFlight;
	}

	public void setCenRequestFlight(final CenRequestFlight cenRequestFlight) {
		this.cenRequestFlight = cenRequestFlight;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 6)
	public int getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final int nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NVERSION", nullable = false, precision = 4)
	public int getNversion() {
		return this.nversion;
	}

	public void setNversion(final int nversion) {
		this.nversion = nversion;
	}

	@Column(name = "NPAX", nullable = false, precision = 4)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(final int npax) {
		this.npax = npax;
	}

	@Column(name = "NEXPECTED", nullable = false, precision = 4)
	public int getNexpected() {
		return this.nexpected;
	}

	public void setNexpected(final int nexpected) {
		this.nexpected = nexpected;
	}

	@Column(name = "NPAD", nullable = false, precision = 4)
	public int getNpad() {
		return this.npad;
	}

	public void setNpad(final int npad) {
		this.npad = npad;
	}

	@Column(name = "NCHD", nullable = false, precision = 4)
	public int getNchd() {
		return this.nchd;
	}

	public void setNchd(final int nchd) {
		this.nchd = nchd;
	}

	@Column(name = "NPAX_SPML", nullable = false, precision = 4)
	public int getNpaxSpml() {
		return this.npaxSpml;
	}

	public void setNpaxSpml(final int npaxSpml) {
		this.npaxSpml = npaxSpml;
	}

	@Column(name = "CCOMMENT", length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NFC_PAX", precision = 8, scale = 4)
	public BigDecimal getNfcPax() {
		return this.nfcPax;
	}

	public void setNfcPax(final BigDecimal nfcPax) {
		this.nfcPax = nfcPax;
	}

	@Column(name = "NFC_MARGIN", precision = 11, scale = 6)
	public BigDecimal getNfcMargin() {
		return this.nfcMargin;
	}

	public void setNfcMargin(final BigDecimal nfcMargin) {
		this.nfcMargin = nfcMargin;
	}

	@Column(name = "CFC_MODEL", length = 100)
	public String getCfcModel() {
		return this.cfcModel;
	}

	public void setCfcModel(final String cfcModel) {
		this.cfcModel = cfcModel;
	}

	@Column(name = "NFC_SPML", precision = 4)
	public Integer getNfcSpml() {
		return this.nfcSpml;
	}

	public void setNfcSpml(final Integer nfcSpml) {
		this.nfcSpml = nfcSpml;
	}

	@Column(name = "NFC_PAX_RAW", precision = 8, scale = 4)
	public BigDecimal getNfcPaxRaw() {
		return this.nfcPaxRaw;
	}

	public void setNfcPaxRaw(final BigDecimal nfcPaxRaw) {
		this.nfcPaxRaw = nfcPaxRaw;
	}

}
