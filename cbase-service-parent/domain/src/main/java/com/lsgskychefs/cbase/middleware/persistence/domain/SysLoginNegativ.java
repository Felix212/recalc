package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_LOGIN_NEGATIV
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGIN_NEGATIV")
public class SysLoginNegativ implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private String cpassword;

	public SysLoginNegativ() {
	}

	public SysLoginNegativ(final String cpassword) {
		this.cpassword = cpassword;
	}

	@Id

	@Column(name = "CPASSWORD", unique = true, nullable = false, length = 40)
	public String getCpassword() {
		return this.cpassword;
	}

	public void setCpassword(final String cpassword) {
		this.cpassword = cpassword;
	}

}
