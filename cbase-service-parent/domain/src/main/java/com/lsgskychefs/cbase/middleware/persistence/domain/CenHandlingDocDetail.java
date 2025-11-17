package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.08.2016 09:42:20 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_HANDLING_DOC_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_HANDLING_DOC_DETAIL")
public class CenHandlingDocDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhandlingDetailKey;
	private CenHandling cenHandling;
	private CenCateringUserobject cenCateringUserobject;
	private int nprio;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String ctimeFrom;
	private String ctimeTo;

	@Id
	@Column(name = "NHANDLING_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingDetailKey() {
		return this.nhandlingDetailKey;
	}

	public void setNhandlingDetailKey(final long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_KEY", nullable = false)
	public CenHandling getCenHandling() {
		return this.cenHandling;
	}

	public void setCenHandling(final CenHandling cenHandling) {
		this.cenHandling = cenHandling;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCATERING_USEROBJECT_ID", nullable = false)
	public CenCateringUserobject getCenCateringUserobject() {
		return this.cenCateringUserobject;
	}

	public void setCenCateringUserobject(final CenCateringUserobject cenCateringUserobject) {
		this.cenCateringUserobject = cenCateringUserobject;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CTIME_FROM", nullable = false, length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(final String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", nullable = false, length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(final String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

}
