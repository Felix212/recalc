package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Nov 14, 2019 11:01:41 AM by Hibernate Tools 4.3.5.Final

import java.sql.Clob;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_EMAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL")
public class CenEmail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nemNkey;
	@JsonIgnore
	private CenEmailServer cenEmailServer;
	private String nemCsendname;
	private String nemCsendemail;
	private String nemCfromname;
	private String nemCfromemail;
	private String nemCsubject;
	@JsonIgnore
	private Clob nemCbody;
	private int nemNprio;
	private Date nemDcreate;
	private Date nemDsend;
	private int nemNstatus;
	private Integer nemNhtml;
	@JsonIgnore
	private Set<CenEmailAttachments> cenEmailAttachmentses = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_EMAIL")
	@SequenceGenerator(name = "SEQ_CEN_EMAIL", sequenceName = "SEQ_CEN_EMAIL", allocationSize = 1)
	@Column(name = "NEM_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNemNkey() {
		return this.nemNkey;
	}

	public void setNemNkey(final long nemNkey) {
		this.nemNkey = nemNkey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEM_NEMS_NKEY", nullable = false)
	public CenEmailServer getCenEmailServer() {
		return this.cenEmailServer;
	}

	public void setCenEmailServer(final CenEmailServer cenEmailServer) {
		this.cenEmailServer = cenEmailServer;
	}

	@Column(name = "NEM_CSENDNAME", nullable = false, length = 1000)
	public String getNemCsendname() {
		return this.nemCsendname;
	}

	public void setNemCsendname(final String nemCsendname) {
		this.nemCsendname = nemCsendname;
	}

	@Column(name = "NEM_CSENDEMAIL", nullable = false, length = 1000)
	public String getNemCsendemail() {
		return this.nemCsendemail;
	}

	public void setNemCsendemail(final String nemCsendemail) {
		this.nemCsendemail = nemCsendemail;
	}

	@Column(name = "NEM_CFROMNAME", nullable = false, length = 100)
	public String getNemCfromname() {
		return this.nemCfromname;
	}

	public void setNemCfromname(final String nemCfromname) {
		this.nemCfromname = nemCfromname;
	}

	@Column(name = "NEM_CFROMEMAIL", nullable = false, length = 100)
	public String getNemCfromemail() {
		return this.nemCfromemail;
	}

	public void setNemCfromemail(final String nemCfromemail) {
		this.nemCfromemail = nemCfromemail;
	}

	@Column(name = "NEM_CSUBJECT", nullable = false, length = 100)
	public String getNemCsubject() {
		return this.nemCsubject;
	}

	public void setNemCsubject(final String nemCsubject) {
		this.nemCsubject = nemCsubject;
	}

	@Column(name = "NEM_CBODY")
	public Clob getNemCbody() {
		return this.nemCbody;
	}

	public void setNemCbody(final Clob nemCbody) {
		this.nemCbody = nemCbody;
	}

	@Column(name = "NEM_NPRIO", nullable = false, precision = 2, scale = 0)
	public int getNemNprio() {
		return this.nemNprio;
	}

	public void setNemNprio(final int nemNprio) {
		this.nemNprio = nemNprio;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "NEM_DCREATE", length = 7)
	public Date getNemDcreate() {
		return this.nemDcreate;
	}

	public void setNemDcreate(final Date nemDcreate) {
		this.nemDcreate = nemDcreate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "NEM_DSEND", length = 7)
	public Date getNemDsend() {
		return this.nemDsend;
	}

	public void setNemDsend(final Date nemDsend) {
		this.nemDsend = nemDsend;
	}

	@Column(name = "NEM_NSTATUS", nullable = false, precision = 1, scale = 0)
	public int getNemNstatus() {
		return this.nemNstatus;
	}

	public void setNemNstatus(final int nemNstatus) {
		this.nemNstatus = nemNstatus;
	}

	@Column(name = "NEM_NHTML", precision = 1, scale = 0)
	public Integer getNemNhtml() {
		return this.nemNhtml;
	}

	public void setNemNhtml(final Integer nemNhtml) {
		this.nemNhtml = nemNhtml;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenEmail", cascade = CascadeType.ALL)
	public Set<CenEmailAttachments> getCenEmailAttachmentses() {
		return this.cenEmailAttachmentses;
	}

	public void setCenEmailAttachmentses(final Set<CenEmailAttachments> cenEmailAttachmentses) {
		this.cenEmailAttachmentses = cenEmailAttachmentses;
	}

}
