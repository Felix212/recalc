package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 21.06.2023 10:22:20 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_OUT_ORDER_SUBST_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_ORDER_SUBST_DETAIL"
)
public class CenOutOrderSubstDetail implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsubstDetailKey;
	private SysLogin sysLogin;
	private CenOutOrderSubst cenOutOrderSubst;
	private long npackinglistIndexKey;
	private String cpackinglist;
	private String ctext;
	private Date dtimestamp;
	private String csubstitution;
	private String ccomment;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_ORDER_SUBST_DETAIL")
	@SequenceGenerator(name = "SEQ_CEN_OUT_ORDER_SUBST_DETAIL", sequenceName = "SEQ_CEN_OUT_ORDER_SUBST_DETAIL", allocationSize = 1)
	@Column(name = "NSUBST_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsubstDetailKey() {
		return this.nsubstDetailKey;
	}

	public void setNsubstDetailKey(long nsubstDetailKey) {
		this.nsubstDetailKey = nsubstDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSUBST_KEY", nullable = false)
	public CenOutOrderSubst getCenOutOrderSubst() {
		return this.cenOutOrderSubst;
	}

	public void setCenOutOrderSubst(CenOutOrderSubst cenOutOrderSubst) {
		this.cenOutOrderSubst = cenOutOrderSubst;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 36)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CSUBSTITUTION", nullable = false, length = 256)
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

}


