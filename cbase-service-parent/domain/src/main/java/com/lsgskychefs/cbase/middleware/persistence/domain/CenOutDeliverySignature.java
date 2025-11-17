package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 16.10.2024 16:12:31 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_DELIVERY_SIGNATURE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DELIVERY_SIGNATURE")
public class CenOutDeliverySignature implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutDeliveryNoteId id;
	private CenOutDeliveryNote cenOutDeliveryNote;
	private byte[] bcrewSignature;
	private byte[] bsupervisorSignature;
	private String ccrew;
	private Date dcrew;
	private String csupervisor;
	private Date dsupervisor;
	/** 0=Strip Loading; 1=Turn Around; */
	private Integer ntypeOfLoading;
	private String csupervisorPosition;
	private String cremark;
	private byte[] bds1Signature;
	private String cds1;
	private String cds1Position;
	private byte[] bds2Signature;
	private String cds2;
	private String cds2Position;
	private byte[] bagentSignature;
	private String cagent;
	private String cagentPosition;
	private Date dds1;
	private Date dds2;
	private Date dagent;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nnumber", column = @Column(name = "NNUMBER", nullable = false, precision = 12, scale = 0)) })
	public CenOutDeliveryNoteId getId() {
		return this.id;
	}

	public void setId(CenOutDeliveryNoteId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY) @PrimaryKeyJoinColumn
	public CenOutDeliveryNote getCenOutDeliveryNote() {
		return this.cenOutDeliveryNote;
	}

	public void setCenOutDeliveryNote(CenOutDeliveryNote cenOutDeliveryNote) {
		this.cenOutDeliveryNote = cenOutDeliveryNote;
	}

	@Lob
	@Column(name = "BCREW_SIGNATURE")
	public byte[] getBcrewSignature() {
		return this.bcrewSignature;
	}

	public void setBcrewSignature(byte[] bcrewSignature) {
		this.bcrewSignature = bcrewSignature;
	}

	@Lob
	@Column(name = "BSUPERVISOR_SIGNATURE")
	public byte[] getBsupervisorSignature() {
		return this.bsupervisorSignature;
	}

	public void setBsupervisorSignature(byte[] bsupervisorSignature) {
		this.bsupervisorSignature = bsupervisorSignature;
	}

	@Column(name = "CCREW", length = 50)
	public String getCcrew() {
		return this.ccrew;
	}

	public void setCcrew(String ccrew) {
		this.ccrew = ccrew;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREW", length = 7)
	public Date getDcrew() {
		return this.dcrew;
	}

	public void setDcrew(Date dcrew) {
		this.dcrew = dcrew;
	}

	@Column(name = "CSUPERVISOR", length = 50)
	public String getCsupervisor() {
		return this.csupervisor;
	}

	public void setCsupervisor(String csupervisor) {
		this.csupervisor = csupervisor;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSUPERVISOR", length = 7)
	public Date getDsupervisor() {
		return this.dsupervisor;
	}

	public void setDsupervisor(Date dsupervisor) {
		this.dsupervisor = dsupervisor;
	}

	@Column(name = "NTYPE_OF_LOADING", precision = 1, scale = 0)
	public Integer getNtypeOfLoading() {
		return this.ntypeOfLoading;
	}

	public void setNtypeOfLoading(Integer ntypeOfLoading) {
		this.ntypeOfLoading = ntypeOfLoading;
	}

	@Column(name = "CSUPERVISOR_POSITION", length = 50)
	public String getCsupervisorPosition() {
		return this.csupervisorPosition;
	}

	public void setCsupervisorPosition(String csupervisorPosition) {
		this.csupervisorPosition = csupervisorPosition;
	}

	@Column(name = "CREMARK", length = 500)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(String cremark) {
		this.cremark = cremark;
	}

	@Lob
	@Column(name = "BDS1_SIGNATURE")
	public byte[] getBds1Signature() {
		return this.bds1Signature;
	}

	public void setBds1Signature(byte[] bds1Signature) {
		this.bds1Signature = bds1Signature;
	}

	@Column(name = "CDS1", length = 50)
	public String getCds1() {
		return this.cds1;
	}

	public void setCds1(String cds1) {
		this.cds1 = cds1;
	}

	@Column(name = "CDS1_POSITION", length = 50)
	public String getCds1Position() {
		return this.cds1Position;
	}

	public void setCds1Position(String cds1Position) {
		this.cds1Position = cds1Position;
	}

	@Lob
	@Column(name = "BDS2_SIGNATURE")
	public byte[] getBds2Signature() {
		return this.bds2Signature;
	}

	public void setBds2Signature(byte[] bds2Signature) {
		this.bds2Signature = bds2Signature;
	}

	@Column(name = "CDS2", length = 50)
	public String getCds2() {
		return this.cds2;
	}

	public void setCds2(String cds2) {
		this.cds2 = cds2;
	}

	@Column(name = "CDS2_POSITION", length = 50)
	public String getCds2Position() {
		return this.cds2Position;
	}

	public void setCds2Position(String cds2Position) {
		this.cds2Position = cds2Position;
	}

	@Lob
	@Column(name = "BAGENT_SIGNATURE")
	public byte[] getBagentSignature() {
		return this.bagentSignature;
	}

	public void setBagentSignature(byte[] bagentSignature) {
		this.bagentSignature = bagentSignature;
	}

	@Column(name = "CAGENT", length = 50)
	public String getCagent() {
		return this.cagent;
	}

	public void setCagent(String cagent) {
		this.cagent = cagent;
	}

	@Column(name = "CAGENT_POSITION", length = 50)
	public String getCagentPosition() {
		return this.cagentPosition;
	}

	public void setCagentPosition(String cagentPosition) {
		this.cagentPosition = cagentPosition;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDS1", length = 7)
	public Date getDds1() {
		return this.dds1;
	}

	public void setDds1(Date dds1) {
		this.dds1 = dds1;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDS2", length = 7)
	public Date getDds2() {
		return this.dds2;
	}

	public void setDds2(Date dds2) {
		this.dds2 = dds2;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DAGENT", length = 7)
	public Date getDagent() {
		return this.dagent;
	}

	public void setDagent(Date dagent) {
		this.dagent = dagent;
	}

}


