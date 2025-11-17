package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table CEN_OUT_PPM_MESSAGES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_MESSAGES")
public class CenOutPpmMessages implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmessKey;
	private long nbatchSeq;
	private Date dtimestamp;
	private String cuser;
	private String cmessage;
	private String cverificationUser;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_MESSAGES")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_MESSAGES", sequenceName = "SEQ_CEN_OUT_PPM_MESSAGES", allocationSize = 1)
	@Column(name = "NMESS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmessKey() {
		return this.nmessKey;
	}

	public void setNmessKey(final long nmessKey) {
		this.nmessKey = nmessKey;
	}

	@Column(name = "NBATCH_SEQ", nullable = false, precision = 12, scale = 0)
	public long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CMESSAGE", nullable = false, length = 1024)
	public String getCmessage() {
		return this.cmessage;
	}

	public void setCmessage(final String cmessage) {
		this.cmessage = cmessage;
	}

	@Column(name = "CVERIFICATION_USER", length = 40)
	public String getCverificationUser() {
		return this.cverificationUser;
	}

	public void setCverificationUser(final String cverificationUser) {
		this.cverificationUser = cverificationUser;
	}
}
