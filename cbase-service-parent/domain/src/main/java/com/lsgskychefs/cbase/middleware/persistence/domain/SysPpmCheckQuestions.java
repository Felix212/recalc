package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.09.2018 15:24:16 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_PPM_CHECK_QUESTIONS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PPM_CHECK_QUESTIONS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysPpmCheckQuestions implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmCheckQuestionKey;

	private String cquestion;

	private int nsort;

	private boolean nactive;

	private Set<CenOutPpmCheckDetail> cenOutPpmCheckDetails = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_PPM_CHECK_QUESTIONS")
	@SequenceGenerator(name = "SEQ_SYS_PPM_CHECK_QUESTIONS", sequenceName = "SEQ_SYS_PPM_CHECK_QUESTIONS", allocationSize = 1)
	@Column(name = "NPPM_CHECK_QUESTION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmCheckQuestionKey() {
		return this.nppmCheckQuestionKey;
	}

	public void setNppmCheckQuestionKey(final long nppmCheckQuestionKey) {
		this.nppmCheckQuestionKey = nppmCheckQuestionKey;
	}

	@Column(name = "CQUESTION", nullable = false, length = 1024)
	public String getCquestion() {
		return this.cquestion;
	}

	public void setCquestion(final String cquestion) {
		this.cquestion = cquestion;
	}

	@Column(name = "NSORT", nullable = false, precision = 1, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NACTIVE", nullable = false, precision = 1, scale = 0)
	public boolean isNactive() {
		return this.nactive;
	}

	public void setNactive(final boolean nactive) {
		this.nactive = nactive;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPpmCheckQuestions")
	@JsonIgnore
	public Set<CenOutPpmCheckDetail> getCenOutPpmCheckDetails() {
		return this.cenOutPpmCheckDetails;
	}

	public void setCenOutPpmCheckDetails(final Set<CenOutPpmCheckDetail> cenOutPpmCheckDetails) {
		this.cenOutPpmCheckDetails = cenOutPpmCheckDetails;
	}

}
