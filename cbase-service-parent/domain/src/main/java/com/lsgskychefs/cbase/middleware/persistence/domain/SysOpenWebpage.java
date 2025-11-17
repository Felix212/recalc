package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14.03.2024 10:53:23 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
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
 * Entity(DomainObject) for table SYS_OPEN_WEBPAGE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_OPEN_WEBPAGE")
public class SysOpenWebpage implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nsysSysOpenWebpageKey;
	private String cpage;
	private String cuser;
	private Date dopenDate;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_OPEN_WEBPAGE")
	@SequenceGenerator(name = "SEQ_SYS_OPEN_WEBPAGE", sequenceName = "SEQ_SYS_OPEN_WEBPAGE", allocationSize = 1)
	@Column(name = "NSYS_SYS_OPEN_WEBPAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsysSysOpenWebpageKey() {
		return this.nsysSysOpenWebpageKey;
	}

	public void setNsysSysOpenWebpageKey(long nsysSysOpenWebpageKey) {
		this.nsysSysOpenWebpageKey = nsysSysOpenWebpageKey;
	}

	@Column(name = "CPAGE", nullable = false, length = 64)
	public String getCpage() {
		return this.cpage;
	}

	public void setCpage(String cpage) {
		this.cpage = cpage;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DOPEN_DATE", nullable = false, length = 7)
	public Date getDopenDate() {
		return this.dopenDate;
	}

	public void setDopenDate(Date dopenDate) {
		this.dopenDate = dopenDate;
	}

}


