package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20.05.2016 12:31:08 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_KEY_LIST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_KEY_LIST")
public class CenKeyList implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenKeyListId id;
	private String ctag;
	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nsessionKey", column = @Column(name = "NSESSION_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenKeyListId getId() {
		return this.id;
	}

	public void setId(final CenKeyListId id) {
		this.id = id;
	}

	@Column(name = "CTAG", length = 30)
	public String getCtag() {
		return this.ctag;
	}

	public void setCtag(final String ctag) {
		this.ctag = ctag;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTimestamp", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
