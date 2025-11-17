package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.06.2017 12:12:34 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CO_BATCHCODE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CO_BATCHCODE")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nppmBatchcodeKey")
public class CenOutPpmCoBatchcode implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmBatchcodeKey;

	@JsonBackReference
	private CenOutPpmCo cenOutPpmCo;

	private String cbatchCode;

	private Long ncolorcodeKey;

	private Date dusedByDate;

	private String cuser;

	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CO_BATCHCODE")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CO_BATCHCODE", sequenceName = "SEQ_CEN_OUT_PPM_CO_BATCHCODE", allocationSize = 1)
	@Column(name = "NPPM_BATCHCODE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmBatchcodeKey() {
		return this.nppmBatchcodeKey;
	}

	public void setNppmBatchcodeKey(final long nppmBatchcodeKey) {
		this.nppmBatchcodeKey = nppmBatchcodeKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_CO_KEY", nullable = false)
	public CenOutPpmCo getCenOutPpmCo() {
		return this.cenOutPpmCo;
	}

	public void setCenOutPpmCo(final CenOutPpmCo cenOutPpmCo) {
		this.cenOutPpmCo = cenOutPpmCo;
	}

	@Column(name = "CBATCH_CODE", length = 20)
	public String getCbatchCode() {
		return this.cbatchCode;
	}

	public void setCbatchCode(final String cbatchCode) {
		this.cbatchCode = cbatchCode;
	}

	@Column(name = "NCOLORCODE_KEY", precision = 12, scale = 0)
	public Long getNcolorcodeKey() {
		return this.ncolorcodeKey;
	}

	public void setNcolorcodeKey(final Long ncolorcodeKey) {
		this.ncolorcodeKey = ncolorcodeKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUSED_BY_DATE", length = 7)
	public Date getDusedByDate() {
		return this.dusedByDate;
	}

	public void setDusedByDate(final Date dusedByDate) {
		this.dusedByDate = dusedByDate;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
