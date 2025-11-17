package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.06.2016 20:40:32 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_EU_ALLERGENS_TEXT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_EU_ALLERGENS_TEXT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysEuAllergensText implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long neuAllgTextKey;
	/** back reference */
	@JsonIgnore
	private SysEuAllergens sysEuAllergens;
	@JsonView(View.SimpleWithReferences.class)
	private SysLanguages sysLanguages;
	@JsonView(View.Simple.class)
	private String ctext;

	@Id
	@Column(name = "NEU_ALLG_TEXT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuAllgTextKey() {
		return this.neuAllgTextKey;
	}

	public void setNeuAllgTextKey(final long neuAllgTextKey) {
		this.neuAllgTextKey = neuAllgTextKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_ALLG_KEY", nullable = false)
	public SysEuAllergens getSysEuAllergens() {
		return this.sysEuAllergens;
	}

	public void setSysEuAllergens(final SysEuAllergens sysEuAllergens) {
		this.sysEuAllergens = sysEuAllergens;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLANG_KEY", nullable = false)
	public SysLanguages getSysLanguages() {
		return this.sysLanguages;
	}

	public void setSysLanguages(final SysLanguages sysLanguages) {
		this.sysLanguages = sysLanguages;
	}

	@Column(name = "CTEXT", nullable = false, length = 200)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

}
