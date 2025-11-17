package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_TEXT_AREA
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_TEXT_AREA")
public class CenOutTextArea implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** id */
	@JsonIgnore
	private CenOutTextAreaId id;

	/** cenOutText */
	@JsonIgnore
	private CenOutText cenOutText;

	/** ntransaction */
	@JsonIgnore
	private long ntransaction;

	/** carea */
	@JsonView(View.Simple.class)
	private String carea;

	/** ctext */
	@JsonView(View.Simple.class)
	private String ctext;

	/** nsend */
	@JsonView(View.Simple.class)
	private int nsend;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nareaKey", column = @Column(name = "NAREA_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutTextAreaId getId() {
		return this.id;
	}

	public void setId(final CenOutTextAreaId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOutText getCenOutText() {
		return this.cenOutText;
	}

	public void setCenOutText(final CenOutText cenOutText) {
		this.cenOutText = cenOutText;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "CAREA", nullable = false, length = 12)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NSEND", nullable = false, precision = 1, scale = 0)
	public int getNsend() {
		return this.nsend;
	}

	public void setNsend(final int nsend) {
		this.nsend = nsend;
	}

}
