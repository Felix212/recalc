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
 * Entity(DomainObject) for table CEN_OUT_PPM_BOB_DRAWER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_BOB_DRAWER")
public class CenOutPpmBobDrawer implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbobDrawerKey;
	private CenBobContainer cenBobContainer;
	private CenOutPpmBobContainer cenOutPpmBobContainer;
	private CenOutPpmBobScan cenOutPpmBobScan;
	private CenPackinglistIndex cenPackinglistIndex;
	private int nsort;
	private String cbarcode;
	private String ctype;
	private Boolean nfrontSide;
	private Long nlayoutContentKey;
	private Set<CenOutPpmBobItem> cenOutPpmBobItems = new HashSet<>(0);
	private CenBobContainerStatus cenBobContainerStatus;

	public CenOutPpmBobDrawer() {}

	public CenOutPpmBobDrawer(
			final CenOutPpmBobContainer cart,
			final CenBobContainer drawerMd,
			final CenBobContainerStatus cenBobContainerStatus) {
		this.cenOutPpmBobContainer = cart;
		this.cenBobContainer = drawerMd;
		this.cenPackinglistIndex = drawerMd.getCenPackinglistIndex();
		this.nsort = cart.getCenOutPpmBobDrawers().size() + 1;
		this.cbarcode = drawerMd.getCbarcode();
		this.ctype = drawerMd.getCtype();
		this.nfrontSide = drawerMd.getNfrontSide();
		this.nlayoutContentKey = drawerMd.getNlayoutContentKey();
		this.cenBobContainerStatus = cenBobContainerStatus;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_DRAWER")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_DRAWER", sequenceName = "SEQ_CEN_OUT_PPM_BOB_DRAWER", allocationSize = 1)
	@Column(name = "NBOB_DRAWER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbobDrawerKey() {
		return this.nbobDrawerKey;
	}

	public void setNbobDrawerKey(long nbobDrawerKey) {
		this.nbobDrawerKey = nbobDrawerKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NBOB_CONTAINER_KEY")
	public CenBobContainer getCenBobContainer() {
		return this.cenBobContainer;
	}

	public void setCenBobContainer(CenBobContainer cenBobContainer) {
		this.cenBobContainer = cenBobContainer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCOP_BOB_CONTAINER_KEY")
	public CenOutPpmBobContainer getCenOutPpmBobContainer() {
		return this.cenOutPpmBobContainer;
	}

	public void setCenOutPpmBobContainer(CenOutPpmBobContainer cenOutPpmBobContainer) {
		this.cenOutPpmBobContainer = cenOutPpmBobContainer;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="NCOP_BOB_SCAN_KEY")
	public CenOutPpmBobScan getCenOutPpmBobScan() {
		return this.cenOutPpmBobScan;
	}

	public void setCenOutPpmBobScan(CenOutPpmBobScan cenOutPpmBobScan) {
		this.cenOutPpmBobScan = cenOutPpmBobScan;
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

	@Column(name = "NFRONT_SIDE", precision = 1, scale = 0)
	public Boolean getNfrontSide() {
		return this.nfrontSide;
	}

	public void setNfrontSide(Boolean nfrontSide) {
		this.nfrontSide = nfrontSide;
	}

	@Column(name = "NLAYOUT_CONTENT_KEY", precision = 12, scale = 0)
	public Long getNlayoutContentKey() {
		return this.nlayoutContentKey;
	}

	public void setNlayoutContentKey(Long nlayoutContentKey) {
		this.nlayoutContentKey = nlayoutContentKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmBobDrawer")
	public Set<CenOutPpmBobItem> getCenOutPpmBobItems() {
		return this.cenOutPpmBobItems;
	}

	public void setCenOutPpmBobItems(Set<CenOutPpmBobItem> cenOutPpmBobItems) {
		this.cenOutPpmBobItems = cenOutPpmBobItems;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTATUS", nullable = false, columnDefinition = "NUMBER(1) DEFAULT 0")
	public CenBobContainerStatus getCenBobContainerStatus() {
		return this.cenBobContainerStatus;
	}

	public void setCenBobContainerStatus(CenBobContainerStatus cenBobContainerStatus) {
		this.cenBobContainerStatus = cenBobContainerStatus;
	}
}


