package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.02.2017 14:23:34 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_KPI
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_KPI")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nkpiKey")
public class SysSlsKpi implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nkpiKey;
	private SysSlsKpiGroup sysSlsKpiGroup;
	private String ckpi;
	private int nkpiSort;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_KPI")
	@SequenceGenerator(name = "SEQ_SYS_SLS_KPI", sequenceName = "SEQ_SYS_SLS_KPI", allocationSize = 1)
	@Column(name = "NKPI_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNkpiKey() {
		return this.nkpiKey;
	}

	public void setNkpiKey(final long nkpiKey) {
		this.nkpiKey = nkpiKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NKPI_GROUP_KEY", nullable = false)
	public SysSlsKpiGroup getSysSlsKpiGroup() {
		return this.sysSlsKpiGroup;
	}

	public void setSysSlsKpiGroup(final SysSlsKpiGroup sysSlsKpiGroup) {
		this.sysSlsKpiGroup = sysSlsKpiGroup;
	}

	@Column(name = "CKPI", nullable = false, length = 200)
	public String getCkpi() {
		return this.ckpi;
	}

	public void setCkpi(final String ckpi) {
		this.ckpi = ckpi;
	}

	@Column(name = "NKPI_SORT", nullable = false, precision = 3, scale = 0)
	public int getNkpiSort() {
		return this.nkpiSort;
	}

	public void setNkpiSort(final int nkpiSort) {
		this.nkpiSort = nkpiSort;
	}

}
