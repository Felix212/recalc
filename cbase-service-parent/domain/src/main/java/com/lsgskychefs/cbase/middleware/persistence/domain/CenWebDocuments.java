package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.06.2016 11:23:54 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table CEN_WEB_DOCUMENTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_WEB_DOCUMENTS")
public class CenWebDocuments implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenWebDocumentsId id;
	private String cdiagramm;
	private String cdocuments;
	private String cloadinglist;
	private String cpackinglistindex;
	private String cstationinstruction;
	private Date dtimestamp;
	private String cpackinglistindexxls;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cflightKey", column = @Column(name = "CFLIGHT_KEY", nullable = false, length = 25)),
			@AttributeOverride(name = "cuser", column = @Column(name = "CUSER", nullable = false, length = 15)) })
	public CenWebDocumentsId getId() {
		return this.id;
	}

	public void setId(final CenWebDocumentsId id) {
		this.id = id;
	}

	@Column(name = "CDIAGRAMM", length = 80)
	public String getCdiagramm() {
		return this.cdiagramm;
	}

	public void setCdiagramm(final String cdiagramm) {
		this.cdiagramm = cdiagramm;
	}

	@Column(name = "CDOCUMENTS", length = 80)
	public String getCdocuments() {
		return this.cdocuments;
	}

	public void setCdocuments(final String cdocuments) {
		this.cdocuments = cdocuments;
	}

	@Column(name = "CLOADINGLIST", length = 80)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "CPACKINGLISTINDEX", length = 80)
	public String getCpackinglistindex() {
		return this.cpackinglistindex;
	}

	public void setCpackinglistindex(final String cpackinglistindex) {
		this.cpackinglistindex = cpackinglistindex;
	}

	@Column(name = "CSTATIONINSTRUCTION", length = 80)
	public String getCstationinstruction() {
		return this.cstationinstruction;
	}

	public void setCstationinstruction(final String cstationinstruction) {
		this.cstationinstruction = cstationinstruction;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CPACKINGLISTINDEXXLS", length = 80)
	public String getCpackinglistindexxls() {
		return this.cpackinglistindexxls;
	}

	public void setCpackinglistindexxls(final String cpackinglistindexxls) {
		this.cpackinglistindexxls = cpackinglistindexxls;
	}

}
