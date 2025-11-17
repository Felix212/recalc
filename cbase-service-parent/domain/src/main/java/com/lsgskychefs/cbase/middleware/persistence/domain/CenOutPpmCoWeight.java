package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.01.2017 13:42:37 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CO_WEIGHT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CO_WEIGHT")
public class CenOutPpmCoWeight implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long nppmWeightKey;

	@JsonBackReference
	private CenOutPpmCo cenOutPpmCo;

	private BigDecimal nquantityChecked;

	private int nsupervisor;

	private String cuser;

	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CO_WEIGHT")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CO_WEIGHT", sequenceName = "SEQ_CEN_OUT_PPM_CO_WEIGHT", allocationSize = 1)
	@Column(name = "NPPM_WEIGHT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNppmWeightKey() {
		return this.nppmWeightKey;
	}

	public void setNppmWeightKey(final Long nppmWeightKey) {
		this.nppmWeightKey = nppmWeightKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_CO_KEY", nullable = false)
	public CenOutPpmCo getCenOutPpmCo() {
		return this.cenOutPpmCo;
	}

	public void setCenOutPpmCo(final CenOutPpmCo cenOutPpmCo) {
		this.cenOutPpmCo = cenOutPpmCo;
	}

	@Column(name = "NQUANTITY_CHECKED", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantityChecked() {
		return this.nquantityChecked;
	}

	public void setNquantityChecked(final BigDecimal nquantityChecked) {
		this.nquantityChecked = nquantityChecked;
	}

	@Column(name = "NSUPERVISOR", nullable = false, precision = 1, scale = 0)
	public int getNsupervisor() {
		return this.nsupervisor;
	}

	public void setNsupervisor(final int nsupervisor) {
		this.nsupervisor = nsupervisor;
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
