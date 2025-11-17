package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.03.2016 11:49:18 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseLoginHistKind;

/**
 * Entity(DomainObject) for table SYS_LOGIN_HISTKIND
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGIN_HISTKIND")
public class SysLoginHistKind implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** @see CbaseLoginHistKind */
	private long nloginHistkindKey;
	private String ctext;
	private String ctext2;
	private Set<SysLoginHistory> sysLoginHistories = new HashSet<>(0);

	/** @see CbaseLoginHistKind */
	@Id
	@Column(name = "NLOGIN_HISTKIND_KEY", unique = true, nullable = false, precision = 5, scale = 0)
	public long getNloginHistkindKey() {
		return this.nloginHistkindKey;
	}

	/** @see CbaseLoginHistKind */
	public void setNloginHistkindKey(final long nloginHistkindKey) {
		this.nloginHistkindKey = nloginHistkindKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 60)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT2", nullable = false, length = 60)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLoginHistkind")
	public Set<SysLoginHistory> getSysLoginHistories() {
		return this.sysLoginHistories;
	}

	public void setSysLoginHistories(final Set<SysLoginHistory> sysLoginHistories) {
		this.sysLoginHistories = sysLoginHistories;
	}

}
