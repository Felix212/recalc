package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_LOS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_LOS")
public class CenOutLos implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long npacketsKey;
	private CenOut cenOut;
	private long nresultKeyGroup;
	private int nlegNumber;
	private String closClass;
	private String closGrpCode;
	private String closVar;

	public CenOutLos() {
	}

	public CenOutLos(final long npacketsKey, final CenOut cenOut, final long nresultKeyGroup, final int nlegNumber,
			final String closClass) {
		this.npacketsKey = npacketsKey;
		this.cenOut = cenOut;
		this.nresultKeyGroup = nresultKeyGroup;
		this.nlegNumber = nlegNumber;
		this.closClass = closClass;
	}

	public CenOutLos(final long npacketsKey, final CenOut cenOut, final long nresultKeyGroup, final int nlegNumber, final String closClass,
			final String closGrpCode, final String closVar) {
		this.npacketsKey = npacketsKey;
		this.cenOut = cenOut;
		this.nresultKeyGroup = nresultKeyGroup;
		this.nlegNumber = nlegNumber;
		this.closClass = closClass;
		this.closGrpCode = closGrpCode;
		this.closVar = closVar;
	}

	@Id

	@Column(name = "NPACKETS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpacketsKey() {
		return this.npacketsKey;
	}

	public void setNpacketsKey(final long npacketsKey) {
		this.npacketsKey = npacketsKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NRESULT_KEY_GROUP", nullable = false, precision = 12, scale = 0)
	public long getNresultKeyGroup() {
		return this.nresultKeyGroup;
	}

	public void setNresultKeyGroup(final long nresultKeyGroup) {
		this.nresultKeyGroup = nresultKeyGroup;
	}

	@Column(name = "NLEG_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNlegNumber() {
		return this.nlegNumber;
	}

	public void setNlegNumber(final int nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	@Column(name = "CLOS_CLASS", nullable = false, length = 6)
	public String getClosClass() {
		return this.closClass;
	}

	public void setClosClass(final String closClass) {
		this.closClass = closClass;
	}

	@Column(name = "CLOS_GRP_CODE", length = 40)
	public String getClosGrpCode() {
		return this.closGrpCode;
	}

	public void setClosGrpCode(final String closGrpCode) {
		this.closGrpCode = closGrpCode;
	}

	@Column(name = "CLOS_VAR", length = 40)
	public String getClosVar() {
		return this.closVar;
	}

	public void setClosVar(final String closVar) {
		this.closVar = closVar;
	}

}
