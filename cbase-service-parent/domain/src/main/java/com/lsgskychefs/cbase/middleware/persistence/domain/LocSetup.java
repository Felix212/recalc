package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.03.2016 13:37:22 by Hibernate Tools 4.3.2-SNAPSHOT

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

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table LOC_SETUP
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_SETUP")
public class LocSetup implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocSetupId id;
	private SysLogin sysLogin;
	private String cvalue = " ";
	private Date dtimestamp;
	private String cchanged;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nuserId", column = @Column(name = "NUSER_ID", nullable = false, precision = 5, scale = 0)),
			@AttributeOverride(name = "csection", column = @Column(name = "CSECTION", nullable = false, length = 25)),
			@AttributeOverride(name = "ckey", column = @Column(name = "CKEY", nullable = false, length = 256)) })
	public LocSetupId getId() {
		return this.id;
	}

	public void setId(final LocSetupId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false, insertable = false, updatable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(final SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@Column(name = "CVALUE", nullable = false, length = 2048)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = CbaseMiddlewareStringUtils.defaultString(cvalue);
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CCHANGED", length = 40)
	public String getCchanged() {
		return this.cchanged;
	}

	public void setCchanged(final String cchanged) {
		this.cchanged = cchanged;
	}

}
