package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.05.2017 12:16:06 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_PR_LAB_SPOTCH
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_PR_LAB_SPOTCH")
public class CenOutPpmPrLabSpotch implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmPrLabSpotchKey;
	private CenOutPpmProdLabel cenOutPpmProdLabel;
	private LocUnitTrailpoint locUnitTrailpoint;
	private long nplIndexKey;
	private String cpackinglist;
	private BigDecimal ntemperature;
	private BigDecimal nquantity;
	private String ccomment;
	private String cuser;
	private Date dtimestamp;
	private Long nclassNumber;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_PR_LAB_SPOTCH")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_PR_LAB_SPOTCH", sequenceName = "SEQ_CEN_OUT_PPM_PR_LAB_SPOTCH", allocationSize = 1)
	@Column(name = "NPPM_PR_LAB_SPOTCH_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmPrLabSpotchKey() {
		return this.nppmPrLabSpotchKey;
	}

	public void setNppmPrLabSpotchKey(final long nppmPrLabSpotchKey) {
		this.nppmPrLabSpotchKey = nppmPrLabSpotchKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTRAILPOINT_KEY", nullable = false)
	public LocUnitTrailpoint getLocUnitTrailpoint() {
		return this.locUnitTrailpoint;
	}

	public void setLocUnitTrailpoint(final LocUnitTrailpoint locUnitTrailpoint) {
		this.locUnitTrailpoint = locUnitTrailpoint;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_PROD_LABEL_KEY", nullable = false)
	@JsonIgnore
	public CenOutPpmProdLabel getCenOutPpmProdLabel() {
		return this.cenOutPpmProdLabel;
	}

	public void setCenOutPpmProdLabel(final CenOutPpmProdLabel cenOutPpmProdLabel) {
		this.cenOutPpmProdLabel = cenOutPpmProdLabel;
	}

	@Column(name = "NPL_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NTEMPERATURE", precision = 12)
	public BigDecimal getNtemperature() {
		return this.ntemperature;
	}

	public void setNtemperature(final BigDecimal ntemperature) {
		this.ntemperature = ntemperature;
	}

	@Column(name = "NQUANTITY", precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CCOMMENT", length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
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

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

}
