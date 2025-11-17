package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.07.2023 10:16:43 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PL_COST_PROJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_COST_PROJECT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenPlCostProject implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplCostProjectKey;
	private CenPackinglists cenPackinglists;
	private CenFollowUpMaster cenFollowUpMaster;
	private CenCostProject cenCostProject;
	private String ccomment;
	private Long nsort;
	private String canalyst;
	private Date dauditDate;
	private BigDecimal nchecked;
	private Date dtimestamp;
	private boolean nisHeader;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PL_COST_PROJECT")
	@SequenceGenerator(name = "SEQ_CEN_PL_COST_PROJECT", sequenceName = "SEQ_CEN_PL_COST_PROJECT", allocationSize = 1)
	@Column(name = "NPL_COST_PROJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplCostProjectKey() {
		return this.nplCostProjectKey;
	}

	public void setNplCostProjectKey(long nplCostProjectKey) {
		this.nplCostProjectKey = nplCostProjectKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return this.cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCOST_PROJECT_KEY", nullable = false)
	public CenCostProject getCenCostProject() {
		return this.cenCostProject;
	}

	public void setCenCostProject(CenCostProject cenCostProject) {
		this.cenCostProject = cenCostProject;
	}

	@Column(name = "CCOMMENT", length = 512)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(Long nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CANALYST", length = 512)
	public String getCanalyst() {
		return this.canalyst;
	}

	public void setCanalyst(String canalyst) {
		this.canalyst = canalyst;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DAUDIT_DATE", length = 7)
	public Date getDauditDate() {
		return this.dauditDate;
	}

	public void setDauditDate(Date dauditDate) {
		this.dauditDate = dauditDate;
	}

	@Column(name = "NCHECKED", precision = 22, scale = 0)
	public BigDecimal getNchecked() {
		return this.nchecked;
	}

	public void setNchecked(BigDecimal nchecked) {
		this.nchecked = nchecked;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name="NIS_HEADER", precision=22, scale=0)
	public boolean getNisHeader() {
		return this.nisHeader;
	}

	public void setNisHeader(boolean nisHeader) {
		this.nisHeader = nisHeader;
	}

}


