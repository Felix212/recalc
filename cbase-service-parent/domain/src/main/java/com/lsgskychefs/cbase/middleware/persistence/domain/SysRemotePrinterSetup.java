package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.01.2017 13:42:37 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_REMOTE_PRINTER_SETUP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_REMOTE_PRINTER_SETUP")
public class SysRemotePrinterSetup implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysRemotePrinterSetupId id;
	private SysRemotePrinter sysRemotePrinter;
	private SysRemotePrinterFunc sysRemotePrinterFunc;
	private String cprinter;

	public SysRemotePrinterSetup() {
	}

	public SysRemotePrinterSetup(final SysRemotePrinterSetupId id, final SysRemotePrinter sysRemotePrinter,
			final SysRemotePrinterFunc sysRemotePrinterFunc, final String cprinter) {
		this.id = id;
		this.sysRemotePrinter = sysRemotePrinter;
		this.sysRemotePrinterFunc = sysRemotePrinterFunc;
		this.cprinter = cprinter;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nprinterKey", column = @Column(name = "NPRINTER_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "njobType", column = @Column(name = "NJOB_TYPE", nullable = false, precision = 12, scale = 0)) })
	public SysRemotePrinterSetupId getId() {
		return this.id;
	}

	public void setId(final SysRemotePrinterSetupId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns( {
			@JoinColumn(name="NJOB_TYPE", referencedColumnName="NJOB_TYPE", nullable=false, insertable=false, updatable=false),
			@JoinColumn(name="NJOB_SUBTYPE", referencedColumnName="NJOB_SUBTYPE", nullable=false, insertable=false, updatable=false) } )
	public SysRemotePrinterFunc getSysRemotePrinterFunc() {
		return this.sysRemotePrinterFunc;
	}

	public void setSysRemotePrinterFunc(final SysRemotePrinterFunc sysRemotePrinterFunc) {
		this.sysRemotePrinterFunc = sysRemotePrinterFunc;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRINTER_KEY", nullable = false, insertable = false, updatable = false)
	public SysRemotePrinter getSysRemotePrinter() {
		return this.sysRemotePrinter;
	}

	public void setSysRemotePrinter(final SysRemotePrinter sysRemotePrinter) {
		this.sysRemotePrinter = sysRemotePrinter;
	}

	@Column(name = "CPRINTER", nullable = false, length = 256)
	public String getCprinter() {
		return this.cprinter;
	}

	public void setCprinter(final String cprinter) {
		this.cprinter = cprinter;
	}

}
