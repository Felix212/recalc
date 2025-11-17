package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.10.2016 11:20:34 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_SLS_CONCEPT_ATTACH
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_CONCEPT_ATTACH")
public class CenSlsConceptAttach implements DomainObject, java.io.Serializable {
	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nattachmentKey;

	private CenSlsConcept cenSlsConcept;

	private String cname;

	private String cfilename;

	private String ctype;

	private byte[] battachment;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_CONCEPT_ATTACH")
	@SequenceGenerator(name = "SEQ_CEN_SLS_CONCEPT_ATTACH", sequenceName = "SEQ_CEN_SLS_CONCEPT_ATTACH", allocationSize = 1)
	@Column(name = "NATTACHMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNattachmentKey() {
		return this.nattachmentKey;
	}

	public void setNattachmentKey(final long nattachmentKey) {
		this.nattachmentKey = nattachmentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCONCEPT_KEY", nullable = false)
	@JsonIgnore
	public CenSlsConcept getCenSlsConcept() {
		return this.cenSlsConcept;
	}

	public void setCenSlsConcept(final CenSlsConcept cenSlsConcept) {
		this.cenSlsConcept = cenSlsConcept;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CFILENAME", nullable = false, length = 256)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(final String cfilename) {
		this.cfilename = cfilename;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CTYPE", nullable = false, length = 5)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	@JsonView(View.SimpleWithReferences.class)
	@Column(name = "BATTACHMENT")
	public byte[] getBattachment() {
		return this.battachment;
	}

	public void setBattachment(final byte[] battachment) {
		this.battachment = battachment;
	}

}
