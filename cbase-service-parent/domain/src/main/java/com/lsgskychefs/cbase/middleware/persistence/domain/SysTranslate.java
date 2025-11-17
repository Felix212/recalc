package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_TRANSLATE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_TRANSLATE")
public class SysTranslate implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private String cpurpose;
	private int nobject;
	private String cgerman;
	private String cenglish;
	private String clanguage3;
	private String clanguage4;
	private String clanguage5;
	private String clanguage6;
	private String clanguage7;
	private String clanguage8;
	private String clanguage9;
	private Integer nstatus;
	private String cprogramInsert;
	private Date dtimestamp;

	public SysTranslate() {
	}

	public SysTranslate(final String cpurpose, final int nobject, final String cgerman, final String cenglish) {
		this.cpurpose = cpurpose;
		this.nobject = nobject;
		this.cgerman = cgerman;
		this.cenglish = cenglish;
	}

	public SysTranslate(final String cpurpose, final int nobject, final String cgerman, final String cenglish, final String clanguage3,
			final String clanguage4, final String clanguage5, final String clanguage6, final String clanguage7, final String clanguage8,
			final String clanguage9, final Integer nstatus, final String cprogramInsert, final Date dtimestamp) {
		this.cpurpose = cpurpose;
		this.nobject = nobject;
		this.cgerman = cgerman;
		this.cenglish = cenglish;
		this.clanguage3 = clanguage3;
		this.clanguage4 = clanguage4;
		this.clanguage5 = clanguage5;
		this.clanguage6 = clanguage6;
		this.clanguage7 = clanguage7;
		this.clanguage8 = clanguage8;
		this.clanguage9 = clanguage9;
		this.nstatus = nstatus;
		this.cprogramInsert = cprogramInsert;
		this.dtimestamp = dtimestamp;
	}

	@Id

	@Column(name = "CPURPOSE", unique = true, nullable = false, length = 250)
	public String getCpurpose() {
		return this.cpurpose;
	}

	public void setCpurpose(final String cpurpose) {
		this.cpurpose = cpurpose;
	}

	@Column(name = "NOBJECT", nullable = false, precision = 2, scale = 0)
	public int getNobject() {
		return this.nobject;
	}

	public void setNobject(final int nobject) {
		this.nobject = nobject;
	}

	@Column(name = "CGERMAN", nullable = false, length = 250)
	public String getCgerman() {
		return this.cgerman;
	}

	public void setCgerman(final String cgerman) {
		this.cgerman = cgerman;
	}

	@Column(name = "CENGLISH", nullable = false, length = 250)
	public String getCenglish() {
		return this.cenglish;
	}

	public void setCenglish(final String cenglish) {
		this.cenglish = cenglish;
	}

	@Column(name = "CLANGUAGE3", length = 250)
	public String getClanguage3() {
		return this.clanguage3;
	}

	public void setClanguage3(final String clanguage3) {
		this.clanguage3 = clanguage3;
	}

	@Column(name = "CLANGUAGE4", length = 250)
	public String getClanguage4() {
		return this.clanguage4;
	}

	public void setClanguage4(final String clanguage4) {
		this.clanguage4 = clanguage4;
	}

	@Column(name = "CLANGUAGE5", length = 250)
	public String getClanguage5() {
		return this.clanguage5;
	}

	public void setClanguage5(final String clanguage5) {
		this.clanguage5 = clanguage5;
	}

	@Column(name = "CLANGUAGE6", length = 250)
	public String getClanguage6() {
		return this.clanguage6;
	}

	public void setClanguage6(final String clanguage6) {
		this.clanguage6 = clanguage6;
	}

	@Column(name = "CLANGUAGE7", length = 250)
	public String getClanguage7() {
		return this.clanguage7;
	}

	public void setClanguage7(final String clanguage7) {
		this.clanguage7 = clanguage7;
	}

	@Column(name = "CLANGUAGE8", length = 250)
	public String getClanguage8() {
		return this.clanguage8;
	}

	public void setClanguage8(final String clanguage8) {
		this.clanguage8 = clanguage8;
	}

	@Column(name = "CLANGUAGE9", length = 250)
	public String getClanguage9() {
		return this.clanguage9;
	}

	public void setClanguage9(final String clanguage9) {
		this.clanguage9 = clanguage9;
	}

	@Column(name = "NSTATUS", precision = 1, scale = 0)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CPROGRAM_INSERT", length = 250)
	public String getCprogramInsert() {
		return this.cprogramInsert;
	}

	public void setCprogramInsert(final String cprogramInsert) {
		this.cprogramInsert = cprogramInsert;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
