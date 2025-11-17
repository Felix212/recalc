package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 02.05.2018 09:56:02 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_APP_UNIT_SETTING
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_APP_UNIT_SETTING")
public class SysAppUnitSetting implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nsettingKey;

	@JsonIgnore
	private SysRoles sysRoles;

	@JsonIgnore
	private SysUnits sysUnits;

	@JsonView(View.Simple.class)
	private String csetting;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_APP_UNIT_SETTING")
	@SequenceGenerator(name = "SEQ_SYS_APP_UNIT_SETTING", sequenceName = "SEQ_SYS_APP_UNIT_SETTING", allocationSize = 1)
	@Column(name = "NSETTING_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsettingKey() {
		return this.nsettingKey;
	}

	public void setNsettingKey(final long nsettingKey) {
		this.nsettingKey = nsettingKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROLE_ID")
	public SysRoles getSysRoles() {
		return this.sysRoles;
	}

	public void setSysRoles(final SysRoles sysRoles) {
		this.sysRoles = sysRoles;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Lob
	@Column(name = "CSETTING")
	public String getCsetting() {
		return this.csetting;
	}

	public void setCsetting(final String csetting) {
		this.csetting = csetting;
	}

}
