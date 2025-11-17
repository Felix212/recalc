package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13-Sep-2024 15:19:47 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_BOB_SEALS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_BOB_SEALS")
public class CenOutPpmBobSeals implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbobSealsKey;
	private CenOutPpmBobScan cenOutPpmBobScan;
	private Long nresultKey;
	private int ntype;
	private int nlost;
	private String cbarcode;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_SEALS")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_SEALS", sequenceName = "SEQ_CEN_OUT_PPM_BOB_SEALS", allocationSize = 1)
	@Column(name = "NBOB_SEALS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbobSealsKey() {
		return this.nbobSealsKey;
	}

	public void setNbobSealsKey(long nbobSealsKey) {
		this.nbobSealsKey = nbobSealsKey;
	}

	@OneToOne(fetch= FetchType.LAZY)
	@JoinColumn(name="NCOP_BOB_SCAN_KEY", unique=true)
	public CenOutPpmBobScan getCenOutPpmBobScan() {
		return this.cenOutPpmBobScan;
	}

	public void setCenOutPpmBobScan(CenOutPpmBobScan cenOutPpmBobScan) {
		this.cenOutPpmBobScan = cenOutPpmBobScan;
	}

	@Column(name = "NRESULT_KEY", nullable = false)
	public Long getNresultKey() {
		return nresultKey;
	}

	public void setNresultKey(Long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NLOST", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNlost() {
		return this.nlost;
	}

	public void setNlost(int nlost) {
		this.nlost = nlost;
	}

	@Column(name = "CBARCODE", length = 256)
	public String getCbarcode() {
		return this.cbarcode;
	}

	public void setCbarcode(String cbarcode) {
		this.cbarcode = cbarcode;
	}

}


