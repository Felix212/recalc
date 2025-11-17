package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.03.2024 13:15:59 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_CHECKPT_STOWAGE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_CHECKPT_STOWAGE"
)
public class CenOutCheckptStowage implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncheckptStowageKey;
	@JsonIgnore
	private CenOutCheckpt cenOutCheckpt;
	private Date drealTime;
	private Integer nstate;
	private Long nstowageKey;
	private String cunit;
	private Long npackingstIndexKey;
	private Long npackinglistDetailKey;
	private String cpackinglist;
	private String ctext;
	private String cstowage;
	private String cgalley;
	private String cplace;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_CHECKPT_STOWAGE")
	@SequenceGenerator(name = "SEQ_CEN_OUT_CHECKPT_STOWAGE", sequenceName = "SEQ_CEN_OUT_CHECKPT_STOWAGE", allocationSize = 1)
	@Column(name = "NCHECKPT_STOWAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcheckptStowageKey() {
		return this.ncheckptStowageKey;
	}

	public void setNcheckptStowageKey(long ncheckptStowageKey) {
		this.ncheckptStowageKey = ncheckptStowageKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NCHECKPOINT_KEY", referencedColumnName = "NCHECKPOINT_KEY", nullable = false) })
	public CenOutCheckpt getCenOutCheckpt() {
		return this.cenOutCheckpt;
	}

	public void setCenOutCheckpt(CenOutCheckpt cenOutCheckpt) {
		this.cenOutCheckpt = cenOutCheckpt;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DREAL_TIME", length = 7)
	public Date getDrealTime() {
		return this.drealTime;
	}

	public void setDrealTime(Date drealTime) {
		this.drealTime = drealTime;
	}

	@Column(name = "NSTATE", precision = 1, scale = 0)
	public Integer getNstate() {
		return this.nstate;
	}

	public void setNstate(Integer nstate) {
		this.nstate = nstate;
	}

	@Column(name = "NSTOWAGE_KEY", precision = 12, scale = 0)
	public Long getNstowageKey() {
		return this.nstowageKey;
	}

	public void setNstowageKey(Long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	@Column(name = "CUNIT", length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NPACKINGST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackingstIndexKey() {
		return this.npackingstIndexKey;
	}

	public void setNpackingstIndexKey(Long npackingstIndexKey) {
		this.npackingstIndexKey = npackingstIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CPACKINGLIST", length = 36)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", length = 50)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CSTOWAGE", length = 20)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CGALLEY", length = 20)
	public String getCgalley() {
		return cgalley;
	}

	public void setCgalley(String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "CPLACE", length = 20)
	public String getCplace() {
		return cplace;
	}

	public void setCplace(String cplace) {
		this.cplace = cplace;
	}
}


