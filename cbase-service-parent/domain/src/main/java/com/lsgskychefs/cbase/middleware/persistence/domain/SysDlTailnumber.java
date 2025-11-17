package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.06.2016 17:55:55 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_DL_TAILNUMBER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_DL_TAILNUMBER")
public class SysDlTailnumber implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndlIndex;
	private String cowner;
	private String cactype;
	private String ccode;

	@Id
	@Column(name = "NDL_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdlIndex() {
		return this.ndlIndex;
	}

	public void setNdlIndex(final long ndlIndex) {
		this.ndlIndex = ndlIndex;
	}

	@Column(name = "COWNER", length = 3)
	public String getCowner() {
		return this.cowner;
	}

	public void setCowner(final String cowner) {
		this.cowner = cowner;
	}

	@Column(name = "CACTYPE", length = 10)
	public String getCactype() {
		return this.cactype;
	}

	public void setCactype(final String cactype) {
		this.cactype = cactype;
	}

	@Column(name = "CCODE", length = 3)
	public String getCcode() {
		return this.ccode;
	}

	public void setCcode(final String ccode) {
		this.ccode = ccode;
	}

}
