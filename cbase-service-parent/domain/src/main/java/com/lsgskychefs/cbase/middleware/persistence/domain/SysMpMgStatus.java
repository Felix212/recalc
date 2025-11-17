package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 18, 2025 11:32:43 AM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_MP_MG_STATUS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_MP_MG_STATUS"
)
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysMpMgStatus implements DomainObject, java.io.Serializable {

	private long nmpMgStatusKey;
	private String ctype;
	private Date dtimestamp;

	@Id
	@Column(name = "NMP_MG_STATUS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpMgStatusKey() {
		return this.nmpMgStatusKey;
	}

	public void setNmpMgStatusKey(long nmpMgStatusKey) {
		this.nmpMgStatusKey = nmpMgStatusKey;
	}

	@Column(name = "CTYPE", nullable = false, length = 40)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}


