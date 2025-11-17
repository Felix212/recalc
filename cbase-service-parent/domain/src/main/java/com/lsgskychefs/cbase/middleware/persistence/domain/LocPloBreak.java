package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 3, 2018 4:59:37 PM by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table LOC_PLO_BREAK
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PLO_BREAK")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocPloBreak implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nbreakKey;
	@JsonIgnore
	private SysUnits sysUnits;
	@JsonIgnore
	private String cclient;
	private String cbreak;
	private String ctext;
	private String ctimeStart;
	private String ctimeEnd;
	@JsonIgnore
	private Set<LocPloWsShiftBreak> locPloWsShiftBreaks = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_PLO_BREAK")
	@SequenceGenerator(name = "SEQ_LOC_PLO_BREAK", sequenceName = "SEQ_LOC_PLO_BREAK", allocationSize = 1)
	@Column(name = "NBREAK_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNbreakKey() {
		return this.nbreakKey;
	}

	public void setNbreakKey(final long nbreakKey) {
		this.nbreakKey = nbreakKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CBREAK", nullable = false, length = 60)
	public String getCbreak() {
		return this.cbreak;
	}

	public void setCbreak(final String cbreak) {
		this.cbreak = cbreak;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTIME_START", nullable = false, length = 5)
	public String getCtimeStart() {
		return this.ctimeStart;
	}

	public void setCtimeStart(final String ctimeStart) {
		this.ctimeStart = ctimeStart;
	}

	@Column(name = "CTIME_END", nullable = false, length = 5)
	public String getCtimeEnd() {
		return this.ctimeEnd;
	}

	public void setCtimeEnd(final String ctimeEnd) {
		this.ctimeEnd = ctimeEnd;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locPloBreak")
	public Set<LocPloWsShiftBreak> getLocPloWsShiftBreaks() {
		return this.locPloWsShiftBreaks;
	}

	public void setLocPloWsShiftBreaks(final Set<LocPloWsShiftBreak> locPloWsShiftBreaks) {
		this.locPloWsShiftBreaks = locPloWsShiftBreaks;
	}

}
