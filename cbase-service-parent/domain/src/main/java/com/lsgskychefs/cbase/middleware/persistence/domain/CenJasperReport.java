package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20.09.2016 09:10:52 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.sql.Clob;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_JASPER_REPORT. Contains the JasperReport-XML and compiled data. And information for complete
 * report(main, sub report),
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_JASPER_REPORT")
public class CenJasperReport implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** The id/pk of this report. */
	private long njasperKey;
	/** A main report an his subreports have the same njasperGroupKey */
	private Set<CenJasperReport> cenJasperReports = new HashSet<>(0);
	/** The information if the report is a main-report or a subreport. */
	private boolean mainReport;
	/** timestamp for xml update. */
	private Date dupdatedDate;
	/** The Jasper Report XML definition. */
	private Clob clbJasperXml;
	/** The rport name, is partielly used as 'foreign key' (CenLabelTypeDetail) */
	private String cname;
	/** The compiled XML, can be null, than compile the xml and save the report */
	private byte[] blbJasper;
	private Set<CenLabelTypeDetail> cenLabelTypeDetails = new HashSet<>(0);

	@Id
	@Column(name = "NJASPER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNjasperKey() {
		return this.njasperKey;
	}

	public void setNjasperKey(final long njasperKey) {
		this.njasperKey = njasperKey;
	}

	@Column(name = "NIS_MAIN_REPORT", nullable = false, precision = 1, scale = 0)
	public boolean isMainReport() {
		return this.mainReport;
	}

	public void setMainReport(final boolean isMainReport) {
		this.mainReport = isMainReport;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", nullable = false, length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CLB_JASPER_XML")
	public Clob getClbJasperXml() {
		return this.clbJasperXml;
	}

	public void setClbJasperXml(final Clob clbJasperXml) {
		this.clbJasperXml = clbJasperXml;
	}

	@Column(name = "CNAME", nullable = false, length = 50)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Lob
	@Column(name = "BLB_JASPER")
	public byte[] getBlbJasper() {
		return this.blbJasper;
	}

	public void setBlbJasper(final byte[] blbJasper) {
		this.blbJasper = blbJasper;
	}

	/**
	 * Get cenJasperReports
	 *
	 * @return the cenJasperReports
	 */
	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJASPER_GROUP_KEY", nullable = false)
	public Set<CenJasperReport> getCenJasperReports() {
		return cenJasperReports;
	}

	public void setCenJasperReports(final Set<CenJasperReport> cenJasperreports) {
		this.cenJasperReports = cenJasperreports;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenJasperReport")
	public Set<CenLabelTypeDetail> getCenLabelTypeDetails() {
		return this.cenLabelTypeDetails;
	}

	public void setCenLabelTypeDetails(final Set<CenLabelTypeDetail> cenLabelTypeDetails) {
		this.cenLabelTypeDetails = cenLabelTypeDetails;
	}

}
