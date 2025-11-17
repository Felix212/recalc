package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Sep 15, 2017 7:52:18 AM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_OUT_CARTDIAGRAMS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_CARTDIAGRAMS")
public class CenOutCartdiagrams implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutCartdiagramsId id;
	private CenOut cenOut;
	private String cuser;
	private String cfilename;
	private Long nareaKey;
	private Long nworkstationKey;
	private String carea;
	private String cworkstation;
	private Date dtimestamp;
	private String cgalley;
	private String cstowage;

	public CenOutCartdiagrams() {
	}

	public CenOutCartdiagrams(final CenOutCartdiagramsId id, final CenOut cenOut, final String cuser) {
		this.id = id;
		this.cenOut = cenOut;
		this.cuser = cuser;
	}

	public CenOutCartdiagrams(final CenOutCartdiagramsId id, final CenOut cenOut, final String cuser, final String cfilename,
			final Long nareaKey, final Long nworkstationKey, final String carea, final String cworkstation, final Date dtimestamp,
			final String cgalley, final String cstowage) {
		this.id = id;
		this.cenOut = cenOut;
		this.cuser = cuser;
		this.cfilename = cfilename;
		this.nareaKey = nareaKey;
		this.nworkstationKey = nworkstationKey;
		this.carea = carea;
		this.cworkstation = cworkstation;
		this.dtimestamp = dtimestamp;
		this.cgalley = cgalley;
		this.cstowage = cstowage;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ctype", column = @Column(name = "CTYPE", nullable = false, length = 10)),
			@AttributeOverride(name = "ncounter", column = @Column(name = "NCOUNTER", nullable = false, precision = 4, scale = 0)) })
	public CenOutCartdiagramsId getId() {
		return this.id;
	}

	public void setId(final CenOutCartdiagramsId id) {
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

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CFILENAME", length = 80)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(final String cfilename) {
		this.cfilename = cfilename;
	}

	@Column(name = "NAREA_KEY", precision = 12, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 12, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "CAREA", length = 80)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CWORKSTATION", length = 80)
	public String getCworkstation() {
		return this.cworkstation;
	}

	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CGALLEY", length = 80)
	public String getCgalley() {
		return this.cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "CSTOWAGE", length = 80)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

}
