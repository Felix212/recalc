package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 29.03.2016 13:08:37 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_AIRL_CATEGORIES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRL_CATEGORIES")
public class CenAirlCategories implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenAirlCategoriesId id;
	private SysAirlineCat sysAirlineCat;
	private CenAirlines cenAirlines;
	private Date dtimestampModification;

	public CenAirlCategories() {
	}

	public CenAirlCategories(final CenAirlCategoriesId id, final SysAirlineCat sysAirlineCat, final CenAirlines cenAirlines) {
		this.id = id;
		this.sysAirlineCat = sysAirlineCat;
		this.cenAirlines = cenAirlines;
	}

	public CenAirlCategories(final CenAirlCategoriesId id, final SysAirlineCat sysAirlineCat, final CenAirlines cenAirlines,
			final Date dtimestampModification) {
		this.id = id;
		this.sysAirlineCat = sysAirlineCat;
		this.cenAirlines = cenAirlines;
		this.dtimestampModification = dtimestampModification;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "ncatKey", column = @Column(name = "NCAT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nairlineKey",
					column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenAirlCategoriesId getId() {
		return this.id;
	}

	public void setId(final CenAirlCategoriesId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCAT_KEY", nullable = false, insertable = false, updatable = false)
	public SysAirlineCat getSysAirlineCat() {
		return this.sysAirlineCat;
	}

	public void setSysAirlineCat(final SysAirlineCat sysAirlineCat) {
		this.sysAirlineCat = sysAirlineCat;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

}
