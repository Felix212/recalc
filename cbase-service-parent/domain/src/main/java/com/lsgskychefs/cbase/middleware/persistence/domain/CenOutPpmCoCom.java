package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 06.06.2019 07:17:40 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_CO_COM
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_CO_COM")
public class CenOutPpmCoCom implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmCoComKey;

	@JsonIgnore
	private CenOutPpmCo cenOutPpmCo;

	private long nresultKey;

	private long nstowageKey;

	private Date dtimestamp;

	private String cuser;

	private String ccomment;

	private byte[] bpicture;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_CO_COM")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_CO_COM", sequenceName = "SEQ_CEN_OUT_PPM_CO_COM", allocationSize = 1)
	@Column(name = "NPPM_CO_COM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmCoComKey() {
		return this.nppmCoComKey;
	}

	public void setNppmCoComKey(final long nppmCoComKey) {
		this.nppmCoComKey = nppmCoComKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_CO_KEY", nullable = false)
	public CenOutPpmCo getCenOutPpmCo() {
		return this.cenOutPpmCo;
	}

	public void setCenOutPpmCo(final CenOutPpmCo cenOutPpmCo) {
		this.cenOutPpmCo = cenOutPpmCo;
	}

	@Column(name = "NRESULT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NSTOWAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNstowageKey() {
		return nstowageKey;
	}

	public void setNstowageKey(final long nstowageKey) {
		this.nstowageKey = nstowageKey;
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

	@Column(name = "CCOMMENT", nullable = false, length = 500)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

}
