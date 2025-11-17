package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.09.2018 15:24:16 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CHECK
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CHECK")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenOutPpmCheck implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmCheckKey;

	@JsonIgnore
	private CenOutPpmSched cenOutPpmSched;

	private long nbatchSeq;

	private String cuser;

	private Date dtimestamp;

	@JsonIgnore
	private Set<CenOutPpmCheckDetail> cenOutPpmCheckDetails = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CHECK")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CHECK", sequenceName = "SEQ_CEN_OUT_PPM_CHECK", allocationSize = 1)
	@Column(name = "NPPM_CHECK_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmCheckKey() {
		return this.nppmCheckKey;
	}

	public void setNppmCheckKey(final long nppmCheckKey) {
		this.nppmCheckKey = nppmCheckKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_SCHED_KEY", nullable = false)
	public CenOutPpmSched getCenOutPpmSched() {
		return this.cenOutPpmSched;
	}

	public void setCenOutPpmSched(final CenOutPpmSched cenOutPpmSched) {
		this.cenOutPpmSched = cenOutPpmSched;
	}

	@Column(name = "NBATCH_SEQ", nullable = false, precision = 12, scale = 0)
	public long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmCheck")
	public Set<CenOutPpmCheckDetail> getCenOutPpmCheckDetails() {
		return this.cenOutPpmCheckDetails;
	}

	public void setCenOutPpmCheckDetails(final Set<CenOutPpmCheckDetail> cenOutPpmCheckDetails) {
		this.cenOutPpmCheckDetails = cenOutPpmCheckDetails;
	}

}
