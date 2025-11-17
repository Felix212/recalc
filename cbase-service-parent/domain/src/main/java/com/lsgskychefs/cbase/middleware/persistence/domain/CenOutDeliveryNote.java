package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;

/**
 * Entity(DomainObject) for table CEN_OUT_DELIVERY_NOTE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DELIVERY_NOTE")
public class CenOutDeliveryNote implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenOutDeliveryNoteId id;
	private CenOut cenOut;
	private Date dtimestamp;
	private Long nnumberMaster;
	private Long nclassNumber;
	private String cclass;
	/** 0: open 1: created/prepared, 2: inProgress, 3: finalized */
	private int ndeliveryStatus;
	private byte[] breport;
	private Date dbelStart;
	private Date dbelStop;
	private Set<CenOutSpmlDelivery> cenOutSpmlDeliveries = new HashSet<>(0);
	private Set<CenOutMealDelivery> cenOutMealDeliveries = new HashSet<>(0);
	private Set<CenDocGenQueueDlv> cenDocGenQueueDlvs = new HashSet<>(0);
	private CenOutDeliverySignature cenOutDeliverySignature;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nnumber", column = @Column(name = "NNUMBER", nullable = false, precision = 12, scale = 0)) })
	public CenOutDeliveryNoteId getId() {
		return this.id;
	}

	public void setId(final CenOutDeliveryNoteId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NNUMBER_MASTER", precision = 12, scale = 0)
	public Long getNnumberMaster() {
		return this.nnumberMaster;
	}

	public void setNnumberMaster(Long nnumberMaster) {
		this.nnumberMaster = nnumberMaster;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NDELIVERY_STATUS", nullable = false, precision = 2, scale = 0)
	public int getNdeliveryStatus() {
		return this.ndeliveryStatus;
	}

	public void setNdeliveryStatus(int ndeliveryStatus) {
		this.ndeliveryStatus = ndeliveryStatus;
	}

	@Column(name = "BREPORT", length = 0)
	public byte[] getBreport() {
		return this.breport;
	}

	public void setBreport(byte[] breport) {
		this.breport = breport;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DBEL_START", length = 7)
	public Date getDbelStart() {
		return this.dbelStart;
	}

	public void setDbelStart(Date dbelStart) {
		this.dbelStart = dbelStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DBEL_STOP", length = 7)
	public Date getDbelStop() {
		return this.dbelStop;
	}

	public void setDbelStop(Date dbelStop) {
		this.dbelStop = dbelStop;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutDeliveryNote", cascade = CascadeType.ALL)
	public Set<CenOutSpmlDelivery> getCenOutSpmlDeliveries() {
		return this.cenOutSpmlDeliveries;
	}

	public void setCenOutSpmlDeliveries(Set<CenOutSpmlDelivery> cenOutSpmlDeliveries) {
		this.cenOutSpmlDeliveries = cenOutSpmlDeliveries;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutDeliveryNote", cascade = CascadeType.ALL)
	public Set<CenOutMealDelivery> getCenOutMealDeliveries() {
		return this.cenOutMealDeliveries;
	}

	public void setCenOutMealDeliveries(Set<CenOutMealDelivery> cenOutMealDeliveries) {
		this.cenOutMealDeliveries = cenOutMealDeliveries;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutDeliveryNote")
	public Set<CenDocGenQueueDlv> getCenDocGenQueueDlvs() {
		return this.cenDocGenQueueDlvs;
	}

	public void setCenDocGenQueueDlvs(Set<CenDocGenQueueDlv> cenDocGenQueueDlvs) {
		this.cenDocGenQueueDlvs = cenDocGenQueueDlvs;
	}

	@LazyToOne(LazyToOneOption.NO_PROXY)
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenOutDeliveryNote", cascade = CascadeType.ALL)
	public CenOutDeliverySignature getCenOutDeliverySignature() {
		return this.cenOutDeliverySignature;
	}

	public void setCenOutDeliverySignature(CenOutDeliverySignature cenOutDeliverySignature) {
		this.cenOutDeliverySignature = cenOutDeliverySignature;
	}
}
