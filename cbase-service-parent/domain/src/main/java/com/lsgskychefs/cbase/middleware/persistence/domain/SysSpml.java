package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.09.2022 09:54:55 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_SPML
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SPML", uniqueConstraints = @UniqueConstraint(columnNames = "CSPML"))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysSpml implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nspmlKey;
	private String cspml;
	private String cdescription;

	@Id
	@Column(name = "NSPML_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNspmlKey() {
		return this.nspmlKey;
	}

	public void setNspmlKey(long nspmlKey) {
		this.nspmlKey = nspmlKey;
	}

	@Column(name = "CSPML", unique = true, nullable = false, length = 10)
	public String getCspml() {
		return this.cspml;
	}

	public void setCspml(String cspml) {
		this.cspml = cspml;
	}

	@Column(name = "CDESCRIPTION", length = 60)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

}


