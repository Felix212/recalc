package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14-Aug-2024 13:31:12 by Hibernate Tools 4.3.5.Final

import java.util.Date;
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
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_BOB_CONTAINER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_BOB_CONTAINER")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "cenBobContainer.recursive", attributeNodes = {
				@NamedAttributeNode(value = "cenBobContainerStatus"),
				@NamedAttributeNode(value = "cenBobContainers"),
				@NamedAttributeNode(value = "cenPackinglistIndex")
		})
})
public class CenBobContainer implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbobContainerKey;
	private CenBobContainer cenBobContainer;
	private CenBobContainerStatus cenBobContainerStatus;
	private CenPackinglistIndex cenPackinglistIndex;
	private int nsort;
	private String cbarcode;
	private String ctype;
	private Boolean nfrontSide;
	private Long nlayoutContentKey;
	private String ccreatedBy;
	private Date dcreatedDate;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Set<CenBobContainerItem> cenBobContainerItems = new HashSet<>(0);
	private Set<CenBobContainer> cenBobContainers = new HashSet<>(0);
	private Set<CenOutPpmBobContainer> cenOutPpmBobContainers = new HashSet<CenOutPpmBobContainer>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_BOB_CONTAINER")
	@SequenceGenerator(name = "SEQ_CEN_BOB_CONTAINER", sequenceName = "SEQ_CEN_BOB_CONTAINER", allocationSize = 1)
	@Column(name = "NBOB_CONTAINER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbobContainerKey() {
		return this.nbobContainerKey;
	}

	public void setNbobContainerKey(long nbobContainerKey) {
		this.nbobContainerKey = nbobContainerKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSOB_MASTER_KEY")
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

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenBobContainer")
	public Set<CenBobContainerItem> getCenBobContainerItems() {
		return this.cenBobContainerItems;
	}

	public void setCenBobContainerItems(Set<CenBobContainerItem> cenBobContainerItems) {
		this.cenBobContainerItems = cenBobContainerItems;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenBobContainer")
	public Set<CenBobContainer> getCenBobContainers() {
		return this.cenBobContainers;
	}

	public void setCenBobContainers(Set<CenBobContainer> cenBobContainers) {
		this.cenBobContainers = cenBobContainers;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenBobContainer")
	public Set<CenOutPpmBobContainer> getCenOutPpmBobContainers() {
		return this.cenOutPpmBobContainers;
	}

	public void setCenOutPpmBobContainers(Set<CenOutPpmBobContainer> cenOutPpmBobContainers) {
		this.cenOutPpmBobContainers = cenOutPpmBobContainers;
	}
}


