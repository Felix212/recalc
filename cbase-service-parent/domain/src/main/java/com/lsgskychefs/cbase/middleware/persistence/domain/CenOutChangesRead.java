package com.lsgskychefs.cbase.middleware.persistence.domain;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "CEN_OUT_CHANGES_READ")
public class CenOutChangesRead implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nuserId", column = @Column(name = "NUSER_ID", nullable = false, precision = 12, scale = 0)) })
	private CenOutChangesReadId id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false, insertable = false, updatable = false) })
	@OnDelete(action = OnDeleteAction.CASCADE)
	private CenOutChanges cenOutChanges;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "NUSER_ID", nullable = false, insertable = false, updatable = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	private SysLogin sysLogin;

	public CenOutChangesReadId getId() {
		return id;
	}

	public void setId(CenOutChangesReadId id) {
		this.id = id;
	}

	public CenOutChanges getCenOutChanges() {
		return cenOutChanges;
	}

	public void setCenOutChanges(CenOutChanges cenOutChanges) {
		this.cenOutChanges = cenOutChanges;
	}

	public SysLogin getSysLogin() {
		return sysLogin;
	}

	public void setSysLogin(SysLogin nuser) {
		this.sysLogin = sysLogin;
	}

}
