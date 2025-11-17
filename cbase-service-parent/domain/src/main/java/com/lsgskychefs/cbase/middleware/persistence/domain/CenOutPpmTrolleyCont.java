package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20.03.2017 09:55:51 by Hibernate Tools 4.3.5.Final

import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_TROLLEY_CONT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_TROLLEY_CONT")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nppmTrContKey")
public class CenOutPpmTrolleyCont implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmTrContKey;
	private CenOutPpmTrolley cenOutPpmTrolley;
	private Long nbatchSeq;
	private Date dtimestamp;
	private String cuser;
	private Long nppmProdLabelKeyMaster;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_TROLLEY_CONT")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_TROLLEY_CONT", sequenceName = "SEQ_CEN_OUT_PPM_TROLLEY_CONT", allocationSize = 1)
	@Column(name = "NPPM_TR_CONT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmTrContKey() {
		return this.nppmTrContKey;
	}

	public void setNppmTrContKey(final long nppmTrContKey) {
		this.nppmTrContKey = nppmTrContKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_TROLLEY_KEY", nullable = false)
	public CenOutPpmTrolley getCenOutPpmTrolley() {
		return this.cenOutPpmTrolley;
	}

	public void setCenOutPpmTrolley(final CenOutPpmTrolley cenOutPpmTrolley) {
		this.cenOutPpmTrolley = cenOutPpmTrolley;
	}

	@Column(name = "NBATCH_SEQ", nullable = false, precision = 12, scale = 0)
	public Long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final Long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "NPPM_PROD_LABEL_KEY_MASTER", precision = 12, scale = 0)
	public Long getNppmProdLabelKeyMaster() {
		return this.nppmProdLabelKeyMaster;
	}

	public void setNppmProdLabelKeyMaster(final Long nppmProdLabelKeyMaster) {
		this.nppmProdLabelKeyMaster = nppmProdLabelKeyMaster;
	}

}
