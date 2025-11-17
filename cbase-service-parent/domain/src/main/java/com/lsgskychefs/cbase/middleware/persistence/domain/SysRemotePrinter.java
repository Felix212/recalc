package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.01.2017 13:42:37 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_REMOTE_PRINTER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_REMOTE_PRINTER")
public class SysRemotePrinter implements DomainObject, java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private long nprinterKey;
	private SysUnits sysUnits;
	private String cname;
	private String cdescription;
	private String chostedBy;
	private Set<SysRemotePrinterSetup> sysRemotePrinterSetups = new HashSet<>(0);
	private Set<CenDocGenQueueRp> cenDocGenQueueRps = new HashSet<>(0);

	public SysRemotePrinter() {
	}

	public SysRemotePrinter(final long nprinterKey, final SysUnits sysUnits, final String cname, final String cdescription) {
		this.nprinterKey = nprinterKey;
		this.sysUnits = sysUnits;
		this.cname = cname;
		this.cdescription = cdescription;
	}

	public SysRemotePrinter(final long nprinterKey, final SysUnits sysUnits, final String cname, final String cdescription,
			final String chostedBy, final Set<SysRemotePrinterSetup> sysRemotePrinterSetups,
			final Set<CenDocGenQueueRp> cenDocGenQueueRps) {
		this.nprinterKey = nprinterKey;
		this.sysUnits = sysUnits;
		this.cname = cname;
		this.cdescription = cdescription;
		this.chostedBy = chostedBy;
		this.sysRemotePrinterSetups = sysRemotePrinterSetups;
		this.cenDocGenQueueRps = cenDocGenQueueRps;
	}

	@Id

	@Column(name = "NPRINTER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprinterKey() {
		return this.nprinterKey;
	}

	public void setNprinterKey(final long nprinterKey) {
		this.nprinterKey = nprinterKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CHOSTED_BY", length = 40)
	public String getChostedBy() {
		return this.chostedBy;
	}

	public void setChostedBy(final String chostedBy) {
		this.chostedBy = chostedBy;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRemotePrinter")
	public Set<SysRemotePrinterSetup> getSysRemotePrinterSetups() {
		return this.sysRemotePrinterSetups;
	}

	public void setSysRemotePrinterSetups(final Set<SysRemotePrinterSetup> sysRemotePrinterSetups) {
		this.sysRemotePrinterSetups = sysRemotePrinterSetups;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRemotePrinter")
	public Set<CenDocGenQueueRp> getCenDocGenQueueRps() {
		return this.cenDocGenQueueRps;
	}

	public void setCenDocGenQueueRps(final Set<CenDocGenQueueRp> cenDocGenQueueRps) {
		this.cenDocGenQueueRps = cenDocGenQueueRps;
	}

}
