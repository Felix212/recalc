package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.01.2017 13:42:37 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_REMOTE_PRINTER_FUNC
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_REMOTE_PRINTER_FUNC")
public class SysRemotePrinterFunc implements DomainObject, java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private SysRemotePrinterFuncId id;

	private String cfunction;

	private String cdescription;

	private Integer nadjust;

	private Set<SysRemotePrinterSetup> sysRemotePrinterSetups = new HashSet<>(0);

	private Set<CenDocGenQueueRp> cenDocGenQueueRps = new HashSet<>(0);

	public SysRemotePrinterFunc() {
	}

	@EmbeddedId
	@AttributeOverrides( {
			@AttributeOverride(name="njobType", column=@Column(name="NJOB_TYPE", nullable=false, precision=12, scale=0) ),
			@AttributeOverride(name="njobSubtype", column=@Column(name="NJOB_SUBTYPE", nullable=false, precision=2, scale=0, columnDefinition = "number(2) default 0") ) } )
	public SysRemotePrinterFuncId getId() {
		return this.id;
	}

	public void setId(SysRemotePrinterFuncId id) {
		this.id = id;
	}

	@Column(name = "CFUNCTION", nullable = false, length = 40)
	public String getCfunction() {
		return this.cfunction;
	}

	public void setCfunction(final String cfunction) {
		this.cfunction = cfunction;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name="NADJUST", precision=1, scale=0, columnDefinition = "number(1) default 0")
	public Integer getNadjust() {
		return this.nadjust;
	}

	public void setNadjust(Integer nadjust) {
		this.nadjust = nadjust;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRemotePrinterFunc")
	public Set<SysRemotePrinterSetup> getSysRemotePrinterSetups() {
		return this.sysRemotePrinterSetups;
	}

	public void setSysRemotePrinterSetups(final Set<SysRemotePrinterSetup> sysRemotePrinterSetups) {
		this.sysRemotePrinterSetups = sysRemotePrinterSetups;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRemotePrinterFunc")
	public Set<CenDocGenQueueRp> getCenDocGenQueueRps() {
		return this.cenDocGenQueueRps;
	}

	public void setCenDocGenQueueRps(final Set<CenDocGenQueueRp> cenDocGenQueueRps) {
		this.cenDocGenQueueRps = cenDocGenQueueRps;
	}

}
