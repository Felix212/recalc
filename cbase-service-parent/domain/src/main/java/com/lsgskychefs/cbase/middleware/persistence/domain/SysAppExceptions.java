package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 20, 2018 12:02:55 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_APP_EXCEPTIONS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_APP_EXCEPTIONS")
public class SysAppExceptions implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private Long nerrorKey;
	@JsonView(View.Simple.class)
	private Date dtimestamp;
	@JsonView(View.Simple.class)
	private String capplication;
	@JsonView(View.Simple.class)
	private String cversion;
	@JsonView(View.Simple.class)
	private String cuser;
	@JsonView(View.Simple.class)
	private String csessionid;
	@JsonView(View.Full.class)
	private String cconfig;
	@JsonView(View.Simple.class)
	private String cdevice;
	@JsonView(View.Full.class)
	private String cangularLog;
	@JsonView(View.Full.class)
	private String ccordovaLog;
	@JsonProperty(access = Access.WRITE_ONLY)
	private byte[] bsnapshot;
	@JsonView(View.Simple.class)
	private Long countExceptions;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_APP_EXCEPTIONS")
	@SequenceGenerator(name = "SEQ_SYS_APP_EXCEPTIONS", sequenceName = "SEQ_SYS_APP_EXCEPTIONS", allocationSize = 1)
	@Column(name = "NERROR_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNerrorKey() {
		return this.nerrorKey;
	}

	public void setNerrorKey(final Long nerrorKey) {
		this.nerrorKey = nerrorKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CAPPLICATION", length = 100)
	public String getCapplication() {
		return this.capplication;
	}

	public void setCapplication(final String capplication) {
		this.capplication = capplication;
	}

	@Column(name = "CVERSION", length = 40)
	public String getCversion() {
		return this.cversion;
	}

	public void setCversion(final String cversion) {
		this.cversion = cversion;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CSESSIONID", length = 40)
	public String getCsessionid() {
		return this.csessionid;
	}

	public void setCsessionid(final String csessionid) {
		this.csessionid = csessionid;
	}

	@Lob
	@Column(name = "CCONFIG")
	public String getCconfig() {
		return this.cconfig;
	}

	public void setCconfig(final String cconfig) {
		this.cconfig = cconfig;
	}

	@Lob
	@Column(name = "CDEVICE")
	public String getCdevice() {
		return this.cdevice;
	}

	public void setCdevice(final String cdevice) {
		this.cdevice = cdevice;
	}

	@Lob
	@Column(name = "CANGULAR_LOG")
	public String getCangularLog() {
		return this.cangularLog;
	}

	public void setCangularLog(final String cangularLog) {
		this.cangularLog = cangularLog;
	}

	@Lob
	@Column(name = "CCORDOVA_LOG")
	public String getCcordovaLog() {
		return this.ccordovaLog;
	}

	public void setCcordovaLog(final String ccordovaLog) {
		this.ccordovaLog = ccordovaLog;
	}

	@Column(name = "BSNAPSHOT")
	public byte[] getBsnapshot() {
		return this.bsnapshot;
	}

	public void setBsnapshot(final byte[] bsnapshot) {
		this.bsnapshot = bsnapshot;
	}

	/**
	 * Get countExceptions
	 *
	 * @return the countExceptions
	 */
	@Transient
	public Long getCountExceptions() {
		return countExceptions;
	}

	/**
	 * Set countExceptions
	 * 
	 * @param countExceptions the countExceptions to set
	 */
	public void setCountExceptions(final Long countExceptions) {
		this.countExceptions = countExceptions;
	}

}
