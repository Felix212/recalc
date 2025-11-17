package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 17, 2017 10:39:57 AM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_SLS_PROJ_CONC_ATT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJ_CONC_ATT")
public class CenSlsProjConcAtt implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenSlsProjConcAttId id;
	private CenSlsProjConcept cenSlsProjConcept;
	private String cname;
	private String cfilename;
	private String ctype;
	private byte[] battachment;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nprojConceptKey", column = @Column(name = "NPROJ_CONCEPT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nattachmentKey", column = @Column(name = "NATTACHMENT_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenSlsProjConcAttId getId() {
		return this.id;
	}

	public void setId(final CenSlsProjConcAttId id) {
		this.id = id;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_CONCEPT_KEY", nullable = false, insertable = false, updatable = false)
	public CenSlsProjConcept getCenSlsProjConcept() {
		return this.cenSlsProjConcept;
	}

	public void setCenSlsProjConcept(final CenSlsProjConcept cenSlsProjConcept) {
		this.cenSlsProjConcept = cenSlsProjConcept;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CFILENAME", nullable = false, length = 256)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(final String cfilename) {
		this.cfilename = cfilename;
	}

	@Column(name = "CTYPE", nullable = false, length = 5)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	@JsonIgnore
	@Column(name = "BATTACHMENT")
	public byte[] getBattachment() {
		return this.battachment;
	}

	public void setBattachment(final byte[] battachment) {
		this.battachment = battachment;
	}

}
