package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_LABELS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_LABELS")
public class CenOutLabels implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutLabelsId id;
	private CenOut cenOut;
	private String carea;
	private String cdescription;
	private String clabel;
	private Integer nbelly;
	private String ccomment;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cuser", column = @Column(name = "CUSER", nullable = false, length = 15)),
			@AttributeOverride(name = "nsort", column = @Column(name = "NSORT", nullable = false, precision = 12, scale = 0)) })
	public CenOutLabelsId getId() {
		return this.id;
	}

	public void setId(final CenOutLabelsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
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

	@Column(name = "CLABEL", nullable = false, length = 80)
	public String getClabel() {
		return this.clabel;
	}

	public void setClabel(final String clabel) {
		this.clabel = clabel;
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
