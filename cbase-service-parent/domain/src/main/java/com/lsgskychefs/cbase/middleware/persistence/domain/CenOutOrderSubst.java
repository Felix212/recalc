package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 21.06.2023 10:22:20 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_ORDER_SUBST
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_ORDER_SUBST"
)
public class CenOutOrderSubst implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsubstKey;
	private CenOut cenOut;
	private SysLogin sysLogin;
	private long ntransaction;
	private long nhandlingDetailKey;
	private Date dtimestamp;
	private String csubstitution;
	private String ccomment;
	private Set<CenOutOrderSubstDetail> cenOutOrderSubstDetails = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_ORDER_SUBST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_ORDER_SUBST", sequenceName = "SEQ_CEN_OUT_ORDER_SUBST", allocationSize = 1)
	@Column(name = "NSUBST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsubstKey() {
		return this.nsubstKey;
	}

	public void setNsubstKey(long nsubstKey) {
		this.nsubstKey = nsubstKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NHANDLING_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingDetailKey() {
		return this.nhandlingDetailKey;
	}

	public void setNhandlingDetailKey(long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CSUBSTITUTION", length = 256)
	public String getCsubstitution() {
		return this.csubstitution;
	}

	public void setCsubstitution(String csubstitution) {
		this.csubstitution = csubstitution;
	}

	@Column(name = "CCOMMENT", length = 256)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutOrderSubst")
	public Set<CenOutOrderSubstDetail> getCenOutOrderSubstDetails() {
		return this.cenOutOrderSubstDetails;
	}

	public void setCenOutOrderSubstDetails(Set<CenOutOrderSubstDetail> cenOutOrderSubstDetails) {
		this.cenOutOrderSubstDetails = cenOutOrderSubstDetails;
	}

}


