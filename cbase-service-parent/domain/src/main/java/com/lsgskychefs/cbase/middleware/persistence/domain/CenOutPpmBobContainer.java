package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13-Sep-2024 15:19:47 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_BOB_CONTAINER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_BOB_CONTAINER")
public class CenOutPpmBobContainer implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncopBobContainerKey;
	private CenBobContainer cenBobContainer;
	private CenBobContainerStatus cenBobContainerStatus;
	private CenOutPpmBobScan cenOutPpmBobScan;
	private CenOutPpm cenOutPpm;
	private CenPackinglistIndex cenPackinglistIndex;
	private int nsort;
	private String cbarcode;
	private String ctype;
	private Set<CenOutPpmBobDrawer> cenOutPpmBobDrawers = new HashSet<>(0);
	private Set<CenOutPpmBobScan> relatedCenOutPpmBobScans = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_CONTAINER")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_CONTAINER", sequenceName = "SEQ_CEN_OUT_PPM_BOB_CONTAINER", allocationSize = 1)
	@Column(name = "NCOP_BOB_CONTAINER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcopBobContainerKey() {
		return this.ncopBobContainerKey;
	}

	public void setNcopBobContainerKey(long ncopBobContainerKey) {
		this.ncopBobContainerKey = ncopBobContainerKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NBOB_CONTAINER_KEY", nullable = false)
	public CenBobContainer getCenBobContainer() {
		return this.cenBobContainer;
	}

	public void setCenBobContainer(CenBobContainer cenBobContainer) {
		this.cenBobContainer = cenBobContainer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTATUS", nullable = false)
	public CenBobContainerStatus getCenBobContainerStatus() {
		return this.cenBobContainerStatus;
	}

	public void setCenBobContainerStatus(CenBobContainerStatus cenBobContainerStatus) {
		this.cenBobContainerStatus = cenBobContainerStatus;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="NCOP_BOB_SCAN_KEY")
	public CenOutPpmBobScan getCenOutPpmBobScan() {
		return this.cenOutPpmBobScan;
	}

	public void setCenOutPpmBobScan(CenOutPpmBobScan cenOutPpmBobScan) {
		this.cenOutPpmBobScan = cenOutPpmBobScan;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_DETAIL_KEY", nullable = false)
	public CenOutPpm getCenOutPpm() {
		return this.cenOutPpm;
	}

	public void setCenOutPpm(CenOutPpm cenOutPpm) {
		this.cenOutPpm = cenOutPpm;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@Column(name = "NSORT", nullable = false, precision = 4, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CBARCODE", nullable = false, length = 256)
	public String getCbarcode() {
		return this.cbarcode;
	}

	public void setCbarcode(String cbarcode) {
		this.cbarcode = cbarcode;
	}

	@Column(name = "CTYPE", nullable = false, length = 4)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmBobContainer")
	public Set<CenOutPpmBobDrawer> getCenOutPpmBobDrawers() {
		return this.cenOutPpmBobDrawers;
	}

	public void setCenOutPpmBobDrawers(Set<CenOutPpmBobDrawer> cenOutPpmBobDrawers) {
		this.cenOutPpmBobDrawers = cenOutPpmBobDrawers;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmBobContainerOrigin")
	public Set<CenOutPpmBobScan> getRelatedCenOutPpmBobScans() {
		return this.relatedCenOutPpmBobScans;
	}

	public void setRelatedCenOutPpmBobScans(Set<CenOutPpmBobScan> relatedCenOutPpmBobScans) {
		this.relatedCenOutPpmBobScans = relatedCenOutPpmBobScans;
	}

}


