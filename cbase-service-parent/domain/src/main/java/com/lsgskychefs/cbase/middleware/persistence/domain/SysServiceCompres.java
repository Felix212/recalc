package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 25.08.2022 13:45:52 by Hibernate Tools 4.3.5.Final

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_SERVICE_COMPRES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SERVICE_COMPRES"
)
public class SysServiceCompres implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nserviceCompres;
	private long nresultKey;
	private String cclass;
	private long nhandlingKey;
	private int nprocessStatus;
	private Date dcreated;
	private Set<SysServiceCompresDet> sysServiceCompresDets = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SERVICE_COMPRES")
	@SequenceGenerator(name = "SEQ_SYS_SERVICE_COMPRES", sequenceName = "SEQ_SYS_SERVICE_COMPRES", allocationSize = 1)
	@Column(name = "NSERVICE_COMPRES", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNserviceCompres() {
		return this.nserviceCompres;
	}

	public void setNserviceCompres(final long nserviceCompres) {
		this.nserviceCompres = nserviceCompres;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NHANDLING_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(final long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@Column(name = "NPROCESS_STATUS", nullable = false, precision = 2, scale = 0)
	public int getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final int nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", nullable = false, length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysServiceCompres")
	public Set<SysServiceCompresDet> getSysServiceCompresDets() {
		return this.sysServiceCompresDets;
	}

	public void setSysServiceCompresDets(final Set<SysServiceCompresDet> sysServiceCompresDets) {
		this.sysServiceCompresDets = sysServiceCompresDets;
	}

}


