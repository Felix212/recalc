package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.06.2016 20:40:32 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_LANGUAGES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LANGUAGES", uniqueConstraints = @UniqueConstraint(columnNames = "CLANG_CODE"))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysLanguages implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nlangKey;
	@JsonView(View.Simple.class)
	private String clangCode;
	@JsonView(View.Simple.class)
	private String clangNameEng;
	@JsonView(View.Simple.class)
	private String clangNameLoc;
	/** back reference */
	@JsonIgnore
	private Set<SysEuAllergensText> sysEuAllergensTexts = new HashSet<>(0);

	@Id
	@Column(name = "NLANG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlangKey() {
		return this.nlangKey;
	}

	public void setNlangKey(final long nlangKey) {
		this.nlangKey = nlangKey;
	}

	@Column(name = "CLANG_CODE", unique = true, nullable = false, length = 2)
	public String getClangCode() {
		return this.clangCode;
	}

	public void setClangCode(final String clangCode) {
		this.clangCode = clangCode;
	}

	@Column(name = "CLANG_NAME_ENG", nullable = false, length = 20)
	public String getClangNameEng() {
		return this.clangNameEng;
	}

	public void setClangNameEng(final String clangNameEng) {
		this.clangNameEng = clangNameEng;
	}

	@Column(name = "CLANG_NAME_LOC", nullable = false, length = 60)
	public String getClangNameLoc() {
		return this.clangNameLoc;
	}

	public void setClangNameLoc(final String clangNameLoc) {
		this.clangNameLoc = clangNameLoc;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLanguages")
	public Set<SysEuAllergensText> getSysEuAllergensTexts() {
		return this.sysEuAllergensTexts;
	}

	public void setSysEuAllergensTexts(final Set<SysEuAllergensText> sysEuAllergensTexts) {
		this.sysEuAllergensTexts = sysEuAllergensTexts;
	}

}
