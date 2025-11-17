package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.06.2016 20:40:32 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.EntityGraphen;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_EU_ALLERGENS
 *
 * @author Hibernate Tools
 */
@Entity
@NamedEntityGraph(name = EntityGraphen.SYS_EU_ALLERGENS_SYS_EU_ALLERGENS_TEXTS, attributeNodes = @NamedAttributeNode("sysEuAllergensTexts"))
@Table(name = "SYS_EU_ALLERGENS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysEuAllergens implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long neuAllgKey;
	@JsonView(View.Simple.class)
	private String callgCode;
	@JsonView(View.Simple.class)
	private int nallgVar;
	@JsonView(View.Simple.class)
	private int nsort;
	@JsonView(View.Simple.class)
	private String cindustryStd;
	@JsonView(View.Simple.class)
	private String ccrewText;
	@JsonView(View.SimpleWithReferences.class)
	private Set<SysEuAllergensText> sysEuAllergensTexts = new HashSet<>(0);
	@JsonView(View.SpecialRelation.class)
	private Set<CenEuItemsAlg> cenEuItemsAlgs = new HashSet<>(0);

	@Id
	@Column(name = "NEU_ALLG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuAllgKey() {
		return this.neuAllgKey;
	}

	public void setNeuAllgKey(final long neuAllgKey) {
		this.neuAllgKey = neuAllgKey;
	}

	@Column(name = "CALLG_CODE", nullable = false, length = 10)
	public String getCallgCode() {
		return this.callgCode;
	}

	public void setCallgCode(final String callgCode) {
		this.callgCode = callgCode;
	}

	@Column(name = "NALLG_VAR", nullable = false, precision = 2, scale = 0)
	public int getNallgVar() {
		return this.nallgVar;
	}

	public void setNallgVar(final int nallgVar) {
		this.nallgVar = nallgVar;
	}

	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "CINDUSTRY_STD", length = 10)
	public String getCindustryStd() {
		return this.cindustryStd;
	}

	public void setCindustryStd(final String cindustryStd) {
		this.cindustryStd = cindustryStd;
	}

	@Column(name = "CCREW_TEXT", length = 40)
	public String getCcrewText() {
		return this.ccrewText;
	}

	public void setCcrewText(final String ccrewText) {
		this.ccrewText = ccrewText;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysEuAllergens")
	public Set<SysEuAllergensText> getSysEuAllergensTexts() {
		return this.sysEuAllergensTexts;
	}

	public void setSysEuAllergensTexts(final Set<SysEuAllergensText> sysEuAllergensTexts) {
		this.sysEuAllergensTexts = sysEuAllergensTexts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysEuAllergens")
	public Set<CenEuItemsAlg> getCenEuItemsAlgs() {
		return this.cenEuItemsAlgs;
	}

	public void setCenEuItemsAlgs(final Set<CenEuItemsAlg> cenEuItemsAlgs) {
		this.cenEuItemsAlgs = cenEuItemsAlgs;
	}

}
