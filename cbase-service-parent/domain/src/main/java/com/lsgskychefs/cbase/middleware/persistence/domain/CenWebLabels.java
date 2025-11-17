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
 * Entity(DomainObject) for table CEN_WEB_LABELS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_WEB_LABELS")
public class CenWebLabels implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenWebLabelsId id;
	private String carea;
	private String cdescription;
	private String clabel;
	private String cstationinstruction;
	private Date dtimestamp;
	private Integer nbelly;
	private String ccomment;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cflightKey", column = @Column(name = "CFLIGHT_KEY", nullable = false, length = 25)),
			@AttributeOverride(name = "cuser", column = @Column(name = "CUSER", nullable = false, length = 15)),
			@AttributeOverride(name = "nsort", column = @Column(name = "NSORT", nullable = false, precision = 12, scale = 0)) })
	public CenWebLabelsId getId() {
		return this.id;
	}

	public void setId(final CenWebLabelsId id) {
		this.id = id;
	}

	@Column(name = "CAREA", length = 80)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CDESCRIPTION", length = 80)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CLABEL", length = 80)
	public String getClabel() {
		return this.clabel;
	}

	public void setClabel(final String clabel) {
		this.clabel = clabel;
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

	@Column(name = "NBELLY", precision = 1, scale = 0)
	public Integer getNbelly() {
		return this.nbelly;
	}

	public void setNbelly(final Integer nbelly) {
		this.nbelly = nbelly;
	}

	@Column(name = "CCOMMENT", length = 80)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

}
