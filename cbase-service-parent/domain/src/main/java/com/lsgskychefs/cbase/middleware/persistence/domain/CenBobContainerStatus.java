package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14-Aug-2024 13:31:12 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_BOB_CONTAINER_STATUS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_BOB_CONTAINER_STATUS")
public class CenBobContainerStatus implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nbobContainerStatusKey;
	private String cstatus;

	@JsonIgnore
	private Set<CenBobContainer> cenBobContainers = new HashSet<>(0);

	public CenBobContainerStatus() {}

	public CenBobContainerStatus(long nbobContainerStatusKey, String cstatus) {
		this.nbobContainerStatusKey = nbobContainerStatusKey;
		this.cstatus = cstatus;
	}

	@Id
	@Column(name = "NBOB_CONTAINER_STATUS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbobContainerStatusKey() {
		return this.nbobContainerStatusKey;
	}

	public void setNbobContainerStatusKey(long nbobContainerStatusKey) {
		this.nbobContainerStatusKey = nbobContainerStatusKey;
	}

	@Column(name = "CSTATUS", nullable = false, length = 40)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenBobContainerStatus")
	public Set<CenBobContainer> getCenBobContainers() {
		return this.cenBobContainers;
	}

	public void setCenBobContainers(Set<CenBobContainer> cenBobContainers) {
		this.cenBobContainers = cenBobContainers;
	}
}
