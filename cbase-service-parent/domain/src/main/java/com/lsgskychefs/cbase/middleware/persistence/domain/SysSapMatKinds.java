package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.06.2025 12:20:48 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_SAP_MAT_KINDS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SAP_MAT_KINDS"
		, uniqueConstraints = @UniqueConstraint(columnNames = "CSAP_KIND")
)
public class SysSapMatKinds implements DomainObject, java.io.Serializable {
	private long nsapKindKey;
	private String csapKind;

	@Id
	@Column(name = "NSAP_KIND_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsapKindKey() {
		return this.nsapKindKey;
	}

	public void setNsapKindKey(long nsapKindKey) {
		this.nsapKindKey = nsapKindKey;
	}

	@Column(name = "CSAP_KIND", unique = true, nullable = false, length = 80)
	public String getCsapKind() {
		return this.csapKind;
	}

	public void setCsapKind(String csapKind) {
		this.csapKind = csapKind;
	}

}


