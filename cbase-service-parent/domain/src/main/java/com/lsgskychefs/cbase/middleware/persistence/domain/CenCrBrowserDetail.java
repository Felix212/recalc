package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.04.2016 13:26:45 by Hibernate Tools 4.3.2-SNAPSHOT

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_CR_BROWSER_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CR_BROWSER_DETAIL")
public class CenCrBrowserDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nrepDetailKey;
	private long nreportKey;
	private String cparameterName;
	private long nsort;
	private long ntype;
	private long nx;
	private long ny;
	private long nwidth;
	private long nheight;
	private String cdefault;

	public CenCrBrowserDetail() {
	}

	public CenCrBrowserDetail(final long nrepDetailKey, final long nreportKey, final String cparameterName, final long nsort,
			final long ntype, final long nx, final long ny, final long nwidth, final long nheight) {
		this.nrepDetailKey = nrepDetailKey;
		this.nreportKey = nreportKey;
		this.cparameterName = cparameterName;
		this.nsort = nsort;
		this.ntype = ntype;
		this.nx = nx;
		this.ny = ny;
		this.nwidth = nwidth;
		this.nheight = nheight;
	}

	public CenCrBrowserDetail(final long nrepDetailKey, final long nreportKey, final String cparameterName, final long nsort,
			final long ntype, final long nx, final long ny, final long nwidth, final long nheight, final String cdefault) {
		this.nrepDetailKey = nrepDetailKey;
		this.nreportKey = nreportKey;
		this.cparameterName = cparameterName;
		this.nsort = nsort;
		this.ntype = ntype;
		this.nx = nx;
		this.ny = ny;
		this.nwidth = nwidth;
		this.nheight = nheight;
		this.cdefault = cdefault;
	}

	@Id

	@Column(name = "NREP_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNrepDetailKey() {
		return this.nrepDetailKey;
	}

	public void setNrepDetailKey(final long nrepDetailKey) {
		this.nrepDetailKey = nrepDetailKey;
	}

	@Column(name = "NREPORT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNreportKey() {
		return this.nreportKey;
	}

	public void setNreportKey(final long nreportKey) {
		this.nreportKey = nreportKey;
	}

	@Column(name = "CPARAMETER_NAME", nullable = false, length = 40)
	public String getCparameterName() {
		return this.cparameterName;
	}

	public void setCparameterName(final String cparameterName) {
		this.cparameterName = cparameterName;
	}

	@Column(name = "NSORT", nullable = false, precision = 12, scale = 0)
	public long getNsort() {
		return this.nsort;
	}

	public void setNsort(final long nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NTYPE", nullable = false, precision = 12, scale = 0)
	public long getNtype() {
		return this.ntype;
	}

	public void setNtype(final long ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NX", nullable = false, precision = 12, scale = 0)
	public long getNx() {
		return this.nx;
	}

	public void setNx(final long nx) {
		this.nx = nx;
	}

	@Column(name = "NY", nullable = false, precision = 12, scale = 0)
	public long getNy() {
		return this.ny;
	}

	public void setNy(final long ny) {
		this.ny = ny;
	}

	@Column(name = "NWIDTH", nullable = false, precision = 12, scale = 0)
	public long getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final long nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NHEIGHT", nullable = false, precision = 12, scale = 0)
	public long getNheight() {
		return this.nheight;
	}

	public void setNheight(final long nheight) {
		this.nheight = nheight;
	}

	@Column(name = "CDEFAULT", length = 40)
	public String getCdefault() {
		return this.cdefault;
	}

	public void setCdefault(final String cdefault) {
		this.cdefault = cdefault;
	}

}
