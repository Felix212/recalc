package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 13, 2020 3:50:45 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_SAP_PROTOCOL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SAP_PROTOCOL")
public class SysSapProtocol implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nprotocolKey;
	private long ninterfaceKey;
	private String cdescription;
	private String cmessage;
	private int nmessageType;
	private Date dtimestamp;

	public SysSapProtocol() {
	}

	public SysSapProtocol(long ninterfaceKey, String cdescription, String cmessage, int nmessageType, Date dtimestamp) {
		this.ninterfaceKey = ninterfaceKey;
		this.cdescription = cdescription;
		this.cmessage = cmessage;
		this.nmessageType = nmessageType;
		this.dtimestamp = dtimestamp;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SAP_PROTOCOL")
	@SequenceGenerator(name = "SEQ_SYS_SAP_PROTOCOL", sequenceName = "SEQ_SYS_SAP_PROTOCOL", allocationSize = 1)
	@Column(name = "NPROTOCOL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprotocolKey() {
		return this.nprotocolKey;
	}

	public void setNprotocolKey(long nprotocolKey) {
		this.nprotocolKey = nprotocolKey;
	}

	@Column(name = "NINTERFACE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNinterfaceKey() {
		return this.ninterfaceKey;
	}

	public void setNinterfaceKey(long ninterfaceKey) {
		this.ninterfaceKey = ninterfaceKey;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 50)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CMESSAGE", nullable = false, length = 500)
	public String getCmessage() {
		return this.cmessage;
	}

	public void setCmessage(String cmessage) {
		this.cmessage = cmessage;
	}

	@Column(name = "NMESSAGE_TYPE", nullable = false, precision = 2, scale = 0)
	public int getNmessageType() {
		return this.nmessageType;
	}

	public void setNmessageType(int nmessageType) {
		this.nmessageType = nmessageType;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
