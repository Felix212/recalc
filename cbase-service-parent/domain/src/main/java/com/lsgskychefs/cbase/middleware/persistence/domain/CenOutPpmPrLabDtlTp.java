package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 18, 2017 11:11:23 AM by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_PR_LAB_DTL_TP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_PR_LAB_DTL_TP")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class CenOutPpmPrLabDtlTp implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmPrLabDtlTpId id;

	private CenOutPpmTrailDetail cenOutPpmTrailDetail;

	private CenOutPpmPrLabDetail cenOutPpmPrLabDetail;

	private Date dtimestamp;

	private String cuser;

	public CenOutPpmPrLabDtlTp() {
	}

	public CenOutPpmPrLabDtlTp(final CenOutPpmPrLabDtlTpId id, final CenOutPpmTrailDetail cenOutPpmTrailDetail,
			final CenOutPpmPrLabDetail cenOutPpmPrLabDetail) {
		this.id = id;
		this.cenOutPpmTrailDetail = cenOutPpmTrailDetail;
		this.cenOutPpmPrLabDetail = cenOutPpmPrLabDetail;
	}

	public CenOutPpmPrLabDtlTp(final CenOutPpmPrLabDtlTpId id, final CenOutPpmTrailDetail cenOutPpmTrailDetail,
			final CenOutPpmPrLabDetail cenOutPpmPrLabDetail, final Date dtimestamp, final String cuser) {
		this.id = id;
		this.cenOutPpmTrailDetail = cenOutPpmTrailDetail;
		this.cenOutPpmPrLabDetail = cenOutPpmPrLabDetail;
		this.dtimestamp = dtimestamp;
		this.cuser = cuser;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nppmPrLabDetailKey", column = @Column(name = "NPPM_PR_LAB_DETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nppmtrailDetailKey", column = @Column(name = "NPPMTRAIL_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmPrLabDtlTpId getId() {
		return this.id;
	}

	public void setId(final CenOutPpmPrLabDtlTpId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPMTRAIL_DETAIL_KEY", nullable = false, insertable = false, updatable = false)
	public CenOutPpmTrailDetail getCenOutPpmTrailDetail() {
		return this.cenOutPpmTrailDetail;
	}

	public void setCenOutPpmTrailDetail(final CenOutPpmTrailDetail cenOutPpmTrailDetail) {
		this.cenOutPpmTrailDetail = cenOutPpmTrailDetail;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_PR_LAB_DETAIL_KEY", nullable = false, insertable = false, updatable = false)
	@JsonBackReference
	public CenOutPpmPrLabDetail getCenOutPpmPrLabDetail() {
		return this.cenOutPpmPrLabDetail;
	}

	public void setCenOutPpmPrLabDetail(final CenOutPpmPrLabDetail cenOutPpmPrLabDetail) {
		this.cenOutPpmPrLabDetail = cenOutPpmPrLabDetail;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

}
