package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.06.2016 16:13:25 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_PPS_ACTION_TYPES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PPS_ACTION_TYPES")
public class SysPpsActionTypes implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nactionTypeKey;
	private String cactionType;
	private String cdescription;
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);

	@Id
	@Column(name = "NACTION_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNactionTypeKey() {
		return this.nactionTypeKey;
	}

	public void setNactionTypeKey(final long nactionTypeKey) {
		this.nactionTypeKey = nactionTypeKey;
	}

	@Column(name = "CACTION_TYPE", nullable = false, length = 20)
	public String getCactionType() {
		return this.cactionType;
	}

	public void setCactionType(final String cactionType) {
		this.cactionType = cactionType;
	}

	@Column(name = "CDESCRIPTION")
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPpsActionTypes")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

}
