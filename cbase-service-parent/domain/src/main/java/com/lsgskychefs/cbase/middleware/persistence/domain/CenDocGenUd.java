package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.05.2016 16:48:23 by Hibernate Tools 4.3.2-SNAPSHOT

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

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_UD
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_UD")
public class CenDocGenUd implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ngenUdIndex;
	private CenDocGenQueue cenDocGenQueue;
	private String csection;
	private String ckey;
	private String cvalue;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOC_GEN_UD")
	@SequenceGenerator(name = "SEQ_CEN_DOC_GEN_UD", sequenceName = "SEQ_CEN_DOC_GEN_UD", allocationSize = 1)
	@Column(name = "NGEN_UD_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNgenUdIndex() {
		return this.ngenUdIndex;
	}

	public void setNgenUdIndex(final long ngenUdIndex) {
		this.ngenUdIndex = ngenUdIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDOC_GEN_QUEUE_KEY", nullable = false)
	public CenDocGenQueue getCenDocGenQueue() {
		return this.cenDocGenQueue;
	}

	public void setCenDocGenQueue(final CenDocGenQueue cenDocGenQueue) {
		this.cenDocGenQueue = cenDocGenQueue;
	}

	@Column(name = "CSECTION", length = 25)
	public String getCsection() {
		return this.csection;
	}

	public void setCsection(final String csection) {
		this.csection = csection;
	}

	@Column(name = "CKEY", length = 256)
	public String getCkey() {
		return this.ckey;
	}

	public void setCkey(final String ckey) {
		this.ckey = ckey;
	}

	@Column(name = "CVALUE", length = 2048)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

}
