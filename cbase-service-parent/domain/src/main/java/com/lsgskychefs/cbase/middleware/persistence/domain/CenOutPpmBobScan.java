package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14.11.2024 12:01:46 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_BOB_SCAN
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_BOB_SCAN")
public class CenOutPpmBobScan implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncopBobScanKey;
	private long ncopBobContainerKey;
	private int ntype;
	private String cbarcode;
	private String cuser;
	private Date dtimestamp;
	private CenOutPpmBobContainer cenOutPpmBobContainerOrigin;
	private CenOutPpmBobSeals cenOutPpmBobSeals;
	private CenOutPpmBobContainer cenOutPpmBobContainer;
	private CenOutPpmBobDrawer cenOutPpmBobDrawer;

	public CenOutPpmBobScan() {

	}

	public CenOutPpmBobScan(CenOutPpmBobContainer cenOutPpmBobContainerOrigin, int type, String barcode, String username, Date timestamp) {
		this.cenOutPpmBobContainerOrigin = cenOutPpmBobContainerOrigin;
		this.ncopBobContainerKey = cenOutPpmBobContainerOrigin.getNcopBobContainerKey();
		this.ntype = type;
		this.cbarcode = barcode;
		this.cuser = username;
		this.dtimestamp = timestamp;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_SCAN")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_SCAN", sequenceName = "SEQ_CEN_OUT_PPM_BOB_SCAN", allocationSize = 1)
	@Column(name = "NCOP_BOB_SCAN_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcopBobScanKey() {
		return this.ncopBobScanKey;
	}

	public void setNcopBobScanKey(long ncopBobScanKey) {
		this.ncopBobScanKey = ncopBobScanKey;
	}

	@NotNull
	@Column(name = "NCOP_BOB_CONTAINER_KEY", nullable = false)
	public long getNcopBobContainerKey() {
		return ncopBobContainerKey;
	}

	public void setNcopBobContainerKey(long ncopBobContainerKey) {
		this.ncopBobContainerKey = ncopBobContainerKey;
	}

	@Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "CBARCODE", nullable = false, length = 256)
	public String getCbarcode() {
		return this.cbarcode;
	}

	public void setCbarcode(String cbarcode) {
		this.cbarcode = cbarcode;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="NCOP_BOB_CONTAINER_KEY", nullable = false, insertable = false, updatable = false)
	public CenOutPpmBobContainer getCenOutPpmBobContainerOrigin() {
		return this.cenOutPpmBobContainerOrigin;
	}

	public void setCenOutPpmBobContainerOrigin(CenOutPpmBobContainer cenOutPpmBobContainerOrigin) {
		this.cenOutPpmBobContainerOrigin = cenOutPpmBobContainerOrigin;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOutPpmBobScan")
	public CenOutPpmBobSeals getCenOutPpmBobSeals() {
		return this.cenOutPpmBobSeals;
	}

	public void setCenOutPpmBobSeals(CenOutPpmBobSeals cenOutPpmBobSeals) {
		this.cenOutPpmBobSeals = cenOutPpmBobSeals;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOutPpmBobScan")
	public CenOutPpmBobContainer getCenOutPpmBobContainer() {
		return this.cenOutPpmBobContainer;
	}

	public void setCenOutPpmBobContainer(CenOutPpmBobContainer cenOutPpmBobContainer) {
		this.cenOutPpmBobContainer = cenOutPpmBobContainer;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOutPpmBobScan")
	public CenOutPpmBobDrawer getCenOutPpmBobDrawer() {
		return this.cenOutPpmBobDrawer;
	}

	public void setCenOutPpmBobDrawer(CenOutPpmBobDrawer cenOutPpmBobDrawer) {
		this.cenOutPpmBobDrawer = cenOutPpmBobDrawer;
	}

}


