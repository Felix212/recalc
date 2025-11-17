package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.02.2017 14:23:34 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_KPI_GROUP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_KPI_GROUP")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nkpiGroupKey")
public class SysSlsKpiGroup implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nkpiGroupKey;
	private String ckpiGroup;
	private int nkpiGroupSort;
	private Set<SysSlsKpi> sysSlsKpis = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_KPI_GROUP")
	@SequenceGenerator(name = "SEQ_SYS_SLS_KPI_GROUP", sequenceName = "SEQ_SYS_SLS_KPI_GROUP", allocationSize = 1)
	@Column(name = "NKPI_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNkpiGroupKey() {
		return this.nkpiGroupKey;
	}

	public void setNkpiGroupKey(final long nkpiGroupKey) {
		this.nkpiGroupKey = nkpiGroupKey;
	}

	@Column(name = "CKPI_GROUP", nullable = false, length = 100)
	public String getCkpiGroup() {
		return this.ckpiGroup;
	}

	public void setCkpiGroup(final String ckpiGroup) {
		this.ckpiGroup = ckpiGroup;
	}

	@Column(name = "NKPI_GROUP_SORT", nullable = false, precision = 3, scale = 0)
	public int getNkpiGroupSort() {
		return this.nkpiGroupSort;
	}

	public void setNkpiGroupSort(final int nkpiGroupSort) {
		this.nkpiGroupSort = nkpiGroupSort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsKpiGroup")
	public Set<SysSlsKpi> getSysSlsKpis() {
		return this.sysSlsKpis;
	}

	public void setSysSlsKpis(final Set<SysSlsKpi> sysSlsKpis) {
		this.sysSlsKpis = sysSlsKpis;
	}

}
