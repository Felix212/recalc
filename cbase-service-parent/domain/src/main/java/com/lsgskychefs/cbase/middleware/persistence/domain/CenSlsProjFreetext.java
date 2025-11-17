package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.02.2017 14:23:34 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_SLS_PROJ_FREETEXT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJ_FREETEXT")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class CenSlsProjFreetext implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private CenSlsProjFreetextId id;
	private SysSlsProjKwCat sysSlsProjKwCat;
	private CenSlsProject cenSlsProject;
	private String ctext;
	private boolean nintern;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nprojectKey", column = @Column(name = "NPROJECT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nprojKwCatKey", column = @Column(name = "NPROJ_KW_CAT_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenSlsProjFreetextId getId() {
		return this.id;
	}

	public void setId(final CenSlsProjFreetextId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_KW_CAT_KEY", nullable = false, insertable = false, updatable = false)
	@JsonIgnore
	public SysSlsProjKwCat getSysSlsProjKwCat() {
		return this.sysSlsProjKwCat;
	}

	public void setSysSlsProjKwCat(final SysSlsProjKwCat sysSlsProjKwCat) {
		this.sysSlsProjKwCat = sysSlsProjKwCat;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_KEY", nullable = false, insertable = false, updatable = false)
	@JsonIgnore
	public CenSlsProject getCenSlsProject() {
		return this.cenSlsProject;
	}

	public void setCenSlsProject(final CenSlsProject cenSlsProject) {
		this.cenSlsProject = cenSlsProject;
	}

	@Column(name = "CTEXT", nullable = false, length = 500)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NINTERN", nullable = false, precision = 1, scale = 0)
	public boolean isNintern() {
		return this.nintern;
	}

	public void setNintern(final boolean nintern) {
		this.nintern = nintern;
	}

}
