package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_PR_LAB_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_PR_LAB_DETAIL")
public class CenOutPpmPrLabDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmPrLabDetailKey;

	private CenOutPpmProdLabel cenOutPpmProdLabel;

	private long nresultKey;

	private long ntransaction;

	private BigDecimal nquantity;

	private long nppmDetailKey;

	private Long nplIndexKey;

	private String cpackinglist;

	private Set<CenOutPpmPrLabDtlTp> cenOutPpmPrLabDtlTps = new HashSet<>(0);

	@Id
	@Column(name = "NPPM_PR_LAB_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmPrLabDetailKey() {
		return this.nppmPrLabDetailKey;
	}

	public void setNppmPrLabDetailKey(final long nppmPrLabDetailKey) {
		this.nppmPrLabDetailKey = nppmPrLabDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_PROD_LABEL_KEY", nullable = false)
	@JsonBackReference(value = "prodLabelToPrLabDetail")
	public CenOutPpmProdLabel getCenOutPpmProdLabel() {
		return this.cenOutPpmProdLabel;
	}

	public void setCenOutPpmProdLabel(final CenOutPpmProdLabel cenOutPpmProdLabel) {
		this.cenOutPpmProdLabel = cenOutPpmProdLabel;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NPPM_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNppmDetailKey() {
		return this.nppmDetailKey;
	}

	public void setNppmDetailKey(final long nppmDetailKey) {
		this.nppmDetailKey = nppmDetailKey;
	}

	@Column(name = "NPL_INDEX_KEY", precision = 12, scale = 0)
	public Long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final Long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpmPrLabDetail")
	@JsonManagedReference
	public Set<CenOutPpmPrLabDtlTp> getCenOutPpmPrLabDtlTps() {
		return this.cenOutPpmPrLabDtlTps;
	}

	public void setCenOutPpmPrLabDtlTps(final Set<CenOutPpmPrLabDtlTp> cenOutPpmPrLabDtlTps) {
		this.cenOutPpmPrLabDtlTps = cenOutPpmPrLabDtlTps;
	}

}
