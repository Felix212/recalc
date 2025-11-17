package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 20, 2025 4:16:26 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_ACCOUNTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ACCOUNTS"
		, uniqueConstraints = @UniqueConstraint(columnNames = "CCODE")
)
public class SysAccounts implements DomainObject, java.io.Serializable {

	private long nsysaccountKey;
	private String ccode;
	private String cdescription;

	@Id
	@Column(name = "NSYSACCOUNT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsysaccountKey() {
		return this.nsysaccountKey;
	}

	public void setNsysaccountKey(long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	@Column(name = "CCODE", unique = true, nullable = false, length = 5)
	public String getCcode() {
		return this.ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

}


