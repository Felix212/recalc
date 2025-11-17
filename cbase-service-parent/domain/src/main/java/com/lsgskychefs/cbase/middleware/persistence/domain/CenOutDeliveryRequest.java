package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 15.10.2024 19:04:31 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.Formula;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_DELIVERY_REQUEST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DELIVERY_REQUEST")
public class CenOutDeliveryRequest implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndeliveryRequestKey;
	private String cclass;
	private String cdescription;
	private BigDecimal nquantity;
	private int ntype;
	private int nstatus;
	private String crequestedBy;
	private Date drequestedOn;
	private String capprovedBy;
	private Date dapprovedOn;
	@JsonIgnore
	private CenOut cenOut;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private String crepresentativeName;
	private String crepresentativePosition;
	private Integer nreason;
	private Integer nsource;
	private Integer ndeliveryMethod;
	@JsonIgnore
	private List<CenOutDeliveryRequestAttach> cenOutDeliveryRequestAttaches = new ArrayList<>(0);
	private Long nrAttachments = 0L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_DELIVERY_REQUEST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_DELIVERY_REQUEST", sequenceName = "SEQ_CEN_OUT_DELIVERY_REQUEST", allocationSize = 1)
	@Column(name = "NDELIVERY_REQUEST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdeliveryRequestKey() {
		return this.ndeliveryRequestKey;
	}

	public void setNdeliveryRequestKey(long ndeliveryRequestKey) {
		this.ndeliveryRequestKey = ndeliveryRequestKey;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 1, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CREQUESTED_BY", length = 50)
	public String getCrequestedBy() {
		return this.crequestedBy;
	}

	public void setCrequestedBy(String crequestedBy) {
		this.crequestedBy = crequestedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DREQUESTED_ON", length = 7)
	public Date getDrequestedOn() {
		return this.drequestedOn;
	}

	public void setDrequestedOn(Date drequestedOn) {
		this.drequestedOn = drequestedOn;
	}

	@Column(name = "CAPPROVED_BY", length = 50)
	public String getCapprovedBy() {
		return capprovedBy;
	}

	public void setCapprovedBy(String capprovedBy) {
		this.capprovedBy = capprovedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DAPPROVED_ON", length = 7)
	public Date getDapprovedOn() {
		return this.dapprovedOn;
	}

	public void setDapprovedOn(Date dapprovedOn) {
		this.dapprovedOn = dapprovedOn;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY"),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY") })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@Column(name = "CREPRESENTATIVE_NAME", length = 50)
	public String getCrepresentativeName() {
		return this.crepresentativeName;
	}

	public void setCrepresentativeName(String crepresentativeName) {
		this.crepresentativeName = crepresentativeName;
	}

	@Column(name = "CREPRESENTATIVE_POSITION", length = 50)
	public String getCrepresentativePosition() {
		return this.crepresentativePosition;
	}

	public void setCrepresentativePosition(String crepresentativePosition) {
		this.crepresentativePosition = crepresentativePosition;
	}

	@Column(name = "NREASON", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNreason() {
		return this.nreason;
	}

	public void setNreason(Integer nreason) {
		this.nreason = nreason;
	}

	@Column(name = "NSOURCE", precision = 1, scale = 0)
	public Integer getNsource() {
		return this.nsource;
	}

	public void setNsource(Integer nsource) {
		this.nsource = nsource;
	}

	@Column(name = "NDELIVERY_METHOD", precision = 1, scale = 0)
	public Integer getNdeliveryMethod() {
		return this.ndeliveryMethod;
	}

	public void setNdeliveryMethod(Integer ndeliveryMethod) {
		this.ndeliveryMethod = ndeliveryMethod;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutDeliveryRequest")
	public List<CenOutDeliveryRequestAttach> getCenOutDeliveryRequestAttaches() {
		return this.cenOutDeliveryRequestAttaches;
	}

	public void setCenOutDeliveryRequestAttaches(List<CenOutDeliveryRequestAttach> cenOutDeliveryRequestAttaches) {
		this.cenOutDeliveryRequestAttaches = cenOutDeliveryRequestAttaches;
	}

	@Formula("("
			+ "SELECT count(*) "
			+ "FROM cen_out_delivery_request_attach attach "
			+ "WHERE attach.ndelivery_request_key = ndelivery_request_key"
			+ ")")
	@Basic(fetch = FetchType.EAGER)
	public Long getNrAttachments() {
		return nrAttachments;
	}

	public void setNrAttachments(Long nrAttachments) {
		this.nrAttachments = nrAttachments;
	}

	@Transient
	public String getCpackinglist() {
		return cenPackinglists != null ? cenPackinglists.getCenPackinglistIndex().getCpackinglist() : null;
	}

	@Transient
	public Long getNpackinglistIndexKey() {
		return cenPackinglists != null ? cenPackinglists.getId().getNpackinglistIndexKey() : null;
	}

	@Transient
	public Long getNpackinglistDetailKey() {
		return cenPackinglists != null ? cenPackinglists.getId().getNpackinglistDetailKey() : null;
	}

}


