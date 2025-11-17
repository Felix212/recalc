package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.10.2016 11:20:34 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_SLS_CONCEPT_USAGE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_CONCEPT_USAGE")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nusageKey")
public class CenSlsConceptUsage implements DomainObject, java.io.Serializable {
	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nusageKey;
	private SysSlsAirline sysSlsAirline;
	private CenSlsConcept cenSlsConcept;
	private String ctext;

	public CenSlsConceptUsage() {
	}

	public CenSlsConceptUsage(final long nusageKey, final SysSlsAirline sysSlsAirlines, final CenSlsConcept cenSlsConcepts,
			final String ctext) {
		this.nusageKey = nusageKey;
		this.sysSlsAirline = sysSlsAirlines;
		this.cenSlsConcept = cenSlsConcepts;
		this.ctext = ctext;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_CONCEPT_USAGE")
	@SequenceGenerator(name = "SEQ_CEN_SLS_CONCEPT_USAGE", sequenceName = "SEQ_CEN_SLS_CONCEPT_USAGE", allocationSize = 1)
	@Column(name = "NUSAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNusageKey() {
		return this.nusageKey;
	}

	public void setNusageKey(final long nusageKey) {
		this.nusageKey = nusageKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public SysSlsAirline getSysSlsAirline() {
		return this.sysSlsAirline;
	}

	public void setSysSlsAirline(final SysSlsAirline sysSlsAirline) {
		this.sysSlsAirline = sysSlsAirline;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCONCEPT_KEY", nullable = false)
	public CenSlsConcept getCenSlsConcept() {
		return this.cenSlsConcept;
	}

	public void setCenSlsConcept(final CenSlsConcept cenSlsConcept) {
		this.cenSlsConcept = cenSlsConcept;
	}

	@Column(name = "CTEXT", nullable = false, length = 256)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

}
