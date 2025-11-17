package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.09.2018 15:24:16 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;

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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CHECK_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CHECK_DETAIL")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenOutPpmCheckDetail implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmCheckDetailKey;

	private SysPpmCheckQuestions sysPpmCheckQuestions;

	private CenOutPpmCheck cenOutPpmCheck;

	private boolean nok;

	private String ccomment;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CHECK_DETAIL")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CHECK_DETAIL", sequenceName = "SEQ_CEN_OUT_PPM_CHECK_DETAIL", allocationSize = 1)
	@Column(name = "NPPM_CHECK_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmCheckDetailKey() {
		return this.nppmCheckDetailKey;
	}

	public void setNppmCheckDetailKey(final long nppmCheckDetailKey) {
		this.nppmCheckDetailKey = nppmCheckDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_CHECK_QUESTION_KEY", nullable = false)
	public SysPpmCheckQuestions getSysPpmCheckQuestions() {
		return this.sysPpmCheckQuestions;
	}

	public void setSysPpmCheckQuestions(final SysPpmCheckQuestions sysPpmCheckQuestions) {
		this.sysPpmCheckQuestions = sysPpmCheckQuestions;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_CHECK_KEY", nullable = false)
	public CenOutPpmCheck getCenOutPpmCheck() {
		return this.cenOutPpmCheck;
	}

	public void setCenOutPpmCheck(final CenOutPpmCheck cenOutPpmCheck) {
		this.cenOutPpmCheck = cenOutPpmCheck;
	}

	@Column(name = "NOK", nullable = false, precision = 1, scale = 0)
	public boolean isNok() {
		return this.nok;
	}

	public void setNok(final boolean nok) {
		this.nok = nok;
	}

	@Column(name = "CCOMMENT", length = 2048)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

}
