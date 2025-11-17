package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_OUT_TEXT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_TEXT")
public class CenOutText implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** nresultKey */
	@JsonIgnore
	private long nresultKey;

	/** cenOut */
	@JsonIgnore
	private CenOut cenOut;

	/** ntransaction */
	@JsonIgnore
	private long ntransaction;

	/** ctextinfo */
	@JsonView(View.Simple.class)
	private String ctextinfo;

	/** dtimestamp */
	@JsonIgnore
	private Date dtimestamp;

	/** nstatus */
	@JsonIgnore
	private int nstatus;

	/** cdescription */
	@JsonIgnore
	private String cdescription;

	/** cenOutTextAreas */
	@JsonView(View.Simple.class)
	private Set<CenOutTextArea> cenOutTextAreas = new HashSet<>(0);

	@Id
	@Column(name = "NRESULT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "CTEXTINFO", length = 2048)
	public String getCtextinfo() {
		return this.ctextinfo;
	}

	public void setCtextinfo(final String ctextinfo) {
		this.ctextinfo = ctextinfo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CDESCRIPTION", length = 30)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutText")
	public Set<CenOutTextArea> getCenOutTextAreas() {
		return this.cenOutTextAreas;
	}

	public void setCenOutTextAreas(final Set<CenOutTextArea> cenOutTextAreas) {
		this.cenOutTextAreas = cenOutTextAreas;
	}

}
