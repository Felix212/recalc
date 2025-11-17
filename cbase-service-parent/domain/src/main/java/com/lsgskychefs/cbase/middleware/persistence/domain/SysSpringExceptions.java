package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 19, 2019 12:00:43 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_SPRING_EXCEPTIONS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SPRING_EXCEPTIONS")
public class SysSpringExceptions implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nerrorKey;
	private Date dtimestamp;
	private String cdatabase;
	private String capplication;
	private String cinstance;
	private String cversion;
	private String cuser;
	private String csessionid;
	private String cendpoint;
	private String cquery;
	private String cbody;
	private String cstacktrace;
	private String cresponse;

	public SysSpringExceptions() {
	}

	public SysSpringExceptions(final long nerrorKey, final Date dtimestamp) {
		this.nerrorKey = nerrorKey;
		this.dtimestamp = dtimestamp;
	}

	public SysSpringExceptions(final long nerrorKey, final Date dtimestamp, final String cdatabase, final String capplication,
			final String cinstance, final String cversion, final String cuser, final String csessionid, final String cendpoint,
			final String cquery, final String cbody, final String cstacktrace, final String cresponse) {
		this.nerrorKey = nerrorKey;
		this.dtimestamp = dtimestamp;
		this.cdatabase = cdatabase;
		this.capplication = capplication;
		this.cinstance = cinstance;
		this.cversion = cversion;
		this.cuser = cuser;
		this.csessionid = csessionid;
		this.cendpoint = cendpoint;
		this.cquery = cquery;
		this.cbody = cbody;
		this.cstacktrace = cstacktrace;
		this.cresponse = cresponse;
	}

	@Id

	@Column(name = "NERROR_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNerrorKey() {
		return this.nerrorKey;
	}

	public void setNerrorKey(final long nerrorKey) {
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

	@Column(name = "CDATABASE", length = 40)
	public String getCdatabase() {
		return this.cdatabase;
	}

	public void setCdatabase(final String cdatabase) {
		this.cdatabase = cdatabase;
	}

	@Column(name = "CAPPLICATION", length = 40)
	public String getCapplication() {
		return this.capplication;
	}

	public void setCapplication(final String capplication) {
		this.capplication = capplication;
	}

	@Column(name = "CINSTANCE", length = 40)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
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

	@Column(name = "CENDPOINT", length = 2000)
	public String getCendpoint() {
		return this.cendpoint;
	}

	public void setCendpoint(final String cendpoint) {
		this.cendpoint = cendpoint;
	}

	@Column(name = "CQUERY")
	public String getCquery() {
		return this.cquery;
	}

	public void setCquery(final String cquery) {
		this.cquery = cquery;
	}

	@Column(name = "CBODY")
	public String getCbody() {
		return this.cbody;
	}

	public void setCbody(final String cbody) {
		this.cbody = cbody;
	}

	@Column(name = "CSTACKTRACE")
	public String getCstacktrace() {
		return this.cstacktrace;
	}

	public void setCstacktrace(final String cstacktrace) {
		this.cstacktrace = cstacktrace;
	}

	@Column(name = "CRESPONSE")
	public String getCresponse() {
		return this.cresponse;
	}

	public void setCresponse(final String cresponse) {
		this.cresponse = cresponse;
	}

}
